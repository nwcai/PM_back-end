-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2025 at 04:19 PM
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
-- Table structure for table `machine`
--

CREATE TABLE `machine` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `machine_name` varchar(100) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  `status` varchar(100) NOT NULL,
  `status_machine` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `life_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `machine`
--

INSERT INTO `machine` (`id`, `id_machine`, `machine_name`, `detail`, `note`, `status`, `status_machine`, `create_date`, `create_by`, `update_date`, `update_by`, `life_time`) VALUES
(16, 221, 'ji', 'ssssssss', 'ssss', 'active', 1, '2025-03-12 18:54:57', 'Admin', '0000-00-00 00:00:00', '', 1000),
(17, 551, 'Test', 'tetst', ' f', 'active', 1, '2025-03-22 16:46:17', 'Admin', '0000-00-00 00:00:00', '', 500),
(18, 664, 'test 03', 'test', '-', 'active', 1, '2025-03-22 21:47:33', 'Admin', '0000-00-00 00:00:00', '', 500);

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
-- Table structure for table `sensor`
--

CREATE TABLE `sensor` (
  `id` int(11) NOT NULL,
  `id_machine` int(11) NOT NULL,
  `id_sensor` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `status_sensor` int(11) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  `severity` int(11) NOT NULL,
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

INSERT INTO `sensor` (`id`, `id_machine`, `id_sensor`, `name`, `status`, `create_by`, `create_date`, `update_by`, `update_date`, `status_sensor`, `detail`, `note`, `severity`, `warning_vibration_x`, `warning_vibration_y`, `warning_vibration_z`, `warning_temp`, `critical_vibration_x`, `critical_vibration_y`, `critical_vibration_z`, `critical_temp`) VALUES
(21, 221, 1111, 'Test', 'inactive', 'admin', '2025-03-22 11:30:42', '', '0000-00-00 00:00:00', 1, 'test 1', '-', 5, 7.000000, 7.000000, 7.000000, 100.000000, 9.000000, 9.000000, 9.000000, 150.000000),
(22, 221, 9999, 'test02', 'inactive', 'admin', '2025-03-22 11:32:44', 'Admin', '2025-03-22 13:49:52', 1, 'test 2', '-', 9, 7.000000, 7.000000, 7.000000, 100.000000, 9.000000, 9.000000, 9.000000, 150.000000),
(23, 221, 1111, 'Test', 'inactive', 'admin', '2025-03-22 12:18:33', '', '2025-03-22 12:18:33', 1, 'test 1', '-', 5, 7.000000, 7.000000, 7.000000, 100.000000, 9.000000, 9.000000, 9.000000, 150.000000),
(24, 221, 9999, 'test02', 'active', 'admin', '2025-03-22 14:05:16', '', '0000-00-00 00:00:00', 1, 'test 2', '-', 9, 8.000000, 8.000000, 8.000000, 100.000000, 9.000000, 9.000000, 9.000000, 150.000000),
(25, 221, 1111, 'Test', 'active', 'admin', '2025-03-22 21:36:21', '', '2025-03-22 21:36:21', 1, 'test 1', '-', 5, 7.000000, 5.000000, 6.000000, 100.000000, 9.000000, 9.000000, 9.000000, 150.000000),
(26, 221, 5555, 'test3', 'active', 'admin', '2025-03-22 21:46:44', '', '0000-00-00 00:00:00', 1, 'test', '-', 5, 4.000000, 6.000000, 7.000000, 100.000000, 8.000000, 9.000000, 9.000000, 150.000000);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` int(11) NOT NULL,
  `id_sensor` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `repair_date` datetime NOT NULL,
  `vibration_x` decimal(10,6) NOT NULL,
  `vibration_y` decimal(10,6) NOT NULL,
  `vibration_z` decimal(10,6) NOT NULL,
  `temp` decimal(10,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor_data`
--

INSERT INTO `sensor_data` (`id`, `id_sensor`, `create_date`, `repair_date`, `vibration_x`, `vibration_y`, `vibration_z`, `temp`) VALUES
(18, 1111, '2025-03-14 12:17:44', '2025-03-14 13:17:44', 5.430000, 9.160000, 1.780000, 40.490000),
(19, 1111, '2025-03-19 12:17:44', '2025-03-19 13:17:44', 5.430000, 1.420000, 1.550000, 20.590000),
(20, 1111, '2025-03-16 12:17:44', '2025-03-16 13:17:44', 5.490000, 1.020000, 8.110000, 26.090000),
(21, 1111, '2025-03-15 12:17:44', '2025-03-15 15:17:44', 7.460000, 9.760000, 3.380000, 78.330000),
(22, 1111, '2025-03-13 12:17:44', '2025-03-13 14:17:44', 2.020000, 2.820000, 3.240000, 58.150000),
(23, 1111, '2025-03-18 12:17:44', '2025-03-18 13:17:44', 7.170000, 2.210000, 8.670000, 90.710000),
(24, 1111, '2025-03-20 12:17:44', '2025-03-20 15:17:44', 4.640000, 0.890000, 0.400000, 58.330000),
(25, 1111, '2025-03-17 12:17:44', '2025-03-17 13:17:44', 4.400000, 2.700000, 2.830000, 72.530000),
(26, 1111, '2025-03-12 12:17:44', '2025-03-12 13:17:44', 5.380000, 2.930000, 7.500000, 114.160000),
(27, 1111, '2025-03-18 12:17:44', '2025-03-18 13:17:44', 3.210000, 7.240000, 5.340000, 119.470000),
(28, 9999, '2025-03-22 08:03:53', '2025-03-22 08:03:53', 5.000000, 6.000000, 7.000000, 100.000000),
(29, 9999, '2025-03-22 08:05:41', '2025-03-22 08:05:41', 6.000000, 7.000000, 8.000000, 110.000000),
(30, 9999, '2025-03-17 17:57:43', '2025-03-17 19:57:43', 6.240000, 2.410000, 0.780000, 47.760000),
(31, 9999, '2025-03-17 17:57:43', '2025-03-17 20:57:43', 4.860000, 3.750000, 8.440000, 64.470000),
(32, 9999, '2025-03-16 17:57:43', '2025-03-16 18:57:43', 3.840000, 3.660000, 5.440000, 132.060000),
(33, 9999, '2025-03-13 17:57:43', '2025-03-13 18:57:43', 2.780000, 8.030000, 4.400000, 73.120000),
(34, 9999, '2025-03-15 17:57:43', '2025-03-15 19:57:43', 6.110000, 3.130000, 9.320000, 57.640000),
(35, 9999, '2025-03-19 17:57:43', '2025-03-19 19:57:43', 9.890000, 2.180000, 6.890000, 42.900000),
(36, 9999, '2025-03-17 17:57:43', '2025-03-17 18:57:43', 8.630000, 0.020000, 7.940000, 66.920000),
(37, 9999, '2025-03-18 17:57:43', '2025-03-18 18:57:43', 7.570000, 0.680000, 3.010000, 74.690000),
(38, 9999, '2025-03-17 17:57:43', '2025-03-17 18:57:43', 3.690000, 7.890000, 5.690000, 124.820000),
(39, 9999, '2025-03-18 17:57:43', '2025-03-18 18:57:43', 8.890000, 5.490000, 5.250000, 120.460000);

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
-- Indexes for table `machine`
--
ALTER TABLE `machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
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
-- AUTO_INCREMENT for table `machine`
--
ALTER TABLE `machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sensor`
--
ALTER TABLE `sensor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
