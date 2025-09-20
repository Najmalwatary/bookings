-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Sep 19, 2025 at 06:46 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booking_app_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `bank_id` int(11) NOT NULL,
  `bank_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`bank_id`, `bank_name`) VALUES
(1, 'البنك الأهلي السعودي'),
(2, 'بنك الراجحي'),
(3, 'بنك ساب'),
(4, 'البنك السعودي الاستثماري'),
(5, 'بنك الرياض');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `service_id`, `provider_id`, `total_amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1500.00, 'Confirmed', '2025-09-15 19:54:03', '2025-09-15 20:19:41'),
(2, 1, 2, 1, 350.00, 'pending', '2025-09-17 23:47:13', '2025-09-17 23:47:13'),
(3, 1, 4, 7, 150.00, 'pending', '2025-09-18 02:23:24', '2025-09-18 02:23:24'),
(4, 1, 5, 9, 150.00, 'pending', '2025-09-18 02:26:03', '2025-09-18 02:26:03'),
(5, 1, 1, 2, 300.00, 'pending', '2025-09-18 02:57:55', '2025-09-18 02:57:55'),
(6, 4, 1, 1, 0.00, 'pending', '2025-09-18 04:24:24', '2025-09-18 04:24:24'),
(7, 4, 1, 1, 0.00, 'pending', '2025-09-18 04:58:32', '2025-09-18 04:58:32'),
(8, 4, 1, 1, 0.00, 'Confirmed', '2025-09-18 05:24:33', '2025-09-18 05:24:33'),
(9, 4, 5, 11, 0.00, 'Confirmed', '2025-09-18 05:25:43', '2025-09-18 05:25:43'),
(10, 4, 2, 5, 0.00, 'Confirmed', '2025-09-18 05:31:49', '2025-09-18 05:31:49'),
(11, 4, 2, 5, 0.00, 'Confirmed', '2025-09-18 05:53:13', '2025-09-18 05:53:13'),
(12, 4, 2, 5, 0.00, 'Confirmed', '2025-09-18 05:54:58', '2025-09-18 05:54:58'),
(13, 4, 3, 7, 0.00, 'Confirmed', '2025-09-18 14:07:40', '2025-09-18 14:07:40'),
(14, 4, 3, 7, 0.00, 'Confirmed', '2025-09-18 14:08:34', '2025-09-18 14:08:34'),
(15, 4, 3, 7, 0.00, 'Confirmed', '2025-09-18 14:56:18', '2025-09-18 14:56:18'),
(16, 4, 3, 7, 0.00, 'Confirmed', '2025-09-18 15:44:34', '2025-09-18 15:44:34'),
(17, 1, 1, 1, 100.00, 'Confirmed', '2025-09-18 20:08:51', '2025-09-18 20:08:51'),
(18, 1, 1, 1, 100.00, 'Confirmed', '2025-09-18 20:17:06', '2025-09-18 20:17:06'),
(19, 1, 1, 1, 100.00, 'Confirmed', '2025-09-18 20:19:33', '2025-09-18 20:19:33'),
(20, 4, 3, 7, 0.00, 'Confirmed', '2025-09-18 21:19:40', '2025-09-18 21:19:40'),
(21, 4, 1, 1, 0.00, 'Confirmed', '2025-09-18 21:22:08', '2025-09-18 21:22:08'),
(22, 4, 1, 1, 0.00, 'Confirmed', '2025-09-18 21:22:29', '2025-09-18 21:22:29'),
(23, 4, 1, 1, 0.00, 'Confirmed', '2025-09-18 21:27:43', '2025-09-18 21:27:43'),
(25, 4, 1, 1, 0.00, 'Confirmed', '2025-09-18 21:41:00', '2025-09-18 21:41:00'),
(27, 4, 1, 1, 1500.00, 'Confirmed', '2025-09-18 22:48:04', '2025-09-18 22:48:04'),
(28, 4, 1, 1, 2000.00, 'Confirmed', '2025-09-18 22:58:53', '2025-09-18 22:58:53'),
(29, 4, 1, 1, 1000.00, 'Confirmed', '2025-09-19 01:38:39', '2025-09-19 01:38:39');

-- --------------------------------------------------------

--
-- Table structure for table `flightbookingdetails`
--

CREATE TABLE `flightbookingdetails` (
  `flight_booking_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `departure_airport` varchar(255) NOT NULL,
  `arrival_airport` varchar(255) NOT NULL,
  `departure_datetime` datetime NOT NULL,
  `seat_class` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flightbookingdetails`
--

INSERT INTO `flightbookingdetails` (`flight_booking_id`, `booking_id`, `departure_airport`, `arrival_airport`, `departure_datetime`, `seat_class`) VALUES
(1, 1, 'جده', 'Abdulaziz Airport', '2025-10-15 22:30:00', 'Economy'),
(2, 8, 'المكلا', 'مأرب', '2025-09-27 07:24:00', 'الدرجة السياحية'),
(3, 21, 'الرياض', 'جدة', '2025-09-30 12:21:00', 'الدرجة السياحية'),
(4, 22, 'الرياض', 'جدة', '2025-09-30 12:21:00', 'الدرجة السياحية'),
(5, 23, 'الرياض', 'جدة', '2025-09-30 12:21:00', 'الدرجة السياحية'),
(6, 25, 'الرياض', 'جدة', '2025-09-22 11:40:00', 'الدرجة السياحية');

-- --------------------------------------------------------

--
-- Table structure for table `hotelbookingdetails`
--

CREATE TABLE `hotelbookingdetails` (
  `hotel_booking_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `number_of_guests` int(11) NOT NULL,
  `number_of_rooms` int(11) NOT NULL,
  `room_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotelbookingdetails`
--

INSERT INTO `hotelbookingdetails` (`hotel_booking_id`, `booking_id`, `check_in_date`, `check_out_date`, `number_of_guests`, `number_of_rooms`, `room_type`) VALUES
(1, 10, '2025-09-22', '2025-09-25', 5, 2, 'Standard'),
(2, 11, '2025-09-22', '2025-09-30', 6, 2, 'Standard'),
(3, 12, '2025-09-22', '2025-09-30', 6, 2, 'Standard');

-- --------------------------------------------------------

--
-- Table structure for table `landtransportdetails`
--

CREATE TABLE `landtransportdetails` (
  `land_transport_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `dropoff_location` varchar(255) NOT NULL,
  `travel_datetime` datetime NOT NULL,
  `vehicle_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `landtransportdetails`
--

INSERT INTO `landtransportdetails` (`land_transport_id`, `booking_id`, `pickup_location`, `dropoff_location`, `travel_datetime`, `vehicle_type`) VALUES
(1, 2, 'مكة المكرمة', 'المدينة المنورة', '2025-10-20 14:30:00', 'سيارة سيدان'),
(2, 9, 'الرياض', 'جدة', '2025-09-22 11:00:00', 'حافلة VIP');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `user_account_id` int(11) NOT NULL,
  `provider_account_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(50) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `user_account_id`, `provider_account_id`, `amount`, `payment_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, 1500.00, 'Completed', '2025-09-15 20:19:14', '2025-09-15 20:19:14');

-- --------------------------------------------------------

--
-- Table structure for table `provideraccounts`
--

CREATE TABLE `provideraccounts` (
  `provider_account_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `account_holder_name` varchar(255) NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `provideraccounts`
--

INSERT INTO `provideraccounts` (`provider_account_id`, `provider_id`, `bank_id`, `account_number`, `account_holder_name`, `balance`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '101123456789012', 'شركة الخطوط الجوية السعودية المحدودة', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(2, 1, 2, '102987654321098', 'شركة الخطوط الجوية السعودية المحدودة', 1700.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(3, 1, 3, '103112233445566', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(4, 1, 4, '104556677889900', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(5, 1, 5, '105990011223344', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(6, 2, 1, '201234567890123', 'شركة طيران ناس المحدودة', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(7, 2, 2, '202876543210987', 'شركة طيران ناس المحدودة', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(8, 2, 3, '203223344556677', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(9, 2, 4, '204667788990011', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(10, 2, 5, '205001122334455', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(11, 3, 1, '301345678901234', 'شركة طيران أديل', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(12, 3, 2, '302765432109876', 'شركة طيران أديل', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(13, 3, 3, '303334455667788', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(14, 3, 4, '304778899001122', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(15, 3, 5, '305112233445566', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(16, 4, 1, '401456789012345', 'فندق دار التوحيد انتركونتيننتال', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(17, 4, 2, '402654321098765', 'فندق دار التوحيد انتركونتيننتال', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(18, 4, 3, '403445566778899', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(19, 4, 4, '404889900112233', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(20, 4, 5, '405223344556677', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(21, 5, 1, '501567890123456', 'فندق ساعة مكة فيرمونت', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(22, 5, 2, '502543210987654', 'فندق ساعة مكة فيرمونت', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(23, 5, 3, '503556677889900', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(24, 5, 4, '504990011223344', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(25, 5, 5, '505334455667788', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(26, 6, 1, '601678901234567', 'فندق فور سيزونز الرياض', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(27, 6, 2, '602432109876543', 'فندق فور سيزونز الرياض', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(28, 6, 3, '603667788990011', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(29, 6, 4, '604001122334455', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(30, 6, 5, '605445566778899', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(31, 7, 1, '701789012345678', 'شركة الهدى للحج والعمرة المحدودة', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(32, 7, 2, '702321098765432', 'شركة الهدى للحج والعمرة المحدودة', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(33, 7, 3, '703778899001122', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(34, 7, 4, '704112233445566', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(35, 7, 5, '705556677889900', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(36, 8, 1, '801890123456789', 'مكتب إيلاف للسياحة', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(37, 8, 2, '802210987654321', 'مكتب إيلاف للسياحة', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(38, 8, 3, '803889900112233', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(39, 8, 4, '804223344556677', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(40, 8, 5, '805667788990011', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(41, 9, 1, '901901234567890', 'مكتب حملات الفرقان للحج', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(42, 9, 2, '902109876543210', 'مكتب حملات الفرقان للحج', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(43, 9, 3, '903990011223344', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(44, 9, 4, '904334455667788', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(45, 9, 5, '905778899001122', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(46, 10, 1, '100101234567890', 'شركة الهدى للحج والعمرة المحدودة', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(47, 10, 2, '100209876543210', 'شركة الهدى للحج والعمرة المحدودة', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(48, 10, 3, '100300112233445', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(49, 10, 4, '100444556677889', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(50, 10, 5, '100588990011223', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(51, 11, 1, '110112345678901', 'الشركة السعودية للنقل الجماعي', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(52, 11, 2, '110298765432109', 'الشركة السعودية للنقل الجماعي', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(53, 11, 3, '110311223344556', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(54, 11, 4, '110455667788990', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(55, 11, 5, '110599001122334', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(56, 12, 1, '120123456789012', 'شركة دروب الوطن للنقل', 4600.00, '2025-09-15 19:23:00', '2025-09-19 01:38:39'),
(57, 12, 2, '120287654321098', 'شركة دروب الوطن للنقل', 200.00, '2025-09-15 19:23:00', '2025-09-18 20:17:06'),
(58, 12, 3, '120322334455667', 'شركة دروب الوطن للنقل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(59, 12, 4, '120466778899001', 'شركة دروب الوطن للنقل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(60, 12, 5, '120500112233445', 'شركة دروب الوطن للنقل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00');

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `provider_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `provider_name` varchar(255) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `provider_phone` varchar(20) DEFAULT NULL,
  `rating` decimal(2,1) NOT NULL DEFAULT 0.0,
  `location` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `provider_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`provider_id`, `service_id`, `provider_name`, `city`, `provider_phone`, `rating`, `location`, `is_active`, `created_at`, `updated_at`, `provider_image`) VALUES
(1, 1, 'الخطوط السعودية', NULL, '920022222', 0.0, 'جدة، حي الخالدية', 1, '2025-09-15 19:11:15', '2025-09-18 02:52:48', 'saudia.jpeg'),
(2, 1, 'طيران ناس', NULL, '920001234', 0.0, 'الرياض، حي المروج', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'flynas.jpg'),
(3, 1, 'طيران أديل', NULL, '920000212', 0.0, 'جدة، مطار الملك عبدالعزيز', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'download.png'),
(4, 2, 'فندق دار التوحيد انتركونتيننتال', 'مكة المكرمة', '0125717777', 0.0, 'مكة، شارع إبراهيم الخليل', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'hotel.png'),
(5, 2, 'فندق ساعة مكة فيرمونت', 'مكة المكرمة', '0125717700', 0.0, 'مكة، وقف الملك عبدالعزيز', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'ticket-ten.png'),
(6, 2, 'فندق فور سيزونز الرياض', 'الرياض', '0112114444', 0.0, 'الرياض، برج المملكة', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'four-seasons-hotel-saudi-featured.png'),
(7, 3, 'شركة الهدى للحج والعمرة', NULL, '920005505', 0.0, 'جدة، شارع الأمير سلطان', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'al-hoda.png'),
(8, 3, 'مكتب إيلاف للسياحة', NULL, '8002449999', 0.0, 'الرياض، طريق الملك فهد', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'cropped.png'),
(9, 4, 'مكتب حملات الفرقان', NULL, '0551234567', 0.0, 'مكة، حي العزيزية', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'alfrqan.png'),
(10, 4, 'شركة الهدى للحج والعمرة', NULL, '920005505', 0.0, 'جدة، شارع الأمير سلطان', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'al-hoda.png'),
(11, 5, 'الشركة السعودية للنقل الجماعي (سابتكو)', NULL, '920026888', 0.0, 'الرياض، حي النزهة', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'saptco.png'),
(12, 5, 'شركة دروب الوطن للنقل', NULL, '920033386', 0.0, 'الرياض، حي السلي', 1, '2025-09-15 19:11:15', '2025-09-17 01:52:41', 'darb-alwatan.png');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_name`, `is_active`) VALUES
(1, 'حجز طيران', 1),
(2, 'حجز فنادق', 1),
(3, 'تأشيرة عمرة', 1),
(4, 'تأشيرة حج', 1),
(5, 'نقل بري', 1);

-- --------------------------------------------------------

--
-- Table structure for table `travelers`
--

CREATE TABLE `travelers` (
  `traveler_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `passport_number` varchar(255) DEFAULT NULL,
  `passport_image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `travelers`
--

INSERT INTO `travelers` (`traveler_id`, `booking_id`, `full_name`, `passport_number`, `passport_image_url`) VALUES
(1, 1, 'نجم الدين سخمان', 'M12345678', NULL),
(2, 1, 'خالد عبدالله', 'M87654321', NULL),
(3, 2, 'مسافر جديد ١', 'N123456', NULL),
(4, 2, 'مسافر جديد ٢', 'N654321', NULL),
(5, 3, 'الاسم عبده صالح ', '124539758', 'uploads/passports/3_68cb6d1cb3191_٢٠٢٥٠٩١٧_٠٢٣١٢٠.jpg'),
(6, 4, 'نجم عبده صالح ', '12543574215', 'uploads/passports/4_68cb6dbb65449_٢٠٢٥٠٩١٧_٠٢٣١٢٠.jpg'),
(7, 5, 'صالح صالح صالح ', '12342751', 'uploads/passports/5_68cb753320f93_٢٠٢٥٠٩١٧_٠٢٣١٢٠.jpg'),
(8, 5, 'محمد صالح صالح ', '1254367212', 'uploads/passports/5_68cb75332532e_٢٠٢٥٠٩١٧_٠٢٣١٢٠.jpg'),
(9, 6, 'كريم ماجد احمد ', '123456789', 'uploads/passports/6_68cb897812456_IMG-20250917-WA0003.jpg'),
(10, 7, 'عبد الله محسن احمد ', '1234562138', 'uploads/passports/7_68cb91782513e_IMG-20250917-WA0003.jpg'),
(11, 8, 'نجم', '12345685', 'uploads/passports/68cb979160aa9-IMG-20250917-WA0006.jpg'),
(12, 9, 'عبد الله ', '15278688', 'uploads/passports/68cb97d702ba8-IMG-20250917-WA0003.jpg'),
(13, 10, 'محسن ', '12457635', 'uploads/passports/68cb9945f2231-IMG-20250917-WA0005.jpg'),
(14, 11, 'مصلح', '123456', 'uploads/passports/68cb9e4970c71-IMG-20250917-WA0005.jpg'),
(15, 12, 'مصلح', '123456', 'uploads/passports/68cb9eb28a2a1-IMG-20250917-WA0005.jpg'),
(18, 15, 'نجم عبده ', '124535412', 'uploads/passports/68cc1d924652f-IMG-20250917-WA0019.jpg'),
(19, 16, 'عبده ', '123456', 'uploads/passports/68cc28e2cecf2-IMG-20250917-WA0019.jpg'),
(20, 20, 'محمد ', '12354216', 'uploads/passports/68cc776c349ef-IMG-20250918-WA0055.jpg'),
(21, 21, 'محمد', '124513254', 'uploads/passports/68cc780025743-IMG-20250918-WA0055.jpg'),
(22, 22, 'محمد', '124513254', 'uploads/passports/68cc7815845b3-IMG-20250918-WA0055.jpg'),
(23, 23, 'محمد', '124513254', 'uploads/passports/68cc794f300e7-IMG-20250918-WA0055.jpg'),
(24, 25, 'عبده سعيد', '1235462458', 'uploads/passports/68cc7c6c482bf-IMG-20250918-WA0055.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `useraccounts`
--

CREATE TABLE `useraccounts` (
  `user_account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `account_password` varchar(255) NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `useraccounts`
--

INSERT INTO `useraccounts` (`user_account_id`, `user_id`, `bank_id`, `account_number`, `account_password`, `balance`, `created_at`, `updated_at`) VALUES
(1, 1, 2, '12345678910', 'najmpass123', 13300.00, '2025-09-15 19:27:57', '2025-09-18 20:17:06'),
(2, 1, 1, '1234567', 'najmpass123', 24900.00, '2025-09-15 19:27:57', '2025-09-18 20:19:33'),
(3, 2, 2, '123456789', 'najm3pass', 50000.00, '2025-09-15 19:27:57', '2025-09-15 19:50:59'),
(4, 2, 1, '12345678910', 'najm3pass', 95500.00, '2025-09-15 19:27:57', '2025-09-19 01:38:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone_number`, `created_at`, `updated_at`) VALUES
(1, 'نجم سخمان', 'najm123@gmail.com', 'password123', '772958016', '2025-09-15 19:25:26', '2025-09-15 19:40:04'),
(2, 'نجم الدين الوتاري', 'najm911@gmail.com', '$2b$10$OYjoPQ6xBkFaJDFuSRAAS.OlJq8xDgQpmhmOuYt3uuEiJgnrL3X5W', '777095536', '2025-09-15 19:25:26', '2025-09-16 01:29:54'),
(3, ' ماجد نجم الدين', 'najm1234@gmail.com', '$2y$10$emIwfbX60mewcW67RY7Sdu42ozcaV.ewTyS3DY7CHUKCfe1diIpVu', '772948016', '2025-09-15 22:54:02', '2025-09-15 22:54:02'),
(4, 'ابومشعل نجم سخمان', 'a@gmail.com', '$2y$10$7zeA4Tuo7J4Z6cLiSMwRpemQpUWW1JalCcH7NkhiTVAnqqy5lmbVq', '783503803', '2025-09-16 02:51:48', '2025-09-16 17:26:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`bank_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `provider_id` (`provider_id`);

--
-- Indexes for table `flightbookingdetails`
--
ALTER TABLE `flightbookingdetails`
  ADD PRIMARY KEY (`flight_booking_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `hotelbookingdetails`
--
ALTER TABLE `hotelbookingdetails`
  ADD PRIMARY KEY (`hotel_booking_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `landtransportdetails`
--
ALTER TABLE `landtransportdetails`
  ADD PRIMARY KEY (`land_transport_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `user_account_id` (`user_account_id`),
  ADD KEY `provider_account_id` (`provider_account_id`);

--
-- Indexes for table `provideraccounts`
--
ALTER TABLE `provideraccounts`
  ADD PRIMARY KEY (`provider_account_id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`provider_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `travelers`
--
ALTER TABLE `travelers`
  ADD PRIMARY KEY (`traveler_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `useraccounts`
--
ALTER TABLE `useraccounts`
  ADD PRIMARY KEY (`user_account_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `bank_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `flightbookingdetails`
--
ALTER TABLE `flightbookingdetails`
  MODIFY `flight_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `hotelbookingdetails`
--
ALTER TABLE `hotelbookingdetails`
  MODIFY `hotel_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `landtransportdetails`
--
ALTER TABLE `landtransportdetails`
  MODIFY `land_transport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `provideraccounts`
--
ALTER TABLE `provideraccounts`
  MODIFY `provider_account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `travelers`
--
ALTER TABLE `travelers`
  MODIFY `traveler_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
  MODIFY `user_account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`provider_id`);

--
-- Constraints for table `flightbookingdetails`
--
ALTER TABLE `flightbookingdetails`
  ADD CONSTRAINT `flightbookingdetails_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Constraints for table `hotelbookingdetails`
--
ALTER TABLE `hotelbookingdetails`
  ADD CONSTRAINT `hotelbookingdetails_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Constraints for table `landtransportdetails`
--
ALTER TABLE `landtransportdetails`
  ADD CONSTRAINT `landtransportdetails_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`user_account_id`) REFERENCES `useraccounts` (`user_account_id`),
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`provider_account_id`) REFERENCES `provideraccounts` (`provider_account_id`);

--
-- Constraints for table `provideraccounts`
--
ALTER TABLE `provideraccounts`
  ADD CONSTRAINT `provideraccounts_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`provider_id`),
  ADD CONSTRAINT `provideraccounts_ibfk_2` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`bank_id`);

--
-- Constraints for table `providers`
--
ALTER TABLE `providers`
  ADD CONSTRAINT `providers_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`);

--
-- Constraints for table `travelers`
--
ALTER TABLE `travelers`
  ADD CONSTRAINT `travelers_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

--
-- Constraints for table `useraccounts`
--
ALTER TABLE `useraccounts`
  ADD CONSTRAINT `useraccounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `useraccounts_ibfk_2` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`bank_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
