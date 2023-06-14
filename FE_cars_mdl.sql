CREATE TABLE color ( 
	color_id INTEGER( 2000000000, 10 ) NOT NULL,
	exterior_color TEXT NULL,
	interior_color TEXT NULL,
CONSTRAINT pk_color PRIMARY KEY ( color_id )
 ) ;

CREATE TABLE drivetrain ( 
	drivetrain_id INT NOT NULL,
	drivetrain TEXT NULL,
CONSTRAINT pk_drivetrain PRIMARY KEY ( drivetrain_id )
 ) ;

CREATE TABLE engine_specs ( 
	engine_id INT NOT NULL,
	cylinder_placement TEXT NULL,
	cubic_capacity_L REAL( 2000000000, 10 ) NULL,
	injection_type TEXT NULL,
	turbo INTEGER( 2000000000, 10 ) NULL,
CONSTRAINT pk_engine_specs PRIMARY KEY ( engine_id )
 ) ;

CREATE TABLE fuel_type ( 
	fuel_type_id INT NOT NULL,
	fuel_type TEXT NULL,
CONSTRAINT pk_fuel_type PRIMARY KEY ( fuel_type_id )
 ) ;

CREATE TABLE mileage ( 
	mileage_group_id INT NOT NULL,
	mileage INT NULL,
CONSTRAINT pk_mileage PRIMARY KEY ( mileage_group_id )
 ) ;

CREATE TABLE mpg ( 
	mpg_grp_id TINYINT NOT NULL,
	mp_range TEXT NULL,
CONSTRAINT pk_mpg PRIMARY KEY ( mpg_grp_id )
 ) ;

CREATE TABLE prod_year ( 
	prod_year_grp_id TINYINT NOT NULL,
	prod_year_range TEXT NULL,
CONSTRAINT pk_prod_year PRIMARY KEY ( prod_year_grp_id )
 ) ;

CREATE TABLE rating ( 
	rating_id TINYINT NOT NULL,
	seller_rating DOUBLE( 2000000000, 10 ) NULL,
	driver_rating DOUBLE( 2000000000, 10 ) NULL,
	driver_reviews_num INTEGER( 2000000000, 10 ) NULL,
CONSTRAINT pk_rating PRIMARY KEY ( rating_id )
 ) ;

CREATE TABLE salesdata ( 
	seller_id INTEGER( 2000000000, 10 ) NOT NULL,
	`seller_name ` TEXT NULL,
	rating TINYINT NULL,
	price INT NULL,
	price_drop INT NULL,
CONSTRAINT pk_salesdata PRIMARY KEY ( seller_id ),
FOREIGN KEY ( rating ) REFERENCES rating( rating_id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ;

CREATE INDEX idx_salesdata ON salesdata ( rating );

CREATE TABLE sqlite_sequence ( 
	name ( 2000000000, 10 ) NULL,
	seq ( 2000000000, 10 ) NULL
 ) ;

CREATE TABLE technical_details ( 
	tech_config_id INT NOT NULL,
	engine_id INT NULL,
	transmission_id INT NULL,
	drivetrain_id INT NULL,
	fuel_type_id INT NULL,
	mpg_group_id INT NULL,
CONSTRAINT pk_technical_details PRIMARY KEY ( tech_config_id ),
FOREIGN KEY ( engine_id ) REFERENCES engine_specs( engine_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( transmission_id ) REFERENCES transmission( transmission_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( drivetrain_id ) REFERENCES drivetrain( drivetrain_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( fuel_type_id ) REFERENCES fuel_type( fuel_type_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( mpg_group_id ) REFERENCES mileage( mileage_group_id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ;

CREATE INDEX idx_technical_details ON technical_details ( engine_id );

CREATE INDEX idx_technical_details ON technical_details ( transmission_id );

CREATE INDEX idx_technical_details ON technical_details ( drivetrain_id );

CREATE INDEX idx_technical_details ON technical_details ( fuel_type_id );

CREATE INDEX idx_technical_details ON technical_details ( mpg_group_id );

CREATE TABLE transmission ( 
	transmission_id INT NOT NULL,
	speed_ratios INTEGER( 2000000000, 10 ) NULL,
	transmision_mode TEXT NULL,
	remarks TEXT NULL,
CONSTRAINT pk_transmission PRIMARY KEY ( transmission_id )
 ) ;

CREATE TABLE usage_statistics ( 
	usage_stats_id INTEGER( 2000000000, 10 ) NOT NULL,
	accidents_or_damage TEXT NULL,
	one_owner TEXT NULL,
	personal_use_only TEXT NULL,
CONSTRAINT pk_usage_statistics PRIMARY KEY ( usage_stats_id )
 ) ;

CREATE TABLE vehicle_details ( 
	vehicle_id INTEGER( 2000000000, 10 ) NOT NULL,
	manufacturer VARCHAR( 255 ) NULL,
	model VARCHAR( 255 ) NULL,
	prod_year_grp_id TINYINT NULL,
	mpg_grp_id TINYINT NULL,
	tech_config_id INT NULL,
	color_id INTEGER( 2000000000 ) NULL,
	usage_stats_id INTEGER( 2000000000 ) NULL,
	sales_data INTEGER( 2000000000, 10 ) NULL,
CONSTRAINT pk_vehicle_details PRIMARY KEY ( vehicle_id ),
FOREIGN KEY ( prod_year_grp_id ) REFERENCES prod_year( prod_year_grp_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( mpg_grp_id ) REFERENCES mpg( mpg_grp_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( tech_config_id ) REFERENCES technical_details( tech_config_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( color_id ) REFERENCES color( color_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( usage_stats_id ) REFERENCES usage_statistics( usage_stats_id ) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ( sales_data ) REFERENCES salesdata( seller_id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ;

CREATE INDEX idx_vehicle_details ON vehicle_details ( prod_year_grp_id );

CREATE INDEX idx_vehicle_details ON vehicle_details ( mpg_grp_id );

CREATE INDEX idx_vehicle_details ON vehicle_details ( tech_config_id );

CREATE INDEX idx_vehicle_details ON vehicle_details ( color_id );

CREATE INDEX idx_vehicle_details ON vehicle_details ( usage_stats_id );

CREATE INDEX idx_vehicle_details ON vehicle_details ( sales_data );

