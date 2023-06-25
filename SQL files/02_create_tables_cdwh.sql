-- Create the cdwh after modelling it in DBSchema.
CREATE DATABASE  IF NOT EXISTS cars_dwh_cdwh;
USE cars_dwh_cdwh;

-- dimen_accidents
DROP Table IF EXISTS accidents_or_damage;
CREATE TABLE accidents_or_damage ( 
    id_accidents_damage TINYINT NOT NULL AUTO_INCREMENT,
    accidents_or_damage TINYTEXT NOT NULL,
CONSTRAINT PK_accidents_or_damage PRIMARY KEY ( id_accidents_damage )
 ) ;

-- dimen_color
DROP Table IF EXISTS color;
CREATE TABLE color ( 
    id_exterior_color TINYINT NOT NULL AUTO_INCREMENT,
    exterior_color TINYTEXT NOT NULL,
CONSTRAINT pk_id_exterior_color PRIMARY KEY ( id_exterior_color )
 ) ;


-- dimen_driver_rating
DROP Table IF EXISTS driver_rating;
CREATE TABLE driver_rating ( 
    id_driver_rating TINYINT NOT NULL AUTO_INCREMENT,
    driver_rating TINYTEXT NOT NULL,
CONSTRAINT PK_driver_rating PRIMARY KEY ( id_driver_rating )
 ) ;


-- dimen_fuel_type
DROP Table IF EXISTS fuel_type;
CREATE TABLE fuel_type ( 
    id_fuelType TINYINT NOT NULL AUTO_INCREMENT,
    fuel_category TINYTEXT NOT NULL,
CONSTRAINT PK_fuel_type PRIMARY KEY ( id_fuelType )
 ) ;


-- dimen_mileage
DROP Table IF EXISTS mileage;
CREATE TABLE mileage ( 
    id_mileage TINYINT NOT NULL AUTO_INCREMENT,
    mileage_category TINYTEXT NOT NULL,
CONSTRAINT PK_mileage PRIMARY KEY ( id_mileage )
 ) ;


-- dimen_single_owner
DROP Table IF EXISTS one_owner;
CREATE TABLE one_owner ( 
    id_one_owner TINYINT NOT NULL AUTO_INCREMENT,
    one_owner_only TINYTEXT NOT NULL,
CONSTRAINT PK_one_owner PRIMARY KEY ( id_one_owner )
 ) ;


-- dimen_paint_finish
DROP Table IF EXISTS paint_finish;
CREATE TABLE paint_finish ( 
    id_paint_finish TINYINT NOT NULL AUTO_INCREMENT,
    paint_finish TINYTEXT NOT NULL,
CONSTRAINT PK_paint_finish PRIMARY KEY ( id_paint_finish )
 ) ;


-- dimen_personal_use_only
DROP Table IF EXISTS personal_use_only;
CREATE TABLE personal_use_only ( 
    id_personal_use_only TINYINT NOT NULL AUTO_INCREMENT,
    personal_use_only TINYTEXT NOT NULL,
CONSTRAINT PK_personal_use_only PRIMARY KEY ( id_personal_use_only )
 ) ;


-- dimen_prod_year
DROP Table IF EXISTS prod_year_category;
CREATE TABLE prod_year_category ( 
    id_prod_year_category TINYINT NOT NULL AUTO_INCREMENT,
    prod_year_category TINYTEXT NOT NULL,
CONSTRAINT PK_prod_year_category PRIMARY KEY ( id_prod_year_category )
 ) ;


-- Fact table- Sales
DROP Table IF EXISTS sales_data;
CREATE TABLE sales_data ( 
    id_vehicle INTEGER NOT NULL AUTO_INCREMENT,
    price INT NOT NULL,
    amount_sold TINYINT NOT NULL,
    id_model INT NOT NULL,
    id_accidents TINYINT NOT NULL,
    id_one_owner TINYINT NOT NULL,
    id_personal_use TINYINT NOT NULL,
    id_color TINYINT NOT NULL,
    id_paintfinish TINYINT NOT NULL,
    id_fuel_type TINYINT NOT NULL,
    id_mileage TINYINT NOT NULL,
    id_prod_year_category TINYINT NOT NULL,
    id_transmission TINYINT NOT NULL,
    id_driver_rating TINYINT NOT NULL,
CONSTRAINT pk_sales_data PRIMARY KEY ( id_vehicle ),
FOREIGN KEY ( id_model ) REFERENCES vehicle_model( id_model )  ,
FOREIGN KEY ( id_accidents ) REFERENCES accidents_or_damage( id_accidents_damage )  ,
FOREIGN KEY ( id_one_owner ) REFERENCES one_owner( id_one_owner )  ,
FOREIGN KEY ( id_personal_use ) REFERENCES personal_use_only( id_personal_use_only )  ,
FOREIGN KEY ( id_color ) REFERENCES color( id_exterior_color )  ,
FOREIGN KEY ( id_paintfinish ) REFERENCES paint_finish( id_paint_finish )  ,
FOREIGN KEY ( id_mileage ) REFERENCES mileage( id_mileage )  ,
FOREIGN KEY ( id_prod_year_category ) REFERENCES prod_year_category( id_prod_year_category)  ,
FOREIGN KEY ( id_transmission ) REFERENCES transmission( id_transmission )  ,
FOREIGN KEY ( id_fuel_type ) REFERENCES fuel_type( id_fuelType )  ,
FOREIGN KEY ( id_driver_rating ) REFERENCES driver_rating( id_driver_rating )  
 ) ;


-- dimen_transmission
DROP Table IF EXISTS transmission;
CREATE TABLE transmission ( 
    id_transmission TINYINT NOT NULL AUTO_INCREMENT,
    transmission TINYTEXT NOT NULL,
CONSTRAINT PK_transmission PRIMARY KEY ( id_transmission )
 ) ;


-- dimen_vehicle
DROP Table IF EXISTS vehicle_manufacturer;
CREATE TABLE vehicle_manufacturer ( 
    id_manufacturer INT NOT NULL AUTO_INCREMENT,
    manufacturer TINYTEXT NOT NULL,
CONSTRAINT PK_vehicle_manufacturer PRIMARY KEY ( id_manufacturer )
 ) ;

DROP Table IF EXISTS vehicle_model;
CREATE TABLE vehicle_model ( 
    id_model INT NOT NULL AUTO_INCREMENT,
    id_manufacturer INT NOT NULL,
    id_efficiency TINYINT NOT NULL,
    model VARCHAR( 100 ) NOT NULL,
CONSTRAINT PK_vehicle_model PRIMARY KEY ( id_model ),
FOREIGN KEY ( id_manufacturer ) REFERENCES vehicle_manufacturer( id_manufacturer )  ,
FOREIGN KEY ( id_efficiency ) REFERENCES vehicle_mpg_efficiency_class( id_efficiency )  
 ) ;

DROP Table IF EXISTS vehicle_mpg_efficiency_class;
CREATE TABLE vehicle_mpg_efficiency_class ( 
    id_efficiency TINYINT NOT NULL AUTO_INCREMENT,
    mpg_efficiency_class TINYTEXT NOT NULL,
CONSTRAINT PK_vehicle_mpg_efficiency_class PRIMARY KEY ( id_efficiency )
 ) ;

-- Create indices
-- indices
CREATE INDEX idx_sales_model ON sales_data ( id_model );
CREATE INDEX idx_sales_accident ON sales_data ( id_accidents );
CREATE INDEX idx_sales_ownership ON sales_data ( id_one_owner );
CREATE INDEX idx_sales_personal_usage ON sales_data ( id_personal_use );
CREATE INDEX idx_sales_color ON sales_data ( id_color );
CREATE INDEX idx_sales_paint_finish ON sales_data ( id_paintfinish );
CREATE INDEX idx_sales_fuel_type ON sales_data ( id_fuel_type );
CREATE INDEX idx_sales_mileage ON sales_data ( id_mileage );
CREATE INDEX idx_sales_prod_year_category ON sales_data ( id_prod_year_category );
CREATE INDEX idx_sales_transmission ON sales_data ( id_transmission );
CREATE INDEX idx_sales_driver_rating ON sales_data ( id_driver_rating );
-- dimen_vehicle
CREATE INDEX idx_model_manufacturer ON vehicle_model ( id_manufacturer );
CREATE INDEX idx_model_efficiency ON vehicle_model ( id_efficiency );
CREATE INDEX idx_model_model ON vehicle_model ( model );
-- dimen_accidents_or_damage
CREATE INDEX idx_accidents_accidents ON accidents_or_damage(accidents_or_damage);
-- dimen_one_owner_only
CREATE INDEX idx_oneowner_oneowner ON one_owner(one_owner_only);
-- dimen_personal_use_only
CREATE INDEX idx_persUse_PersUse ON personal_use_only(personal_use_only);
-- dimen_exterior_color
CREATE INDEX idx_color_color ON color(exterior_color);
-- dimen_paint_finish
CREATE INDEX idx_paint_paint ON paint_finish(paint_finish);
-- dimen_fuel_category
CREATE INDEX idx_fuel_fuel ON fuel_type(fuel_category);
-- dimen_driver_rating
CREATE INDEX idx_miles_miles ON mileage(driver_rating);
-- dimen_driver_rating
CREATE INDEX idx_rating_rating ON driver_rating(driver_rating);
-- dimen_transmission
CREATE INDEX idx_trans_trans ON transmission (transmission);
-- dimen_prod_year_category
CREATE INDEX idx_year_year ON prod_year_category (prod_year_category);


