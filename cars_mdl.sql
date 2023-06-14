-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2023 at 10:04 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cars_mdl`
--

-- --------------------------------------------------------

--
-- Table structure for table `color`
--

CREATE TABLE `color` (
  `color_id` int(11) NOT NULL,
  `exterior_color` varchar(255) DEFAULT NULL,
  `interior_color` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drivetrain`
--

CREATE TABLE `drivetrain` (
  `drivetrain_id` int(11) NOT NULL,
  `drivetrain` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine_specs`
--

CREATE TABLE `engine_specs` (
  `engine_id` int(11) NOT NULL,
  `cylinder_placement` varchar(255) DEFAULT NULL,
  `cubic_capacity_L` double DEFAULT NULL,
  `injection_type` varchar(255) DEFAULT NULL,
  `turbo` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuel_type`
--

CREATE TABLE `fuel_type` (
  `fuel_type_id` int(11) NOT NULL,
  `fuel_type` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mileage`
--

CREATE TABLE `mileage` (
  `mileage_group_id` int(11) NOT NULL,
  `mileage` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mpg`
--

CREATE TABLE `mpg` (
  `mpg_group_id` int(11) NOT NULL,
  `mpg` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prod_year`
--

CREATE TABLE `prod_year` (
  `prod_year_group_id` int(11) NOT NULL,
  `prod_year` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `seller_rating` double DEFAULT NULL,
  `driver_rating` double DEFAULT NULL,
  `driver_reviews_num` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salesdata`
--

CREATE TABLE `salesdata` (
  `seller_id` int(11) NOT NULL,
  `seller_name` varchar(255) DEFAULT NULL,
  `rating` int(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `price_drop` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `technical_details`
--

CREATE TABLE `technical_details` (
  `tech_config_id` int(11) NOT NULL,
  `engine_id` int(11) DEFAULT NULL,
  `transmission_id` int(11) DEFAULT NULL,
  `drivetrain_id` int(11) DEFAULT NULL,
  `fuel_type_id` int(11) DEFAULT NULL,
  `mpg_group_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transmission`
--

CREATE TABLE `transmission` (
  `transmission_id` int(11) NOT NULL,
  `speed_ratios` int(11) DEFAULT NULL,
  `transmision_mode` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `usage_statistics`
--

CREATE TABLE `usage_statistics` (
  `usage_stats_id` int(11) NOT NULL,
  `accidents_or_damage` varchar(255) DEFAULT NULL,
  `one_owner` varchar(255) DEFAULT NULL,
  `personal_use_only` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_details`
--

CREATE TABLE `vehicle_details` (
  `vehicle_id` int(11) NOT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `prod_year_group_id` varchar(255) DEFAULT NULL,
  `mileage_group_id` int(11) DEFAULT NULL,
  `tech_config_id` int(11) DEFAULT NULL,
  `color_id` int(11) DEFAULT NULL,
  `usage_stats_id` int(11) DEFAULT NULL,
  `sales_data` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`color_id`);

--
-- Indexes for table `drivetrain`
--
ALTER TABLE `drivetrain`
  ADD PRIMARY KEY (`drivetrain_id`);

--
-- Indexes for table `engine_specs`
--
ALTER TABLE `engine_specs`
  ADD PRIMARY KEY (`engine_id`);

--
-- Indexes for table `fuel_type`
--
ALTER TABLE `fuel_type`
  ADD PRIMARY KEY (`fuel_type_id`);

--
-- Indexes for table `mileage`
--
ALTER TABLE `mileage`
  ADD PRIMARY KEY (`mileage_group_id`);

--
-- Indexes for table `mpg`
--
ALTER TABLE `mpg`
  ADD PRIMARY KEY (`mpg_group_id`);

--
-- Indexes for table `prod_year`
--
ALTER TABLE `prod_year`
  ADD PRIMARY KEY (`prod_year_group_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`);

--
-- Indexes for table `salesdata`
--
ALTER TABLE `salesdata`
  ADD PRIMARY KEY (`seller_id`);

--
-- Indexes for table `technical_details`
--
ALTER TABLE `technical_details`
  ADD PRIMARY KEY (`tech_config_id`);

--
-- Indexes for table `transmission`
--
ALTER TABLE `transmission`
  ADD PRIMARY KEY (`transmission_id`);

--
-- Indexes for table `usage_statistics`
--
ALTER TABLE `usage_statistics`
  ADD PRIMARY KEY (`usage_stats_id`);

--
-- Indexes for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  ADD PRIMARY KEY (`vehicle_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `color`
--
ALTER TABLE `color`
  MODIFY `color_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drivetrain`
--
ALTER TABLE `drivetrain`
  MODIFY `drivetrain_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `engine_specs`
--
ALTER TABLE `engine_specs`
  MODIFY `engine_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuel_type`
--
ALTER TABLE `fuel_type`
  MODIFY `fuel_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mileage`
--
ALTER TABLE `mileage`
  MODIFY `mileage_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mpg`
--
ALTER TABLE `mpg`
  MODIFY `mpg_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_year`
--
ALTER TABLE `prod_year`
  MODIFY `prod_year_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salesdata`
--
ALTER TABLE `salesdata`
  MODIFY `seller_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `technical_details`
--
ALTER TABLE `technical_details`
  MODIFY `tech_config_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transmission`
--
ALTER TABLE `transmission`
  MODIFY `transmission_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usage_statistics`
--
ALTER TABLE `usage_statistics`
  MODIFY `usage_stats_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_details`
--
ALTER TABLE `vehicle_details`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
