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


-- Insert measurement units, avoiding duplicates using INSERT OR IGNORE
-- INSERT INTO measurement_units (unit, abbreviation) VALUES
-- ('teaspoon', 'tsp'),
-- ('tablespoon', 'tbsp'),
-- ('fluid ounce', 'fl oz'),
-- ('cup', 'c'),
-- ('pint', 'pt'),
-- ('quart', 'qt'),
-- ('gallon', 'gal'),
-- ('milliliter', 'ml'),
-- ('liter', 'l'),
-- ('gram', 'g'),
-- ('kilogram', 'kg'),
-- ('ounce', 'oz'),
-- ('pound', 'lb');

-- Insert more ingredients, using SELECT to retrieve type and measurement unit IDs dynamically
-- INSERT INTO ingredients (name, ingredient_type_id, measurement_unit_id, notes)
-- SELECT 'Apple', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Red and delicious'
-- UNION ALL
-- SELECT 'Baking Powder', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
-- UNION ALL
-- SELECT 'Banana', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Ripe and yellow'
-- UNION ALL
-- SELECT 'Beef Broth', (SELECT id FROM ingredient_types WHERE name = 'Broth'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), NULL
-- UNION ALL
-- SELECT 'Black Pepper', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
-- UNION ALL
-- SELECT 'Butter', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
--        (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Unsalted'
-- UNION ALL
-- SELECT 'Cayenne Pepper', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Spicy'
-- UNION ALL
-- SELECT 'Cherry', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Sweet and juicy'
-- UNION ALL
-- SELECT 'Chilled Espresso', (SELECT id FROM ingredient_types WHERE name = 'Coffee'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), NULL
-- UNION ALL
-- SELECT 'Chili Powder', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For a hint of heat'
-- UNION ALL
-- SELECT 'Chocolate Sprinkles', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
--        (SELECT id FROM measurement_units WHERE name = 'tablespoon'), NULL
-- UNION ALL
-- SELECT 'Cinnamon', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Ground'
-- UNION ALL
-- SELECT 'Cocoa Powder', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Unsweetened'
-- UNION ALL
-- SELECT 'Coffee Beans', (SELECT id FROM ingredient_types WHERE name = 'Coffee'),
--        (SELECT id FROM measurement_units WHERE name = 'gram'), NULL
-- UNION ALL
-- SELECT 'Corn Flakes', (SELECT id FROM ingredient_types WHERE name = 'Cereal'),
--        (SELECT id FROM measurement_units WHERE name = 'ounce'), 'Cereal'
-- UNION ALL
-- SELECT 'Eggs', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
--        (SELECT id FROM measurement_units WHERE name = 'dozen'), NULL
-- UNION ALL
-- SELECT 'Garlic Powder', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For flavor'
-- UNION ALL
-- SELECT 'Ground Beef', (SELECT id FROM ingredient_types WHERE name = 'Protein'),
--        (SELECT id FROM measurement_units WHERE name = 'pound'), 'Lean'
-- UNION ALL
-- SELECT 'Ground Cumin', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), NULL
-- UNION ALL
-- SELECT 'Lemon Twist', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'For garnish'
-- UNION ALL
-- SELECT 'Lime', (SELECT id FROM ingredient_types WHERE name = 'Fruit'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Citrus fruit'
-- UNION ALL
-- SELECT 'Milk', (SELECT id FROM ingredient_types WHERE name = 'Dairy'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Whole milk'
-- UNION ALL
-- SELECT 'Nutmeg', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Ground'
-- UNION ALL
-- SELECT 'Olive Oil', (SELECT id FROM ingredient_types WHERE name = 'Oil'),
--        (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Extra virgin'
-- UNION ALL
-- SELECT 'Pecans', (SELECT id FROM ingredient_types WHERE name = 'Nuts'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Nuts'
-- UNION ALL
-- SELECT 'Rolled Oats', (SELECT id FROM ingredient_types WHERE name = 'Cereal'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Oatmeal'
-- UNION ALL
-- SELECT 'Salt', (SELECT id FROM ingredient_types WHERE name = 'Spice'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Table salt'
-- UNION ALL
-- SELECT 'Sugar', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
--        (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Granulated sugar'
-- UNION ALL
-- SELECT 'Tomato Paste', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Concentrated tomato'
-- UNION ALL
-- SELECT 'Tomato Sauce', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Sauce'
-- UNION ALL
-- SELECT 'Tomatoes', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Fresh tomatoes'
-- UNION ALL
-- SELECT 'Vanilla Extract', (SELECT id FROM ingredient_types WHERE name = 'Baking Ingredient'),
--        (SELECT id FROM measurement_units WHERE name = 'tablespoon'), 'Pure extract'
-- UNION ALL
-- SELECT 'Walnuts', (SELECT id FROM ingredient_types WHERE name = 'Nuts'),
--        (SELECT id FROM measurement_units WHERE name = 'teaspoon'), 'Nuts'
-- UNION ALL
-- SELECT 'Yellow Onion', (SELECT id FROM ingredient_types WHERE name = 'Produce'),
--        (SELECT id FROM measurement_units WHERE name = 'cup'), 'Onion';

-- Insert basic ingredients with predefined IDs
-- INSERT INTO ingredients (name)
-- VALUES
--     ('All Purpose Flour'),
--     ('All Spice'),
--     ('Almonds'),
--     ('Amaretto'),
--     ('Ancho'),
-- ('Andouille Sausage'),
-- ('Apple Puckers'),
-- ('Apricot'),
-- ('Baking Powder'),
-- ('Banana Pepper'),
-- ('Basil'),
-- ('Bay Leaves'),
-- ('Bell Pepper'),
-- ('Black Pepper'),
-- ('Boneless Pork Chops'),
-- ('Bourbon'),
-- ('Brandy'),
-- ('Brown Sugar'),
-- ('Butter'),
-- ('Buttermilk'),
-- ('Cake Flour'),
-- ('Capers'),
-- ('Caraway Seeds'),
-- ('Cardamom'),
-- ('Carrots'),
-- ('Cayenne'),
-- ('Celery'),
-- ('Celery Seeds'),
-- ('Chambord'),
-- ('Champagne'),
-- ('Cherry'),
-- ('Cherry Brandy'),
-- ('Chervil'),
-- ('Chicken Stock'),
-- ('Chicken Thighs'),
-- ('Chilled Expresso'),
-- ('Chilli Powder'),
-- ('Chipotle'),
-- ('Chives'),
-- ('Chocolate Sprinkles'),
-- ('Cilantro'),
-- ('Cinnamon'),
-- ('Cloves'),
-- ('Cocoa Powder'),
-- ('Coffee'),
-- ('Coffee Beans'),
-- ('Coffee Liqueur'),
-- ('Coke'),
-- ('Coriander'),
-- ('Corn Flakes'),
-- ('Corn Starch'),
-- ('Cranberry'),
-- ('Cream'),
-- ('Cream Cheese'),
-- ('Cream of Coconut'),
-- ('Cream Soda'),
-- ('Crown'),
-- ('Crushed Tomatoes'),
-- ('Cumin'),
-- ('Dark Rum'),
-- ('Dijon Mustard'),
-- ('Dill'),
-- ('Drambuie'),
-- ('Dry Vermouth'),
-- ('Eggs'),
-- ('Elderflower'),
-- ('Frangelico'),
-- ('Garlic'),
-- ('Garlic Powder'),
-- ('Ghee'),
-- ('Gin'),
-- ('Ginger'),
-- ('Godiva Dark Liqueur'),
-- ('Godiva Light Liquer'),
-- ('Grapefruit Juice'),
-- ('Green Apples'),
-- ('Grenadince'),
-- ('Ground Beef'),
-- ('Habanero'),
-- ('Half and Half'),
-- ('Heavy Cream'),
-- ('Hennessy'),
-- ('Hypnotiq'),
-- ('Jalepeno'),
-- ('Juniper Berries'),
-- ('Kahlua'),
-- ('Kosher Salt'),
-- ('Lavender'),
-- ('Lemon'),
-- ('Lemon Juice'),
-- ('Lemon Twist'),
-- ('Lemongrass'),
-- ('Lime'),
-- ('Melon Liqueur'),
-- ('Milk'),
-- ('Mint'),
-- ('Molasses'),
-- ('Nutmeg'),
-- ('Okra'),
-- ('Olive Oil'),
-- ('Onion'),
-- ('Orange'),
-- ('Orange Juice'),
-- ('Oregano'),
-- ('Paprika'),
-- ('Parsley'),
-- ('Peach Schnapps'),
-- ('Pecans'),
-- ('Pimiento'),
-- ('Poblan Pepper'),
-- ('Poppy Seeds'),
-- ('Potatoes'),
-- ('Rock Salt'),
-- ('Rolled Oats'),
-- ('Romesco'),
-- ('Rosemary'),
-- ('Rum'),
-- ('Saffron'),
-- ('Sage'),
-- ('Salmon'),
-- ('Scotch'),
-- ('Sea Salt'),
-- ('Farro Seeds'),
-- ('Serrano'),
-- ('Sesame Seeds'),
-- ('Shallot'),
-- ('Shrimp'),
-- ('Sour Cream'),
-- ('Southern Comfort'),
-- ('Sparkling Wine'),
-- ('Sprite'),
-- ('Strawberry'),
-- ('Sugar'),
-- ('Sweet and Sour'),
-- ('Sweet Vermouth'),
-- ('Dry Vermouth'),
-- ('Table Salt'),
-- ('Tarragon'),
-- ('Tequila'),
-- ('Thai'),
-- ('Thyme'),
-- ('Tomato Pase'),
-- ('Tomato Sauce'),
-- ('Tomatoes'),
-- ('Triple Sec'),
-- ('Turmeric'),
-- ('Vanilla Bean'),
-- ('Vanilla Extract'),
-- ('Vanilla Vodka'),
-- ('Vodka'),
-- ('Gin'),
-- ('Walnuts'),
-- ('Water'),
-- ('Whipping Cream'),
-- ('Whisky'),
-- ('Whie Crem de Menthe'),
-- ('White Peach'),
-- ('White Rice'),
-- ('White Vinegar'),
-- ('Wine'),
-- ('Worcestershire Souce'),
-- ('Yellow Onion'),
-- ('Yogurt')
-- ;

-- CREATE TABLE ingredients_temp (
--     id INTEGER PRIMARY KEY,
--     name TEXT NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
--
-- INSERT INTO ingredients_temp (id, name, created_at)
-- SELECT id, name, created_at FROM ingredients;
--
-- DROP TABLE ingredients;
--
-- ALTER TABLE ingredients_temp RENAME TO ingredients;
--
-- -- Trigger to set updated_at to current timestamp on update
-- CREATE TRIGGER set_updated_at
-- AFTER UPDATE ON ingredients
-- FOR EACH ROW
-- BEGIN
--     UPDATE ingredients SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
-- END;


INSERT INTO recipes (name)
VALUES
  ('French Toash'),
  ('Strawberry Creami'),
  ('Oatmeal Cookies'),
  ('Beff Bulgogi Bowl'),
  ('Chicken Sausage and Ricotta Ravioli'),
  ('Hurry Up Biscuits'),
  ('Pineapple Poblano Beef Tacos'),
  ('Bison Pasta'),
  ('Frijoles Fresca'),
  ('Beef Burrito Bowls'),
  ('Chicken Pineapple Quesadillas'),
  ('Chilli'),
  ('Korean Beef Bibimbap'),
  ('Steak Tips and Creamy Truffle Fettucine'),
  ('Balsamic Fig Chicken'),
  ('Cherry Balsamic Pork Chops'),
  ('Hot Honey Chicken'),
  ('One-Pan Penut Udon Stir Fry'),
  ('Orange Glazed Salmon'),
  ('Parmesan-crusted Chicken'),
  ('Pork Carnitas Tacos'),
  ('Tuscan Sausage and Pepper'),
  ('Curried Cauliflower'),
  ('Curry and Soy-Glazed Chicken'),
  ('Firecracker meatballs'),
  ('Garlic-Caper Chicken'),
  ('Jucy Lucy Burger'),
  ('Pork Enchilada'),
  ('Scallops Over Creamy Lemon Fettucine'),
  ('Steak and Cheesy Mashed Potatoes'),
  ('Cheesy Artichoke and Romesco Baked Chicken'),
  ('Chicken and Farro'),
  ('Crispy Baked Chicken and Ancho Honey Sauce'),
  ('Pork Chops with Asparagus Salad'),
  ('Seared Steaks and Lemon-caper Butter'),
  ('Chorizo Tacos'),
  ('Miso-Maple Chicken Thighs and Rice'),
  ('Sheet Pan Pork Roast'),
  ('Amaretto Sour'),
  ('Apple Cinnamon Oatmeal'),
  ('Apple Dijon Braised Chicken'),
  ('Appletini'),
  ('Banana Bread Bowl'),
  ('Banana Pudding'),
  ('Bay Breeze'),
  ('Black Bean Chilli'),
  ('Black Russian'),
  ('Bloody Mary'),
  ('Breakfast Tacos'),
  ('Butter Chicken'),
  ('Cabbage Salad'),
  ('Cape Cod'),
  ('Chicken Chips'),
  ('Chicken Dumplings'),
  ('Chicken Enchiladas'),
  ('Chocolate Martini'),
  ('Cinnamon Pecans'),
  ('Colorado Bulldog'),
  ('Cosmopolitan'),
  ('Cottage Cheese Bowl'),
  ('Crispy Buffalo Wings'),
  ('Crispy Parmesan Chicken'),
  ('Dark and Stormy'),
  ('Face Eraser'),
  ('Fried Chicken'),
  ('Frozen Vegetable Stir Fry'),
  ('Fuzzy Navel'),
  ('Garlic Butter Salmon'),
  ('Gimlet'),
  ('Godfather'),
  ('Godmother'),
  ('Greyhound'),
  ('Hasselback Potatoes'),
  ('Herb Grilled Chicken'),
  ('Honey Sesame Chicken'),
  ('Incredible Hulk'),
  ('Italian Stinger'),
  ('Jambalaya'),
  ('Joe Collins'),
  ('John Collins'),
  ('Lemon Chicken Wraps'),
  ('Lemon Drop'),
  ('Long Beach Tea'),
  ('Long Island Iced Tea'),
  ('Lynchburg Lemonade'),
  ('Madras'),
  ('Manhattan'),
  ('Melon Ball Cocktail'),
  ('Michael Scotch'),
  ('Mind Eraser'),
  ('Mini Cheesecake'),
  ('Orange Crush'),
  ('Painkiller'),
  ('Pancakes'),
  ('Peanut Butter Granola'),
  ('Pecan Pie'),
  ('Pinkman'),
  ('Pound Cake'),
  ('Raspberry Tea'),
  ('Red Rum Sour'),
  ('Red Sauce'),
  ('Rob Roy'),
  ('Royal Blue Smoothie'),
  ('Rusy Nail'),
  ('Sally Collins'),
  ('Salty Dog'),
  ('Savory Oatmeal'),
  ('Screwdriver'),
  ('Sea Breeze'),
  ('Sex on the Beach'),
  ('Shrimp Packets'),
  ('Singapore Sling'),
  ('Sloe Gin Fizz'),
  ('Slow Comfortable Screw'),
  ('Slow Screw'),
  ('Slushi Creami'),
  ('Smoke Salmon Toast'),
  ('Sombrero'),
  ('South Padre Tea'),
  ('Stinger'),
  ('Stone Sour'),
  ('Sweet Potato Fries'),
  ('Tequila Sunrise'),
  ('Tiramasu'),
  ('Tiramisu Martini'),
  ('Tom Collins'),
  ('Tomato Soup'),
  ('Truffle Risotto'),
  ('Tuscan Chicken Skillet'),
  ('Twice Baked Potato Casserole'),
  ('Vanilla Creami'),
  ('Vodka Cherry Sour'),
  ('Washinton Apple'),
  ('Water Mocasin'),
  ('Whisky Sour'),
  ('Woo'),
  ('White Russian'),
  ('Yogurt Parfait'),
  ('Chocolate Creami');


