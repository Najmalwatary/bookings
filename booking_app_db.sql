-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Sep 15, 2025 at 10:33 PM
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
(1, 1, 1, 1, 1500.00, 'Confirmed', '2025-09-15 19:54:03', '2025-09-15 20:19:41');

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
(1, 1, 'جده', 'Abdulaziz Airport', '2025-10-15 22:30:00', 'Economy');

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
(1, 1, 1, '101123456789012', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(2, 1, 2, '102987654321098', 'شركة الخطوط الجوية السعودية المحدودة', 1500.00, '2025-09-15 19:23:00', '2025-09-15 20:20:13'),
(3, 1, 3, '103112233445566', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(4, 1, 4, '104556677889900', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(5, 1, 5, '105990011223344', 'شركة الخطوط الجوية السعودية المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(6, 2, 1, '201234567890123', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(7, 2, 2, '202876543210987', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(8, 2, 3, '203223344556677', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(9, 2, 4, '204667788990011', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(10, 2, 5, '205001122334455', 'شركة طيران ناس المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(11, 3, 1, '301345678901234', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(12, 3, 2, '302765432109876', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(13, 3, 3, '303334455667788', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(14, 3, 4, '304778899001122', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(15, 3, 5, '305112233445566', 'شركة طيران أديل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(16, 4, 1, '401456789012345', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(17, 4, 2, '402654321098765', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(18, 4, 3, '403445566778899', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(19, 4, 4, '404889900112233', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(20, 4, 5, '405223344556677', 'فندق دار التوحيد انتركونتيننتال', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(21, 5, 1, '501567890123456', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(22, 5, 2, '502543210987654', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(23, 5, 3, '503556677889900', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(24, 5, 4, '504990011223344', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(25, 5, 5, '505334455667788', 'فندق ساعة مكة فيرمونت', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(26, 6, 1, '601678901234567', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(27, 6, 2, '602432109876543', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(28, 6, 3, '603667788990011', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(29, 6, 4, '604001122334455', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(30, 6, 5, '605445566778899', 'فندق فور سيزونز الرياض', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(31, 7, 1, '701789012345678', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(32, 7, 2, '702321098765432', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(33, 7, 3, '703778899001122', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(34, 7, 4, '704112233445566', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(35, 7, 5, '705556677889900', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(36, 8, 1, '801890123456789', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(37, 8, 2, '802210987654321', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(38, 8, 3, '803889900112233', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(39, 8, 4, '804223344556677', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(40, 8, 5, '805667788990011', 'مكتب إيلاف للسياحة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(41, 9, 1, '901901234567890', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(42, 9, 2, '902109876543210', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(43, 9, 3, '903990011223344', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(44, 9, 4, '904334455667788', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(45, 9, 5, '905778899001122', 'مكتب حملات الفرقان للحج', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(46, 10, 1, '100101234567890', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(47, 10, 2, '100209876543210', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(48, 10, 3, '100300112233445', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(49, 10, 4, '100444556677889', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(50, 10, 5, '100588990011223', 'شركة الهدى للحج والعمرة المحدودة', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(51, 11, 1, '110112345678901', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(52, 11, 2, '110298765432109', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(53, 11, 3, '110311223344556', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(54, 11, 4, '110455667788990', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(55, 11, 5, '110599001122334', 'الشركة السعودية للنقل الجماعي', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(56, 12, 1, '120123456789012', 'شركة دروب الوطن للنقل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
(57, 12, 2, '120287654321098', 'شركة دروب الوطن للنقل', 0.00, '2025-09-15 19:23:00', '2025-09-15 19:23:00'),
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
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`provider_id`, `service_id`, `provider_name`, `city`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'الخطوط السعودية', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(2, 1, 'طيران ناس', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(3, 1, 'طيران أديل', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(4, 2, 'فندق دار التوحيد انتركونتيننتال', 'مكة المكرمة', 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(5, 2, 'فندق ساعة مكة فيرمونت', 'مكة المكرمة', 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(6, 2, 'فندق فور سيزونز الرياض', 'الرياض', 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(7, 3, 'شركة الهدى للحج والعمرة', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(8, 3, 'مكتب إيلاف للسياحة', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(9, 4, 'مكتب حملات الفرقان', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(10, 4, 'شركة الهدى للحج والعمرة', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(11, 5, 'الشركة السعودية للنقل الجماعي (سابتكو)', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(12, 5, 'شركة دروب الوطن للنقل', NULL, 1, '2025-09-15 19:11:15', '2025-09-15 19:11:15'),
(13, 1, 'الخطوط السعودية', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(14, 1, 'طيران ناس', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(15, 1, 'طيران أديل', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(16, 2, 'فندق دار التوحيد انتركونتيننتال', 'مكة المكرمة', 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(17, 2, 'فندق ساعة مكة فيرمونت', 'مكة المكرمة', 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(18, 2, 'فندق فور سيزونز الرياض', 'الرياض', 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(19, 3, 'شركة الهدى للحج والعمرة', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(20, 3, 'مكتب إيلاف للسياحة', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(21, 4, 'مكتب حملات الفرقان', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(22, 4, 'شركة الهدى للحج والعمرة', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(23, 5, 'الشركة السعودية للنقل الجماعي (سابتكو)', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10'),
(24, 5, 'شركة دروب الوطن للنقل', NULL, 1, '2025-09-15 19:15:10', '2025-09-15 19:15:10');

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
(2, 1, 'خالد عبدالله', 'M87654321', NULL);

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
(1, 1, 2, '12345678910', 'najmpass123', 13500.00, '2025-09-15 19:27:57', '2025-09-15 20:19:57'),
(2, 1, 1, '1234567', 'najmpass123', 25000.00, '2025-09-15 19:27:57', '2025-09-15 19:50:35'),
(3, 2, 2, '123456789', 'najm3pass', 50000.00, '2025-09-15 19:27:57', '2025-09-15 19:50:59'),
(4, 2, 1, '123456', 'najm3pass', 10000.00, '2025-09-15 19:27:57', '2025-09-15 19:51:14');

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
(2, 'نجم الدين الوتاري', 'najm911@gmail.com', 'pass1234', '777095536', '2025-09-15 19:25:26', '2025-09-15 19:41:39');

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
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `flightbookingdetails`
--
ALTER TABLE `flightbookingdetails`
  MODIFY `flight_booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotelbookingdetails`
--
ALTER TABLE `hotelbookingdetails`
  MODIFY `hotel_booking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `landtransportdetails`
--
ALTER TABLE `landtransportdetails`
  MODIFY `land_transport_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `traveler_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `useraccounts`
--
ALTER TABLE `useraccounts`
  MODIFY `user_account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
