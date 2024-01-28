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

 Date: 28/01/2024 23:14:06
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
  `kode_booking` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_mulai_sewa` date NOT NULL,
  `tgl_selesai_sewa` date NOT NULL,
  `status` enum('pending','dikonfirmasi','selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_booking`(`kode_booking`) USING BTREE,
  INDEX `bk_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `bk_id_user`(`id_user`) USING BTREE,
  CONSTRAINT `bk_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bk_id_user` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of Booking
-- ----------------------------
INSERT INTO `Booking` VALUES (34, 61, 42, '2024-01-27 18:59:38', 'BK000001', '2024-01-01', '2024-01-08', 'dikonfirmasi');
INSERT INTO `Booking` VALUES (35, 61, 57, '2024-01-27 18:59:49', 'BK000035', '2024-01-02', '2024-01-16', 'selesai');
INSERT INTO `Booking` VALUES (36, 61, 39, '2024-01-27 19:00:04', 'BK000036', '2024-01-01', '2024-01-31', 'selesai');
INSERT INTO `Booking` VALUES (37, 61, 45, '2024-01-27 19:00:12', 'BK000037', '2024-01-02', '2024-01-16', 'selesai');
INSERT INTO `Booking` VALUES (38, 58, 54, '2024-01-27 19:07:27', 'BK000038', '2024-01-01', '2024-01-31', 'pending');
INSERT INTO `Booking` VALUES (39, 58, 46, '2024-01-27 19:07:36', 'BK000039', '2024-01-01', '2024-01-17', 'selesai');
INSERT INTO `Booking` VALUES (40, 58, 69, '2024-01-27 19:07:56', 'BK000040', '2024-01-16', '2024-02-10', 'selesai');
INSERT INTO `Booking` VALUES (41, 58, 63, '2024-01-27 19:08:24', 'BK000041', '2024-02-08', '2024-02-20', 'selesai');
INSERT INTO `Booking` VALUES (43, 61, 43, '2024-01-28 14:27:27', 'BK000042', '2024-01-18', '2024-01-26', 'dikonfirmasi');
INSERT INTO `Booking` VALUES (45, 61, 39, '2024-01-28 16:05:02', 'BKNG000044', '2024-01-09', '2024-01-17', 'selesai');
INSERT INTO `Booking` VALUES (46, 61, 41, '2024-01-28 16:05:07', 'BKNG000046', '2024-01-10', '2024-01-30', 'pending');
INSERT INTO `Booking` VALUES (47, 61, 48, '2024-01-28 16:05:14', 'BKNG000047', '2024-01-02', '2024-01-24', 'selesai');
INSERT INTO `Booking` VALUES (48, 61, 66, '2024-01-28 16:05:24', 'BKNG000048', '2024-01-09', '2024-01-24', 'pending');
INSERT INTO `Booking` VALUES (49, 61, 73, '2024-01-28 16:05:33', 'BKNG000049', '2024-01-02', '2024-01-17', 'pending');
INSERT INTO `Booking` VALUES (50, 61, 47, '2024-01-28 16:25:52', 'BKNG000050', '2024-01-02', '2024-01-23', 'selesai');
INSERT INTO `Booking` VALUES (51, 61, 56, '2024-01-28 16:26:02', 'BKNG000051', '2024-01-01', '2024-01-17', 'pending');
INSERT INTO `Booking` VALUES (52, 61, 60, '2024-01-28 16:26:11', 'BKNG000052', '2024-01-08', '2024-01-17', 'selesai');

-- ----------------------------
-- Table structure for Kode
-- ----------------------------
DROP TABLE IF EXISTS `Kode`;
CREATE TABLE `Kode`  (
  `id` int NOT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `kode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_indeks_nama`(`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Kode
-- ----------------------------
INSERT INTO `Kode` VALUES (1, 'Transaksi', 'TSKI', 'Kode untuk transaksi');
INSERT INTO `Kode` VALUES (2, 'Booking', 'BKG', 'Kode untuk Booking');

-- ----------------------------
-- Table structure for Kode_history
-- ----------------------------
DROP TABLE IF EXISTS `Kode_history`;
CREATE TABLE `Kode_history`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_kode` int NULL DEFAULT NULL,
  `kode_sebelumnya` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tgl_perubahan` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_kh_id_kode`(`id_kode`) USING BTREE,
  CONSTRAINT `hs_id_kode` FOREIGN KEY (`id_kode`) REFERENCES `Kode` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Kode_history
-- ----------------------------
INSERT INTO `Kode_history` VALUES (12, 1, 'TS', '2024-01-28 16:04:15');
INSERT INTO `Kode_history` VALUES (13, 2, 'BK', '2024-01-28 16:04:28');
INSERT INTO `Kode_history` VALUES (14, 1, 'TSK', '2024-01-28 16:24:38');
INSERT INTO `Kode_history` VALUES (15, 2, 'BKNG', '2024-01-28 23:08:48');

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
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of Mobil
-- ----------------------------
INSERT INTO `Mobil` VALUES (39, 'Hyundais', 'Stargazer', 2022, 'Silver', 'Z 2001 DC', 86655678563286450000, 200000, 'tersedia');
INSERT INTO `Mobil` VALUES (40, 'Hyundai', 'Ioniq 5', 2022, 'Silver', 'Z D4D0 CY', 86655864543234570000, 1100000, 'tersedia');
INSERT INTO `Mobil` VALUES (41, 'Hyundai', 'Palisade', 2022, 'Putih', 'D 2093 YY', 86655678563234560000, 300000, 'disewa');
INSERT INTO `Mobil` VALUES (42, 'Hyundai', 'Santa FE', 2022, 'Hitam', 'D 1920 DA', 86655678971234570000, 800000, 'disewa');
INSERT INTO `Mobil` VALUES (43, 'Hyundai', 'H1', 2022, 'Silver', 'C 4479 H', 86655678901234570000, 2200000, 'disewa');
INSERT INTO `Mobil` VALUES (44, 'Toyota', 'Avanza', 2020, 'Silver', 'B 1234 CD', 12345678901234567890, 200000, 'tersedia');
INSERT INTO `Mobil` VALUES (45, 'Honda', 'Jazz', 2019, 'White', 'D 5678 EF', 23456789012345678901, 180000, 'tersedia');
INSERT INTO `Mobil` VALUES (46, 'Ford', 'Mustang', 2021, 'Red', 'G 9012 HI', 34567890123456789012, 300000, 'tersedia');
INSERT INTO `Mobil` VALUES (47, 'Chevrolet', 'Camaro', 2022, 'Yellow', 'K 3456 LM', 45678901234567890123, 280000, 'tersedia');
INSERT INTO `Mobil` VALUES (48, 'Nissan', 'X-Trail', 2022, 'Blue', 'Z 9012 GH', 98765432109876543210, 250000, 'tersedia');
INSERT INTO `Mobil` VALUES (49, 'Mitsubishi', 'Outlander', 2020, 'Green', 'P 7890 QR', 56789012345678901234, 230000, 'tersedia');
INSERT INTO `Mobil` VALUES (50, 'Volkswagen', 'Golf', 2021, 'Black', 'N 2345 ST', 67890123456789012345, 220000, 'tersedia');
INSERT INTO `Mobil` VALUES (51, 'Hyundai', 'Tucson', 2019, 'Gray', 'R 6789 UV', 78901234567890123456, 210000, 'tersedia');
INSERT INTO `Mobil` VALUES (52, 'Kia', 'Seltos', 2022, 'Orange', 'W 1234 XY', 89012345678901234567, 240000, 'tersedia');
INSERT INTO `Mobil` VALUES (53, 'Subaru', 'Crosstrek', 2021, 'Purple', 'C 5678 AB', 90123456789012345678, 260000, 'tersedia');
INSERT INTO `Mobil` VALUES (54, 'BMW', 'X5', 2020, 'Silver', 'Y 9012 CD', 34567890123456789012, 320000, 'disewa');
INSERT INTO `Mobil` VALUES (55, 'Mercedes-Benz', 'C-Class', 2019, 'Blue', 'L 3456 EF', 45678901234567890123, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (56, 'Audi', 'Q7', 2022, 'White', 'Z 7890 GH', 98765432109876543210, 350000, 'disewa');
INSERT INTO `Mobil` VALUES (57, 'Lexus', 'RX', 2021, 'Red', 'M 2345 IJ', 56789012345678901234, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (58, 'Tesla', 'Model 3', 2020, 'Black', 'O 6789 KL', 67890123456789012345, 380000, 'tersedia');
INSERT INTO `Mobil` VALUES (59, 'Ford', 'Escape', 2019, 'Gray', 'T 1234 UV', 78901234567890123456, 270000, 'tersedia');
INSERT INTO `Mobil` VALUES (60, 'Chevrolet', 'Equinox', 2022, 'Green', 'A 5678 WX', 89012345678901234567, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (61, 'Toyota', 'Rav4', 2021, 'Silver', 'S 9012 YZ', 90123456789012345678, 260000, 'tersedia');
INSERT INTO `Mobil` VALUES (62, 'Honda', 'CR-V', 2020, 'Blue', 'X 3456 AB', 34567890123456789012, 280000, 'tersedia');
INSERT INTO `Mobil` VALUES (63, 'Nissan', 'Rogue', 2019, 'White', 'F 7890 CD', 45678901234567890123, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (64, 'Mazda', 'CX-5', 2022, 'Silver', 'E 1234 FG', 56789012345678901234, 270000, 'tersedia');
INSERT INTO `Mobil` VALUES (65, 'Jeep', 'Cherokee', 2021, 'Blue', 'G 5678 HI', 67890123456789012345, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (66, 'Volkswagen', 'Tiguan', 2020, 'Black', 'J 9012 KL', 78901234567890123456, 310000, 'disewa');
INSERT INTO `Mobil` VALUES (67, 'Subaru', 'Forester', 2019, 'Green', 'L 2345 MN', 89012345678901234567, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (68, 'Hyundai', 'Creta', 2022, 'Hitam', 'Z 1290 ZK', 34568730123456790000, 250000, 'tersedia');
INSERT INTO `Mobil` VALUES (69, 'Toyota', 'Camry', 2022, 'Black', 'B 5678 EF', 98765432101234567890, 400000, 'tersedia');
INSERT INTO `Mobil` VALUES (70, 'Honda', 'Accord', 2022, 'White', 'D 1234 GH', 87654321012345678901, 380000, 'tersedia');
INSERT INTO `Mobil` VALUES (71, 'Ford', 'Fusion', 2022, 'Gray', 'G 9012 IJ', 76543210912345678901, 370000, 'tersedia');
INSERT INTO `Mobil` VALUES (72, 'Chevrolet', 'Malibu', 2022, 'Blue', 'K 3456 KL', 65432109812345678901, 360000, 'tersedia');
INSERT INTO `Mobil` VALUES (73, 'Nissan', 'Altima', 2022, 'Red', 'Z 9012 MN', 54321098712345678901, 350000, 'disewa');
INSERT INTO `Mobil` VALUES (74, 'Mitsubishi', 'Lancer', 2022, 'Silver', 'P 7890 QR', 43210987612345678901, 340000, 'tersedia');
INSERT INTO `Mobil` VALUES (75, 'Volkswagen', 'Passat', 2022, 'Green', 'N 2345 ST', 32109876512345678901, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (76, 'Hyundai', 'Elantra', 2022, 'Orange', 'W 1234 XY', 21098765412345678901, 320000, 'tersedia');
INSERT INTO `Mobil` VALUES (77, 'Kia', 'Optima', 2022, 'Purple', 'C 5678 AB', 10987654312345678901, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (78, 'Subaru', 'Impreza', 2022, 'Yellow', 'C 5678 CD', 12345678901234567890, 300000, 'tersedia');
INSERT INTO `Mobil` VALUES (79, 'BMW', '3 Series', 2022, 'Black', 'Y 9012 EF', 23456789012345678901, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (80, 'Toyota', 'Corolla', 2022, 'White', 'X 3456 GH', 34567890123456789012, 280000, 'tersedia');
INSERT INTO `Mobil` VALUES (81, 'Honda', 'Civic', 2022, 'Blue', 'F 7890 IJ', 45678901234567890123, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (82, 'Ford', 'Focus', 2022, 'Red', 'T 1234 KL', 56789012345678901234, 270000, 'tersedia');
INSERT INTO `Mobil` VALUES (83, 'Chevrolet', 'Spark', 2022, 'Green', 'A 5678 MN', 67890123456789012345, 290000, 'tersedia');
INSERT INTO `Mobil` VALUES (84, 'Nissan', 'Versa', 2022, 'Black', 'S 9012 OP', 78901234567890123456, 310000, 'tersedia');
INSERT INTO `Mobil` VALUES (85, 'Mitsubishi', 'Mirage', 2022, 'Silver', 'L 2345 QR', 89012345678901234567, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (86, 'Volkswagen', 'Polo', 2022, 'Gray', 'N 6789 ST', 90123456789012345678, 350000, 'tersedia');
INSERT INTO `Mobil` VALUES (87, 'Hyundai', 'Accent', 2022, 'Orange', 'W 1234 UV', 12345678901234567890, 330000, 'tersedia');
INSERT INTO `Mobil` VALUES (88, 'Kia', 'Rio', 2022, 'Purple', 'C 5678 AB', 23456789012345678901, 320000, 'tersedia');
INSERT INTO `Mobil` VALUES (89, 'Subaru', 'Legacy', 2022, 'Yellow', 'C 5678 CD', 34567890123456789012, 310000, 'tersedia');

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
  `kode_transaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('selesai','belum di bayar') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'belum di bayar',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kode_transaksi`(`kode_transaksi`) USING BTREE,
  INDEX `tr_id_mobil`(`id_mobil`) USING BTREE,
  INDEX `tr_id_user`(`id_user`) USING BTREE,
  CONSTRAINT `tr_id_mobil` FOREIGN KEY (`id_mobil`) REFERENCES `Mobil` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tr_id_user` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of Transaksi
-- ----------------------------
INSERT INTO `Transaksi` VALUES (8, 61, 45, '2024-01-02 00:00:00', '2024-01-16 00:00:00', 2520000.00, 'TS000001', 'selesai');
INSERT INTO `Transaksi` VALUES (9, 61, 57, '2024-01-02 00:00:00', '2024-01-16 00:00:00', 4620000.00, 'TS000009', 'selesai');
INSERT INTO `Transaksi` VALUES (10, 61, 39, '2024-01-01 00:00:00', '2024-01-31 00:00:00', 6000000.00, 'TS000010', 'belum di bayar');
INSERT INTO `Transaksi` VALUES (11, 58, 46, '2024-01-01 00:00:00', '2024-01-17 00:00:00', 4800000.00, 'TS000011', 'belum di bayar');
INSERT INTO `Transaksi` VALUES (12, 58, 69, '2024-01-16 00:00:00', '2024-02-10 00:00:00', 10000000.00, 'TS000012', 'selesai');
INSERT INTO `Transaksi` VALUES (16, 61, 39, '2024-01-09 00:00:00', '2024-01-17 00:00:00', 1600000.00, 'TSK000014', 'belum di bayar');
INSERT INTO `Transaksi` VALUES (17, 61, 48, '2024-01-02 00:00:00', '2024-01-24 00:00:00', 5500000.00, 'TSK000017', 'selesai');
INSERT INTO `Transaksi` VALUES (18, 58, 63, '2024-02-08 00:00:00', '2024-02-20 00:00:00', 3720000.00, 'TSKI000018', 'belum di bayar');
INSERT INTO `Transaksi` VALUES (19, 61, 60, '2024-01-08 00:00:00', '2024-01-17 00:00:00', 2610000.00, 'TSKI000019', 'belum di bayar');
INSERT INTO `Transaksi` VALUES (20, 61, 47, '2024-01-02 00:00:00', '2024-01-23 00:00:00', 5880000.00, 'TSKI000020', 'belum di bayar');

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nik` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nomor_telepon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `roles` enum('client','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'client',
  `foto_profil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of Users
-- ----------------------------
INSERT INTO `Users` VALUES (58, '000058', 'Anri Client', '3278101608990001', '2024-01-27', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', 'anriclient@gmail.com', '082121212154', '$2b$10$Unot.jre8xM2liXu7hHXkOXv0zWjh.E.I/Rr85l/nqyGZQnWrzzzK', 'client', NULL);
INSERT INTO `Users` VALUES (59, '000059', 'Anri Admin', '3278101608990002', '2024-01-26', 'Kp.Golempang 002/007 Kel.Sukajaya, Kec.Purbaratu, Kota Tasikmalaya', 'anriadmin@gmail.com', '082121212154', '$2b$10$.XLXe.68w3ZSYA9JcFEmueKbb..G/9xa.rgokzcI1aCT3ZK9w73/.', 'admin', NULL);
INSERT INTO `Users` VALUES (60, '000060', 'Admin', '3278101608990003', '2024-01-09', 'Kp.Admin 002/007 Kel.Admin, Kec.Admin, Kota Admin', 'admin@gmail.com', '082121212154', '$2b$10$EZU6zVeRmX.hY36sP9juQufJ8SsTLJ9qAIgO.o9eNDCodA8CbSqIa', 'admin', NULL);
INSERT INTO `Users` VALUES (61, '000061', 'Client', '3278101608990010', '2024-01-03', 'Kp.Client 002/007 Kel.Client, Kec.Client, Kota Client', 'client@gmail.com', '082121212154', '$2b$10$RhwTtnb6N3ntsjyY8GqaAeNnjdccC0kyTS4QpKxKclhy6XU9DLD6W', 'client', NULL);

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
