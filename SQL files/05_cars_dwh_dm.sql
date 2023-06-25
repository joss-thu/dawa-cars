-- Create datamart
DROP DATABASE IF EXISTS cars_dwh_dm;
CREATE DATABASE cars_dwh_dm;
USE cars_dwh_dm;

-- create tables
DROP TABLE IF EXISTS `accidents_or_damage`;
CREATE TABLE `accidents_or_damage` (
  `id_accidents_damage` tinyint(4) NOT NULL AUTO_INCREMENT,
  `accidents_or_damage` tinytext NOT NULL,
  PRIMARY KEY (`id_accidents_damage`)
);

DROP TABLE IF EXISTS `color`;
CREATE TABLE `color` (
  `id_exterior_color` tinyint(4) NOT NULL AUTO_INCREMENT,
  `exterior_color` tinytext NOT NULL,
  PRIMARY KEY (`id_exterior_color`)
);

DROP TABLE IF EXISTS `driver_rating`;
CREATE TABLE `driver_rating` (
  `id_driver_rating` tinyint(4) NOT NULL AUTO_INCREMENT,
  `driver_rating` tinytext NOT NULL,
  PRIMARY KEY (`id_driver_rating`)
);

DROP TABLE IF EXISTS `fuel_type`;
CREATE TABLE `fuel_type` (
  `id_fuelType` tinyint(4) NOT NULL AUTO_INCREMENT,
  `fuel_category` tinytext NOT NULL,
  PRIMARY KEY (`id_fuelType`)
);

DROP TABLE IF EXISTS `mileage`;
CREATE TABLE `mileage` (
  `id_mileage` tinyint(4) NOT NULL AUTO_INCREMENT,
  `mileage_category` tinytext NOT NULL,
  PRIMARY KEY (`id_mileage`)
);

DROP TABLE IF EXISTS `one_owner`;
CREATE TABLE `one_owner` (
  `id_one_owner` tinyint(4) NOT NULL AUTO_INCREMENT,
  `one_owner_only` tinytext NOT NULL,
  PRIMARY KEY (`id_one_owner`)
);

DROP TABLE IF EXISTS `paint_finish`;
CREATE TABLE `paint_finish` (
  `id_paint_finish` tinyint(4) NOT NULL AUTO_INCREMENT,
  `paint_finish` tinytext NOT NULL,
  PRIMARY KEY (`id_paint_finish`)
);

DROP TABLE IF EXISTS `personal_use_only`;
CREATE TABLE `personal_use_only` (
  `id_personal_use_only` tinyint(4) NOT NULL AUTO_INCREMENT,
  `personal_use_only` tinytext NOT NULL,
  PRIMARY KEY (`id_personal_use_only`)
);
 
DROP TABLE IF EXISTS `prod_year_category`;
CREATE TABLE `prod_year_category` (
  `id_prod_year_category` tinyint(4) NOT NULL AUTO_INCREMENT,
  `prod_year_category` tinytext NOT NULL,
  PRIMARY KEY (`id_prod_year_category`)
);

DROP TABLE IF EXISTS `sales_data`;
CREATE TABLE `sales_data` (
  `id_vehicle` int(11) NOT NULL AUTO_INCREMENT,
  `price` int(11) NOT NULL,
  `amount_sold` tinyint(4) NOT NULL,
  `id_model` int(11) NOT NULL,
  `id_accidents` tinyint(4) NOT NULL,
  `id_one_owner` tinyint(4) NOT NULL,
  `id_personal_use` tinyint(4) NOT NULL,
  `id_color` tinyint(4) NOT NULL,
  `id_paintfinish` tinyint(4) NOT NULL,
  `id_fuel_type` tinyint(4) NOT NULL,
  `id_mileage` tinyint(4) NOT NULL,
  `id_prod_year_category` tinyint(4) NOT NULL,
  `id_transmission` tinyint(4) NOT NULL,
  `id_driver_rating` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_vehicle`)
);

DROP TABLE IF EXISTS `transmission`;
CREATE TABLE `transmission` (
  `id_transmission` tinyint(4) NOT NULL AUTO_INCREMENT,
  `transmission` tinytext NOT NULL,
  PRIMARY KEY (`id_transmission`)
);

DROP TABLE IF EXISTS `vehicle_model`;
CREATE TABLE `vehicle_model` (
  `id_model` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` tinytext NOT NULL,
  `mpg_efficiency_class` tinytext NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id_model`)
);

-- Insert Data
INSERT INTO vehicle_model(
	SELECT v_mod.id_model, v_man.manufacturer, v_mpg.mpg_efficiency_class, v_mod.model
    FROM cars_dwh_cdwh.vehicle_model v_mod JOIN cars_dwh_cdwh.vehicle_manufacturer v_man
    ON v_mod.id_manufacturer = v_man.id_manufacturer JOIN cars_dwh_cdwh.vehicle_mpg_efficiency_class v_mpg
    ON v_mod.id_efficiency = v_mpg.id_efficiency
);

INSERT INTO accidents_or_damage(
	SELECT * FROM cars_dwh_cdwh.accidents_or_damage
);


INSERT INTO color(
	SELECT * FROM cars_dwh_cdwh.color
);

INSERT INTO driver_rating(
	SELECT * FROM cars_dwh_cdwh.driver_rating
);

INSERT INTO fuel_type(
	SELECT * FROM cars_dwh_cdwh.fuel_type
);

INSERT INTO mileage(
	SELECT * FROM cars_dwh_cdwh.mileage
);

INSERT INTO one_owner(
	SELECT * FROM cars_dwh_cdwh.one_owner
);

INSERT INTO paint_finish(
	SELECT * FROM cars_dwh_cdwh.paint_finish
);

INSERT INTO personal_use_only(
	SELECT * FROM cars_dwh_cdwh.personal_use_only
);

INSERT INTO prod_year_category(
	SELECT * FROM cars_dwh_cdwh.prod_year_category
);

INSERT INTO transmission(
	SELECT * FROM cars_dwh_cdwh.transmission
);

INSERT INTO sales_data(
	SELECT * FROM cars_dwh_cdwh.sales_data
);

-- FKs for Star Join
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_model (id_model) REFERENCES vehicle_model(id_model);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_accidents (id_accidents) REFERENCES accidents_or_damage(id_accidents_damage);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_owner (id_one_owner) REFERENCES one_owner(id_one_owner);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_personaluse (id_personal_use) REFERENCES personal_use_only(id_personal_use_only);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_color (id_color) REFERENCES color(id_exterior_color);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_finish (id_paintfinish) REFERENCES paint_finish(id_paint_finish);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_fuel(id_fuel_type) REFERENCES fuel_type(id_fuelType);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_mileage (id_mileage) REFERENCES mileage(id_mileage);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_prdyear (id_prod_year_category) REFERENCES prod_year_category(id_prod_year_category);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_transmission (id_transmission) REFERENCES transmission(id_transmission);
ALTER TABLE sales_data ADD FOREIGN KEY FK_STAR_rating (id_driver_rating) REFERENCES driver_rating(id_driver_rating);

-- Enable efficient analyses
ALTER TABLE accidents_or_damage ADD KEY `idx_accidents_accidents` (`accidents_or_damage`);
ALTER TABLE color ADD KEY `idx_color_color` (`exterior_color`);
ALTER TABLE driver_rating ADD KEY `idx_rating_rating` (`driver_rating`);
ALTER TABLE fuel_type ADD KEY `idx_fuel_fuel` (`fuel_category`);
ALTER TABLE mileage ADD KEY `idx_miles_miles` (`mileage_category`);
ALTER TABLE one_owner ADD KEY `idx_oneowner_oneowner` (`one_owner_only`);
ALTER TABLE paint_finish ADD KEY `idx_paint_paint` (`paint_finish`);
ALTER TABLE personal_use_only ADD KEY `idx_persUse_PersUse` (`personal_use_only`);
ALTER TABLE prod_year_category ADD KEY `idx_year_year` (`prod_year_category`);
ALTER TABLE transmission ADD KEY `idx_trans_trans` (`transmission`);
ALTER TABLE vehicle_model ADD KEY `idx_model_manufacturer` (`manufacturer`);
ALTER TABLE vehicle_model ADD KEY `idx_model_efficiency` (`mpg_efficiency_class`);
ALTER TABLE vehicle_model ADD KEY `idx_model_model` (`model`);