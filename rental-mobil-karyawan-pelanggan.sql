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

 Date: 24/01/2024 00:23:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Booking
-- ----------------------------
DROP TABLE IF EXISTS `Booking`;
CREATE TABLE `Booking`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int NOT NULL,
  `id_mobil` int NOT NULL,
  `id_karyawan` int NOT NULL,
  `tgl_booking` datetime NOT NULL,
  `kode_booking` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_mulai_sewa` datetime NULL DEFAULT NULL,
  `tgl_selesai_sewa` datetime NULL DEFAULT NULL,
  `status` enum('pending','selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_booking`(`kode_booking`) USING BTREE,
  INDEX `bk_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `bk_id_pelanggan`(`id_pelanggan`) USING BTREE,
  INDEX `bk_id_karwayan`(`id_karyawan`) USING BTREE,
  CONSTRAINT `bk_id_karwayan` FOREIGN KEY (`id_karyawan`) REFERENCES `Karwayan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bk_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bk_id_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `Pelanggan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Booking
-- ----------------------------

-- ----------------------------
-- Table structure for Karwayan
-- ----------------------------
DROP TABLE IF EXISTS `Karwayan`;
CREATE TABLE `Karwayan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `telepon` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `nik` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `roles` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Karwayan
-- ----------------------------

-- ----------------------------
-- Table structure for Mobil
-- ----------------------------
DROP TABLE IF EXISTS `Mobil`;
CREATE TABLE `Mobil`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `merk` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tahun_produksi` int NOT NULL,
  `warna` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `plat_nomor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_stnk` decimal(20, 0) NOT NULL,
  `harga` decimal(10, 0) NOT NULL,
  `status` enum('tersedia','disewa') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'tersedia',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Mobil
-- ----------------------------
INSERT INTO `Mobil` VALUES (6, 'Hyundai', 'Stargazer', 2022, 'Silver', 'Z 2001 DC', 86655678563286450000, 200000, 'tersedia');
INSERT INTO `Mobil` VALUES (8, 'Hyundai', 'Ioniq 5', 2022, 'Silver', 'Z D4D0 CY', 86655864543234570000, 1100000, 'tersedia');
INSERT INTO `Mobil` VALUES (9, 'Hyundai', 'Palisade', 2022, 'Putih', 'D 2093 YY', 86655678563234560000, 300000, 'tersedia');
INSERT INTO `Mobil` VALUES (10, 'Hyundai', 'Santa FE', 2022, 'Hitam', 'D 1920 DA', 86655678971234570000, 800000, 'tersedia');
INSERT INTO `Mobil` VALUES (11, 'Hyundai', 'H1', 2022, 'Silver', 'C 4479 H', 86655678901234570000, 2200000, 'tersedia');
INSERT INTO `Mobil` VALUES (13, 'Toyota', 'Avanza', 2020, 'Silver', 'B 1234 CD', 12345678901234567890, 200000, 'tersedia');
INSERT INTO `Mobil` VALUES (14, 'Honda', 'Jazz', 2019, 'White', 'D 5678 EF', 23456789012345678901, 180000, 'tersedia');
INSERT INTO `Mobil` VALUES (15, 'Ford', 'Mustang', 2021, 'Red', 'G 9012 HI', 34567890123456789012, 300000, 'tersedia');
INSERT INTO `Mobil` VALUES (16, 'Chevrolet', 'Camaro', 2022, 'Yellow', 'K 3456 LM', 45678901234567890123, 280000, 'tersedia');
INSERT INTO `Mobil` VALUES (17, 'Nissan', 'X-Trail', 2022, 'Blue', 'Z 9012 GH', 98765432109876543210, 250000, 'tersedia');
INSERT INTO `Mobil` VALUES (18, 'Mitsubishi', 'Outlander', 2020, 'Green', 'P 7890 QR', 56789012345678901234, 230000, 'tersedia');
INSERT INTO `Mobil` VALUES (19, 'Volkswagen', 'Golf', 2021, 'Black', 'N 2345 ST', 67890123456789012345, 220000, 'tersedia');
INSERT INTO `Mobil` VALUES (20, 'Hyundai', 'Tucson', 2019, 'Gray', 'R 6789 UV', 78901234567890123456, 210000, 'tersedia');
INSERT INTO `Mobil` VALUES (21, 'Kia', 'Seltos', 2022, 'Orange', 'W 1234 XY', 89012345678901234567, 240000, 'tersedia');
INSERT INTO `Mobil` VALUES (22, 'Subaru', 'Crosstrek', 2021, 'Purple', 'C 5678 AB', 90123456789012345678, 260000, 'tersedia');
INSERT INTO `Mobil` VALUES (23, 'BMW', 'X5', 2020, 'Silver', 'Y 9012 CD', 34567890123456789012, 320000, 'tersedia');
INSERT INTO `Mobil` VALUES (24, 'Mercedes-Benz', 'C-Class', 2019, 'Blue', 'L 3456 EF', 45678901234567890123, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (25, 'Audi', 'Q7', 2022, 'White', 'Z 7890 GH', 98765432109876543210, 350000, 'tersedia');
INSERT INTO `Mobil` VALUES (26, 'Lexus', 'RX', 2021, 'Red', 'M 2345 IJ', 56789012345678901234, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (27, 'Tesla', 'Model 3', 2020, 'Black', 'O 6789 KL', 67890123456789012345, 380000, 'tersedia');
INSERT INTO `Mobil` VALUES (28, 'Ford', 'Escape', 2019, 'Gray', 'T 1234 UV', 78901234567890123456, 270000, 'tersedia');
INSERT INTO `Mobil` VALUES (29, 'Chevrolet', 'Equinox', 2022, 'Green', 'A 5678 WX', 89012345678901234567, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (30, 'Toyota', 'Rav4', 2021, 'Silver', 'S 9012 YZ', 90123456789012345678, 260000, 'tersedia');
INSERT INTO `Mobil` VALUES (31, 'Honda', 'CR-V', 2020, 'Blue', 'X 3456 AB', 34567890123456789012, 280000, 'tersedia');
INSERT INTO `Mobil` VALUES (32, 'Nissan', 'Rogue', 2019, 'White', 'F 7890 CD', 45678901234567890123, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (33, 'Mazda', 'CX-5', 2022, 'Silver', 'E 1234 FG', 56789012345678901234, 270000, 'tersedia');
INSERT INTO `Mobil` VALUES (34, 'Jeep', 'Cherokee', 2021, 'Blue', 'G 5678 HI', 67890123456789012345, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (35, 'Volkswagen', 'Tiguan', 2020, 'Black', 'J 9012 KL', 78901234567890123456, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (36, 'Subaru', 'Forester', 2019, 'Green', 'L 2345 MN', 89012345678901234567, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (38, 'Hyundai', 'Creta', 2022, 'Hitam', 'Z 1290 ZK', 34568730123456790000, 250000, 'tersedia');

-- ----------------------------
-- Table structure for Pelanggan
-- ----------------------------
DROP TABLE IF EXISTS `Pelanggan`;
CREATE TABLE `Pelanggan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nik` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nomor_telepon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `roles` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Pelanggan
-- ----------------------------
INSERT INTO `Pelanggan` VALUES (1, 'Salis Billy Nasrullah', '3278101608990001', 'arbudiman@gmail.com', 'Kp.Bebedahan 3 002/008 Kel. Lengkongsari, Kec. Tawang, Kota Tasikmalaya', '082121212154', '2024-01-31', 'wkwkwkwk', 'member');
INSERT INTO `Pelanggan` VALUES (22, 'Anri', '3278101608990001', 'lilis@gmail.com', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', '082121212154', '2024-01-21', '$2b$10$lcSHjvHfhui4hTiWYj.TzOd2gWV0j60ubL8TPC6u4kjJtt3zrk.AW', 'member');
INSERT INTO `Pelanggan` VALUES (23, 'Anri', '3278101608990001', 'anri26049@gmail.com', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', '082121212154', '2024-01-20', '$2b$10$0t/lx3Av9/phXIgE0wz.Pen9D8azxd5pBo6qeAhVahrsl/2YzRRSW', 'admin');
INSERT INTO `Pelanggan` VALUES (24, 'Anri', '3278101608990001', 'anricullens26@gmail.com', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', '082121212154', '2024-01-04', '$2b$10$VEftipPU5JO9e8EcmXZ1J.tbXpRmQfOc3741iucGoBzyRTjAlkyD2', 'member');

-- ----------------------------
-- Table structure for Transaksi
-- ----------------------------
DROP TABLE IF EXISTS `Transaksi`;
CREATE TABLE `Transaksi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int NOT NULL,
  `id_mobil` int NOT NULL,
  `id_karyawan` int NOT NULL,
  `tgl_peminjaman` datetime NOT NULL,
  `tgl_pengembalian` datetime NULL DEFAULT NULL,
  `total_biaya` decimal(10, 2) NULL DEFAULT NULL,
  `kode_transaksi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_transaksi`(`kode_transaksi`) USING BTREE,
  INDEX `tr_id_pelanggan`(`id_pelanggan`) USING BTREE,
  INDEX `tr_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `tr_id_karyawan`(`id_karyawan`) USING BTREE,
  CONSTRAINT `tr_id_karyawan` FOREIGN KEY (`id_karyawan`) REFERENCES `Karwayan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tr_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tr_id_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `Pelanggan` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Transaksi
-- ----------------------------

-- ----------------------------
-- Triggers structure for table Booking
-- ----------------------------
DROP TRIGGER IF EXISTS `kodebooking_gen`;
delimiter ;;
CREATE TRIGGER `kodebooking_gen` BEFORE INSERT ON `Booking` FOR EACH ROW BEGIN
  SET NEW.kode_booking = CONCAT('BK', LPAD(NEW.id, 6, '0'));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Transaksi
-- ----------------------------
DROP TRIGGER IF EXISTS `kode_transaksi_gen`;
delimiter ;;
CREATE TRIGGER `kode_transaksi_gen` BEFORE INSERT ON `Transaksi` FOR EACH ROW BEGIN
  SET NEW.kode_transaksi = CONCAT('TP', LPAD(NEW.id, 6, '0'));
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
