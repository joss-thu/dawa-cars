
DROP VIEW IF EXISTS accidentsOrDamageView;
CREATE VIEW accidentsOrDamageView AS
SELECT
    accidents_or_damage AS 'Driver accidents category',
    COUNT(*)      AS 'Number of drivers per category'
FROM sales_data
         JOIN accidents_or_damage ON sales_data.id_accidents = accidents_or_damage.id_accidents_damage
GROUP BY accidents_or_damage
ORDER BY COUNT(*);


DROP VIEW IF EXISTS accidentsPerManufacturer;
CREATE VIEW accidentsPerManufacturer AS
SELECT
    manufacturer AS 'Manufacturer',
    COUNT(*) AS 'Number of accidents'
FROM sales_data
         JOIN vehicle_model vm ON sales_data.id_model = vm.id_model
         JOIN vehicle_manufacturer v ON vm.id_manufacturer = v.id_manufacturer
         JOIN accidents_or_damage ac ON sales_data.id_accidents = ac.id_accidents_damage
WHERE accidents_or_damage = 'Yes'
GROUP BY v.manufacturer, accidents_or_damage;


DROP VIEW IF EXISTS carRatingCategoryView;
CREATE VIEW carRatingCategoryView AS
SELECT
    driver_rating AS 'Car rating category',
    COUNT(*)      AS 'Number of drivers per category'
FROM sales_data
         JOIN driver_rating dr ON sales_data.id_driver_rating = dr.id_driver_rating
GROUP BY driver_rating
ORDER BY COUNT(*);



DROP VIEW IF EXISTS colorView;
CREATE VIEW colorView AS
SELECT color.exterior_color AS 'Çolor category', COUNT(*) AS 'Number of cars per category'
FROM sales_data
         INNER JOIN color ON sales_data.id_color = color.id_exterior_color
GROUP BY color.exterior_color
ORDER BY exterior_color;


DROP VIEW IF EXISTS fuelCategoryView;
CREATE VIEW fuelCategoryView AS
SELECT
    fuel_type.fuel_category AS 'Fuel category',
    COUNT(*) AS 'Number of cars per category'
FROM sales_data
         JOIN fuel_type ON sales_data.id_fuel_type = fuel_type.id_fueltype
GROUP BY fuel_type.fuel_category
ORDER BY fuel_category;


DROP VIEW IF EXISTS manufacturerView;
CREATE VIEW manufacturerView AS
SELECT
   v.manufacturer AS 'Manufacturer', COUNT(*) AS 'Numbers of cars per manufacturer'
FROM sales_data
         JOIN vehicle_model vm ON sales_data.id_model = vm.id_model
         JOIN vehicle_manufacturer v ON vm.id_manufacturer = v.id_manufacturer
GROUP BY v.manufacturer
ORDER BY COUNT(*);




DROP VIEW IF EXISTS mileageView;
CREATE VIEW mileageView AS
SELECT
    mileage_category AS 'Mileage category',
    COUNT(*)      AS 'Number of cars per category'
FROM sales_data
         JOIN mileage m ON sales_data.id_mileage = m.id_mileage
GROUP BY mileage_category
ORDER BY COUNT(*);




DROP VIEW IF EXISTS accidentsPerModels;
CREATE VIEW accidentspermodels AS
SELECT
    model    AS 'Model',
    COUNT(*) AS 'Number of accidents'
FROM sales_data
         JOIN vehicle_model vm ON sales_data.id_model = vm.id_model
         JOIN accidents_or_damage ac ON sales_data.id_accidents = ac.id_accidents_damage
WHERE accidents_or_damage = 'Yes'
GROUP BY vm.model, accidents_or_damage
ORDER BY COUNT(*) DESC
LIMIT 15;



DROP VIEW IF EXISTS mpgEfficiencyClassView;
CREATE VIEW mpgEfficiencyClassView AS
SELECT
   vmec.mpg_efficiency_class AS 'MPG efficiency class', COUNT(*) AS 'Numbers of cars per class'
FROM sales_data
         JOIN vehicle_model vm ON sales_data.id_model = vm.id_model
         JOIN vehicle_mpg_efficiency_class vmec ON vm.id_efficiency = vmec.id_efficiency
GROUP BY vmec.mpg_efficiency_class
ORDER BY COUNT(*);



DROP VIEW IF EXISTS oneownerView;
CREATE VIEW oneOwnerView AS
SELECT
    one_owner_only AS 'One owner',
    COUNT(*)      AS 'Number of drivers per category'
FROM sales_data
         JOIN one_owner oo ON sales_data.id_one_owner = oo.id_one_owner
GROUP BY one_owner_only
ORDER BY COUNT(*);



DROP VIEW IF EXISTS paintFinishView;
CREATE VIEW paintFinishView AS
SELECT
    pf.paint_finish AS 'Paint finish category',
    COUNT(*) AS 'Number of cars per category'
FROM sales_data
         JOIN paint_finish pf ON sales_data.id_driver_rating = pf.id_paint_finish
GROUP BY pf.id_paint_finish;


DROP VIEW IF EXISTS productionYearView;
CREATE VIEW productionYearView AS
SELECT
    pyc.prod_year_category AS 'Category',
    COUNT(*) AS 'Number of cars per category',
    SUM(price) AS 'Sales'
FROM sales_data
         JOIN prod_year_category pyc ON sales_data.id_prod_year_category = pyc.id_prod_year_category
GROUP BY pyc.prod_year_category;



DROP VIEW IF EXISTS transmissionView;
CREATE VIEW transmissionView AS
SELECT
    transmission AS 'Transmission category',
    COUNT(*)      AS 'Number of cars per category'
FROM sales_data
         JOIN transmission t ON sales_data.id_transmission = t.id_transmission
GROUP BY transmission
ORDER BY COUNT(*);







