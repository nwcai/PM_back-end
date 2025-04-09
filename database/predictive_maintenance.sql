-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 09, 2025 at 10:51 AM
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
(1, 4, '-', 'test', 'manual', 2, 'tea', '2025-03-20 10:45:55', '2025-05-14 21:48:00', 0.80, 'test2'),
(2, 1, 'sensor2', 'Sensor state changed to warning', 'automatic', 2, 'The sensor state was updated to warning with severity level 2.', '2025-02-21 00:27:14', NULL, NULL, NULL),
(3, 33, 'sensor15', 'Sensor state changed to warning', 'automatic', 1, 'The sensor state was updated to warning with severity level 1.', '2025-02-21 00:27:14', NULL, NULL, NULL),
(4, 2, 'sensor3', 'Sensor state changed to critical', 'automatic', 7, 'The sensor state was updated to critical with severity level 7.', '2025-02-21 00:27:14', '2025-02-28 16:48:00', 80.00, 'เปลี่นอะไหล่'),
(5, 35, 'sensor_5c10be', 'Sensor state changed to warning', 'automatic', 3, 'The sensor state was updated to warning with severity level 3.', '2025-02-21 00:00:07', NULL, NULL, NULL),
(6, 36, 'sensor_5c1202', 'Sensor state changed to critical', 'automatic', 5, 'The sensor state was updated to critical with severity level 5.', '2025-02-21 00:00:11', NULL, NULL, NULL),
(7, 35, 'sensor_5c1223', 'Sensor state changed to warning', 'automatic', 1, 'The sensor state was updated to warning with severity level 1.', '2025-02-21 00:00:08', NULL, NULL, NULL),
(8, 36, 'sensor_5c124f', 'Sensor state changed to warning', 'automatic', 3, 'The sensor state was updated to warning with severity level 3.', '2025-02-21 00:00:12', NULL, NULL, NULL),
(9, 35, 'sensor_5c126d', 'Sensor state changed to warning', 'automatic', 2, 'The sensor state was updated to warning with severity level 2.', '2025-02-21 00:00:03', NULL, NULL, NULL),
(10, 35, 'sensor_5c1289', 'Sensor state changed to warning', 'automatic', 5, 'The sensor state was updated to warning with severity level 5.', '2025-02-21 00:00:09', NULL, NULL, NULL),
(11, 35, 'sensor_5c12d7', 'Sensor state changed to warning', 'automatic', 1, 'The sensor state was updated to warning with severity level 1.', '2025-02-21 00:00:05', NULL, NULL, NULL),
(12, 36, 'sensor_5c1338', 'Sensor state changed to critical', 'automatic', 5, 'The sensor state was updated to critical with severity level 5.', '2025-02-21 00:00:17', NULL, NULL, NULL),
(13, 36, 'sensor_5c13be', 'Sensor state changed to critical', 'automatic', 6, 'The sensor state was updated to critical with severity level 6.', '2025-02-21 00:00:22', NULL, NULL, NULL),
(14, 4, 'sensor9', 'Sensor state changed to critical', 'automatic', 8, 'The sensor state was updated to critical with severity level 8.', '2025-02-21 00:27:15', '2025-02-23 21:46:00', 0.50, 'test'),
(15, 3, 'sensor6', 'Sensor state changed to warning', 'automatic', 5, 'The sensor state was updated to warning with severity level 5.', '2025-02-21 00:27:14', NULL, NULL, NULL),
(16, 5, 'sensor10', 'Sensor state changed to warning', 'automatic', 4, 'The sensor state was updated to warning with severity level 4.', '2025-02-21 00:57:16', NULL, NULL, NULL),
(17, 6, 'sensor13', 'Sensor state changed to warning', 'automatic', 4, 'The sensor state was updated to warning with severity level 4.', '2025-02-21 00:57:15', NULL, NULL, NULL),
(18, 3, 'sensor14', 'Sensor state changed to warning', 'automatic', 5, 'The sensor state was updated to warning with severity level 5.', '2025-02-21 01:57:19', NULL, NULL, NULL),
(19, 2, 'sensor4', 'Sensor state changed to warning', 'automatic', 2, 'The sensor state was updated to warning with severity level 2.', '2025-02-21 01:57:20', NULL, NULL, NULL),
(20, 1, 'Motor Drive', 'Sensor state changed to warning', 'automatic', 2, 'The sensor state was updated to warning with severity level 2.', '2025-02-21 02:27:21', NULL, NULL, NULL),
(21, 2, 'sensor5', 'Sensor state changed to warning', 'automatic', 4, 'The sensor state was updated to warning with severity level 4.', '2025-02-21 02:27:23', NULL, NULL, NULL),
(22, 36, 'sensor_5c12e5', 'Sensor state changed to critical', 'automatic', 6, 'The sensor state was updated to critical with severity level 6.', '2025-02-21 02:00:12', NULL, NULL, NULL),
(23, 4, '-', 'test2', 'manual', 5, 'teste', '2025-04-07 14:50:27', NULL, NULL, NULL);

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
(23, 1, 'Motor Mixer', 'mixing', 'NULL', 'active', 1, '2025-02-10 00:51:25', 'Admin', '0000-00-00 00:00:00', '', 732, NULL, NULL),
(24, 5, 'Industrial Tank', 'Tanks', 'NULL', 'active', 1, '2025-02-10 00:51:53', 'Admin', '0000-00-00 00:00:00', '', 864, NULL, NULL),
(25, 6, 'Electric Rotor', 'Rotor', 'NULL', 'active', 1, '2025-02-06 00:52:01', 'Admin', '0000-00-00 00:00:00', '', 953, NULL, NULL),
(26, 3, 'Compressor1', 'Compressor', 'NULL', 'active', 1, '2025-02-02 00:52:10', 'Admin', '0000-00-00 00:00:00', '', 589, NULL, NULL),
(27, 33, 'Gearbox2', 'Gearbox', 'NULL', 'active', 1, '2025-02-07 00:52:17', 'Admin', '0000-00-00 00:00:00', '', 725, NULL, NULL),
(28, 2, 'Rotor1', 'Rotor', 'NULL', 'active', 1, '2025-02-03 00:52:27', 'Admin', '0000-00-00 00:00:00', '', 891, NULL, NULL),
(29, 35, 'CC2 Filler Machine No. 2', 'NULL', 'NULL', 'active', 1, '2025-02-02 00:52:35', 'Admin', '0000-00-00 00:00:00', '', 673, NULL, NULL),
(30, 36, 'CC1 Filler Machine No. 1', 'NULL', 'NULL', 'active', 1, '2025-02-01 00:52:43', 'Admin', '0000-00-00 00:00:00', '', 910, NULL, NULL),
(31, 4, 'Motor', 'Motor1', 'NULL', 'active', 1, '2025-02-02 00:52:51', 'Admin', '0000-00-00 00:00:00', '', 2500, NULL, NULL);

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
  `id_sensor` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `status_sensor` int(100) NOT NULL,
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
(1, 1, 'Motor Drive', 'Motor Drive', 'active', 'admin', '2024-09-07 14:03:02', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 2, 4, 0.600000, 0.600000, 0.600000, 50.000000, 1.000000, 1.100000, 1.200000, 80.000000),
(2, 2, 'sensor5', 'sensor5', 'active', 'admin', '2024-09-15 00:29:00', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 4, 5, 0.600000, 0.600000, 0.500000, 52.000000, 0.700000, 0.700000, 0.700000, 90.000000),
(3, 5, 'sensor10', 'sensor10', 'active', 'admin', '2024-09-20 00:50:23', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 4, 7, 0.500000, 0.600000, 0.500000, 53.000000, 0.700000, 1.000000, 0.700000, 73.000000),
(4, 5, 'sensor11', 'sensor11', 'active', 'admin', '2024-09-20 00:50:32', '', '0000-00-00 00:00:00', 1, 'good', '', '', 2, 4, 0.500000, 0.500000, 0.500000, 47.000000, 0.700000, 0.800000, 0.700000, 67.000000),
(5, 6, 'sensor12', 'sensor12', 'active', 'admin', '2024-09-20 00:50:38', '', '0000-00-00 00:00:00', 1, 'good', '', '', 1, 2, 0.500000, 0.600000, 0.600000, 49.000000, 0.900000, 0.800000, 0.900000, 59.000000),
(6, 6, 'sensor13', 'sensor13', 'active', 'admin', '2024-09-20 00:51:46', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 4, 6, 0.500000, 0.600000, 0.500000, 53.000000, 0.900000, 0.900000, 0.700000, 83.000000),
(7, 1, 'sensor2', 'sensor2', 'active', 'admin', '2024-09-07 14:03:24', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 2, 3, 0.500000, 0.500000, 0.500000, 50.000000, 0.900000, 1.000000, 1.100000, 75.000000),
(8, 33, 'sensor15', 'sensor15', 'active', 'admin', '2024-09-24 16:32:58', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 1, 3, 0.500000, 0.500000, 0.600000, 60.000000, 0.800000, 0.700000, 0.900000, 80.000000),
(9, 2, 'sensor3', 'sensor3', 'active', 'admin', '2024-09-15 00:28:47', '', '0000-00-00 00:00:00', 1, 'good', '', '', 4, 7, 0.700000, 0.700000, 0.500000, 45.000000, 0.800000, 0.900000, 1.000000, 60.000000),
(10, 3, 'sensor14', 'sensor14', 'active', 'admin', '2024-09-23 10:33:09', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 5, 6, 0.600000, 0.600000, 0.600000, 40.000000, 0.700000, 0.700000, 0.700000, 50.000000),
(11, 2, 'sensor4', 'sensor4', 'active', 'admin', '2024-09-15 00:28:53', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 2, 4, 0.200000, 0.300000, 0.400000, 60.000000, 0.600000, 0.600000, 0.600000, 100.000000),
(12, 36, 'sensor_5c12e5', 'Point 5 Motor DE', 'active', 'admin', '2024-10-14 16:34:24', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 3, 6, 0.500000, 0.600000, 0.500000, 52.000000, 0.700000, 0.900000, 0.900000, 82.000000),
(13, 35, 'sensor_5c10be', 'Point 4 Can output', 'active', 'admin', '2024-10-14 16:30:41', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 3, 5, 0.600000, 0.500000, 0.600000, 47.000000, 0.900000, 0.700000, 0.800000, 87.000000),
(14, 36, 'sensor_5c1202', 'Point 3 can middle output', 'active', 'admin', '2024-10-14 16:33:33', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 4, 5, 0.600000, 0.600000, 0.600000, 52.000000, 0.900000, 1.000000, 1.000000, 72.000000),
(15, 35, 'sensor_5c1223', 'Point 3 can middle output', 'active', 'admin', '2024-10-14 16:30:12', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 1, 2, 0.600000, 0.500000, 0.600000, 57.000000, 0.800000, 0.700000, 0.800000, 67.000000),
(16, 36, 'sensor_5c124f', 'Point 4 Can output', 'active', 'admin', '2024-10-14 16:33:53', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 3, 6, 0.600000, 0.600000, 0.600000, 48.000000, 0.900000, 0.900000, 1.000000, 88.000000),
(17, 35, 'sensor_5c126d', 'Point 1 can input', 'active', 'admin', '2024-10-14 16:08:03', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 2, 5, 0.500000, 0.500000, 0.500000, 48.000000, 0.900000, 0.700000, 0.800000, 58.000000),
(18, 35, 'sensor_5c1289', 'Point 5 Motor DE', 'active', 'admin', '2024-10-14 16:31:15', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 5, 7, 0.500000, 0.500000, 0.600000, 49.000000, 0.900000, 0.700000, 1.000000, 59.000000),
(19, 35, 'sensor_5c12d7', 'Point 2 can middle input', 'active', 'admin', '2024-10-14 16:20:09', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 1, 3, 0.500000, 0.500000, 0.500000, 49.000000, 0.700000, 0.700000, 0.700000, 69.000000),
(20, 36, 'sensor_5c1338', 'Point 1 can input', 'active', 'admin', '2024-10-14 16:32:44', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 2, 5, 0.500000, 0.600000, 0.500000, 40.000000, 0.900000, 1.000000, 0.700000, 50.000000),
(21, 36, 'sensor_5c13be', 'Point 2 can middle input', 'active', 'admin', '2024-10-14 16:33:09', '', '0000-00-00 00:00:00', 1, 'critical', '', '', 5, 6, 0.500000, 0.600000, 0.500000, 55.000000, 0.800000, 0.900000, 0.900000, 65.000000),
(22, 4, 'sensor9', 'sensor9', 'active', 'admin', '2024-09-20 00:49:48', '', '0000-00-00 00:00:00', 1, 'good', '', '', 5, 8, 0.600000, 0.600000, 0.600000, 60.000000, 0.800000, 0.800000, 0.800000, 70.000000),
(23, 3, 'sensor6', 'sensor6', 'active', 'admin', '2024-09-19 23:59:00', '', '0000-00-00 00:00:00', 1, 'warning', '', '', 5, 6, 0.500000, 0.600000, 0.600000, 40.000000, 0.800000, 1.000000, 0.900000, 60.000000),
(24, 4, 'sensor7', 'sensor7', 'active', 'admin', '2024-09-20 00:49:33', '', '0000-00-00 00:00:00', 1, 'good', '', '', 3, 5, 0.600000, 0.500000, 0.600000, 58.000000, 1.000000, 0.700000, 0.900000, 88.000000),
(25, 4, 'sensor8', 'sensor8', 'active', 'admin', '2024-09-20 00:49:41', '', '0000-00-00 00:00:00', 1, 'good', '', '', 2, 3, 0.600000, 0.600000, 0.600000, 47.000000, 0.800000, 0.800000, 0.800000, 77.000000);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` int(11) NOT NULL,
  `id_sensor` varchar(100) NOT NULL,
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
(1, 'Motor Drive', '2025-02-21 00:27:14', NULL, 0.587509, 0.569723, 0.431187, 69.000000),
(2, 'sensor5', '2025-02-21 00:27:15', NULL, 0.479961, 0.599912, 0.416604, 30.000000),
(3, 'sensor10', '2025-02-21 00:27:14', NULL, 0.581231, 0.416359, 0.483310, 28.000000),
(4, 'sensor13', '2025-02-21 00:27:14', NULL, 0.401008, 0.490856, 0.510450, 73.000000),
(5, 'sensor2', '2025-02-21 00:27:14', NULL, 2.097628, 1.910680, 1.992412, 109.000000),
(6, 'sensor15', '2025-02-21 00:27:14', NULL, 2.092021, 1.942209, 2.030905, 92.000000),
(7, 'sensor3', '2025-02-21 00:27:14', NULL, 0.412780, 0.567427, 0.566724, 63.000000),
(8, 'sensor14', '2025-02-21 00:27:14', NULL, 0.454689, 0.459629, 0.542631, 26.000000),
(9, 'sensor4', '2025-02-21 00:27:15', NULL, 0.547257, 0.521186, 0.441563, 26.000000),
(10, 'sensor_5c12e5', '2025-02-21 00:00:13', NULL, 2.434082, 1.184082, 1.584473, 33.100000),
(11, 'sensor_5c10be', '2025-02-21 00:00:07', NULL, 0.527344, 1.110840, 0.471191, 27.700000),
(12, 'sensor_5c1202', '2025-02-21 00:00:11', NULL, 1.113281, 2.175293, 1.240234, 29.400000),
(13, 'sensor_5c1223', '2025-02-21 00:00:08', NULL, 0.473633, 0.615234, 0.356445, 28.200000),
(14, 'sensor_5c124f', '2025-02-21 00:00:12', NULL, 0.979004, 1.242676, 1.975098, 28.600000),
(15, 'sensor_5c126d', '2025-02-21 00:00:03', NULL, 0.522461, 0.498047, 0.456543, 28.500000),
(16, 'sensor_5c1289', '2025-02-21 00:00:09', NULL, 2.626953, 1.320801, 1.516113, 30.700000),
(17, 'sensor_5c12d7', '2025-02-21 00:00:05', NULL, 0.646973, 0.856934, 0.402832, 28.500000),
(18, 'sensor_5c1338', '2025-02-21 00:00:17', NULL, 1.210938, 0.878906, 1.484375, 29.700000),
(19, 'sensor_5c13be', '2025-02-21 00:00:22', NULL, 0.878906, 1.337891, 1.437988, 29.400000),
(20, 'sensor9', '2025-02-21 00:27:15', NULL, 2.077546, 1.909438, 2.027225, 64.000000),
(21, 'sensor6', '2025-02-21 00:27:14', NULL, 0.564606, 0.469677, 0.561708, 56.000000),
(22, 'sensor7', '2025-02-21 00:27:15', NULL, 0.517432, 0.487797, 0.481214, 25.000000),
(23, 'Motor Drive', '2025-02-21 00:57:16', NULL, 0.579797, 0.577786, 0.424259, 81.000000),
(24, 'sensor5', '2025-02-21 00:57:17', NULL, 0.532517, 0.578177, 0.514252, 76.000000),
(25, 'sensor10', '2025-02-21 00:57:16', NULL, 0.547210, 0.585489, 0.482613, 26.000000),
(26, 'sensor13', '2025-02-21 00:57:15', NULL, 0.436323, 0.409363, 0.427063, 67.000000),
(27, 'sensor2', '2025-02-21 00:57:16', NULL, 0.513959, 0.541141, 0.534636, 72.000000),
(28, 'sensor15', '2025-02-21 00:57:16', NULL, 0.459235, 0.401471, 0.599010, 84.000000),
(29, 'sensor3', '2025-02-21 00:57:17', NULL, 0.402554, 0.529745, 0.436791, 28.000000),
(30, 'sensor14', '2025-02-21 00:57:16', NULL, 0.477215, 0.507832, 0.446540, 56.000000),
(31, 'sensor4', '2025-02-21 00:57:17', NULL, 0.555414, 0.561039, 0.563426, 71.000000),
(32, 'sensor9', '2025-02-21 00:57:17', NULL, 0.462401, 0.499715, 0.588710, 28.000000),
(33, 'sensor6', '2025-02-21 00:57:16', NULL, 0.484558, 0.522067, 0.426224, 29.000000),
(34, 'sensor7', '2025-02-21 00:57:17', NULL, 1.914557, 1.936178, 2.094200, 99.000000),
(35, 'Motor Drive', '2025-02-21 01:27:17', NULL, 0.479993, 0.424454, 0.505811, 25.000000),
(36, 'sensor5', '2025-02-21 01:27:19', NULL, 0.515190, 0.445919, 0.486572, 26.000000),
(37, 'sensor10', '2025-02-21 01:27:18', NULL, 2.003887, 2.060606, 1.921799, 103.000000),
(38, 'sensor13', '2025-02-21 01:27:17', NULL, 0.562345, 0.540396, 0.451708, 66.000000),
(39, 'sensor2', '2025-02-21 01:27:18', NULL, 0.502835, 0.531337, 0.493560, 70.000000),
(40, 'sensor15', '2025-02-21 01:27:18', NULL, 0.455411, 0.438999, 0.463249, 71.000000),
(41, 'sensor3', '2025-02-21 01:27:18', NULL, 0.406639, 0.447405, 0.505757, 29.000000),
(42, 'sensor14', '2025-02-21 01:27:18', NULL, 0.543788, 0.555628, 0.591105, 28.000000),
(43, 'sensor4', '2025-02-21 01:27:18', NULL, 0.420879, 0.515053, 0.467585, 28.000000),
(44, 'sensor_5c12e5', '2025-02-21 01:00:16', NULL, 2.409668, 1.289063, 1.154785, 34.700000),
(45, 'sensor_5c10be', '2025-02-21 01:00:08', NULL, 0.617676, 0.908203, 0.541992, 30.900000),
(46, 'sensor_5c1202', '2025-02-21 01:00:14', NULL, 1.071777, 0.925293, 2.131348, 30.900000),
(47, 'sensor_5c1223', '2025-02-21 01:00:11', NULL, 0.432129, 0.544434, 0.478516, 32.500000),
(48, 'sensor_5c124f', '2025-02-21 01:00:15', NULL, 0.849609, 0.776367, 1.088867, 29.600000),
(49, 'sensor_5c126d', '2025-02-21 01:00:03', NULL, 0.761719, 1.115723, 0.632324, 33.000000),
(50, 'sensor_5c1289', '2025-02-21 01:00:13', NULL, 2.038574, 1.013184, 1.318359, 33.800000),
(51, 'sensor_5c12d7', '2025-02-21 01:00:07', NULL, 0.632324, 0.815430, 0.454102, 33.000000),
(52, 'sensor_5c1338', '2025-02-21 01:00:16', NULL, 1.091309, 0.881348, 1.669922, 31.200000),
(53, 'sensor_5c13be', '2025-02-21 01:00:17', NULL, 1.057129, 1.101074, 1.726074, 31.100000),
(54, 'sensor9', '2025-02-21 01:27:19', NULL, 0.500740, 0.444650, 0.517215, 28.000000),
(55, 'sensor6', '2025-02-21 01:27:18', NULL, 0.426871, 0.500639, 0.517323, 29.000000),
(56, 'sensor7', '2025-02-21 01:27:19', NULL, 0.547301, 0.448806, 0.431575, 30.000000),
(57, 'Motor Drive', '2025-02-21 01:57:19', NULL, 0.534771, 0.409880, 0.526905, 27.000000),
(58, 'sensor5', '2025-02-21 01:57:21', NULL, 0.570968, 0.562605, 0.482044, 25.000000),
(59, 'sensor10', '2025-02-21 01:57:20', NULL, 1.902453, 1.961380, 2.043621, 91.000000),
(60, 'sensor13', '2025-02-21 01:57:19', NULL, 0.437455, 0.490635, 0.467143, 25.000000),
(61, 'sensor2', '2025-02-21 01:57:20', NULL, 0.574835, 0.479242, 0.538329, 69.000000),
(62, 'sensor15', '2025-02-21 01:57:20', NULL, 0.578312, 0.530660, 0.510775, 62.000000),
(63, 'sensor3', '2025-02-21 01:57:20', NULL, 2.004728, 2.054708, 1.950086, 61.000000),
(64, 'sensor14', '2025-02-21 01:57:19', NULL, 0.561785, 0.451696, 0.554167, 45.000000),
(65, 'sensor4', '2025-02-21 01:57:20', NULL, 2.032810, 2.025738, 1.928783, 63.000000),
(66, 'sensor9', '2025-02-21 01:57:21', NULL, 0.428596, 0.464051, 0.405528, 28.000000),
(67, 'sensor6', '2025-02-21 01:57:19', NULL, 2.093949, 1.966845, 2.019723, 113.000000),
(68, 'sensor7', '2025-02-21 01:57:21', NULL, 2.036879, 2.063417, 1.975575, 94.000000),
(69, 'Motor Drive', '2025-02-21 02:27:21', NULL, 0.574778, 0.587032, 0.499673, 61.000000),
(70, 'sensor5', '2025-02-21 02:27:23', NULL, 0.508239, 0.444794, 0.551700, 27.000000),
(71, 'sensor10', '2025-02-21 02:27:22', NULL, 0.498472, 0.504892, 0.414276, 26.000000),
(72, 'sensor13', '2025-02-21 02:27:21', NULL, 2.075923, 2.095578, 2.083556, 117.000000),
(73, 'sensor2', '2025-02-21 02:27:22', NULL, 0.578730, 0.572064, 0.468139, 64.000000),
(74, 'sensor15', '2025-02-21 02:27:22', NULL, 0.502247, 0.535114, 0.436779, 56.000000),
(75, 'sensor3', '2025-02-21 02:27:22', NULL, 0.562661, 0.490309, 0.458895, 62.000000),
(76, 'sensor14', '2025-02-21 02:27:22', NULL, 0.556454, 0.541505, 0.445623, 68.000000),
(77, 'sensor4', '2025-02-21 02:27:22', NULL, 1.946087, 2.016152, 2.012024, 61.000000),
(78, 'sensor_5c12e5', '2025-02-21 02:00:12', NULL, 1.899414, 1.176758, 1.367188, 35.600000),
(79, 'sensor_5c10be', '2025-02-21 02:00:06', NULL, 0.505371, 0.610352, 0.415039, 33.100000),
(80, 'sensor_5c1202', '2025-02-21 02:00:09', NULL, 1.149902, 1.433105, 1.618652, 32.300000),
(81, 'sensor_5c1223', '2025-02-21 02:00:07', NULL, 0.456543, 0.839844, 0.373535, 34.200000),
(82, 'sensor_5c124f', '2025-02-21 02:00:10', NULL, 0.986328, 1.220703, 1.313477, 31.100000),
(83, 'sensor_5c126d', '2025-02-21 02:00:03', NULL, 0.688477, 0.913086, 0.522461, 35.300000),
(84, 'sensor_5c1289', '2025-02-21 02:00:08', NULL, 2.971191, 0.927734, 1.506348, 35.300000),
(85, 'sensor_5c12d7', '2025-02-21 02:00:05', NULL, 0.546875, 0.895996, 0.395508, 34.700000),
(86, 'sensor_5c1338', '2025-02-21 02:00:12', NULL, 1.228027, 0.805664, 1.608887, 32.400000),
(87, 'sensor_5c13be', '2025-02-21 02:00:14', NULL, 1.308594, 0.715332, 1.645508, 32.600000),
(88, 'sensor9', '2025-02-21 02:27:23', NULL, 0.532091, 0.459061, 0.565370, 28.000000),
(89, 'sensor6', '2025-02-21 02:27:21', NULL, 0.507650, 0.544954, 0.592310, 72.000000),
(90, 'sensor7', '2025-02-21 02:27:23', NULL, 0.575208, 0.416359, 0.499098, 73.000000),
(91, 'Motor Drive', '2025-02-21 02:57:23', NULL, 0.475566, 0.516669, 0.501234, 78.000000),
(92, 'sensor5', '2025-02-21 02:57:25', NULL, 0.564950, 0.484884, 0.431316, 25.000000),
(93, 'sensor10', '2025-02-21 02:57:24', NULL, 0.559833, 0.452198, 0.525988, 85.000000),
(94, 'sensor13', '2025-02-21 02:57:23', NULL, 0.539280, 0.479959, 0.446098, 28.000000),
(95, 'sensor2', '2025-02-21 02:57:24', NULL, 0.413939, 0.503511, 0.465123, 28.000000),
(96, 'sensor15', '2025-02-21 02:57:24', NULL, 2.063202, 2.029931, 1.909905, 97.000000),
(97, 'sensor3', '2025-02-21 02:57:24', NULL, 0.569890, 0.521441, 0.541067, 58.000000),
(98, 'sensor14', '2025-02-21 02:57:24', NULL, 0.579575, 0.420562, 0.572895, 50.000000),
(99, 'sensor4', '2025-02-21 02:57:24', NULL, 0.507637, 0.535298, 0.418434, 28.000000);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `machine`
--
ALTER TABLE `machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

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
