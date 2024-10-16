/*
 Navicat Premium Data Transfer

 Source Server         : mariadb
 Source Server Type    : MariaDB
 Source Server Version : 100424
 Source Host           : localhost:3306
 Source Schema         : masterworkrrhh

 Target Server Type    : MariaDB
 Target Server Version : 100424
 File Encoding         : 65001

 Date: 18/08/2024 23:27:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cm_users
-- ----------------------------
DROP TABLE IF EXISTS `cm_users`;
CREATE TABLE `cm_users`  (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `cusername` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cuserpass` varchar(250) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cuserdoc` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cusermail` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `nflgactivo` tinyint(1) NULL DEFAULT 1,
  `freg` timestamp(0) NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cm_users
-- ----------------------------
INSERT INTO `cm_users` VALUES (1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '20036250', 'carroyo@sepcon.net', 1, '2024-08-11 21:03:05');
INSERT INTO `cm_users` VALUES (2, 'lcatacora', '5d18ff2a1ca851d727d253d2162aca46ee73b122', '42132408', 'lcatacora@sepcon.net', 1, '2024-08-11 18:00:04');

-- ----------------------------
-- Table structure for tb_datostareo
-- ----------------------------
DROP TABLE IF EXISTS `tb_datostareo`;
CREATE TABLE `tb_datostareo`  (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nddoc` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cencargado` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `ncondicion` int(2) NULL DEFAULT NULL,
  `npersonal` int(2) NULL DEFAULT NULL,
  `cespecialidad` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `nmanoobra` int(2) NULL DEFAULT NULL,
  `cproyecto` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cfase` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cubicacion` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cregimen` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `fingreso` date NULL DEFAULT NULL,
  `fsalida` date NULL DEFAULT NULL,
  `fretorno` date NULL DEFAULT NULL,
  `dgoce` int(3) NULL DEFAULT NULL,
  `dlibre` int(3) NULL DEFAULT NULL,
  `dcampo` int(3) NULL DEFAULT NULL,
  `dreales` int(3) NULL DEFAULT NULL,
  `cobservaciones` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cdescanso` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `fcese` date NULL DEFAULT NULL,
  `cmotivocese` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `nflgactivo` tinyint(1) NULL DEFAULT 1,
  `fregsys` timestamp(0) NULL DEFAULT current_timestamp,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_datostareo
-- ----------------------------
INSERT INTO `tb_datostareo` VALUES (1, '20036250', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2024-08-06 23:37:53');
INSERT INTO `tb_datostareo` VALUES (2, '20036250', 'LUIS FALCON', 3, 10, 'DESARROLLO DE SISTEMAS', 6, '020000 ADMINISTRACION DE OFICINA / Sede Lima', 'LIMA', 'LIMA', '14/7', '2024-08-07', '2024-08-20', '2024-08-26', 14, 5, 14, NULL, 'PRUEBA', 'PRUEBA', '0000-00-00', 'PRUEBA', 1, '2024-08-06 23:55:11');
INSERT INTO `tb_datostareo` VALUES (3, '20036250', 'LUIS FALCON', 3, 10, 'DESARROLLO DE SISTEMAS', 6, '020000 ADMINISTRACION DE OFICINA / Sede Lima', 'PRUEBA', 'MALVINAS', '28/7', '2024-08-07', '2024-09-03', '2024-09-09', 28, 0, 0, NULL, 'PRUEBA', 'PRUEBA', '0000-00-00', '', 1, '2024-08-07 00:29:38');
INSERT INTO `tb_datostareo` VALUES (4, '20036250', 'LUIS FALCON', 3, 10, 'DESARROLLO DE SISTEMAS', 6, '020000 ADMINISTRACION DE OFICINA / Sede Lima', 'PRUEBA', 'MALVINAS', '28/7', '2024-08-07', '2024-09-03', '2024-09-09', 28, 0, 0, NULL, 'PRUEBA', 'PRUEBA', '0000-00-00', '', 1, '2024-08-07 01:28:27');
INSERT INTO `tb_datostareo` VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2024-08-11 16:21:23');

-- ----------------------------
-- Table structure for tb_parametros
-- ----------------------------
DROP TABLE IF EXISTS `tb_parametros`;
CREATE TABLE `tb_parametros`  (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nclase` varchar(6) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `ncod` varchar(6) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cdescripcion` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `nflgactivo` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_parametros
-- ----------------------------
INSERT INTO `tb_parametros` VALUES (1, '00', '00', 'CONDICION', 1);
INSERT INTO `tb_parametros` VALUES (2, '00', '01', 'OBRERO', 1);
INSERT INTO `tb_parametros` VALUES (3, '00', '02', 'STAFF', 1);
INSERT INTO `tb_parametros` VALUES (4, '01', '00', 'TERCERO', 1);
INSERT INTO `tb_parametros` VALUES (5, '01', '00', 'MANO DE OBRA', 1);
INSERT INTO `tb_parametros` VALUES (6, '01', '01', 'DIRECTA', 1);
INSERT INTO `tb_parametros` VALUES (7, '01', '02', 'INDIRECTA', 1);
INSERT INTO `tb_parametros` VALUES (8, '02', '00', 'PERSONAL', 1);
INSERT INTO `tb_parametros` VALUES (9, '02', '01', 'FORANEO', 1);
INSERT INTO `tb_parametros` VALUES (10, '02', '02', 'LOCAL', 1);
INSERT INTO `tb_parametros` VALUES (11, '02', '03', 'EXTRANJERO', 1);

-- ----------------------------
-- Table structure for tb_tareos
-- ----------------------------
DROP TABLE IF EXISTS `tb_tareos`;
CREATE TABLE `tb_tareos`  (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nrodoc` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cproyecto` int(11) NULL DEFAULT NULL,
  `cubicacion` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `estado` varchar(3) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `mes` int(2) NULL DEFAULT NULL,
  `anio` int(4) NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `fingreso` date NULL DEFAULT NULL,
  `fregsys` timestamp(0) NULL DEFAULT current_timestamp,
  `nfgactivo` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_tareos
-- ----------------------------
INSERT INTO `tb_tareos` VALUES (1, '000789910', 20000, 'PISCO', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (2, '06813229', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (3, '10313207', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (4, '20036250', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (5, '06708203', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (6, '41667405', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (7, '71820627', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (8, '72890114', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (9, '09680835', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (10, '08934899', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (11, '46067198', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (12, '10751826', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (13, '73830015', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (14, '71932542', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (15, '22284149', 20000, 'PISCO', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (16, '71942763', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (17, '09383118', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (18, '10281988', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (19, '25608087', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (20, '000853189', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (21, '74174466', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (22, '000458816', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (23, '000692215', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (24, '40802035', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (25, '10634270', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (26, '42778331', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (27, '76640732', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (28, '72921002', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (29, '21301845', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (30, '21276405', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (31, '07038472', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (32, '000821937', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (33, '06097752', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (34, '72306549', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (35, '70613887', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (36, '47425100', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (37, '005982120', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (38, '000148566', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (39, '10307288', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (40, '44660228', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (41, '08165961', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (42, '47892426', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (43, '000435778', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (44, '08488980', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (45, '44068092', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (46, '45077172', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (47, '43281347', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (48, '72701092', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (49, '000685634', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (50, '10712208', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (51, '000540903', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (52, '09619538', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (53, '45882664', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (54, '43095718', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (55, '41310878', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (56, '18217223', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (57, '000809716', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (58, '42284795', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (59, '41095867', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);
INSERT INTO `tb_tareos` VALUES (60, '000426973', 20000, 'LIMA ', 'A', 8, 2024, '0000-00-00', NULL, '2024-08-18 22:41:24', 1);

-- ----------------------------
-- Table structure for tm_userproyectos
-- ----------------------------
DROP TABLE IF EXISTS `tm_userproyectos`;
CREATE TABLE `tm_userproyectos`  (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `cdocumento` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `ccodigo` varchar(32) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `cdescripcion` text CHARACTER SET utf8 COLLATE utf8_spanish2_ci NULL DEFAULT NULL,
  `fregsys` timestamp(0) NULL DEFAULT current_timestamp,
  `nflgactivo` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_spanish2_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tm_userproyectos
-- ----------------------------
INSERT INTO `tm_userproyectos` VALUES (1, '20036250', '020000', 'ADMINISTRACION DE OFICINA / Sede Lima', '2024-08-11 17:55:01', 1);
INSERT INTO `tm_userproyectos` VALUES (2, '20036250', '340000', 'SERV. REEMPLAZO DE AISLAMIENTO TÉRMICO Y RECUPERACION DE ESPESOR POR SOLDADURA EN CRIOGÉNICAS 3,4Y5', '2024-08-11 17:55:01', 1);
INSERT INTO `tm_userproyectos` VALUES (3, '42132408', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-08-11 18:00:04', 1);

SET FOREIGN_KEY_CHECKS = 1;
