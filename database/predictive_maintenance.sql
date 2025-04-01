-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2025 at 03:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `predictive_maintenance`
--

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `id_sensor` varchar(100) DEFAULT NULL,
  `event_name` varchar(100) NOT NULL,
  `event_type` enum('manual','automatic') NOT NULL,
  `severity` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `repair_date` datetime DEFAULT NULL,
  `repair_effectiveness` decimal(10,2) DEFAULT NULL,
  `repair_detail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `id_machine`, `id_sensor`, `event_name`, `event_type`, `severity`, `description`, `timestamp`, `repair_date`, `repair_effectiveness`, `repair_detail`) VALUES
(26, 221, '-', 'Impact', 'manual', 3, 'machine hit by falling debris', '2025-03-17 05:44:02', '2025-03-20 07:35:00', 0.80, 'ซ่อมแซมส่วนที่โดนกระแทก'),
(27, 221, '-', 'Oil Particle', 'manual', 1, 'found scrap in oil', '2025-04-30 06:49:50', NULL, NULL, NULL),
(36, 221, 'T0001', 'Test', 'automatic', 7, 'Sensor state changed to critical', '2025-04-21 07:44:00', '2025-04-28 08:06:00', 1.00, 'Try Fix'),
(37, 221, 'T0002', 'Test02', 'automatic', 5, 'Sensor state changed to critical', '2025-04-25 07:44:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `machine`
--

CREATE TABLE `machine` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `machine_name` varchar(100) NOT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `status_machine` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `life_time` int(11) NOT NULL,
  `used_time` int(11) DEFAULT NULL,
  `current_rul` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `machine`
--

INSERT INTO `machine` (`id`, `id_machine`, `machine_name`, `detail`, `note`, `status`, `status_machine`, `create_date`, `create_by`, `update_date`, `update_by`, `life_time`, `used_time`, `current_rul`) VALUES
(16, 221, 'Motor_Test', 'test', '-', 'inactive', 1, '2025-03-12 18:54:57', 'Admin', '0000-00-00 00:00:00', '', 100, 0, NULL),
(17, 551, 'Test', 'tetst', ' f', 'inactive', 1, '2025-03-22 16:46:17', 'Admin', '2025-04-01 02:10:34', 'Admin', 500, NULL, NULL),
(18, 664, 'test 03', 'test', '-', 'inactive', 1, '2025-03-22 21:47:33', 'Admin', '2025-04-01 02:10:29', 'Admin', 500, NULL, NULL),
(21, 54564, 'jack', '-', '-', 'inactive', 1, '2025-03-30 12:19:41', 'Admin', '2025-04-01 02:10:27', 'Admin', 500, 500, NULL),
(22, 216, 'atra', 'dsfds', '6165', 'inactive', 1, '2025-04-01 00:48:48', 'Admin', '2025-04-01 00:49:10', 'Admin', 51651, NULL, NULL),
(23, 1, 'Motor Mixer', 'mixing', 'NULL', 'active', 1, '2025-04-01 00:51:25', 'Admin', '0000-00-00 00:00:00', '', 732, NULL, NULL),
(24, 5, 'Industrial Tank', 'Tanks', 'NULL', 'active', 1, '2025-04-01 00:51:53', 'Admin', '0000-00-00 00:00:00', '', 864, NULL, NULL),
(25, 6, 'Electric Rotor', 'Rotor', 'NULL', 'active', 1, '2025-04-01 00:52:01', 'Admin', '0000-00-00 00:00:00', '', 953, NULL, NULL),
(26, 3, 'Compressor1', 'Compressor', 'NULL', 'active', 1, '2025-04-01 00:52:10', 'Admin', '0000-00-00 00:00:00', '', 589, NULL, NULL),
(27, 33, 'Gearbox2', 'Gearbox', 'NULL', 'active', 1, '2025-04-01 00:52:17', 'Admin', '0000-00-00 00:00:00', '', 725, NULL, NULL),
(28, 2, 'Rotor1', 'Rotor', 'NULL', 'active', 1, '2025-04-01 00:52:27', 'Admin', '0000-00-00 00:00:00', '', 891, NULL, NULL),
(29, 35, 'CC2 Filler Machine No. 2', 'NULL', 'NULL', 'active', 1, '2025-04-01 00:52:35', 'Admin', '0000-00-00 00:00:00', '', 673, NULL, NULL),
(30, 36, 'CC1 Filler Machine No. 1', 'NULL', 'NULL', 'active', 1, '2025-04-01 00:52:43', 'Admin', '0000-00-00 00:00:00', '', 910, NULL, NULL),
(31, 4, 'Motor', 'Motor1', 'NULL', 'active', 1, '2025-04-01 00:52:51', 'Admin', '0000-00-00 00:00:00', '', 802, NULL, NULL),
(32, 54654, 'dgfdsg', 'fdfds', '-', 'inactive', 1, '2025-04-01 02:10:11', 'Admin', '2025-04-01 02:10:23', 'Admin', 61654, NULL, NULL),
(33, 221, 'Motor_Test', 'test', '-', 'active', 1, '2025-03-12 11:54:57', 'Admin', '2025-04-01 02:26:44', 'Admin', 1000, NULL, NULL),
(34, 12345, 'Motor_Engine', 'locate at plant 4', '-', 'inactive', 1, '2025-04-01 06:01:35', 'Admin', '0000-00-00 00:00:00', '', 2500, NULL, NULL),
(35, 12345, 'Motor_Engine', 'locate at plant 4', '-', 'active', 1, '2025-03-31 23:01:35', 'Admin', '2025-04-01 06:20:09', 'Admin', 2500, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL,
  `status` enum('unread','read') DEFAULT 'unread'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `repair`
--

CREATE TABLE `repair` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `repair_date` datetime NOT NULL,
  `repair_effectiveness` float DEFAULT NULL CHECK (`repair_effectiveness` between 0 and 1),
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role_id` varchar(100) NOT NULL,
  `role_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `role_id`, `role_name`) VALUES
(1, '1', 'Admin'),
(2, '2', 'Common');

-- --------------------------------------------------------

--
-- Table structure for table `rul_history`
--

CREATE TABLE `rul_history` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `calculated_rul` decimal(10,2) NOT NULL,
  `calculation_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sensor`
--

CREATE TABLE `sensor` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `id_sensor` varchar(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `status_sensor` int(11) NOT NULL,
  `state` varchar(10) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  `warning_severity` int(11) DEFAULT NULL,
  `critical_severity` int(11) DEFAULT NULL,
  `warning_vibration_x` decimal(10,6) DEFAULT NULL,
  `warning_vibration_y` decimal(10,6) DEFAULT NULL,
  `warning_vibration_z` decimal(10,6) DEFAULT NULL,
  `warning_temp` decimal(10,6) DEFAULT NULL,
  `critical_vibration_x` decimal(10,6) DEFAULT NULL,
  `critical_vibration_y` decimal(10,6) DEFAULT NULL,
  `critical_vibration_z` decimal(10,6) DEFAULT NULL,
  `critical_temp` decimal(10,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor`
--

INSERT INTO `sensor` (`id`, `id_machine`, `id_sensor`, `name`, `status`, `create_by`, `create_date`, `update_by`, `update_date`, `status_sensor`, `state`, `detail`, `note`, `warning_severity`, `critical_severity`, `warning_vibration_x`, `warning_vibration_y`, `warning_vibration_z`, `warning_temp`, `critical_vibration_x`, `critical_vibration_y`, `critical_vibration_z`, `critical_temp`) VALUES
(34, 221, 'T0001', 'Test', 'inactive', 'admin', '2025-03-28 17:58:16', '', '2025-03-28 17:58:16', 1, 'good', 'testing sensor system', '-', 5, 7, 6.000000, 5.000000, 7.000000, 100.000000, 8.000000, 7.000000, 9.000000, 150.000000),
(35, 221, 'T0002', 'Test02', 'inactive', 'admin', '2025-03-28 17:59:37', '', '2025-03-28 17:59:37', 1, 'good', 'testing sensor system 2', '', 2, 5, 5.000000, 5.000000, 5.000000, 150.000000, 8.000000, 8.000000, 8.000000, 200.000000),
(36, 221, 'T00013', 'Test', 'inactive', 'admin', '2025-04-01 02:09:56', '', '2025-04-01 02:09:56', 1, 'good', 'testing sensor system', '-', 5, 7, 6.000000, 5.000000, 7.000000, 100.000000, 8.000000, 7.000000, 9.000000, 150.000000),
(37, 221, 'T0001', 'Test', 'active', 'admin', '2025-04-01 06:51:21', '', '2025-04-01 06:51:21', 1, 'good', 'testing sensor system', '-', 5, 7, 6.000000, 5.000000, 7.000000, 100.000000, 8.000000, 7.000000, 9.000000, 150.000000),
(38, 221, 'T0002', 'Test02', 'active', 'admin', '2025-04-01 07:12:31', '', '2025-04-01 07:12:31', 1, 'good', 'testing sensor system 2', '', 2, 5, 5.000000, 5.000000, 5.000000, 150.000000, 8.000000, 8.000000, 8.000000, 200.000000);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` int(11) NOT NULL,
  `id_sensor` varchar(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `repair_date` datetime DEFAULT NULL,
  `vibration_x` decimal(10,6) NOT NULL,
  `vibration_y` decimal(10,6) NOT NULL,
  `vibration_z` decimal(10,6) NOT NULL,
  `temp` decimal(10,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor_data`
--

INSERT INTO `sensor_data` (`id`, `id_sensor`, `create_date`, `repair_date`, `vibration_x`, `vibration_y`, `vibration_z`, `temp`) VALUES
(160, 'T0001', '2025-03-25 17:23:50', '0000-00-00 00:00:00', 2.400000, 2.980000, 2.690000, 70.230000),
(161, 'T0001', '2025-03-25 18:23:50', '0000-00-00 00:00:00', 2.680000, 2.830000, 2.610000, 68.620000),
(162, 'T0001', '2025-03-25 19:23:50', '0000-00-00 00:00:00', 2.400000, 2.760000, 2.670000, 70.140000),
(163, 'T0001', '2025-03-25 20:23:50', '0000-00-00 00:00:00', 2.290000, 2.620000, 2.890000, 70.920000),
(164, 'T0001', '2025-03-25 21:23:50', '0000-00-00 00:00:00', 2.720000, 2.800000, 3.140000, 69.680000),
(165, 'T0001', '2025-03-25 22:23:50', '0000-00-00 00:00:00', 2.430000, 2.570000, 2.770000, 67.970000),
(166, 'T0001', '2025-03-25 23:23:50', '0000-00-00 00:00:00', 2.890000, 2.910000, 3.000000, 67.890000),
(167, 'T0001', '2025-03-26 00:23:50', '0000-00-00 00:00:00', 3.280000, 3.270000, 3.120000, 66.470000),
(168, 'T0001', '2025-03-26 01:23:50', '0000-00-00 00:00:00', 3.460000, 3.200000, 2.910000, 64.710000),
(169, 'T0001', '2025-03-26 02:23:50', '0000-00-00 00:00:00', 3.580000, 2.910000, 2.610000, 65.990000),
(170, 'T0001', '2025-03-26 03:23:50', '0000-00-00 00:00:00', 3.790000, 2.620000, 2.980000, 66.640000),
(171, 'T0001', '2025-03-26 04:23:50', '0000-00-00 00:00:00', 3.750000, 2.990000, 3.170000, 68.020000),
(172, 'T0001', '2025-03-26 05:23:50', '0000-00-00 00:00:00', 3.410000, 2.510000, 2.820000, 69.450000),
(173, 'T0001', '2025-03-26 06:23:50', '0000-00-00 00:00:00', 3.740000, 2.390000, 3.220000, 68.350000),
(174, 'T0001', '2025-03-26 07:23:50', '0000-00-00 00:00:00', 3.340000, 1.990000, 3.460000, 70.170000),
(175, 'T0001', '2025-03-26 08:23:50', '0000-00-00 00:00:00', 3.350000, 2.180000, 3.120000, 71.550000),
(176, 'T0001', '2025-03-26 09:23:50', '0000-00-00 00:00:00', 3.470000, 1.840000, 3.280000, 70.850000),
(177, 'T0001', '2025-03-26 10:23:50', '0000-00-00 00:00:00', 3.260000, 1.390000, 3.430000, 72.790000),
(178, 'T0001', '2025-03-26 11:23:50', '0000-00-00 00:00:00', 3.590000, 1.000000, 3.640000, 71.980000),
(179, 'T0001', '2025-03-26 12:23:50', '0000-00-00 00:00:00', 4.080000, 0.580000, 3.660000, 72.000000),
(180, 'T0002', '2025-03-25 17:27:26', '0000-00-00 00:00:00', 3.550000, 3.670000, 3.380000, 116.590000),
(181, 'T0002', '2025-03-25 18:27:26', '0000-00-00 00:00:00', 3.980000, 3.220000, 3.770000, 115.580000),
(182, 'T0002', '2025-03-25 19:27:26', '0000-00-00 00:00:00', 4.290000, 3.490000, 3.820000, 115.270000),
(183, 'T0002', '2025-03-25 20:27:26', '0000-00-00 00:00:00', 4.480000, 3.580000, 4.220000, 114.130000),
(184, 'T0002', '2025-03-25 21:27:26', '0000-00-00 00:00:00', 4.890000, 3.390000, 4.140000, 112.310000),
(185, 'T0002', '2025-03-25 22:27:26', '0000-00-00 00:00:00', 5.160000, 3.870000, 3.720000, 113.850000),
(186, 'T0002', '2025-03-25 23:27:26', '0000-00-00 00:00:00', 5.480000, 4.370000, 3.620000, 115.800000),
(187, 'T0002', '2025-03-26 00:27:26', '0000-00-00 00:00:00', 5.520000, 3.980000, 3.510000, 114.470000),
(188, 'T0002', '2025-03-26 01:27:26', '0000-00-00 00:00:00', 5.320000, 3.860000, 3.680000, 114.880000),
(189, 'T0002', '2025-03-26 02:27:26', '0000-00-00 00:00:00', 5.460000, 4.280000, 3.350000, 113.090000),
(190, 'T0002', '2025-03-26 03:27:26', '0000-00-00 00:00:00', 4.980000, 4.270000, 2.910000, 114.890000),
(191, 'T0002', '2025-03-26 04:27:26', '0000-00-00 00:00:00', 5.340000, 4.200000, 2.580000, 114.890000),
(192, 'T0002', '2025-03-26 05:27:26', '0000-00-00 00:00:00', 4.900000, 3.980000, 2.860000, 115.150000),
(193, 'T0002', '2025-03-26 06:27:26', '0000-00-00 00:00:00', 5.130000, 3.580000, 3.160000, 117.030000),
(194, 'T0002', '2025-03-26 07:27:26', '0000-00-00 00:00:00', 5.260000, 3.200000, 2.830000, 118.220000),
(195, 'T0002', '2025-03-26 08:27:26', '0000-00-00 00:00:00', 4.830000, 3.140000, 2.860000, 116.610000),
(196, 'T0002', '2025-03-26 09:27:26', '0000-00-00 00:00:00', 4.560000, 2.830000, 2.990000, 115.390000),
(197, 'T0002', '2025-03-26 10:27:26', '0000-00-00 00:00:00', 4.640000, 3.030000, 2.490000, 117.320000),
(198, 'T0002', '2025-03-26 11:27:26', '0000-00-00 00:00:00', 4.430000, 3.300000, 2.790000, 116.580000),
(199, 'T0002', '2025-03-26 12:27:26', '0000-00-00 00:00:00', 4.490000, 3.710000, 3.130000, 118.040000),
(200, 'T0002', '2025-03-29 20:02:06', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(201, 'T0002', '2025-03-29 20:02:47', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(202, 'T0002', '2025-03-29 20:02:52', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(203, 'T0002', '2025-03-29 20:02:54', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(204, 'T0002', '2025-03-29 20:02:55', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(205, 'T0002', '2025-03-29 20:06:11', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(206, 'T0002', '2025-03-29 20:06:37', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(207, 'T0002', '2025-03-29 20:06:40', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(208, 'T0002', '2025-03-29 20:06:41', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(209, 'T0002', '2025-03-29 20:08:27', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(210, 'T0002', '2025-03-29 20:08:28', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(211, 'T0002', '2025-03-29 20:08:29', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(212, 'T0002', '2025-03-29 20:08:30', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(213, 'T0002', '2025-03-29 20:10:28', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(214, 'T0002', '2025-03-29 20:10:30', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(215, 'T0002', '2025-03-29 20:10:37', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(216, 'T0002', '2025-03-29 20:10:58', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(217, 'T0002', '2025-03-29 20:11:43', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(218, 'T0002', '2025-03-29 20:11:45', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(219, 'T0002', '2025-03-29 20:11:47', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(220, 'T0002', '2025-03-29 20:11:56', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(221, 'T0002', '2025-03-29 20:12:01', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(222, 'T0002', '2025-03-29 20:12:06', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(223, 'T0002', '2025-03-29 20:12:29', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(224, 'T0002', '2025-03-29 20:16:10', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(225, 'T0002', '2025-03-29 20:16:16', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(226, 'T0002', '2025-03-29 20:16:17', NULL, 6.000000, 6.000000, 6.000000, 151.000000),
(227, 'T0002', '2025-03-29 20:16:24', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(228, 'T0002', '2025-03-29 20:16:29', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(229, 'T0002', '2025-03-29 20:16:35', NULL, 9.000000, 9.000000, 9.000000, 201.000000),
(230, 'T0002', '2025-03-29 20:18:13', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(231, 'T0002', '2025-03-29 20:18:14', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(232, 'T0002', '2025-03-29 20:18:16', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(233, 'T0002', '2025-03-29 20:18:39', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(234, 'T0002', '2025-03-29 20:18:57', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(235, 'T0002', '2025-03-29 20:18:58', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(236, 'T0002', '2025-03-29 20:19:00', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(237, 'T0002', '2025-03-29 20:19:10', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(238, 'T0002', '2025-03-29 20:19:11', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(239, 'T0002', '2025-03-29 20:19:13', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(240, 'T0002', '2025-03-29 20:22:33', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(241, 'T0002', '2025-03-29 20:22:34', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(242, 'T0002', '2025-03-29 20:22:35', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(243, 'T0002', '2025-03-29 20:24:14', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(244, 'T0002', '2025-03-29 20:24:19', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(245, 'T0002', '2025-03-29 20:24:20', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(246, 'T0002', '2025-03-29 20:24:39', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(247, 'T0002', '2025-03-29 20:25:33', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(248, 'T0002', '2025-03-29 20:25:33', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(249, 'T0002', '2025-03-29 20:25:34', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(250, 'T0002', '2025-03-29 20:25:38', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(251, 'T0002', '2025-03-29 20:25:39', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(252, 'T0002', '2025-03-29 20:25:40', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(253, 'T0002', '2025-03-29 20:25:46', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(254, 'T0002', '2025-03-29 20:25:47', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(255, 'T0002', '2025-03-29 20:25:51', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(256, 'T0002', '2025-03-29 20:25:55', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(257, 'T0002', '2025-03-29 20:25:59', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(258, 'T0002', '2025-03-29 20:26:03', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(259, 'T0002', '2025-03-30 11:07:28', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(260, 'T0002', '2025-03-30 11:07:38', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(261, 'T0002', '2025-03-30 11:07:40', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(262, 'T0002', '2025-03-30 11:07:42', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(263, 'T0002', '2025-03-30 11:26:13', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(264, 'T0002', '2025-03-30 11:26:15', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(265, 'T0002', '2025-03-30 11:26:16', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(266, 'T0002', '2025-03-30 11:40:45', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(267, 'T0002', '2025-03-30 11:40:47', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(268, 'T0002', '2025-03-30 11:40:48', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(269, 'T0002', '2025-04-01 01:21:36', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(270, 'T0002', '2025-04-01 01:21:38', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(271, 'T0002', '2025-04-01 01:21:39', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(272, 'T0002', '2025-04-01 01:22:34', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(273, 'T0002', '2025-04-01 01:22:35', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(274, 'T0002', '2025-04-01 01:22:36', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(275, 'T0002', '2025-04-01 01:51:22', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(276, 'T0002', '2025-04-01 01:51:23', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(277, 'T0002', '2025-04-01 01:51:24', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(278, 'T0002', '2025-04-01 01:57:06', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(279, 'T0002', '2025-04-01 01:57:07', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(280, 'T0002', '2025-04-01 01:57:08', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(281, 'T0002', '2025-04-01 01:58:10', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(282, 'T0002', '2025-04-01 01:58:11', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(283, 'T0002', '2025-04-01 01:58:12', NULL, 6.000000, 0.000000, 0.000000, 0.000000),
(284, 'T0001', '2025-04-01 06:51:31', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(285, 'T0001', '2025-04-01 06:51:33', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(286, 'T0001', '2025-04-01 06:51:34', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(287, 'T0001', '2025-04-01 06:57:51', NULL, 7.000000, 0.000000, 0.000000, 0.000000),
(288, 'T0001', '2025-04-01 06:57:52', NULL, 7.000000, 0.000000, 0.000000, 0.000000),
(289, 'T0001', '2025-04-01 06:57:53', NULL, 7.000000, 0.000000, 0.000000, 0.000000),
(290, 'T0001', '2025-04-01 06:58:59', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(291, 'T0001', '2025-04-01 06:58:59', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(292, 'T0001', '2025-04-01 06:59:00', NULL, 9.000000, 0.000000, 0.000000, 0.000000),
(293, 'T0001', '2025-04-01 07:12:18', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(294, 'T0001', '2025-04-01 07:12:19', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(295, 'T0001', '2025-04-01 07:12:20', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(296, 'T0002', '2025-04-01 07:12:27', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(297, 'T0002', '2025-04-01 07:12:28', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(298, 'T0002', '2025-04-01 07:12:28', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(299, 'T0001', '2025-04-01 08:08:51', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(300, 'T0001', '2025-04-01 08:08:52', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(301, 'T0001', '2025-04-01 08:08:52', NULL, 5.000000, 4.000000, 6.000000, 99.000000),
(302, 'T0002', '2025-04-01 08:09:11', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(303, 'T0002', '2025-04-01 08:09:12', NULL, 4.000000, 4.000000, 4.000000, 149.000000),
(304, 'T0002', '2025-04-01 08:09:12', NULL, 4.000000, 4.000000, 4.000000, 149.000000);

-- --------------------------------------------------------

--
-- Table structure for table `status_machine`
--

CREATE TABLE `status_machine` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `status_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_machine`
--

INSERT INTO `status_machine` (`id`, `status_id`, `status_name`) VALUES
(1, 1, 'active'),
(2, 2, 'repair'),
(5, 3, 'inactive');

-- --------------------------------------------------------

--
-- Table structure for table `status_senser`
--

CREATE TABLE `status_senser` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `status_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_senser`
--

INSERT INTO `status_senser` (`id`, `status_id`, `status_name`) VALUES
(1, 1, 'active'),
(2, 2, 'inactive');

-- --------------------------------------------------------

--
-- Table structure for table `status_user`
--

CREATE TABLE `status_user` (
  `id` int(11) NOT NULL,
  `stauts_id` varchar(100) NOT NULL,
  `status_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_user`
--

INSERT INTO `status_user` (`id`, `stauts_id`, `status_name`) VALUES
(1, '1', 'ทำงานอยู่'),
(2, '2', 'ปลดประจำการ');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `tel` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_user` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_by` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_id`, `username`, `password`, `first_name`, `last_name`, `tel`, `email`, `status`, `role_id`, `status_user`, `create_date`, `create_by`) VALUES
(9, 'admin', 'admin', '$2b$10$F1rC4N92XcY41LkK56he.u.djllMpeAHagQCYmpxx4j5127DM9Wye', 'admin', 'admin', '0000000', '00000000@0000', 'active', 1, '1', '2025-02-12 19:02:51', 'admin'),
(10, '0001', '0001', '$2b$10$T6PaXoGJPzSUuVd9E9C1QuhZAElCA6MVs2acbk6N5mEGJripIpCa.', 'name', '---', '000000', 'name@mail.com', 'active', 2, '1', '2025-02-12 19:34:46', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `repair`
--
ALTER TABLE `repair`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rul_history`
--
ALTER TABLE `rul_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status_machine`
--
ALTER TABLE `status_machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status_senser`
--
ALTER TABLE `status_senser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status_user`
--
ALTER TABLE `status_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `machine`
--
ALTER TABLE `machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `repair`
--
ALTER TABLE `repair`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rul_history`
--
ALTER TABLE `rul_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sensor`
--
ALTER TABLE `sensor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;

--
-- AUTO_INCREMENT for table `status_machine`
--
ALTER TABLE `status_machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `status_senser`
--
ALTER TABLE `status_senser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `status_user`
--
ALTER TABLE `status_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
