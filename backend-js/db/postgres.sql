
CREATE TABLE ingredient_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL Unique
);

CREATE TABLE recipe_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL Unique
);

CREATE TABLE measurement_units (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL unique
);

CREATE TABLE ingredients (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL unique,
	ingredient_type_id INT,
	notes TEXT,
	created_at TIMESTAMP DEFAULT current_timestamp,
	updated_at TIMESTAMP DEFAULT current_timestamp,
	FOREIGN KEY (ingredient_type_id) REFERENCES ingredient_types(id)
);

CREATE TABLE cooking_techniques (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE recipes (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type_id INT,
    instructions TEXT,
    prep_time INT,
    cooking_time INT,
    serving_size INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (type_id) REFERENCES recipe_types(id)
);

CREATE TABLE recipe_ingredients (
    id SERIAL PRIMARY KEY,
    recipe_id INTEGER REFERENCES recipes(id),
    ingredient_id INTEGER REFERENCES ingredients(id),
    measurement_unit_id INT REFERENCES measurement_units(id),
    quantity TEXT
);

CREATE TABLE recipe_techniques (
    recipe_id INT,
    technique_id INT,
    PRIMARY KEY (recipe_id, technique_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (technique_id) REFERENCES cooking_techniques(id)
);

CREATE TABLE ingredient_substitutions (
    id SERIAL PRIMARY KEY,
    recipe_id INT,
    original_ingredient_id INT,
    substitute_ingredient_id INT,
    quantity NUMERIC,
    unit_id INT,
    substitute_rank INT,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (original_ingredient_id) REFERENCES ingredients(id),
    FOREIGN KEY (substitute_ingredient_id) REFERENCES ingredients(id),
    FOREIGN KEY (unit_id) REFERENCES measurement_units(id)
);
-- Indicies
CREATE INDEX idx_ingredients_name ON ingredients (name);
CREATE INDEX idx_recipes_name ON recipes (name);
CREATE INDEX idx_techniques_name ON cooking_techniques (name);
