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

-- Data exporting was unselected.

-- Dumping structure for table rental_mobil.kode
CREATE TABLE IF NOT EXISTS `kode` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `kode` varchar(5) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `kode_indeks_nama` (`nama`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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

-- Data exporting was unselected.

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
