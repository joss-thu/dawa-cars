-- ---------------------------------------------
-- Create cars_ETL and import all data
-- ---------------------------------------------
DROP DATABASE IF EXISTS cars_ETL;
CREATE DATABASE cars_ETL;

create table cars_ETL.cars
Select * from cars.cars;
-- ################
-- index cars table
-- ################
ALTER TABLE cars ADD KEY (manufacturer);
ALTER TABLE cars ADD KEY (model);
ALTER TABLE cars ADD KEY (year);
ALTER TABLE cars ADD KEY (mileage);
ALTER TABLE cars ADD KEY (engine);
ALTER TABLE cars ADD KEY (transmission);
ALTER TABLE cars ADD KEY (drivetrain);
ALTER TABLE cars ADD KEY (fuel_type);
ALTER TABLE cars ADD KEY (mpg);
ALTER TABLE cars ADD KEY (exterior_color);
ALTER TABLE cars ADD KEY (interior_color);
ALTER TABLE cars ADD KEY (accidents_or_damage);
ALTER TABLE cars ADD KEY (one_owner);
ALTER TABLE cars ADD KEY (personal_use_only);
ALTER TABLE cars ADD KEY (seller_name);
ALTER TABLE cars ADD KEY (seller_rating);
ALTER TABLE cars ADD KEY (driver_rating);
ALTER TABLE cars ADD KEY (driver_reviews_num);
ALTER TABLE cars ADD KEY (price_drop);
ALTER TABLE cars ADD KEY (price);

-- ---------------------------------------------
-- dimen_vehicle => vehicle_mpg_efficiency_class 
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.vehicle_mpg_efficiency_class(mpg_efficiency_class) VALUES
('A++'),
('A+'),
('A'),
('B++'),
('B+'),
('B'),
('C'),
('Unknown');

-- ---------------------------------------------
-- dimen_vehicle => vehicle_manufacturer
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.vehicle_manufacturer(manufacturer)
SELECT distinct manufacturer FROM `cars_ETL`.`cars`;

-- ---------------------------------------------
## Create intermediary database and tables
-- ---------------------------------------------
#########################
-- vehicle_model intermediary table
#########################
USE cars_ETL;

DROP TABLE IF EXISTS vehicle_model_intermediary;
create Table vehicle_model_intermediary(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	id_manufacturer INT,
    manufacturer VARCHAR(100),
	id_efficiency INT NOT NULL ,
    efficiency_class VARCHAR(100),
    model VARCHAR(100)
);

INSERT INTO vehicle_model_intermediary(model, manufacturer, efficiency_class)
(SELECT DISTINCT model,  manufacturer, 
		CASE
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 130 THEN 'A++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 100 THEN 'A+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 80 THEN 'A'
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 50 THEN 'B++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 30 THEN 'B+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 10 THEN 'B'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 >= 1 THEN 'C'
         ELSE 'Unknown'
     END AS efficiency_class
FROM cars_ETL.cars
    Group By model -- The mapping model-> mpg is not one to one, but for this scenario, it is made one-to-one by grouping
    -- ORDER BY FIELD(efficiency_class, 'A++', 'A+', 'A', 'B++', 'B+', 'B', 'C', 'Unknown') ASC
    );

UPDATE vehicle_model_intermediary
JOIN cars_dwh_cdwh.vehicle_manufacturer vm ON vehicle_model_intermediary.manufacturer = vm.manufacturer
SET vehicle_model_intermediary.id_manufacturer = vm.id_manufacturer;

UPDATE vehicle_model_intermediary
JOIN cars_dwh_cdwh.vehicle_mpg_efficiency_class vmpg ON vehicle_model_intermediary.efficiency_class = vmpg.mpg_efficiency_class
SET vehicle_model_intermediary.id_efficiency = vmpg.id_efficiency;

ALTER TABLE vehicle_model_intermediary DROP COLUMN manufacturer;
ALTER TABLE vehicle_model_intermediary DROP COLUMN efficiency_class;
#########################
-- ---------------------------------------------
-- dimen_vehicle => vehicle_model
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.vehicle_model(id_manufacturer,id_efficiency,model)
SELECT id_manufacturer, id_efficiency, model FROM cars_ETL.vehicle_model_intermediary;
-- ---------------------------------------------
-- dimen_vehicle => accidents_or_damage
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.accidents_or_damage(accidents_or_damage)VALUES
('Yes'),
('No'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => one_owner
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.one_owner(one_owner_only)VALUES
('Yes'),
('No'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => personal_use_only
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.personal_use_only(personal_use_only)VALUES
('Yes'),
('No'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => color
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.color(exterior_color) VALUES
('Black'),
('White'),
('Grey'),
('Red'),
('Blue'),
('Green'),
('Yellow'),
('Silver'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => paint_finish
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.paint_finish(paint_finish) VALUES
('Matte'),
('Pearl'),
('Metal'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => fuel_type
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.fuel_type(fuel_category) VALUES
('Gasoline'),
('Diesel'),
('Hybrid'),
('Electric'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => mileage
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.mileage(mileage_category) VALUES
('Rundown'),
('Well used'),
('High'),
('Low'),
('New'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => prod_year_category
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.prod_year_category(prod_year_category) VALUES
('Brand new'),
('Used'),
('Old'),
('Classic'),
('Antique'),
('Vintage'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => transmission
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.transmission(transmission) VALUES
('Automatic'),
('Manual'),
('Unknown');
-- ---------------------------------------------
-- dimen_vehicle => driver_rating
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.driver_rating(driver_rating) VALUES
('Low'),
('Average'),
('High'),
('Unknown');

-- ---------------------------------------------
## Create intermediary database and tables
-- ---------------------------------------------
#########################
-- Fact table-sales intermediary table
#########################
USE cars_ETL;

DROP TABLE IF EXISTS sales_intermediary;
create Table sales_intermediary(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    price INT,
    amount_sold TINYINT,
    id_model INT,
	model VARCHAR(100),
    id_accidents TINYINT,
    accidents VARCHAR(50),
    id_one_owner TINYINT,
    one_owner VARCHAR(50),
    id_personal_use TINYINT,
    personal_use_only VARCHAR(50),
    id_color TINYINT,
    color_ext VARCHAR(100),
    id_paintfinish TINYINT,
    paint_finish VARCHAR(100),
    id_fuel_type TINYINT,
    fuel_type VARCHAR(100),
    id_mileage TINYINT,
    mileage_cat VARCHAR(100),
    id_prod_year_category TINYINT,
    prod_year_cat VARCHAR(100),
    id_transmission TINYINT,
    transmission_cat VARCHAR(100),
    id_driver_rating TINYINT,
    driver_rating VARCHAR(100)
);

INSERT INTO sales_intermediary(price, amount_sold, model,accidents,one_owner,personal_use_only,color_ext,paint_finish,fuel_type,mileage_cat,prod_year_cat,transmission_cat,driver_rating)
(SELECT price, 1 AS amount_sold, model, 
		CASE
			WHEN accidents_or_damage = '1' THEN 'Yes'
			WHEN accidents_or_damage = '0' THEN 'No'
			ELSE 'Unknown'
		END AS accidents,
		CASE
			WHEN one_owner = '1' THEN 'Yes'
			WHEN one_owner = '0' THEN 'No'
			ELSE 'Unknown'
		END AS one_owner,
		CASE
			WHEN personal_use_only = '1' THEN 'Yes'
			WHEN personal_use_only = '0' THEN 'No'
			ELSE 'Unknown'
		END AS personal_use_only,
		CASE
			WHEN (LOWER(exterior_color) LIKE LOWER("%black%")) THEN 'Black'
			WHEN (LOWER(exterior_color) LIKE LOWER("%white%")) THEN 'White'
			WHEN (LOWER(exterior_color) LIKE LOWER("%gray%")) THEN 'Grey'
			WHEN (LOWER(exterior_color) LIKE LOWER("%red%")) THEN 'Red'
			WHEN (LOWER(exterior_color) LIKE LOWER("%blue%")) THEN 'Blue'
			WHEN (LOWER(exterior_color) LIKE LOWER("%green%")) THEN 'Green'
			WHEN (LOWER(exterior_color) LIKE LOWER("%yellow%")) THEN 'Yellow'
			WHEN (LOWER(exterior_color) LIKE LOWER("%silver%")) THEN 'Silver'
			ELSE 'Unknown'
     END AS color_ext,
		CASE
			WHEN (LOWER(exterior_color) LIKE LOWER("%matte%")) THEN 'Matte'
			WHEN (LOWER(exterior_color) LIKE LOWER("%pearl%")) THEN 'Pearl'
			WHEN (LOWER(exterior_color) LIKE LOWER("%metal%")) THEN 'Metal'
			ELSE 'Unknown'
     END AS paint_finish,
		CASE
			WHEN (LOWER(fuel_type) LIKE LOWER("%gasoline%")) THEN 'Gasoline'
			WHEN (LOWER(fuel_type) LIKE LOWER("%diesel%")) THEN 'Diesel'
			WHEN (LOWER(fuel_type) LIKE LOWER("%hybrid%")) THEN 'Hybrid'
			WHEN (LOWER(fuel_type) LIKE LOWER("%electric%")) THEN 'Electric'
			ELSE 'Unknown'
     END AS fuel_type,
		CASE
			WHEN CAST(mileage AS UNSIGNED) >= 1000000 THEN 'Rundown'
			WHEN CAST(mileage AS UNSIGNED) >= 500000 THEN 'Well used'
			WHEN CAST(mileage AS UNSIGNED) >= 100000 THEN 'High'
			WHEN CAST(mileage AS UNSIGNED) >= 50000 THEN 'Low'
			WHEN CAST(mileage AS UNSIGNED) >= 500 THEN 'New'
			ELSE 'Unknown'
     END AS mileage_cat,
		CASE
			WHEN CAST(year AS UNSIGNED) >= 2022 THEN 'Brand new'
			WHEN CAST(year AS UNSIGNED) >= 2020 THEN 'Used'
			WHEN CAST(year AS UNSIGNED) >= 2000 THEN 'Old'
			WHEN CAST(year AS UNSIGNED) >= 1980 THEN 'Classic'
			WHEN CAST(year AS UNSIGNED) >= 1940 THEN 'Antique'
			WHEN CAST(year AS UNSIGNED) >= 1910 THEN 'Vintage'
			ELSE 'Unknown'
     END AS prod_year_cat,
		CASE
			WHEN (LOWER(transmission) LIKE LOWER("%automatic%")) THEN 'Automatic'
			WHEN (LOWER(transmission) LIKE LOWER("%manual%")) THEN 'Manual'
			ELSE 'Unknown'
     END AS transmission_cat,
     CASE
			WHEN CAST(driver_rating AS DECIMAL(4,2)) >= 4.0 THEN 'High'
			WHEN CAST(driver_rating AS DECIMAL(4,2)) >= 2.5 THEN 'Average'
			WHEN CAST(driver_rating AS DECIMAL(4,2)) >= 0.0 THEN 'Low'
			ELSE 'Unknown'
     END AS driver_rating
FROM cars_ETL.cars
);
##############
-- Add indices
##############
ALTER TABLE sales_intermediary ADD KEY (model);
ALTER TABLE sales_intermediary ADD KEY (accidents);
ALTER TABLE sales_intermediary ADD KEY (one_owner);
ALTER TABLE sales_intermediary ADD KEY (personal_use_only);
ALTER TABLE sales_intermediary ADD KEY (color_ext);
ALTER TABLE sales_intermediary ADD KEY (paint_finish);
ALTER TABLE sales_intermediary ADD KEY (fuel_type);
ALTER TABLE sales_intermediary ADD KEY (mileage_cat);
ALTER TABLE sales_intermediary ADD KEY (prod_year_cat);
ALTER TABLE sales_intermediary ADD KEY (transmission_cat);
ALTER TABLE sales_intermediary ADD KEY (driver_rating);

##############
-- Update intermediary tables
##############
UPDATE sales_intermediary
JOIN cars_dwh_cdwh.vehicle_model cdcvm ON sales_intermediary.model = cdcvm.model
SET sales_intermediary.id_model = cdcvm.id_model;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.accidents_or_damage cdc ON sales_intermediary.accidents = cdc.accidents_or_damage
SET sales_intermediary.id_accidents = cdc.id_accidents_damage;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.one_owner cdc ON sales_intermediary.one_owner = cdc.one_owner_only
SET sales_intermediary.id_one_owner = cdc.id_one_owner;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.personal_use_only cdc ON sales_intermediary.personal_use_only = cdc.personal_use_only
SET sales_intermediary.id_personal_use = cdc.id_personal_use_only;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.color cdc ON sales_intermediary.color_ext = cdc.exterior_color
SET sales_intermediary.id_color = cdc.id_exterior_color;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.paint_finish cdc ON sales_intermediary.paint_finish = cdc.paint_finish
SET sales_intermediary.id_paintfinish = cdc.id_paint_finish;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.fuel_type cdc ON sales_intermediary.fuel_type = cdc.fuel_category
SET sales_intermediary.id_fuel_type = cdc.id_fuelType;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.mileage cdc ON sales_intermediary.mileage_cat = cdc.mileage_category
SET sales_intermediary.id_mileage = cdc.id_mileage;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.prod_year_category cdc ON sales_intermediary.prod_year_cat = cdc.prod_year_category
SET sales_intermediary.id_prod_year_category = cdc.id_prod_year_category;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.transmission cdc ON sales_intermediary.transmission_cat = cdc.transmission
SET sales_intermediary.id_transmission = cdc.id_transmission;

UPDATE sales_intermediary
JOIN cars_dwh_cdwh.driver_rating cdc ON sales_intermediary.driver_rating = cdc.driver_rating
SET sales_intermediary.id_driver_rating = cdc.id_driver_rating;

#########################
-- ---------------------------------------------
-- Update fact table
-- ---------------------------------------------
INSERT INTO cars_dwh_cdwh.sales_data(price, amount_sold, id_model, id_accidents, id_one_owner, id_personal_use, id_color, id_paintfinish, id_fuel_type, id_mileage, id_prod_year_category, id_transmission, id_driver_rating)
SELECT price, amount_sold, id_model, id_accidents, id_one_owner, id_personal_use, id_color, id_paintfinish, id_fuel_type, id_mileage, id_prod_year_category, id_transmission, id_driver_rating FROM cars_ETL.sales_intermediary;

