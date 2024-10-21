--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.4 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: cooking_techniques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cooking_techniques (id, name, description) FROM stdin;
1	Grilling	Cooking food over an open flame or heat source.
2	Baking	Cooking food by surrounding it with dry, hot air in an oven.
3	Frying	Cooking food by submerging it in hot oil or fat.
4	Boiling	Cooking food by submerging it in boiling water or liquid.
\.


--
-- Data for Name: ingredient_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredient_types (id, name) FROM stdin;
1	Fruit
2	Vegetable
3	Protein
4	Grain
5	Dairy
19	Baking Ingredient
20	Broth
21	Spice
23	Coffee
24	Cereal
27	Garnish
28	Oil
29	Nuts
30	Alcohol
31	Sweetener
32	Flavoring
33	Juice
34	Carbonated Beverage
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredients (id, name, ingredient_type_id, notes, created_at, updated_at) FROM stdin;
1	Apple	1	Red and delicious	2023-12-31 14:14:53.534359	2023-12-31 14:14:53.534359
2	Carrot	2	Orange and crunchy	2023-12-31 14:14:53.534359	2023-12-31 14:14:53.534359
3	Chicken Breast	3	Skinless and boneless	2023-12-31 14:14:53.534359	2023-12-31 14:14:53.534359
4	Rice	4	Long-grain white rice	2023-12-31 14:14:53.534359	2023-12-31 14:14:53.534359
5	Milk	5	Whole milk	2023-12-31 14:14:53.534359	2023-12-31 14:14:53.534359
8	Baking Powder	19	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
9	Banana	1	Ripe and yellow	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
10	Beef Broth	20	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
11	Black Pepper	21	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
12	Butter	5	Unsalted	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
13	Cayenne Pepper	21	Spicy	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
14	Cherry	1	Sweet and juicy	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
15	Chilled Espresso	23	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
16	Chili Powder	21	For a hint of heat	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
17	Chocolate Sprinkles	19	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
18	Cinnamon	21	Ground	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
19	Cocoa Powder	19	Unsweetened	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
20	Coffee Beans	23	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
21	Corn Flakes	24	Cereal	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
22	Eggs	5	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
23	Garlic Powder	21	For flavor	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
24	Ground Beef	3	Lean	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
25	Ground Cumin	21	\N	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
26	Lemon Twist	1	For garnish	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
27	Lime	1	Citrus fruit	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
29	Nutmeg	21	Ground	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
30	Olive Oil	28	Extra virgin	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
31	Pecans	29	Nuts	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
32	Rolled Oats	24	Oatmeal	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
33	Salt	21	Table salt	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
34	Sugar	19	Granulated sugar	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
35	Tomato Paste	\N	Concentrated tomato	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
36	Tomato Sauce	\N	Sauce	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
38	Vanilla Extract	19	Pure extract	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
39	Walnuts	29	Nuts	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
60	Tequila	30	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
61	Triple sec	30	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
62	Bourbon	30	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
63	Sugar cube	31	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
64	Angostura bitters	32	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
65	Vodka	30	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
66	Cranberry juice	33	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
68	White rum	30	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
69	Fresh mint leaves	\N	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
70	Soda water	34	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
71	Pineapple juice	33	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
72	Coconut cream	5	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
74	Cranberry Juice	33	\N	2024-01-01 13:33:15.890712	2024-01-01 13:33:15.890712
73	Triple Sec	30	\N	2024-01-01 13:33:15.890712	2024-01-01 13:33:15.890712
67	Lime juice	33	\N	2024-01-01 12:39:36.20134	2024-01-01 12:39:36.20134
40	Yellow Onion	2	Onion	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
37	Tomatoes	1	Fresh tomatoes	2023-12-31 14:33:37.519498	2023-12-31 14:33:37.519498
\.


--
-- Data for Name: measurement_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurement_units (id, name) FROM stdin;
1	cup
2	teaspoon
3	gram
4	ounce
5	pound
19	tablespoon
24	dozen
26	each
28	dash
\.


--
-- Data for Name: recipe_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_types (id, name) FROM stdin;
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipes (id, name, type_id, instructions, prep_time, cooking_time, created_at, updated_at) FROM stdin;
1	Margarita	\N	\N	\N	\N	2024-01-01 13:12:29.983485	2024-01-01 13:12:29.983485
2	Old Fashioned	\N	\N	\N	\N	2024-01-01 13:12:29.983485	2024-01-01 13:12:29.983485
3	Cosmopolitan	\N	\N	\N	\N	2024-01-01 13:12:29.983485	2024-01-01 13:12:29.983485
4	Mojito	\N	\N	\N	\N	2024-01-01 13:12:29.983485	2024-01-01 13:12:29.983485
5	Pina Colada	\N	\N	\N	\N	2024-01-01 13:12:29.983485	2024-01-01 13:12:29.983485
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_ingredients (id, recipe_id, ingredient_id, measurement_unit_id, quantity) FROM stdin;
1	3	65	4	2.5
2	3	74	4	0.5
3	3	73	4	0.5
\.


--
-- Data for Name: recipe_techniques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_techniques (recipe_id, technique_id) FROM stdin;
\.


--
-- Name: cooking_techniques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cooking_techniques_id_seq', 4, true);


--
-- Name: ingredient_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredient_types_id_seq', 34, true);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 76, true);


--
-- Name: measurement_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measurement_units_id_seq', 28, true);


--
-- Name: recipe_ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_ingredients_id_seq', 3, true);


--
-- Name: recipe_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_types_id_seq', 1, false);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipes_id_seq', 5, true);


--
-- PostgreSQL database dump complete
--

