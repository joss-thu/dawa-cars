
DROP DATABASE IF EXISTS cars_mpg_lookup;
CREATE DATABASE cars_mpg_lookup;
USE cars_mpg_lookup;

--
-- Table SizeClass
--

CREATE TABLE IF NOT EXISTS mpg_class (
  LowerLimit int(11) NOT NULL,
  UpperLimit int(11) NOT NULL,
  mpg_class_grade varchar(30) NOT NULL
);

--
-- Data for SizeClass
--

INSERT INTO SizeClass (LowerLimit, UpperLimit, ClassName) VALUES
(0, 10, 'Class F'),
(11, 30, 'Class E'),
(31, 50, 'Class D'),
(51, 70, 'Class C'),
(71, 100, 'Class B'),
(101, 130, 'Class A');

