-- create table
CREATE TABLE `cars` (
  `manufacturer` text DEFAULT NULL,
  `model` text DEFAULT NULL,
  `year` text DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `engine` text DEFAULT NULL,
  `transmission` text DEFAULT NULL,
  `drivetrain` text DEFAULT NULL,
  `fuel_type` text DEFAULT NULL,
  `mpg` text DEFAULT NULL,
  `exterior_color` text DEFAULT NULL,
  `interior_color` text DEFAULT NULL,
  `accidents_or_damage` text DEFAULT NULL,
  `one_owner` text DEFAULT NULL,
  `personal_use_only` text DEFAULT NULL,
  `seller_name` text DEFAULT NULL,
  `seller_rating` double DEFAULT NULL,
  `driver_rating` double DEFAULT NULL,
  `driver_reviews_num` int(11) DEFAULT NULL,
  `price_drop` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
);

-- import cars
LOAD DATA INFILE 'S:\\OneDrive\\THU\\00.Semester4\\DAWA\\Project\\CarsDataset\\cars.csv' 
INTO TABLE cars 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Create primary key
ALTER TABLE cars ADD car_id int NOT NULL AUTO_INCREMENT primary key FIRST;

-- Drop column
ALTER TABLE cars DROP COLUMN new_column;

-- copy table from existing table
CREATE TABLE cars_clean
AS SELECT
  *
FROM cars;

-- #####################
