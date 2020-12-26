-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Dec 26, 2020 at 06:45 PM
-- Server version: 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP Version: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sam_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `kapal`
--

CREATE TABLE `kapal` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `callsign` varchar(255) NOT NULL,
  `gt` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `pemilik` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kapal`
--

INSERT INTO `kapal` (`id`, `nama`, `callsign`, `gt`, `tahun`, `pemilik`) VALUES
(1, 'KMP. Lakaan', 'LGRM', 1698, 2016, 'Ro-ro'),
(2, 'KMP. Ranaka', 'JZCN', 1029, 2012, 'Ro-ro'),
(3, 'KMP. IleMandiri', 'KLJX', 533, 1995, 'Ro-ro'),
(4, 'KMP. Ilelabalekan', 'SDPF', 895, 2014, 'Ro-ro');

-- --------------------------------------------------------

--
-- Table structure for table `kapal_bobot`
--

CREATE TABLE `kapal_bobot` (
  `id_kapal` int(11) NOT NULL,
  `id_sub` int(11) NOT NULL,
  `bobot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kapal_bobot`
--

INSERT INTO `kapal_bobot` (`id_kapal`, `id_sub`, `bobot`) VALUES
(1, 1, 2),
(1, 2, 4),
(1, 7, 5),
(1, 8, 4),
(1, 9, 5),
(1, 10, 2),
(1, 11, 4),
(1, 12, 5),
(1, 13, 1),
(1, 14, 1),
(1, 15, 4),
(2, 1, 2),
(2, 2, 4),
(2, 7, 1),
(2, 8, 5),
(2, 9, 2),
(2, 10, 3),
(2, 11, 3),
(2, 12, 4),
(2, 13, 3),
(2, 14, 4),
(2, 15, 1),
(3, 1, 1),
(3, 2, 2),
(3, 7, 1),
(3, 8, 3),
(3, 9, 3),
(3, 10, 2),
(3, 11, 2),
(3, 12, 1),
(3, 13, 1),
(3, 14, 1),
(3, 15, 2),
(4, 1, 4),
(4, 2, 5),
(4, 7, 4),
(4, 8, 3),
(4, 9, 3),
(4, 10, 1),
(4, 11, 5),
(4, 12, 2),
(4, 13, 2),
(4, 14, 2),
(4, 15, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kriteria`
--

CREATE TABLE `kriteria` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `bobot` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kriteria`
--

INSERT INTO `kriteria` (`id`, `nama`, `bobot`) VALUES
(3, 'Pelayanan Penumpang', 40),
(4, 'Administrasi', 35),
(5, 'Navigasi dan Pengawasan', 25);

-- --------------------------------------------------------

--
-- Table structure for table `subkriteria`
--

CREATE TABLE `subkriteria` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `bobot` int(11) NOT NULL,
  `core` tinyint(1) NOT NULL,
  `id_kriteria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subkriteria`
--

INSERT INTO `subkriteria` (`id`, `nama`, `bobot`, `core`, `id_kriteria`) VALUES
(1, 'Keselamatan Penumpang', 5, 1, 3),
(2, 'Keamanan dan Kenyamanan penumpang', 4, 1, 3),
(7, 'Kemudahan dan Keterjangakauan', 4, 0, 3),
(8, 'Pelayanan Kesataraan', 3, 0, 3),
(9, 'Status Hukum', 5, 1, 4),
(10, 'Sertifikat Kapal', 4, 1, 4),
(11, 'Manifest Muatan', 3, 0, 4),
(12, 'Garis Muat', 3, 0, 4),
(13, 'Sarana Bantu Navigasi', 4, 1, 5),
(14, 'Hidrografi dan Metereologi', 3, 1, 5),
(15, 'Pengawakan', 3, 0, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kapal`
--
ALTER TABLE `kapal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kapal_bobot`
--
ALTER TABLE `kapal_bobot`
  ADD KEY `kapal_nilai_kapal` (`id_kapal`),
  ADD KEY `kapal_nilai_subkriteria` (`id_sub`);

--
-- Indexes for table `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subkriteria_kriteria` (`id_kriteria`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kapal`
--
ALTER TABLE `kapal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subkriteria`
--
ALTER TABLE `subkriteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kapal_bobot`
--
ALTER TABLE `kapal_bobot`
  ADD CONSTRAINT `kapal_nilai_kapal` FOREIGN KEY (`id_kapal`) REFERENCES `kapal` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kapal_nilai_subkriteria` FOREIGN KEY (`id_sub`) REFERENCES `subkriteria` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subkriteria`
--
ALTER TABLE `subkriteria`
  ADD CONSTRAINT `subkriteria_kriteria` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
