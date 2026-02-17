#!/usr/bin/env python3
"""
One-time SQLite -> Postgres migration for Foodie (robust numeric parsing).

- Parses prep_time / cook_time strings into integer minutes when possible.
- Preserves relationships by building sqlite_id -> pg_id maps for each table.
- Migrates measurement_units.name + measurement_units.abbreviation.
- Skips orphan join rows rather than failing migration.
"""

import re
import sqlite3
from typing import Optional

import psycopg

SQLITE_PATH = "foodie.db"
PG_DSN = "postgresql://foodie:foodie@localhost:2022/foodie"


def fetch_all(cur, sql, params=()):
    cur.execute(sql, params)
    cols = [d[0] for d in cur.description]
    return cols, cur.fetchall()


def parse_int_like(v) -> Optional[int]:
    """
    Try to coerce v into an integer number of minutes.
    Supports:
      - integer or float numbers (returns int)
      - "35", "35 minutes"
      - "1 hr 20 min", "1h30", "1 hour", "90m"
      - "about 30", "approx. 30 min"
    Returns None if cannot parse.
    """
    if v is None:
        return None

    # If numeric already
    if isinstance(v, int):
        return v
    if isinstance(v, float):
        return int(v)

    s = str(v).strip()
    if s == "":
        return None

    s_low = s.lower()

    # Common pattern: look for hours and minutes
    # Examples matched: "1 hr 15 min", "1h30", "2 hours", "90 min", "1hr", "1 hour 20"
    hours = 0
    minutes = 0

    # Find hour pattern
    m = re.search(r'(\d+)\s*(h|hr|hour|hours)', s_low)
    if m:
        hours = int(m.group(1))

    # Find minute pattern
    m2 = re.search(r'(\d+)\s*(m|min|minute|minutes)', s_low)
    if m2:
        minutes = int(m2.group(1))

    # If we found hours or minutes, compute total minutes
    if hours or minutes:
        return hours * 60 + minutes

    # Try compact hhmm like "1h30" handled above, but also "1:30"
    m3 = re.search(r'(\d+)\s*[:h]\s*(\d+)', s_low)
    if m3:
        hh = int(m3.group(1))
        mm = int(m3.group(2))
        return hh * 60 + mm

    # As a last-ditch, extract the first integer found (e.g. "35 minutes" -> 35)
    m4 = re.search(r'(-?\d+)', s_low)
    if m4:
        try:
            return int(m4.group(1))
        except ValueError:
            return None

    return None


# --- UPSERT / INSERTS ---
def upsert_lookup(pg, table, unique_col, rows):
    id_map = {}
    with pg.cursor() as cur:
        for r in rows:
            sqlite_id = r[0]
            name = r[1]
            cur.execute(
                f"""
                INSERT INTO {table} ({unique_col})
                VALUES (%s)
                ON CONFLICT ({unique_col}) DO UPDATE SET {unique_col} = EXCLUDED.{unique_col}
                RETURNING id
                """,
                (name,),
            )
            id_map[sqlite_id] = cur.fetchone()[0]
    return id_map


def upsert_units(pg, rows):
    """
    measurement_units: handle both name and abbreviation; avoid abort on abbreviation collision.
    """
    id_map = {}
    with pg.cursor() as cur:
        for (sid, name, abbreviation) in rows:
            # Prefer matching by abbreviation first (to avoid duplicate abbrev collisions)
            cur.execute("SELECT id FROM measurement_units WHERE abbreviation = %s", (abbreviation,))
            existing = cur.fetchone()
            if existing:
                pg_id = existing[0]
                # Keep PG in sync with sqlite name
                cur.execute("UPDATE measurement_units SET name = %s WHERE id = %s", (name, pg_id))
                id_map[sid] = pg_id
                continue

            # Insert or update on name conflict
            cur.execute(
                """
                INSERT INTO measurement_units (name, abbreviation)
                VALUES (%s, %s)
                ON CONFLICT (name) DO UPDATE SET
                  abbreviation = EXCLUDED.abbreviation
                RETURNING id
                """,
                (name, abbreviation),
            )
            id_map[sid] = cur.fetchone()[0]
    return id_map


def insert_techniques(pg, rows):
    id_map = {}
    with pg.cursor() as cur:
        for (sid, name, desc) in rows:
            cur.execute("SELECT id, description FROM cooking_techniques WHERE name = %s", (name,))
            found = cur.fetchone()
            if found:
                pg_id, existing_desc = found
                id_map[sid] = pg_id
                if (existing_desc is None or existing_desc == "") and desc:
                    cur.execute("UPDATE cooking_techniques SET description = %s WHERE id = %s", (desc, pg_id))
                continue

            cur.execute(
                """
                INSERT INTO cooking_techniques (name, description)
                VALUES (%s, %s)
                RETURNING id
                """,
                (name, desc),
            )
            id_map[sid] = cur.fetchone()[0]
    return id_map


def insert_ingredients(pg, rows, ingredient_type_map):
    id_map = {}
    with pg.cursor() as cur:
        for (sid, name, type_id, notes, created_at, updated_at) in rows:
            pg_type_id = ingredient_type_map.get(type_id) if type_id is not None else None
            cur.execute(
                """
                INSERT INTO ingredients (name, ingredient_type_id, notes, created_at, updated_at)
                VALUES (%s, %s, %s, %s, %s)
                ON CONFLICT (name) DO UPDATE SET
                  ingredient_type_id = EXCLUDED.ingredient_type_id,
                  notes = EXCLUDED.notes,
                  updated_at = EXCLUDED.updated_at
                RETURNING id
                """,
                (name, pg_type_id, notes, created_at, updated_at),
            )
            id_map[sid] = cur.fetchone()[0]
    return id_map


def insert_recipes(pg, rows, recipe_type_map):
    id_map = {}
    with pg.cursor() as cur:
        for (
            sid,
            name,
            type_id,
            instructions,
            prep_time_raw,
            cook_time_raw,
            serving_size_raw,
            created_at,
            updated_at,
        ) in rows:
            pg_type_id = recipe_type_map.get(type_id) if type_id is not None else None

            # Parse prep_time and cook_time into integer minutes when possible
            prep_time = parse_int_like(prep_time_raw)
            cook_time = parse_int_like(cook_time_raw)

            # serving_size maybe integer or string; try to coerce integer
            serving_size = None
            if serving_size_raw is not None:
                try:
                    serving_size = int(serving_size_raw)
                except Exception:
                    # try to extract an int from string
                    m = re.search(r'(\d+)', str(serving_size_raw))
                    serving_size = int(m.group(1)) if m else None

            cur.execute(
                """
                INSERT INTO recipes (name, type_id, instructions, prep_time, cooking_time, serving_size, created_at, updated_at)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (name) DO UPDATE SET
                  type_id = EXCLUDED.type_id,
                  instructions = EXCLUDED.instructions,
                  prep_time = EXCLUDED.prep_time,
                  cooking_time = EXCLUDED.cooking_time,
                  serving_size = EXCLUDED.serving_size,
                  updated_at = EXCLUDED.updated_at
                RETURNING id
                """,
                (
                    name,
                    pg_type_id,
                    instructions,
                    prep_time,
                    cook_time,
                    serving_size,
                    created_at,
                    updated_at,
                ),
            )
            id_map[sid] = cur.fetchone()[0]
    return id_map


def insert_recipe_ingredients(pg, rows, recipe_map, ingredient_map, unit_map):
    with pg.cursor() as cur:
        for (_sid, recipe_id, ingredient_id, unit_id, qty) in rows:
            pg_recipe_id = recipe_map.get(recipe_id)
            pg_ingredient_id = ingredient_map.get(ingredient_id)
            pg_unit_id = unit_map.get(unit_id) if unit_id is not None else None

            if pg_recipe_id is None or pg_ingredient_id is None:
                # orphan; skip
                continue

            qty_text = None if qty is None else str(qty)

            cur.execute(
                """
                INSERT INTO recipe_ingredients (recipe_id, ingredient_id, measurement_unit_id, quantity)
                VALUES (%s, %s, %s, %s)
                """,
                (pg_recipe_id, pg_ingredient_id, pg_unit_id, qty_text),
            )


def insert_recipe_techniques(pg, rows, recipe_map, technique_map):
    with pg.cursor() as cur:
        for (recipe_id, technique_id) in rows:
            pg_recipe_id = recipe_map.get(recipe_id)
            pg_technique_id = technique_map.get(technique_id)
            if pg_recipe_id is None or pg_technique_id is None:
                continue

            cur.execute(
                """
                INSERT INTO recipe_techniques (recipe_id, technique_id)
                VALUES (%s, %s)
                ON CONFLICT DO NOTHING
                """,
                (pg_recipe_id, pg_technique_id),
            )


# --- MAIN ---
def main():
    sqlite = sqlite3.connect(SQLITE_PATH)
    s = sqlite.cursor()

    with psycopg.connect(PG_DSN) as pg:
        with pg.transaction():
            # 1) Lookups
            _, ingredient_types = fetch_all(s, "SELECT id, name FROM ingredient_types")
            ingredient_type_map = upsert_lookup(pg, "ingredient_types", "name", ingredient_types)

            _, recipe_types = fetch_all(s, "SELECT id, name FROM recipe_types")
            recipe_type_map = upsert_lookup(pg, "recipe_types", "name", recipe_types)

            _, units = fetch_all(s, "SELECT id, name, abbreviation FROM measurement_units")
            unit_map = upsert_units(pg, units)

            _, techniques = fetch_all(s, "SELECT id, name, description FROM cooking_techniques")
            technique_map = insert_techniques(pg, techniques)

            # 2) Parents
            _, ingredients = fetch_all(
                s,
                "SELECT id, name, ingredient_type_id, notes, created_at, updated_at FROM ingredients",
            )
            ingredient_map = insert_ingredients(pg, ingredients, ingredient_type_map)

            # Recipes: SQLite has cook_time, serving_size
            _, recipes = fetch_all(
                s,
                "SELECT id, name, type_id, instructions, prep_time, cook_time, serving_size, created_at, updated_at FROM recipes",
            )
            recipe_map = insert_recipes(pg, recipes, recipe_type_map)

            # 3) Joins
            _, recipe_ingredients = fetch_all(
                s,
                "SELECT id, recipe_id, ingredient_id, measurement_unit_id, quantity FROM recipe_ingredients",
            )
            insert_recipe_ingredients(pg, recipe_ingredients, recipe_map, ingredient_map, unit_map)

            _, recipe_techniques = fetch_all(
                s,
                "SELECT recipe_id, technique_id FROM recipe_techniques",
            )
            insert_recipe_techniques(pg, recipe_techniques, recipe_map, technique_map)

            print("Migration complete.")
            print(f"ingredient_types: {len(ingredient_type_map)}")
            print(f"recipe_types: {len(recipe_type_map)}")
            print(f"measurement_units: {len(unit_map)}")
            print(f"cooking_techniques: {len(technique_map)}")
            print(f"ingredients: {len(ingredient_map)}")
            print(f"recipes: {len(recipe_map)}")

    sqlite.close()


if __name__ == "__main__":
    main()
