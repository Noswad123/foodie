-- insert into recipes (name, type_id)
--   values

-- select recipes.id, recipes.name as recipe, recipe_types.name as type from recipes
-- join recipe_types on recipes.type_id=recipe_types.id;

-- INSERT INTO measurement_units (name, abbreviation) VALUES
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
-- ('dash', 'dash'),
-- ('pinch', 'pinch'),
-- ('each', 'ea'),
-- ('pound', 'lb');

-- select * from measurement_units;

select ri.id, r.name, i.id, i.name, quantity, ri.measurement_unit_id, mu.name from recipe_ingredients ri
left join ingredients i on ri.ingredient_id=i.id
left join recipes r on ri.recipe_id=r.id
left join measurement_units mu on ri.measurement_unit_id=mu.id;

-- INSERT INTO recipe_ingredients (recipe_id, ingredient_id, measurement_unit_id, quantity)
-- VALUES
-- ((SELECT id FROM recipes WHERE name = 'Margarita'),
--  (SELECT id FROM ingredients WHERE name = 'Tequila'),
--  (SELECT id FROM measurement_units WHERE abbreviation = 'oz'),
--  1.5),
-- ((SELECT id FROM recipes WHERE name = 'Margarita'),
--  (SELECT id FROM ingredients WHERE name = 'Triple Sec'),
--  (SELECT id FROM measurement_units WHERE abbreviation = 'oz'),
--  .5),
-- ((SELECT id FROM recipes WHERE name = 'Margarita'),
--  (SELECT id FROM ingredients WHERE name = 'Lime Juice'),
--  (SELECT id FROM measurement_units WHERE abbreviation = 'oz'),
--  .5),
-- ((SELECT id FROM recipes WHERE name = 'Margarita'),
--  (SELECT id FROM ingredients WHERE name = 'Salt'),
--  (SELECT id FROM measurement_units WHERE name = 'pinch'),
--  1);

-- select id, name from recipes;

-- select id, name, ingredient_type_id from ingredients order by name;
-- delete from ingredients where id in (46, 67);

-- insert into ingredient_types (name) values ();
--
-- UPDATE ingredient_types SET name='fruits' WHERE id=1;


-- UPDATE ingredients SET ingredient_type_id=7 WHERE id in (12);
-- insert into ingredient_types (name) values ();

-- select * from ingredient_types;

-- INGREDIENTS
-- select id, name from ingredients order by name;



-- SELECT ingredients.name AS ingredient_name, ingredient_types.name AS ingredient_type_name
-- FROM ingredients
-- JOIN ingredient_types ON ingredients.ingredient_type_id = ingredient_types.id;


-- insert into recipe_types (name) values ('alcoholic beverage')
-- update recipes set type_id=1;
-- select id, name, type_id, instructions from recipes;

-- update ingredient_types set name='non-meat protein' where id=13;

-- select * from ingredient_types;

