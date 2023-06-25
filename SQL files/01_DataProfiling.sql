-- Data profiling to understand the data
-- check for null values in manufacturer 

SELECT DISTINCT (manufacturer) FROM cars.cars
order by manufacturer ASC;


SELECT COUNT(DISTINCT (manufacturer)) FROM cars.cars;
-- ANS: 30

-- #############################################

SELECT DISTINCT model FROM cars.cars
order by model ASC;

SELECT COUNT(DISTINCT model) FROM cars.cars;
-- ANS: 11923

SELECT * FROM cars.cars
WHERE model LIKE "" OR model LIKE "%NULL%" or model LIKE " "
order by model ASC;
-- Observation: There can be "NULL" as model 

-- #############################################

SELECT COUNT(DISTINCT (year)) FROM cars.cars;
-- ANS: 100

SELECT DISTINCT (year) FROM cars.cars
order by year ASC;

SELECT MIN(CAST(year AS UNSIGNED)), MAX(CAST(year AS UNSIGNED)) FROM cars.cars;
-- ANS:  1915, 2024

SELECT year FROM cars.cars where CAST(year AS UNSIGNED) = 0 OR CAST(year AS UNSIGNED) > 2023
order by year ASC;

SELECT * FROM cars.cars where CAST(year AS UNSIGNED) > 2023
order by year ASC;
-- Observation: 2 cars have year 2024

-- #############################################

SELECT COUNT(DISTINCT (mileage)) FROM cars.cars;
-- ANS: 158751

SELECT MAX(mileage), MIN(mileage) FROM cars.cars;
-- ANS: 119067, 0

SELECT DISTINCT (mileage) FROM cars.cars
order by mileage ASC;
-- OBS: mileage is like 1,2,3..etc. Need to classify into categories

-- #############################################

SELECT COUNT(DISTINCT (engine)) FROM cars.cars;
-- ANS: 6804

SELECT DISTINCT (engine) FROM cars.cars
order by engine ASC;

-- #############################################
SELECT COUNT(DISTINCT (transmission)) FROM cars.cars;
-- ANS: 1173

SELECT DISTINCT (transmission) FROM cars.cars
order by transmission ASC limit 20000;

-- #############################################

SELECT COUNT(DISTINCT (drivetrain)) FROM cars.cars;
-- ANS: 30

SELECT DISTINCT (drivetrain) FROM cars.cars
order by drivetrain ASC;

-- #############################################

SELECT COUNT(DISTINCT (fuel_type)) FROM cars.cars;
-- ANS: 38

SELECT DISTINCT (fuel_type) FROM cars.cars
order by fuel_type ASC;

-- #############################################


SELECT COUNT(DISTINCT (mpg)) FROM cars.cars;
-- ANS: 867

SELECT DISTINCT (mpg) FROM cars.cars
order by mpg ASC limit 10000;

-- #############################################


SELECT COUNT(DISTINCT (exterior_color)) FROM cars.cars;
-- ANS: 7212

SELECT DISTINCT (exterior_color) FROM cars.cars
order by exterior_color ASC limit 30000;

SELECT *FROM cars.cars
WHERE (LOWER(exterior_color) LIKE LOWER("matte %")) OR (LOWER(exterior_color) LIKE LOWER("% matte %")) OR (LOWER(exterior_color) LIKE LOWER("% matte"))
order by exterior_color ASC limit 30000;


SELECT *FROM cars.cars
WHERE (LOWER(exterior_color) LIKE LOWER("pearl%")) OR (LOWER(exterior_color) LIKE LOWER("%pearl%")) OR (LOWER(exterior_color) LIKE LOWER("%pearl"))
order by exterior_color ASC limit 700000;

SELECT *FROM cars.cars
WHERE (LOWER(exterior_color) LIKE LOWER("metal%")) OR (LOWER(exterior_color) LIKE LOWER("%metal%")) OR (LOWER(exterior_color) LIKE LOWER("%metal"))
order by exterior_color ASC limit 700000;

-- #############################################


SELECT COUNT(DISTINCT (interior_color)) FROM cars.cars;
-- ANS: 4401

SELECT DISTINCT (interior_color) FROM cars.cars
order by interior_color ASC;

-- #############################################


SELECT COUNT(DISTINCT (accidents_or_damage)) FROM cars.cars;
-- ANS: 9

SELECT DISTINCT (accidents_or_damage) FROM cars.cars
order by accidents_or_damage ASC;

Select * from cars.cars
WHERE accidents_or_damage = "</sup> With Gray Sapele Wedgewood With Alu" OR accidents_or_damage = "Black";

-- #############################################


SELECT COUNT(DISTINCT (one_owner)) FROM cars.cars;
-- ANS: 3

SELECT DISTINCT (one_owner) FROM cars.cars
order by one_owner ASC;

SELECT COUNT(*) FROM cars.cars
WHERE one_owner = ""
order by one_owner ASC;
-- ANS: 31483

-- #############################################


SELECT COUNT(DISTINCT (personal_use_only)) FROM cars.cars;
-- ANS: 3

SELECT DISTINCT (personal_use_only) FROM cars.cars
order by personal_use_only ASC;

SELECT COUNT(*) FROM cars.cars
WHERE personal_use_only = ""
order by personal_use_only ASC;
-- ANS: 24852

-- #############################################

SELECT COUNT(DISTINCT (seller_name)) FROM cars.cars;
-- ANS: 18240

SELECT DISTINCT (seller_name) FROM cars.cars
order by seller_name ASC LIMIT 20000;

-- #############################################

SELECT COUNT(DISTINCT (seller_rating)) FROM cars.cars;
-- ANS: 42

SELECT DISTINCT (seller_rating) FROM cars.cars
order by seller_rating ASC;

-- #############################################

SELECT COUNT(DISTINCT (driver_rating)) FROM cars.cars;
-- ANS: 36

SELECT DISTINCT (driver_rating) FROM cars.cars
order by driver_rating ASC;

-- #############################################

SELECT COUNT(DISTINCT (driver_reviews_num)) FROM cars.cars;
-- ANS: 369

SELECT DISTINCT (driver_reviews_num) FROM cars.cars
order by driver_reviews_num ASC;

-- min, max: 0, 1025

-- #############################################

SELECT COUNT(DISTINCT (price_drop)) FROM cars.cars;
-- ANS: 6409

SELECT DISTINCT (price_drop) FROM cars.cars
order by price_drop ASC;

-- min, max: 0, 1094

-- #############################################

SELECT COUNT(DISTINCT (price)) FROM cars.cars;
-- ANS: 63466

SELECT DISTINCT (price) FROM cars.cars
order by price ASC LIMIT 10000

-- min, max: 0, 18106