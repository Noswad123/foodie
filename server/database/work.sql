-- insert into recipes (name, type_id)
--   values

select recipes.id, recipes.name as recipe, recipe_types.name as type from recipes
join recipe_types on recipes.type_id=recipe_types.id;

-- select id, name from recipes;

-- select id, name, ingredient_type_id from ingredients order by name;
-- delete from ingredients where id in (46, 67);

-- insert into ingredient_types (name) values ();
--
-- UPDATE ingredient_typesi SET name='fruits' WHERE id=1;


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

