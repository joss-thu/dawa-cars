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


CREATE INDEX idx_accidents_accidents ON accidents_or_damage(accidents_or_damage);

CREATE INDEX idx_oneowner_oneowner ON one_owner(one_owner_only);

CREATE INDEX idx_persUse_PersUse ON personal_use_only(personal_use_only);

CREATE INDEX idx_color_color ON color(exterior_color);

CREATE INDEX idx_paint_paint ON paint_finish(paint_finish);

CREATE INDEX idx_fuel_fuel ON fuel_type(fuel_category);

CREATE INDEX idx_miles_miles ON mileage(mileage_category);

CREATE INDEX idx_rating_rating ON driver_rating(driver_rating);

CREATE INDEX idx_trans_trans ON transmission (transmission);

CREATE INDEX idx_year_year ON prod_year_category (prod_year_category);


