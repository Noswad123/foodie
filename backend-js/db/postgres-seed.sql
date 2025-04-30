
-- Insert ingredient type
WITH type_data AS (
    INSERT INTO ingredient_types (name)
    VALUES ('Fruit')
    ON CONFLICT (name) DO NOTHING
    RETURNING id
)
INSERT INTO ingredients (name, ingredient_type_id, measurement_unit_id, notes)
SELECT 'Apple', COALESCE((SELECT id FROM type_data), (SELECT id FROM ingredient_types WHERE name = 'Fruit')),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Red and delicious';

-- Insert recipes
INSERT INTO recipes (name, instructions) VALUES
    ('Margarita', 'Shake and strain into a glass.'),
    ('Old Fashioned', 'Stir and strain into a glass.'),
    ('Cosmopolitan', 'Shake and strain into a glass.'),
    ('Mojito', 'Muddle, shake, and strain into a glass.'),
    ('Piña Colada', 'Blend all ingredients and pour into a glass.');

-- Insert recipe ingredients for Margarita
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
VALUES
    ((SELECT id FROM recipes WHERE name = 'Margarita'), 1, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Margarita'), 2, '1', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Margarita'), 3, '1', (SELECT id FROM measurement_units WHERE name = 'ounce'));

-- Insert recipe ingredients for Old Fashioned
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
VALUES
    ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 4, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 5, '1', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 6, '2', (SELECT id FROM measurement_units WHERE name = 'dash'));

-- Insert recipe ingredients for Cosmopolitan
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
VALUES
    ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Vodka'), '2.5', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Triple Sec'), '0.5', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Cranberry Juice'), '0.5', (SELECT id FROM measurement_units WHERE name = 'ounce'));

-- Insert recipe ingredients for Mojito
INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
VALUES
    ((SELECT id FROM recipes WHERE name = 'Mojito'), 10, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
    ((SELECT id FROM recipes WHERE name = 'Mojito'), 2, '1', (SELECT id FROM measurement_units WHERE name = '

