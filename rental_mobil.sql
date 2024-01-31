-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for rental_mobil
CREATE DATABASE IF NOT EXISTS `rental_mobil` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `rental_mobil`;

-- Dumping structure for table rental_mobil.booking
CREATE TABLE IF NOT EXISTS `booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_mobil` int(11) NOT NULL,
  `tgl_booking` timestamp NOT NULL DEFAULT current_timestamp(),
  `kode_booking` varchar(200) NOT NULL,
  `tgl_mulai_sewa` date NOT NULL,
  `tgl_selesai_sewa` date NOT NULL,
  `status` enum('pending','dikonfirmasi','selesai') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `kode_booking` (`kode_booking`) USING BTREE,
  KEY `bk_id_mobil` (`id_mobil`) USING BTREE,
  KEY `bk_id_user` (`id_user`) USING BTREE,
  CONSTRAINT `bk_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `mobil` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `bk_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.booking: ~17 rows (approximately)
INSERT INTO `booking` (`id`, `id_user`, `id_mobil`, `tgl_booking`, `kode_booking`, `tgl_mulai_sewa`, `tgl_selesai_sewa`, `status`) VALUES
	(34, 61, 42, '2024-01-27 11:59:38', 'BK000001', '2024-01-01', '2024-01-08', 'dikonfirmasi'),
	(35, 61, 57, '2024-01-27 11:59:49', 'BK000035', '2024-01-02', '2024-01-16', 'selesai'),
	(36, 61, 39, '2024-01-27 12:00:04', 'BK000036', '2024-01-01', '2024-01-31', 'selesai'),
	(37, 61, 45, '2024-01-27 12:00:12', 'BK000037', '2024-01-02', '2024-01-16', 'selesai'),
	(38, 58, 54, '2024-01-27 12:07:27', 'BK000038', '2024-01-01', '2024-01-31', 'pending'),
	(39, 58, 46, '2024-01-27 12:07:36', 'BK000039', '2024-01-01', '2024-01-17', 'selesai'),
	(40, 58, 69, '2024-01-27 12:07:56', 'BK000040', '2024-01-16', '2024-02-10', 'selesai'),
	(41, 58, 63, '2024-01-27 12:08:24', 'BK000041', '2024-02-08', '2024-02-20', 'selesai'),
	(43, 61, 43, '2024-01-28 07:27:27', 'BK000042', '2024-01-18', '2024-01-26', 'dikonfirmasi'),
	(45, 61, 39, '2024-01-28 09:05:02', 'BKNG000044', '2024-01-09', '2024-01-17', 'selesai'),
	(46, 61, 41, '2024-01-28 09:05:07', 'BKNG000046', '2024-01-10', '2024-01-30', 'pending'),
	(47, 61, 48, '2024-01-28 09:05:14', 'BKNG000047', '2024-01-02', '2024-01-24', 'selesai'),
	(48, 61, 66, '2024-01-28 09:05:24', 'BKNG000048', '2024-01-09', '2024-01-24', 'pending'),
	(49, 61, 73, '2024-01-28 09:05:33', 'BKNG000049', '2024-01-02', '2024-01-17', 'pending'),
	(50, 61, 47, '2024-01-28 09:25:52', 'BKNG000050', '2024-01-02', '2024-01-23', 'selesai'),
	(51, 61, 56, '2024-01-28 09:26:02', 'BKNG000051', '2024-01-01', '2024-01-17', 'pending'),
	(52, 61, 60, '2024-01-28 09:26:11', 'BKNG000052', '2024-01-08', '2024-01-17', 'selesai');

-- Dumping structure for table rental_mobil.kode
CREATE TABLE IF NOT EXISTS `kode` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `kode` varchar(5) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `kode_indeks_nama` (`nama`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.kode: ~2 rows (approximately)
INSERT INTO `kode` (`id`, `nama`, `kode`, `deskripsi`) VALUES
	(1, 'Transaksi', 'TSKI', 'Kode untuk transaksi'),
	(2, 'Booking', 'BKG', 'Kode untuk Booking');

-- Dumping structure for table rental_mobil.kode_history
CREATE TABLE IF NOT EXISTS `kode_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_kode` int(11) DEFAULT NULL,
  `kode_sebelumnya` varchar(4) DEFAULT NULL,
  `tgl_perubahan` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_kh_id_kode` (`id_kode`) USING BTREE,
  CONSTRAINT `hs_id_kode` FOREIGN KEY (`id_kode`) REFERENCES `kode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.kode_history: ~4 rows (approximately)
INSERT INTO `kode_history` (`id`, `id_kode`, `kode_sebelumnya`, `tgl_perubahan`) VALUES
	(12, 1, 'TS', '2024-01-28 09:04:15'),
	(13, 2, 'BK', '2024-01-28 09:04:28'),
	(14, 1, 'TSK', '2024-01-28 09:24:38'),
	(15, 2, 'BKNG', '2024-01-28 16:08:48');

-- Dumping structure for table rental_mobil.mobil
CREATE TABLE IF NOT EXISTS `mobil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `merk` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `tahun_produksi` int(11) NOT NULL,
  `warna` varchar(20) NOT NULL,
  `plat_nomor` varchar(20) NOT NULL,
  `nomor_stnk` decimal(20,0) NOT NULL,
  `harga` decimal(10,0) NOT NULL,
  `status` enum('tersedia','disewa') DEFAULT 'tersedia',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.mobil: ~58 rows (approximately)
INSERT INTO `mobil` (`id`, `merk`, `model`, `tahun_produksi`, `warna`, `plat_nomor`, `nomor_stnk`, `harga`, `status`) VALUES
	(39, 'Hyundais', 'Stargazer', 2022, 'Silver', 'Z 2001 DC', 86655678563286450000, 200000, 'tersedia'),
	(40, 'Hyundai', 'Ioniq 5', 2022, 'Silver', 'Z D4D0 CY', 86655864543234570000, 1100000, 'tersedia'),
	(41, 'Hyundai', 'Palisade', 2022, 'Putih', 'D 2093 YY', 86655678563234560000, 300000, 'disewa'),
	(42, 'Hyundai', 'Santa FE', 2022, 'Hitam', 'D 1920 DA', 86655678971234570000, 800000, 'disewa'),
	(43, 'Hyundai', 'H1', 2022, 'Silver', 'C 4479 H', 86655678901234570000, 2200000, 'disewa'),
	(44, 'Toyota', 'Avanza', 2020, 'Silver', 'B 1234 CD', 12345678901234567890, 200000, 'tersedia'),
	(45, 'Honda', 'Jazz', 2019, 'White', 'D 5678 EF', 23456789012345678901, 180000, 'tersedia'),
	(46, 'Ford', 'Mustang', 2021, 'Red', 'G 9012 HI', 34567890123456789012, 300000, 'tersedia'),
	(47, 'Chevrolet', 'Camaro', 2022, 'Yellow', 'K 3456 LM', 45678901234567890123, 280000, 'tersedia'),
	(48, 'Nissan', 'X-Trail', 2022, 'Blue', 'Z 9012 GH', 98765432109876543210, 250000, 'tersedia'),
	(49, 'Mitsubishi', 'Outlander', 2020, 'Green', 'P 7890 QR', 56789012345678901234, 230000, 'tersedia'),
	(50, 'Volkswagen', 'Golf', 2021, 'Black', 'N 2345 ST', 67890123456789012345, 220000, 'tersedia'),
	(51, 'Hyundai', 'Tucson', 2019, 'Gray', 'R 6789 UV', 78901234567890123456, 210000, 'tersedia'),
	(52, 'Kia', 'Seltos', 2022, 'Orange', 'W 1234 XY', 89012345678901234567, 240000, 'tersedia'),
	(53, 'Subaru', 'Crosstrek', 2021, 'Purple', 'C 5678 AB', 90123456789012345678, 260000, 'tersedia'),
	(54, 'BMW', 'X5', 2020, 'Silver', 'Y 9012 CD', 34567890123456789012, 320000, 'disewa'),
	(55, 'Mercedes-Benz', 'C-Class', 2019, 'Blue', 'L 3456 EF', 45678901234567890123, 310000, 'tersedia'),
	(56, 'Audi', 'Q7', 2022, 'White', 'Z 7890 GH', 98765432109876543210, 350000, 'disewa'),
	(57, 'Lexus', 'RX', 2021, 'Red', 'M 2345 IJ', 56789012345678901234, 330000, 'tersedia'),
	(58, 'Tesla', 'Model 3', 2020, 'Black', 'O 6789 KL', 67890123456789012345, 380000, 'tersedia'),
	(59, 'Ford', 'Escape', 2019, 'Gray', 'T 1234 UV', 78901234567890123456, 270000, 'tersedia'),
	(60, 'Chevrolet', 'Equinox', 2022, 'Green', 'A 5678 WX', 89012345678901234567, 290000, 'tersedia'),
	(61, 'Toyota', 'Rav4', 2021, 'Silver', 'S 9012 YZ', 90123456789012345678, 260000, 'tersedia'),
	(62, 'Honda', 'CR-V', 2020, 'Blue', 'X 3456 AB', 34567890123456789012, 280000, 'tersedia'),
	(63, 'Nissan', 'Rogue', 2019, 'White', 'F 7890 CD', 45678901234567890123, 310000, 'tersedia'),
	(64, 'Mazda', 'CX-5', 2022, 'Silver', 'E 1234 FG', 56789012345678901234, 270000, 'tersedia'),
	(65, 'Jeep', 'Cherokee', 2021, 'Blue', 'G 5678 HI', 67890123456789012345, 290000, 'tersedia'),
	(66, 'Volkswagen', 'Tiguan', 2020, 'Black', 'J 9012 KL', 78901234567890123456, 310000, 'disewa'),
	(67, 'Subaru', 'Forester', 2019, 'Green', 'L 2345 MN', 89012345678901234567, 330000, 'tersedia'),
	(68, 'Hyundai', 'Creta', 2022, 'Hitam', 'Z 1290 ZK', 34568730123456790000, 250000, 'tersedia'),
	(69, 'Toyota', 'Camry', 2022, 'Black', 'B 5678 EF', 98765432101234567890, 400000, 'tersedia'),
	(70, 'Honda', 'Accord', 2022, 'White', 'D 1234 GH', 87654321012345678901, 380000, 'tersedia'),
	(71, 'Ford', 'Fusion', 2022, 'Gray', 'G 9012 IJ', 76543210912345678901, 370000, 'tersedia'),
	(72, 'Chevrolet', 'Malibu', 2022, 'Blue', 'K 3456 KL', 65432109812345678901, 360000, 'tersedia'),
	(73, 'Nissan', 'Altima', 2022, 'Red', 'Z 9012 MN', 54321098712345678901, 350000, 'disewa'),
	(74, 'Mitsubishi', 'Lancer', 2022, 'Silver', 'P 7890 QR', 43210987612345678901, 340000, 'tersedia'),
	(75, 'Volkswagen', 'Passat', 2022, 'Green', 'N 2345 ST', 32109876512345678901, 330000, 'tersedia'),
	(76, 'Hyundai', 'Elantra', 2022, 'Orange', 'W 1234 XY', 21098765412345678901, 320000, 'tersedia'),
	(77, 'Kia', 'Optima', 2022, 'Purple', 'C 5678 AB', 10987654312345678901, 310000, 'tersedia'),
	(78, 'Subaru', 'Impreza', 2022, 'Yellow', 'C 5678 CD', 12345678901234567890, 300000, 'tersedia'),
	(79, 'BMW', '3 Series', 2022, 'Black', 'Y 9012 EF', 23456789012345678901, 290000, 'tersedia'),
	(80, 'Toyota', 'Corolla', 2022, 'White', 'X 3456 GH', 34567890123456789012, 280000, 'tersedia'),
	(81, 'Honda', 'Civic', 2022, 'Blue', 'F 7890 IJ', 45678901234567890123, 310000, 'tersedia'),
	(82, 'Ford', 'Focus', 2022, 'Red', 'T 1234 KL', 56789012345678901234, 270000, 'tersedia'),
	(83, 'Chevrolet', 'Spark', 2022, 'Green', 'A 5678 MN', 67890123456789012345, 290000, 'tersedia'),
	(84, 'Nissan', 'Versa', 2022, 'Black', 'S 9012 OP', 78901234567890123456, 310000, 'tersedia'),
	(85, 'Mitsubishi', 'Mirage', 2022, 'Silver', 'L 2345 QR', 89012345678901234567, 330000, 'tersedia'),
	(86, 'Volkswagen', 'Polo', 2022, 'Gray', 'N 6789 ST', 90123456789012345678, 350000, 'tersedia'),
	(87, 'Hyundai', 'Accent', 2022, 'Orange', 'W 1234 UV', 12345678901234567890, 330000, 'tersedia'),
	(88, 'Kia', 'Rio', 2022, 'Purple', 'C 5678 AB', 23456789012345678901, 320000, 'tersedia'),
	(89, 'Subaru', 'Legacy', 2022, 'Yellow', 'C 5678 CD', 34567890123456789012, 310000, 'tersedia'),
	(90, 'Mercedes-Benz', 'E 200 Avantgarde Line', 2024, 'Hitam', 'Z 1299 ZK', 34567890123456790000, 1000000, 'tersedia'),
	(91, 'Mercedes-Benz', 'C-Class', 2022, 'Silver', 'L 7890 EF', 90123456789012345678, 350000, 'tersedia'),
	(92, 'Mercedes-Benz', 'E-Class', 2022, 'Black', 'M 9012 GH', 34567890123456789012, 380000, 'tersedia'),
	(93, 'Mercedes-Benz', 'S-Class', 2022, 'White', 'N 5678 IJ', 45678901234567890123, 400000, 'tersedia'),
	(94, 'Mercedes-Benz', 'GLC', 2022, 'Blue', 'O 1234 KL', 56789012345678901234, 420000, 'tersedia'),
	(95, 'Mercedes-Benz', 'GLE', 2022, 'Red', 'P 9012 MN', 67890123456789012345, 450000, 'tersedia'),
	(96, 'Toyota', 'Century', 2023, 'Silver', 'Z 1234 ZY', 34567890123456790000, 180000, 'tersedia');

-- Dumping structure for table rental_mobil.transaksi
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_mobil` int(11) NOT NULL,
  `tgl_peminjaman` datetime NOT NULL,
  `tgl_pengembalian` datetime DEFAULT NULL,
  `total_biaya` decimal(10,2) DEFAULT NULL,
  `kode_transaksi` varchar(50) NOT NULL,
  `status` enum('selesai','belum di bayar') DEFAULT 'belum di bayar',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `kode_transaksi` (`kode_transaksi`) USING BTREE,
  KEY `tr_id_mobil` (`id_mobil`) USING BTREE,
  KEY `tr_id_user` (`id_user`) USING BTREE,
  CONSTRAINT `tr_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `mobil` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `tr_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.transaksi: ~10 rows (approximately)
INSERT INTO `transaksi` (`id`, `id_user`, `id_mobil`, `tgl_peminjaman`, `tgl_pengembalian`, `total_biaya`, `kode_transaksi`, `status`) VALUES
	(8, 61, 45, '2024-01-02 00:00:00', '2024-01-16 00:00:00', 2520000.00, 'TS000001', 'selesai'),
	(9, 61, 57, '2024-01-02 00:00:00', '2024-01-16 00:00:00', 4620000.00, 'TS000009', 'selesai'),
	(10, 61, 39, '2024-01-01 00:00:00', '2024-01-31 00:00:00', 6000000.00, 'TS000010', 'belum di bayar'),
	(11, 58, 46, '2024-01-01 00:00:00', '2024-01-17 00:00:00', 4800000.00, 'TS000011', 'belum di bayar'),
	(12, 58, 69, '2024-01-16 00:00:00', '2024-02-10 00:00:00', 10000000.00, 'TS000012', 'selesai'),
	(16, 61, 39, '2024-01-09 00:00:00', '2024-01-17 00:00:00', 1600000.00, 'TSK000014', 'selesai'),
	(17, 61, 48, '2024-01-02 00:00:00', '2024-01-24 00:00:00', 5500000.00, 'TSK000017', 'selesai'),
	(18, 58, 63, '2024-02-08 00:00:00', '2024-02-20 00:00:00', 3720000.00, 'TSKI000018', 'belum di bayar'),
	(19, 61, 60, '2024-01-08 00:00:00', '2024-01-17 00:00:00', 2610000.00, 'TSKI000019', 'selesai'),
	(20, 61, 47, '2024-01-02 00:00:00', '2024-01-23 00:00:00', 5880000.00, 'TSKI000020', 'belum di bayar');

-- Dumping structure for table rental_mobil.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `nama` varchar(150) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `nomor_telepon` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roles` enum('client','admin') NOT NULL DEFAULT 'client',
  `foto_profil` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table rental_mobil.users: ~4 rows (approximately)
INSERT INTO `users` (`id`, `username`, `nama`, `nik`, `tgl_lahir`, `alamat`, `email`, `nomor_telepon`, `password`, `roles`, `foto_profil`) VALUES
	(58, '000058', 'Anri Client', '3278101608990001', '2024-01-27', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', 'anriclient@gmail.com', '082121212154', '$2b$10$Unot.jre8xM2liXu7hHXkOXv0zWjh.E.I/Rr85l/nqyGZQnWrzzzK', 'client', NULL),
	(59, '000059', 'Anri Admin', '3278101608990002', '2024-01-26', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', 'anriadmin@gmail.com', '082121212154', '$2b$10$.XLXe.68w3ZSYA9JcFEmueKbb..G/9xa.rgokzcI1aCT3ZK9w73/.', 'admin', NULL),
	(60, '000060', 'Admin', '3278101608990003', '2024-01-09', 'Kp.Admin 002/007 Kel.Admin, Kec.Admin, Kota Admin', 'admin@gmail.com', '082121212154', '$2b$10$EZU6zVeRmX.hY36sP9juQufJ8SsTLJ9qAIgO.o9eNDCodA8CbSqIa', 'admin', NULL),
	(61, '000061', 'Client', '3278101608990010', '2024-01-03', 'Kp.Client 002/007 Kel.Client, Kec.Client, Kota Client', 'client@gmail.com', '082121212154', '$2b$10$RhwTtnb6N3ntsjyY8GqaAeNnjdccC0kyTS4QpKxKclhy6XU9DLD6W', 'client', NULL);

-- Dumping structure for trigger rental_mobil.kodebooking_gen
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `kodebooking_gen` BEFORE INSERT ON `booking` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM booking);
  SET NEW.kode_booking = CONCAT((SELECT kode FROM kode WHERE nama = 'booking'), LPAD(last_id + 1, 6, '0'));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger rental_mobil.kode_transaksi_gen
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `kode_transaksi_gen` BEFORE INSERT ON `transaksi` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM transaksi);
  SET NEW.kode_transaksi = CONCAT((SELECT kode FROM kode WHERE nama = 'transaksi'), LPAD(last_id + 1, 6, '0'));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger rental_mobil.perubahan_kode
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `perubahan_kode` AFTER UPDATE ON `kode` FOR EACH ROW BEGIN
	IF NEW.kode != OLD.kode THEN
		INSERT INTO kode_history (id_kode, kode_sebelumnya, tgl_perubahan)
		VALUES (OLD.id, OLD.kode, NOW());
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger rental_mobil.username
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `username` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM users);
  SET NEW.username = LPAD(last_id + 1, 6, '0');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
