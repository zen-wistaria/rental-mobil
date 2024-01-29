/*
 Navicat Premium Data Transfer

 Source Server         : docker-app
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : 192.168.192.252:3306
 Source Schema         : rental-mobil

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 29/01/2024 23:24:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Booking
-- ----------------------------
DROP TABLE IF EXISTS `Booking`;
CREATE TABLE `Booking`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_mobil` int NOT NULL,
  `tgl_booking` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `kode_booking` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_mulai_sewa` date NOT NULL,
  `tgl_selesai_sewa` date NOT NULL,
  `status` enum('pending','dikonfirmasi','selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_booking`(`kode_booking`) USING BTREE,
  INDEX `bk_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `bk_id_user`(`id_user`) USING BTREE,
  CONSTRAINT `bk_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bk_id_user` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for Kode
-- ----------------------------
DROP TABLE IF EXISTS `Kode`;
CREATE TABLE `Kode`  (
  `id` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_indeks_nama`(`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for Kode_history
-- ----------------------------
DROP TABLE IF EXISTS `Kode_history`;
CREATE TABLE `Kode_history`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_kode` int NULL DEFAULT NULL,
  `kode_sebelumnya` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tgl_perubahan` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_kh_id_kode`(`id_kode`) USING BTREE,
  CONSTRAINT `hs_id_kode` FOREIGN KEY (`id_kode`) REFERENCES `Kode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for Mobil
-- ----------------------------
DROP TABLE IF EXISTS `Mobil`;
CREATE TABLE `Mobil`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `merk` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tahun_produksi` int NOT NULL,
  `warna` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `plat_nomor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nomor_stnk` decimal(20, 0) NOT NULL,
  `harga` decimal(10, 0) NOT NULL,
  `status` enum('tersedia','disewa') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'tersedia',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 96 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for Transaksi
-- ----------------------------
DROP TABLE IF EXISTS `Transaksi`;
CREATE TABLE `Transaksi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `id_mobil` int NOT NULL,
  `tgl_peminjaman` datetime NOT NULL,
  `tgl_pengembalian` datetime NULL DEFAULT NULL,
  `total_biaya` decimal(10, 2) NULL DEFAULT NULL,
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('selesai','belum di bayar') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'belum di bayar',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_transaksi`(`kode_transaksi`) USING BTREE,
  INDEX `tr_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `tr_id_user`(`id_user`) USING BTREE,
  CONSTRAINT `tr_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tr_id_user` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nik` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nomor_telepon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `roles` enum('client','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'client',
  `foto_profil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Triggers structure for table Booking
-- ----------------------------
DROP TRIGGER IF EXISTS `kodebooking_gen`;
delimiter ;;
CREATE TRIGGER `kodebooking_gen` BEFORE INSERT ON `Booking` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM Booking);
  SET NEW.kode_booking = CONCAT((SELECT kode FROM Kode WHERE nama = 'Booking'), LPAD(last_id + 1, 6, '0'));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Kode
-- ----------------------------
DROP TRIGGER IF EXISTS `perubahan_kode`;
delimiter ;;
CREATE TRIGGER `perubahan_kode` AFTER UPDATE ON `Kode` FOR EACH ROW BEGIN
	IF NEW.kode != OLD.kode THEN
		INSERT INTO Kode_history (id_kode, kode_sebelumnya, tgl_perubahan)
		VALUES (OLD.id, OLD.kode, NOW());
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Transaksi
-- ----------------------------
DROP TRIGGER IF EXISTS `kode_transaksi_gen`;
delimiter ;;
CREATE TRIGGER `kode_transaksi_gen` BEFORE INSERT ON `Transaksi` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM Transaksi);
  SET NEW.kode_transaksi = CONCAT((SELECT kode FROM Kode WHERE nama = 'Transaksi'), LPAD(last_id + 1, 6, '0'));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Users
-- ----------------------------
DROP TRIGGER IF EXISTS `username`;
delimiter ;;
CREATE TRIGGER `username` BEFORE INSERT ON `Users` FOR EACH ROW BEGIN
  DECLARE last_id INT;
  SET last_id = (SELECT IFNULL(MAX(id), 0) FROM Users);
  SET NEW.username = LPAD(last_id + 1, 6, '0');
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
