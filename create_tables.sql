DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  seller_rating DOUBLE,
  driver_rating DOUBLE,
  driver_reviews_num INT
);

DROP TABLE IF EXISTS salesdata;
CREATE TABLE salesdata (
  seller_id INT AUTO_INCREMENT PRIMARY KEY,
  seller_name VARCHAR(255),
  rating INT(255),
  price INT,
  price_drop INT
);

DROP TABLE IF EXISTS color;
CREATE TABLE color (
  color_id INT AUTO_INCREMENT PRIMARY KEY,
  exterior_color VARCHAR(255),
  interior_color VARCHAR(255)
);

DROP TABLE IF EXISTS usage_statistics;
CREATE TABLE usage_statistics (
  usage_stats_id INT AUTO_INCREMENT PRIMARY KEY,
  accidents_or_damage VARCHAR(255),
  one_owner VARCHAR(255),
  personal_use_only VARCHAR(255)
);


DROP TABLE IF EXISTS engine_specs;
CREATE TABLE engine_specs (
  engine_id INT AUTO_INCREMENT PRIMARY KEY,
  cylinder_placement VARCHAR(255),
  cubic_capacity_L double,
  injection_type VARCHAR(255),
  turbo int
);

DROP TABLE IF EXISTS transmission;
CREATE TABLE transmission (
  transmission_id INT AUTO_INCREMENT PRIMARY KEY,
  speed_ratios INT,
  transmision_mode VARCHAR(255),
  remarks VARCHAR(255)
);

DROP TABLE IF EXISTS drivetrain;
CREATE TABLE drivetrain (
  drivetrain_id INT AUTO_INCREMENT PRIMARY KEY,
  drivetrain  VARCHAR(255)
);

DROP TABLE IF EXISTS fuel_type;
CREATE TABLE fuel_type (
  fuel_type_id INT AUTO_INCREMENT PRIMARY KEY,
  fuel_type  VARCHAR(255)
);

DROP TABLE IF EXISTS mpg;
CREATE TABLE mpg (
  mpg_group_id INT AUTO_INCREMENT PRIMARY KEY,
  mpg  VARCHAR(255)
);

DROP TABLE IF EXISTS technical_details;
CREATE TABLE technical_details (
  tech_config_id INT AUTO_INCREMENT PRIMARY KEY,
  engine_id INT,
  transmission_id INT,
  drivetrain_id INT,
  fuel_type_id INT,
  mpg_group_id INT
);

DROP TABLE IF EXISTS mileage;
CREATE TABLE mileage (
  mileage_group_id INT AUTO_INCREMENT PRIMARY KEY,
  mileage  INT
  );
  
DROP TABLE IF EXISTS prod_year;
CREATE TABLE prod_year (
  prod_year_group_id INT AUTO_INCREMENT PRIMARY KEY,
  prod_year  INT
  );

DROP TABLE IF EXISTS vehicle_details;
CREATE TABLE vehicle_details (
  vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
  manufacturer VARCHAR(255),
  model VARCHAR(255),
  prod_year_group_id VARCHAR(255),
  mileage_group_id INT, 
  tech_config_id INT,
  color_id INT,
  usage_stats_id INT,
  sales_data INT
);


