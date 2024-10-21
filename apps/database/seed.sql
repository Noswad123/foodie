-- --Insert ingredient type
-- INSERT OR IGNORE INTO ingredient_types (name) VALUES ('Fruit');
--
-- -- Get the id of the newly inserted or existing 'Fruit' type
-- INSERT INTO ingredients (name, ingredient_type_id, measurement_unit_id, notes)
-- SELECT
--     'Apple',
--     (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--     (SELECT id FROM measurement_units WHERE name = 'cup'),
--     'Red and delicious';
--
-- -- Insert recipes
-- INSERT INTO recipes (name, instructions) VALUES
--     ('Margarita', 'Shake and strain into a glass.'),
--     ('Old Fashioned', 'Stir and strain into a glass.'),
--     ('Cosmopolitan', 'Shake and strain into a glass.'),
--     ('Mojito', 'Muddle, shake, and strain into a glass.'),
--     ('Piña Colada', 'Blend all ingredients and pour into a glass.');
--
-- -- Insert recipe ingredients for Margarita
-- INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
-- VALUES
--     ((SELECT id FROM recipes WHERE name = 'Margarita'), 1, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Margarita'), 2, '1', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Margarita'), 3, '1', (SELECT id FROM measurement_units WHERE name = 'ounce'));
--
-- -- Insert recipe ingredients for Old Fashioned
-- INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
-- VALUES
--     ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 4, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 5, '1', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Old Fashioned'), 6, '2', (SELECT id FROM measurement_units WHERE name = 'dash'));
--
-- -- Insert recipe ingredients for Cosmopolitan
-- INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
-- VALUES
--     ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Vodka'), '2.5', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Triple Sec'), '0.5', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Cosmopolitan'), (SELECT id FROM ingredients WHERE name = 'Cranberry Juice'), '0.5', (SELECT id FROM measurement_units WHERE name = 'ounce'));
--
-- -- Insert recipe ingredients for Mojito
-- INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, measurement_unit_id)
-- VALUES
--     ((SELECT id FROM recipes WHERE name = 'Mojito'), 10, '2', (SELECT id FROM measurement_units WHERE name = 'ounce')),
--     ((SELECT id FROM recipes WHERE name = 'Mojito'), 2, '1', (SELECT id FROM measurement_units WHERE name = 'teaspoon'));  -- Assuming 'teaspoon' is the intended measurement unit

-- Insert basic ingredients with predefined IDs
INSERT INTO ingredients (name, ingredient_type_id, measurement_unit_id, notes)
VALUES
    ('Apple', 1, 1, 'Red and delicious'),
    ('Carrot', 2, 3, 'Orange and crunchy'),
    ('Chicken Breast', 3, 4, 'Skinless and boneless'),
    ('Rice', 4, 1, 'Long-grain white rice'),
    ('Milk', 5, 5, 'Whole milk');

-- Insert measurement units, avoiding duplicates using INSERT OR IGNORE
INSERT OR IGNORE INTO measurement_units (name)
VALUES
    ('cup'),
    ('teaspoon'),
    ('tablespoon'),
    ('ounce'),
    ('gram'),
    ('dozen'),
    ('pound'),
    ('each');

-- Insert more ingredients, using SELECT to retrieve type and measurement unit IDs dynamically
INSERT INTO ingredients (name, ingredient_type_id, measurement_unit_id, notes)
SELECT 'Apple', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Red and delicious'
UNION ALL
SELECT 'Baking Powder', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
UNION ALL
SELECT 'Banana', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Ripe and yellow'
UNION ALL
SELECT 'Beef Broth', (SELECT id FROM ingredient_types WHERE name = 'Broth'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), NULL
UNION ALL
SELECT 'Black Pepper', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
UNION ALL
SELECT 'Butter', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
       (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Unsalted'
UNION ALL
SELECT 'Cayenne Pepper', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Spicy'
UNION ALL
SELECT 'Cherry', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Sweet and juicy'
UNION ALL
SELECT 'Chilled Espresso', (SELECT id FROM ingredient_types WHERE name = 'Coffee'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), NULL
UNION ALL
SELECT 'Chili Powder', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For a hint of heat'
UNION ALL
SELECT 'Chocolate Sprinkles', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
       (SELECT id FROM measurement_units WHERE name = 'tablespoon'), NULL
UNION ALL
SELECT 'Cinnamon', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Ground'
UNION ALL
SELECT 'Cocoa Powder', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Unsweetened'
UNION ALL
SELECT 'Coffee Beans', (SELECT id FROM ingredient_types WHERE name = 'Coffee'),
       (SELECT id FROM measurement_units WHERE name = 'gram'), NULL
UNION ALL
SELECT 'Corn Flakes', (SELECT id FROM ingredient_types WHERE name = 'Cereal'),
       (SELECT id FROM measurement_units WHERE name = 'ounce'), 'Cereal'
UNION ALL
SELECT 'Eggs', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
       (SELECT id FROM measurement_units WHERE name = 'dozen'), NULL
UNION ALL
SELECT 'Garlic Powder', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For flavor'
UNION ALL
SELECT 'Ground Beef', (SELECT id FROM ingredient_types WHERE name = 'Protein'),
       (SELECT id FROM measurement_units WHERE name = 'pound'), 'Lean'
UNION ALL
SELECT 'Ground Cumin', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
UNION ALL
SELECT 'Lemon Twist', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For garnish'
UNION ALL
SELECT 'Lime', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Citrus fruit'
UNION ALL
SELECT 'Milk', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Whole milk'
UNION ALL
SELECT 'Nutmeg', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Ground'
UNION ALL
SELECT 'Olive Oil', (SELECT id FROM ingredient_types WHERE name = 'Oil'),
       (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Extra virgin'
UNION ALL
SELECT 'Pecans', (SELECT id FROM ingredient_types WHERE name = 'Nuts'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Nuts'
UNION ALL
SELECT 'Rolled Oats', (SELECT id FROM ingredient_types WHERE name = 'Cereal'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Oatmeal'
UNION ALL
SELECT 'Salt', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Table salt'
UNION ALL
SELECT 'Sugar', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
       (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Granulated sugar'
UNION ALL
SELECT 'Tomato Paste', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Concentrated tomato'
UNION ALL
SELECT 'Tomato Sauce', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Sauce'
UNION ALL
SELECT 'Tomatoes', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Fresh tomatoes'
UNION ALL
SELECT 'Vanilla Extract', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
       (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Pure extract'
UNION ALL
SELECT 'Walnuts', (SELECT id FROM ingredient_types WHERE name = 'Nuts'),
       (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Nuts'
UNION ALL
SELECT 'Yellow Onion', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
       (SELECT id FROM measurement_units WHERE name = 'cup'), 'Onion';

