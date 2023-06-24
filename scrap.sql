SELECT distinct model, manufacturer
FROM `cars_cleansed`.`cars` LIMIT 12000;


SELECT DISTINCT model, count( distinct model),
manufacturer,
 mpg, 
   -- CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) AS lim_1,
 --   CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) AS lim_2,
	 CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 AS average,
		CASE
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 130 THEN 'A++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 100 THEN 'A+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 80 THEN 'A'
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 50 THEN 'B++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 30 THEN 'B+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 10 THEN 'B'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 >= 1 THEN 'C'
         ELSE 'Unknown'
     END AS Class
FROM
    cars_cleansed.cars
    Group By model
    ORDER BY FIELD(Class, 'A++', 'A+', 'A', 'B++', 'B+', 'B', 'C', 'Unknown') ASC LIMIT 30000;
    
SELECT DISTINCT model, 
		CASE
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 130 THEN 'A++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 100 THEN 'A+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 80 THEN 'A'
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 50 THEN 'B++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 30 THEN 'B+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 > 10 THEN 'B'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(4,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(4,2)) / 2 >= 1 THEN 'C'
         ELSE 'Unknown'
     END AS mpg_efficiency_class
FROM
    cars_cleansed.cars
    Group By model
    ORDER BY FIELD(mpg_efficiency_class, 'A++', 'A+', 'A', 'B++', 'B+', 'B', 'C', 'Unknown') ASC LIMIT 30000;
    
    
    
INSERT INTO cars_dwh_cdwh.vehicle_model(model)
(SELECT model FROM cars_cleansed.cars);


SELECT cd_vm.model, v_man.manufacturer, v_man.id_manufacturer
FROM
cars_dwh_cdwh.vehicle_model cd_vm,
cars_dwh_cdwh.vehicle_manufacturer v_man,
cars_cleansed.cars cc_cars
WHERE 
cd_vm.model = cc_cars.manufacturer AND
cc_cars.manufacturer = v_man.manufacturer;

INSERT INTO cars_dwh_cdwh.vehicle_model(id_manufacturer)
(
SELECT cd_vm.model, v_man.manufacturer, v_man.id_manufacturer FROM
	cars_dwh_cdwh.vehicle_model cd_vmanufacturerm INNER JOIN cars_cleansed.cars cc_cars
    ON cd_vm.model = cc_cars.model
    INNER JOIN cars_dwh_cdwh.vehicle_manufacturer v_man
    ON cc_cars.manufacturer = v_man.manufacturer
    GROUP BY cd_vm.model
    );
    


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


ALTER TABLE cars DROP INDEX driver_rating;

CREATE TABLE IF NOT EXISTS models_mpg_class (
  model VARCHAR(100) NOT NULL,
  mpg_class varchar(100) NOT NULL
);

INSERT INTO models_mpg_class (model, mpg_class)
SELECT DISTINCT model, 
		CASE
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 130 THEN 'A++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 100 THEN 'A+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 80 THEN 'A'
			WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 50 THEN 'B++'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 30 THEN 'B+'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 > 10 THEN 'B'
            WHEN CAST(SUBSTRING_INDEX(TRIM(mpg), '-', 1) AS DECIMAL(6,2)) + CAST(SUBSTRING_INDEX(TRIM(mpg), '-', -1) AS DECIMAL(6,2)) / 2 >= 1 THEN 'C'
         ELSE 'Unknown'
     END AS mpg_class
FROM
    cars_cleansed.cars
    Group By model
    ORDER BY FIELD(mpg_class, 'A++', 'A+', 'A', 'B++', 'B+', 'B', 'C', 'Unknown') ASC;
    
-- Add index
ALTER TABLE models_mpg_class ADD KEY(model, mpg_class);

INSERT INTO cars_dwh_cdwh.color(exterior_color)
(SELECT
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
     END AS exterior_color
FROM cars_ETL.cars
);

ALTER TABLE cars_ETL.sales_intermediary AUTO_INCREMENT = 1;
UPDATE sales_intermediary
SET id_paintfinish = NULL;

