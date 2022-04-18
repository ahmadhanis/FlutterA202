-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2021 at 04:38 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `myshopdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `prid` int(11) NOT NULL,
  `prname` varchar(30) NOT NULL,
  `prtype` varchar(30) NOT NULL,
  `prprice` double NOT NULL,
  `prqty` int(11) NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp(),
  `picture` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`prid`, `prname`, `prtype`, `prprice`, `prqty`, `datecreated`, `picture`) VALUES
(28, 'Acoustic Guitar', 'Instrument', 312.9, 1, '2021-05-19 20:58:10', '60a51972dd733.png'),
(29, 'Mechanical Keyboard', 'Computer Acc', 412.2, 5, '2021-05-19 20:59:52', '60a519d81f552.png'),
(30, 'Gaming Chair', 'Furniture', 523.3, 3, '2021-05-19 21:04:50', '60a51b0215725.png'),
(31, 'Farm Dining Table', 'Furniture', 172, 21, '2021-05-19 21:05:29', '60a51b29713e8.png'),
(32, 'Rounded Table', 'Furniture', 242.3, 3, '2021-05-19 21:06:11', '60a51b53a3992.png'),
(33, 'Mrvls Table', 'Furniture', 321, 3, '2021-05-19 21:06:52', '60a51b7c2e87b.png'),
(34, 'Crystal Dining Table', 'Furniture', 1234.3, 2, '2021-05-19 21:08:42', '60a51bea3f7b5.png'),
(35, 'Television', 'Electronic', 32.3, 1, '2021-05-19 21:32:00', '60a52160bd41a.png'),
(36, 'Comfy Couch', 'Furniture', 200, 1, '2021-05-19 21:33:11', '60a521a70d7be.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`prid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `prid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
