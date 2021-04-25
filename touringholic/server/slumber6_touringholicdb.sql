-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 25, 2021 at 10:25 AM
-- Server version: 10.3.28-MariaDB-cll-lve
-- PHP Version: 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_touringholicdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_grams`
--

CREATE TABLE `tbl_grams` (
  `gram_id` int(5) NOT NULL,
  `gram_desc` varchar(500) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `date_post` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_grams`
--

INSERT INTO `tbl_grams` (`gram_id`, `gram_desc`, `user_email`, `date_post`) VALUES
(1, 'Welcome to my new gram 1', 'slumberjer@gmail.com', '2021-04-25 09:09:21.516640'),
(2, 'Welcome to my new gram 2', 'slumberjer@gmail.com', '2021-04-25 09:11:52.149900'),
(3, 'Welcome to my new gram 3', 'slumberjer@gmail.com', '2021-04-25 09:12:54.823762'),
(4, 'Welcome to my new gram 4', 'slumberjer@gmail.com', '2021-04-25 09:14:44.678999'),
(5, 'Welcome to my new gram 5', 'slumberjer@gmail.com', '2021-04-25 09:15:38.040950'),
(6, 'This is my dog', 'slumberjer@gmail.com', '2021-04-25 10:23:38.786453');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `password` varchar(40) NOT NULL,
  `otp` varchar(5) NOT NULL,
  `date_reg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `rating` varchar(1) NOT NULL,
  `credit` varchar(6) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_name`, `user_email`, `password`, `otp`, `date_reg`, `rating`, `credit`, `status`) VALUES
('abc', '1@gmail.com', 'abb9ed21cc41612fbadaa07dd45a8a1a88fe8565', '3387', '2021-04-23 22:24:12.044849', '0', '0', 'active'),
('asdad', 'abc@gmail.com', '2e8cdf2c808cacec07bf3f172f66093a093a34e9', '7361', '2021-04-24 16:53:10.094873', '0', '0', 'active'),
('abce', 'limyopeng@gmail.com', '2e8cdf2c808cacec07bf3f172f66093a093a34e9', '1784', '2021-04-24 16:54:08.838107', '0', '0', 'active'),
('Ahmad Hanis', 'slumberjer@gmail.com', 'bec75d2e4e2acf4f4ab038144c0d862505e52d07', '0', '2021-04-19 22:19:00.515839', '0', '0', 'active'),
('test', 'zoolim123@gmail.com', '14459f84a76df0cc57ffd1bf6a17149bfd09f82b', '0', '2021-04-23 03:47:41.096874', '0', '0', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_grams`
--
ALTER TABLE `tbl_grams`
  ADD PRIMARY KEY (`gram_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_grams`
--
ALTER TABLE `tbl_grams`
  MODIFY `gram_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
