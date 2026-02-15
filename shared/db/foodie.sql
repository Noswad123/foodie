-- sqlite
-- Name: cooking_techniques; Type: TABLE
CREATE TABLE cooking_techniques (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT
);

-- Name: ingredient_types; Type: TABLE
CREATE TABLE ingredient_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Name: ingredients; Type: TABLE
CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    ingredient_type_id INTEGER,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ingredient_type_id) REFERENCES ingredient_types(id)
);

-- Name: measurement_units; Type: TABLE
CREATE TABLE measurement_units (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    abbreviation TEXT NOT NULL
);

-- Name: recipe_ingredients; Type: TABLE
CREATE TABLE recipe_ingredients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    ingredient_id INTEGER,
    measurement_unit_id INTEGER,
    quantity REAL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id),
    FOREIGN KEY (measurement_unit_id) REFERENCES measurement_units(id)
);

-- Name: recipe_techniques; Type: TABLE
CREATE TABLE recipe_techniques (
    recipe_id INTEGER NOT NULL,
    technique_id INTEGER NOT NULL,
    PRIMARY KEY (recipe_id, technique_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (technique_id) REFERENCES cooking_techniques(id)
);

-- Name: recipe_types; Type: TABLE
CREATE TABLE recipe_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Name: recipes; Type: TABLE
CREATE TABLE recipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type_id INTEGER,
    instructions TEXT,
    prep_time INTEGER,
    cooking_time INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (type_id) REFERENCES recipe_types(id)
);

