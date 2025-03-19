-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 19, 2025 at 03:50 PM
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
(16, 221, 'ji', 'ssssssss', 'ssss', 'active', 1, '2025-03-12 18:54:57', 'Admin', '0000-00-00 00:00:00', '', 100);

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
  `name` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `serial_number` varchar(100) NOT NULL,
  `create_by` varchar(100) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_by` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `status_sensor` int(11) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
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

INSERT INTO `sensor` (`id`, `id_machine`, `name`, `status`, `serial_number`, `create_by`, `create_date`, `update_by`, `update_date`, `status_sensor`, `detail`, `note`, `warning_vibration_x`, `warning_vibration_y`, `warning_vibration_z`, `warning_temp`, `critical_vibration_x`, `critical_vibration_y`, `critical_vibration_z`, `critical_temp`) VALUES
(16, 221, 'yoyo', 'inactive', 'yoyo112', 'admin', '2025-03-12 20:44:35', '', '0000-00-00 00:00:00', 1, '', '', 33.000000, 0.000000, 0.000000, 54.000000, 45.000000, 0.000000, 0.000000, 100.000000),
(17, 221, 'yoyo', 'inactive', 'yoyo112', 'admin', '2025-03-12 20:44:47', '', '2025-03-12 20:44:47', 1, '', '', 33.000000, 1.000000, 0.000000, 54.000000, 45.000000, 7.000000, 0.000000, 100.000000),
(18, 221, 'yoyo', 'active', 'yoyo112', 'admin', '2025-03-12 20:45:36', '', '2025-03-12 20:45:36', 1, '', 'yo', 33.000000, 1.000000, 3.000000, 53.000000, 45.000000, 7.000000, 11.000000, 100.000000);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` int(11) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `input_temp` decimal(10,6) NOT NULL,
  `create_date` datetime NOT NULL,
  `repair_date` datetime NOT NULL,
  `input_vibration_x` decimal(10,6) NOT NULL,
  `input_vibration_y` decimal(10,6) NOT NULL,
  `input_vibration_z` decimal(10,6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sensor`
--
ALTER TABLE `sensor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
