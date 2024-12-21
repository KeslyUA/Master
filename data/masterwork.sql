/*
Navicat MySQL Data Transfer

Source Server         : Local
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : masterwork

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-12-21 11:06:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cm_users`
-- ----------------------------
DROP TABLE IF EXISTS `cm_users`;
CREATE TABLE `cm_users` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `cusername` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cuserpass` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cuserdoc` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cusermail` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1,
  `freg` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cm_users
-- ----------------------------
INSERT INTO `cm_users` VALUES ('1', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '20036250', 'carroyo@sepcon.net', '1', '2024-11-07 10:56:44');
INSERT INTO `cm_users` VALUES ('2', 'lcatacora', '75a0f3342a2fbcbe1254fa8d49b31cefadd630ec', '42132408', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('3', 'rari', 'e2f6ade5854bb9988360fb232c55998507688780', '76478671', 'rari@sepcon.net', '2', '2024-11-27 08:55:35');
INSERT INTO `cm_users` VALUES ('4', 'invitado', '0c0438a2d770051789cbafdd47fe25a9d7f74587', '00000000', 'invitado', '1', '2024-10-24 14:10:12');
INSERT INTO `cm_users` VALUES ('5', 'fquicana', 'df19ef3b0d0b16c91e28f7e53ca8687529e96e3e', '41667546', 'felimonjose@gmail.com', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('8', 'alujan', 'e3b39a53542820ba6db569dd2c9ab71e03406bf7', '70566358', '@sepcon.net', '1', '2024-11-11 10:25:56');
INSERT INTO `cm_users` VALUES ('9', 'egamarra', '89ddeabe87c653d60ee115afdbc19156b44c1d0a', '27690290', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('10', 'jcuello', 'c872676f6664374c512e9bcf2714ea210193d1f7', '78720030', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('11', 'jsaavedra', '6413b38fe61fef3e8bd99f608c1d2cada1a46702', '76175725', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('12', 'lgutierrez', 'c81d6266a2989b250582af63e0db863f42caf121', '71972542', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('13', 'allaque', '2e3d152df4664eb45c3215a57159b3e900ea3b01', '43856063', '@sepcon.net', '1', '2024-11-11 14:23:53');
INSERT INTO `cm_users` VALUES ('14', 'adminrrhh', '6ca6f27ca3a9a0318b5e5ff5eac02ad7fc988cc5', '111111', '@sepcon.net', '1', '2024-11-11 11:06:41');

-- ----------------------------
-- Table structure for `tb_datostareo`
-- ----------------------------
DROP TABLE IF EXISTS `tb_datostareo`;
CREATE TABLE `tb_datostareo` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nddoc` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cencargado` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ncondicion` int(2) DEFAULT NULL,
  `npersonal` int(2) DEFAULT NULL,
  `cespecialidad` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nmanoobra` int(2) DEFAULT NULL,
  `cproyecto` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cfase` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cubicacion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cregimen` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fingreso` date DEFAULT NULL,
  `fsalida` date DEFAULT NULL,
  `fretorno` date DEFAULT NULL,
  `dgoce` int(3) DEFAULT NULL,
  `dlibre` int(3) DEFAULT NULL,
  `dcampo` int(3) DEFAULT NULL,
  `dreales` int(3) DEFAULT NULL,
  `cobservaciones` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescanso` int(3) DEFAULT NULL,
  `fcese` date DEFAULT NULL,
  `cmotivocese` int(3) DEFAULT NULL,
  `nregimen` int(11) DEFAULT NULL,
  `nespecificacion` int(11) DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_datostareo
-- ----------------------------
INSERT INTO `tb_datostareo` VALUES ('1', '76478671', '1', '3', '10', 'DESARROLLO DE SISTEMAS', '7', '020000', '2', 'LIMA', '2x1', '2024-12-03', '2024-12-10', '0000-00-00', '3', '0', '7', '0', 'observacion prueba', '23', '0000-00-00', '-1', '12', '16', '1', '2024-12-03 09:15:01');
INSERT INTO `tb_datostareo` VALUES ('2', '04412417', '2', '3', '10', 'DESARROLLO DE SISTEMAS', '7', '020000', '1', 'LIMA', '2x1', '2024-12-03', '2024-12-17', '0000-00-00', '7', '0', '14', '0', 'observaciones de prueba teceros', '24', '0000-00-00', '29', '13', '17', '1', '2024-12-03 10:54:28');
INSERT INTO `tb_datostareo` VALUES ('3', '42132408', '9', '3', '9', null, '7', '390000', '8', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '13', '19', '1', '2024-12-05 11:08:25');
INSERT INTO `tb_datostareo` VALUES ('4', '000789910', '9', '3', '11', 'GERENTE DE CONSTRUCCION', '7', '390000', '-1', 'NUEVO MUNDO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '-1', '1', '2024-12-05 11:18:57');
INSERT INTO `tb_datostareo` VALUES ('5', '008640258', '9', '3', '11', 'GERENTE DE PROYECTOS', '7', '390000', '7', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:20:44');
INSERT INTO `tb_datostareo` VALUES ('6', '40778235', '9', '3', '9', null, '7', '390000', '9', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '13', '19', '1', '2024-12-05 11:27:23');
INSERT INTO `tb_datostareo` VALUES ('7', '40778235', '9', '3', '9', null, '7', '390000', '9', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '13', '19', '1', '2024-12-05 11:27:41');
INSERT INTO `tb_datostareo` VALUES ('8', '47960091', '4', '3', '9', 'Inspector de SSMA', '7', '390000', '13', 'NUEVO MUNDO', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:50:40');
INSERT INTO `tb_datostareo` VALUES ('9', '46605432', '9', '3', '9', 'Supervisor de Obras Civiles', '7', '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:56:29');
INSERT INTO `tb_datostareo` VALUES ('10', '46605432', '9', '3', '9', 'Supervisor de Obras Civiles', '7', '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:56:42');
INSERT INTO `tb_datostareo` VALUES ('11', '46605432', '9', '3', '9', 'Supervisor de Obras Civiles', '7', '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:56:47');
INSERT INTO `tb_datostareo` VALUES ('12', '46605432', '9', '3', '9', 'Supervisor de Obras Civiles', '7', '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 11:56:54');
INSERT INTO `tb_datostareo` VALUES ('13', '72890114', '3', '3', '9', 'Asistente de RR.HH. ', '7', '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:00:01');
INSERT INTO `tb_datostareo` VALUES ('14', '44823974', '9', '3', '9', 'Jefe de SSMA', '7', '390000', '13', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:06:10');
INSERT INTO `tb_datostareo` VALUES ('15', '16123862', '11', '2', '9', '-1', '6', '390000', '11', '4', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:09:56');
INSERT INTO `tb_datostareo` VALUES ('16', '72654693', '9', '2', '9', 'Peón', '6', '390000', '27', 'PUCALLPA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:13:48');
INSERT INTO `tb_datostareo` VALUES ('17', '41929321', '9', '2', '9', 'Operario Mecánico de Mtto. de Equipos Pesados', '6', '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:15:22');
INSERT INTO `tb_datostareo` VALUES ('18', '43162015', '9', '3', '9', 'Coordinador Eléctrico e Instrumentista', '6', '390000', '18', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 12:21:57');
INSERT INTO `tb_datostareo` VALUES ('19', '46078454', '9', '2', '9', 'Operario Mecánico de Mtto. de Equipos Pesados', '6', '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:27:21');
INSERT INTO `tb_datostareo` VALUES ('20', '43164161', '9', '2', '9', 'Peón', '6', '390000', '27', 'PUCALLPA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:28:34');
INSERT INTO `tb_datostareo` VALUES ('21', '45711527', '9', '2', '9', 'Operario Mecánico de Mtto. de Equipos Pesados', '6', '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:33:49');
INSERT INTO `tb_datostareo` VALUES ('22', '70613887', '-1', '3', '9', '-1', '7', '390000', '-1', '-1', '6X1', '2024-12-13', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:35:39');
INSERT INTO `tb_datostareo` VALUES ('23', '03897077', '9', '3', '9', 'Coordinador de Logística', '7', '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:36:55');
INSERT INTO `tb_datostareo` VALUES ('24', '41090322', '9', '3', '9', 'Asistente de Tecnología e Informática', '7', '390000', '15', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:39:22');
INSERT INTO `tb_datostareo` VALUES ('25', '44085611', '11', '2', '9', 'Oficial de Topografía', '6', '390000', '11', 'NUEVO MUNDO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:40:32');
INSERT INTO `tb_datostareo` VALUES ('26', '72433532', '11', '2', '9', 'Oficial de Topografía', '7', '390000', '11', 'NUEVO MUNDO', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:42:25');
INSERT INTO `tb_datostareo` VALUES ('27', '008536028', '9', '3', '11', 'Jefe de QA/QC', '7', '390000', '10', 'LIMA', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:43:38');
INSERT INTO `tb_datostareo` VALUES ('28', '76742784', '9', '3', '9', 'Asistente de Compras', '7', '390000', '25', 'LIMA', '6X1', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:46:53');
INSERT INTO `tb_datostareo` VALUES ('29', '42743571', '4', '3', '9', 'Enfermero Ocupacional', '7', '390000', '13', 'LIMA', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:48:00');
INSERT INTO `tb_datostareo` VALUES ('30', '43563747', '9', '3', '9', 'Auxiliar de Logística', '-1', '390000', '25', 'PUCALLPA', '6X1', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:49:07');
INSERT INTO `tb_datostareo` VALUES ('31', '21136515', '9', '3', '9', 'Jefe de Almacén', '7', '390000', '28', 'PISCO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:52:03');
INSERT INTO `tb_datostareo` VALUES ('32', '22297859', '9', '3', '9', 'Supervisor de Armado de Campamento', '7', '390000', '17', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:55:12');
INSERT INTO `tb_datostareo` VALUES ('33', '40423524', '9', '3', '9', 'Jefe de Oficina Técnica', '7', '390000', '11', 'LIMA', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:56:34');
INSERT INTO `tb_datostareo` VALUES ('34', '46831991', '9', '3', '9', 'Asistente de Logística', '7', '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-05 14:58:14');
INSERT INTO `tb_datostareo` VALUES ('35', '42363352', '12', '2', '9', 'Operario Pintor Civil', '6', '390000', '16', 'PISCO', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-06 08:55:12');
INSERT INTO `tb_datostareo` VALUES ('36', '41413571', '12', '2', '9', 'Operario de Almacén', '6', '390000', '16', 'PISCO', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '-1', '1', '2024-12-06 08:56:32');
INSERT INTO `tb_datostareo` VALUES ('37', '25849265', '9', '3', '9', 'Coordinador de Logística', '7', '390000', '20', 'NUEVO MUNDO', '14X7', '2024-12-10', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-10 10:18:56');
INSERT INTO `tb_datostareo` VALUES ('38', '07473313', '-1', '2', '9', '-1', '6', '390000', '28', '5', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-10 11:19:55');
INSERT INTO `tb_datostareo` VALUES ('39', '15855546', '9', '3', '9', 'Coordinador de Logística', '7', '390000', '28', 'PISCO', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-10 11:26:43');
INSERT INTO `tb_datostareo` VALUES ('40', '22308082', '9', '2', '9', 'Operario Rigger', '6', '390000', '28', 'PISCO', '6X1', '2024-12-10', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-10 15:35:50');
INSERT INTO `tb_datostareo` VALUES ('41', '43178225', '9', '2', '9', '1', '6', '390000', '27', '3', '14X7', '2024-12-12', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-12 13:51:05');
INSERT INTO `tb_datostareo` VALUES ('42', '40908346', '12', '2', '9', '-1', '6', '390000', '16', '1', '14X7', '0000-00-00', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-17 15:34:22');
INSERT INTO `tb_datostareo` VALUES ('43', '70055164', '9', '2', '9', '-1', '6', '390000', '26', '5', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-18 16:14:18');
INSERT INTO `tb_datostareo` VALUES ('44', '008639724', '9', '2', '11', '-1', '6', '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '12', '19', '1', '2024-12-20 09:40:52');

-- ----------------------------
-- Table structure for `tb_datostareo_historico`
-- ----------------------------
DROP TABLE IF EXISTS `tb_datostareo_historico`;
CREATE TABLE `tb_datostareo_historico` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nddoc` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cencargado` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ncondicion` int(2) DEFAULT NULL,
  `npersonal` int(2) DEFAULT NULL,
  `cespecialidad` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nmanoobra` int(2) DEFAULT NULL,
  `cproyecto` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cfase` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cubicacion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cregimen` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fingreso` date DEFAULT NULL,
  `fsalida` date DEFAULT NULL,
  `fretorno` date DEFAULT NULL,
  `dgoce` int(3) DEFAULT NULL,
  `dlibre` int(3) DEFAULT NULL,
  `dcampo` int(3) DEFAULT NULL,
  `dreales` int(3) DEFAULT NULL,
  `cobservaciones` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescanso` int(3) DEFAULT NULL,
  `fcese` date DEFAULT NULL,
  `cmotivocese` int(3) DEFAULT NULL,
  `nregimen` int(11) DEFAULT NULL,
  `nespecificacion` int(11) DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_datostareo_historico
-- ----------------------------
INSERT INTO `tb_datostareo_historico` VALUES ('1', '07473313', '12', '2', '9', '-1', '6', '390000', '28', '-1', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:22:12');
INSERT INTO `tb_datostareo_historico` VALUES ('2', '07473313', '-1', '2', '9', '-1', '6', '390000', '28', '5', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:24:32');
INSERT INTO `tb_datostareo_historico` VALUES ('3', '16123862', '11', '2', '9', null, '6', '390000', '11', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:04');
INSERT INTO `tb_datostareo_historico` VALUES ('4', '16123862', '11', '2', '9', null, '6', '390000', '11', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:11');
INSERT INTO `tb_datostareo_historico` VALUES ('5', '16123862', '11', '2', '9', null, '6', '390000', '11', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:12');
INSERT INTO `tb_datostareo_historico` VALUES ('6', '16123862', '11', '2', '9', null, '6', '390000', '11', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:13');
INSERT INTO `tb_datostareo_historico` VALUES ('7', '16123862', '11', '2', '9', '-1', '6', '390000', '11', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:24');
INSERT INTO `tb_datostareo_historico` VALUES ('8', '16123862', '11', '2', '9', '-1', '6', '390000', '11', '4', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:39:36');
INSERT INTO `tb_datostareo_historico` VALUES ('9', '008639724', '9', '2', '11', '-1', '6', '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-20 09:40:52');
INSERT INTO `tb_datostareo_historico` VALUES ('10', '42132408', '9', '3', '9', null, '7', '390000', '8', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '13', '19', '1', '2024-12-20 09:47:08');
INSERT INTO `tb_datostareo_historico` VALUES ('11', '40778235', '9', '3', '9', null, '7', '390000', '9', null, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '13', '19', '1', '2024-12-20 09:47:58');
INSERT INTO `tb_datostareo_historico` VALUES ('12', '008639724', '9', '2', '11', '-1', '6', '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '12', '19', '1', '2024-12-21 10:05:34');
INSERT INTO `tb_datostareo_historico` VALUES ('13', '16123862', '11', '2', '9', '-1', '6', '390000', '11', '4', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', '0', '0', '0', '0', '', '-1', '0000-00-00', '-1', '-1', '19', '1', '2024-12-21 10:57:14');

-- ----------------------------
-- Table structure for `tb_datosterceros`
-- ----------------------------
DROP TABLE IF EXISTS `tb_datosterceros`;
CREATE TABLE `tb_datosterceros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(255) DEFAULT NULL,
  `paterno` varchar(255) DEFAULT NULL,
  `materno` varchar(255) DEFAULT NULL,
  `nombres` varchar(255) DEFAULT NULL,
  `cargo` varchar(255) DEFAULT NULL,
  `sede` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `cut` varchar(255) DEFAULT NULL,
  `sucursal` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `cesado` varchar(255) DEFAULT NULL,
  `nacimiento` date DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ubigeo` varchar(255) DEFAULT NULL,
  `departamento` varchar(255) DEFAULT NULL,
  `provincia` varchar(255) DEFAULT NULL,
  `distrito` varchar(255) DEFAULT NULL,
  `origen` varchar(255) DEFAULT NULL,
  `ingreso` date DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `sangre` varchar(255) DEFAULT NULL,
  `proyecto` varchar(255) DEFAULT NULL,
  `regimen` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `cod_pais` varchar(255) DEFAULT NULL,
  `empresa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_datosterceros
-- ----------------------------
INSERT INTO `tb_datosterceros` VALUES ('1', '10001088', 'FUJIMORI', 'HIGUCHI', 'KEIKO SOFIA', 'D', null, 'ACTIVO', '979887', 'LIMA', 'kfujimori@gmail.com', null, '1990-03-15', 'San Borja', '140140', null, null, null, null, null, '975149289', 'A-', '380000', 'LABORAL', 'PERÚ', null, 'FUERZA POPULAR');
INSERT INTO `tb_datosterceros` VALUES ('2', '74294745', 'VELASQUEZ', 'ROLDAN', 'SAMIR EDUARDO', 'Practicante de Tecnología e Informática', null, 'ACTIVO', '054887', 'LIMA', 'svelasquez@gmail.com', null, '1995-01-07', 'ASOC. SEOR DE LOS MILAGROS', '140109', null, null, null, null, null, '984562178', 'A+', '380000', 'PRACTICANTES', 'PERÚ', null, 'S');
INSERT INTO `tb_datosterceros` VALUES ('3', '04412417', 'VIZCARRA', 'CORNEJO', 'MARTIN ALBERTO', 'PRESIDENTE DEL PERU', null, 'ACTIVO', '013348', 'LIMA', 'vizcarra@gmail.com', null, '1989-02-07', 'av. ferrocarril s/n', '150131', 'LIMA', 'LIMA', 'SAN ISIDRO', null, null, '963852741', 'O+', '020000', 'LABORAL', 'PERÚ', null, 'PARTIDO DEMOCRATICO SOMOS PERU');
INSERT INTO `tb_datosterceros` VALUES ('9', '27427864', 'CASTILLO', 'TERRONES', 'JOSE PEDRO', 'Practicante de Tecnología e Informática', null, 'ACTIVO', null, 'LIMA', 'pcastillo@gmail.com', null, '2024-11-01', 'AV. san borja 445', '150101', null, null, null, null, null, '963852741', 'o+', '020000', 'LABORAL', 'PERÚ', null, 'SEPCON');
INSERT INTO `tb_datosterceros` VALUES ('10', '07845838', 'LOPEZ', 'ALIAGA', 'CAZORLA RAFAEL', 'Practicante de Tecnología e Informática', null, 'ACTIVO', null, 'LIMA', 'rlopez@gmail.com', null, '1982-03-11', 'AV. san borja 445', null, null, null, null, null, null, '999999999', 'O+', '020000', 'LABORAL', 'PERÚ', null, 'RENOVACION POPULAR');
INSERT INTO `tb_datosterceros` VALUES ('24', '06256217', 'BOLUARTE', 'ZEGARRA', 'DINA ERCILIA', 'Desarrollador de Sistemas', null, 'ACTIVO', null, 'LIMA', 'dboluarte@gmail.com', null, '1979-03-15', 'san borja', null, 'LIMA', 'LIMA', 'SAN BORJA', null, null, '777888999', 'O+', '020000', 'LABORAL', 'PERÚ', null, 'PERU LIBRE');

-- ----------------------------
-- Table structure for `tb_encargadoproyectos`
-- ----------------------------
DROP TABLE IF EXISTS `tb_encargadoproyectos`;
CREATE TABLE `tb_encargadoproyectos` (
  `idencargadoproyecto` int(11) NOT NULL AUTO_INCREMENT,
  `ccodigoproyecto` int(11) NOT NULL,
  `idencargado` int(11) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`idencargadoproyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_encargadoproyectos
-- ----------------------------
INSERT INTO `tb_encargadoproyectos` VALUES ('1', '20000', '1', '2024-12-03 09:51:51', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('2', '20000', '2', '2024-12-03 09:52:02', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('3', '390000', '3', '2024-12-05 10:36:27', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('4', '390000', '4', '2024-12-05 10:40:14', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('5', '390000', '5', '2024-12-05 10:40:28', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('6', '390000', '6', '2024-12-05 10:42:33', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('7', '390000', '8', '2024-12-05 10:45:06', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('8', '390000', '9', '2024-12-05 11:03:35', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('9', '390000', '10', '2024-12-05 11:03:35', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('10', '390000', '11', '2024-12-05 11:39:41', '1');
INSERT INTO `tb_encargadoproyectos` VALUES ('11', '390000', '12', '2024-12-05 11:43:57', '1');

-- ----------------------------
-- Table structure for `tb_encargados`
-- ----------------------------
DROP TABLE IF EXISTS `tb_encargados`;
CREATE TABLE `tb_encargados` (
  `idencargado` int(11) NOT NULL AUTO_INCREMENT,
  `cnumdoc` varchar(20) NOT NULL,
  `cnombres` varchar(50) NOT NULL,
  `capellidopat` varchar(50) NOT NULL,
  `capellidomat` varchar(50) NOT NULL,
  `cnombrecompleto` varchar(255) DEFAULT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idencargado`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_encargados
-- ----------------------------
INSERT INTO `tb_encargados` VALUES ('3', '42132408', 'LUZMERY PAULA', 'CATACORA', 'RAZO', 'LUZMERY PAULA CATACORA RAZO', '2024-12-05 10:35:56', '1');
INSERT INTO `tb_encargados` VALUES ('4', '44823974  ', ' JOSE ENRIQUE', 'COSSIO ', 'LOPEZ', ' JOSE ENRIQUE COSSIO  LOPEZ', '2024-12-05 10:38:27', '1');
INSERT INTO `tb_encargados` VALUES ('5', '40778235  ', 'ANDRES CRISTHIAN', 'BERRU ', 'GUEVARA', 'ANDRES CRISTHIAN BERRU  GUEVARA', '2024-12-05 10:39:44', '1');
INSERT INTO `tb_encargados` VALUES ('6', '008536028', 'ROBERTO', 'ROCA ', 'AVENDAÑO', 'ROBERTO ROCA  AVENDAÑO', '2024-12-05 10:42:18', '1');
INSERT INTO `tb_encargados` VALUES ('7', '43162015  ', 'ALEJANDRO', 'FLORES', ' CARMONA', 'ALEJANDRO FLORES  CARMONA', '2024-12-05 10:44:14', '1');
INSERT INTO `tb_encargados` VALUES ('8', '22297859  ', 'BENIGNO ANTONIO RUPE', 'TIZON ', 'RAMIREZ', 'BENIGNO ANTONIO RUPE TIZON  RAMIREZ', '2024-12-05 10:44:14', '1');
INSERT INTO `tb_encargados` VALUES ('9', '000529179', 'HERNAN', 'QUEVEDO ', 'ROJAS', 'HERNAN QUEVEDO  ROJAS', '2024-12-05 11:02:52', '1');
INSERT INTO `tb_encargados` VALUES ('10', '46605432 ', 'KATHIA GIULIANA', 'ACUÑA ', 'CAMPOS', 'KATHIA GIULIANA ACUÑA  CAMPOS', '2024-12-05 11:02:52', '1');
INSERT INTO `tb_encargados` VALUES ('11', '40423524', 'ELISEO WILFREDO', 'TURPO ', 'CHILE ', 'ELISEO WILFREDO TURPO  CHILE ', '2024-12-05 11:38:54', '1');
INSERT INTO `tb_encargados` VALUES ('12', '21136515', 'ESTHER NANCY', 'SILVESTRE', 'BEJARANO', 'ESTHER NANCY SILVESTRE BEJARANO', '2024-12-05 11:43:36', '1');

-- ----------------------------
-- Table structure for `tb_especialidad`
-- ----------------------------
DROP TABLE IF EXISTS `tb_especialidad`;
CREATE TABLE `tb_especialidad` (
  `idespecialidad` int(11) NOT NULL AUTO_INCREMENT,
  `cespecialidad` varchar(100) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idespecialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_especialidad
-- ----------------------------
INSERT INTO `tb_especialidad` VALUES ('1', 'Operario Mecánico de Mtto. De Equipos Pesados', '2024-12-12 13:53:23', '1');

-- ----------------------------
-- Table structure for `tb_fases`
-- ----------------------------
DROP TABLE IF EXISTS `tb_fases`;
CREATE TABLE `tb_fases` (
  `idfase` int(11) NOT NULL AUTO_INCREMENT,
  `cnombre` text NOT NULL,
  `cdescripcion` text NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idfase`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_fases
-- ----------------------------
INSERT INTO `tb_fases` VALUES ('7', '390001', 'Dirección y Control de Obra', '2024-12-05 10:48:18', '1');
INSERT INTO `tb_fases` VALUES ('8', '390002', 'Recursos Humanos', '2024-12-05 11:05:12', '1');
INSERT INTO `tb_fases` VALUES ('9', '390003', 'Control de Proyectos', '2024-12-05 11:28:11', '1');
INSERT INTO `tb_fases` VALUES ('10', '390004', 'Control de Calidad', '2024-12-06 13:55:40', '1');
INSERT INTO `tb_fases` VALUES ('11', '390005', 'Ingeniería y Topografía', '2024-12-06 13:55:47', '1');
INSERT INTO `tb_fases` VALUES ('12', '390006', 'Mantenimiento de Equipos Mecánicos', '2024-12-06 13:55:57', '1');
INSERT INTO `tb_fases` VALUES ('13', '390007', 'SSMA - Seguridad', '2024-12-05 13:38:37', '1');
INSERT INTO `tb_fases` VALUES ('14', '390008', 'Precom . con', '2024-12-05 13:38:37', '1');
INSERT INTO `tb_fases` VALUES ('15', '390009', 'Soporte de Sistemas', '2024-12-05 13:38:37', '1');
INSERT INTO `tb_fases` VALUES ('16', '390010', 'Almacenes Generales', '2024-12-05 13:38:37', '1');
INSERT INTO `tb_fases` VALUES ('17', '390011', 'Armado de Campamento', '2024-12-06 13:59:53', '1');
INSERT INTO `tb_fases` VALUES ('18', '390012', 'Electricidad e Instrumentación', '2024-12-05 13:41:03', '1');
INSERT INTO `tb_fases` VALUES ('19', '390013', 'Obras Civiles', '2024-12-05 13:41:03', '1');
INSERT INTO `tb_fases` VALUES ('20', '390014', 'Logistica, Operadores y Rigger', '2024-12-10 15:11:09', '1');
INSERT INTO `tb_fases` VALUES ('21', '390015', 'Montaje de Andamios', '2024-12-05 13:44:28', '1');
INSERT INTO `tb_fases` VALUES ('22', '390016', 'Montaje - Soldadura - Piping', '2024-12-05 13:44:28', '1');
INSERT INTO `tb_fases` VALUES ('23', '390017', 'Pruebas Hidrostaticas', '2024-12-05 14:16:19', '1');
INSERT INTO `tb_fases` VALUES ('24', '390018', 'Pintura y Granallado', '2024-12-05 14:16:20', '1');
INSERT INTO `tb_fases` VALUES ('25', '390060', 'Oficina -  Lima', '2024-12-05 14:16:20', '1');
INSERT INTO `tb_fases` VALUES ('26', '390061', 'Almacen Lurin', '2024-12-05 14:16:20', '1');
INSERT INTO `tb_fases` VALUES ('27', '390062', 'Almacen - Pucallpa', '2024-12-05 14:16:20', '1');
INSERT INTO `tb_fases` VALUES ('28', '390063', 'Oficina - Pisco', '2024-12-05 14:52:51', '1');
INSERT INTO `tb_fases` VALUES ('29', '', '', '2024-12-05 14:52:51', '1');

-- ----------------------------
-- Table structure for `tb_parametros`
-- ----------------------------
DROP TABLE IF EXISTS `tb_parametros`;
CREATE TABLE `tb_parametros` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nclase` varchar(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ncod` varchar(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescripcion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_parametros
-- ----------------------------
INSERT INTO `tb_parametros` VALUES ('1', '00', '00', 'CONDICION', '1');
INSERT INTO `tb_parametros` VALUES ('2', '00', '01', 'OBRERO', '1');
INSERT INTO `tb_parametros` VALUES ('3', '00', '02', 'STAFF', '1');
INSERT INTO `tb_parametros` VALUES ('4', '01', '00', 'TERCERO', '1');
INSERT INTO `tb_parametros` VALUES ('5', '01', '00', 'MANO DE OBRA', '1');
INSERT INTO `tb_parametros` VALUES ('6', '01', '01', 'DIRECTA', '1');
INSERT INTO `tb_parametros` VALUES ('7', '01', '02', 'INDIRECTA', '1');
INSERT INTO `tb_parametros` VALUES ('8', '02', '00', 'PERSONAL', '1');
INSERT INTO `tb_parametros` VALUES ('9', '02', '01', 'FORANEO', '1');
INSERT INTO `tb_parametros` VALUES ('10', '02', '02', 'LOCAL', '1');
INSERT INTO `tb_parametros` VALUES ('11', '02', '03', 'EXTRANJERO', '1');
INSERT INTO `tb_parametros` VALUES ('12', '03', '01', 'CIVL', '1');
INSERT INTO `tb_parametros` VALUES ('13', '03', '02', 'COMUN', '1');
INSERT INTO `tb_parametros` VALUES ('14', '04', '01', 'FACILIDADES', '1');
INSERT INTO `tb_parametros` VALUES ('15', '04', '02', 'SOPORTE', '1');
INSERT INTO `tb_parametros` VALUES ('16', '04', '03', 'CIVIL', '1');
INSERT INTO `tb_parametros` VALUES ('17', '04', '04', 'MECANICA', '1');
INSERT INTO `tb_parametros` VALUES ('18', '04', '05', 'E&I', '1');
INSERT INTO `tb_parametros` VALUES ('19', '04', '06', 'DIRECTO', '1');
INSERT INTO `tb_parametros` VALUES ('20', '04', '07', 'INDIRECTO', '1');
INSERT INTO `tb_parametros` VALUES ('21', '05', '01', 'INGRESO', '1');
INSERT INTO `tb_parametros` VALUES ('22', '05', '02', 'PERMISO', '1');
INSERT INTO `tb_parametros` VALUES ('23', '05', '03', 'DESCANSO MEDICO', '1');
INSERT INTO `tb_parametros` VALUES ('24', '05', '04', 'BAJADA PROGRAMADA', '1');
INSERT INTO `tb_parametros` VALUES ('25', '05', '05', 'CESE', '1');
INSERT INTO `tb_parametros` VALUES ('26', '05', '06', 'AMONESTACION', '1');
INSERT INTO `tb_parametros` VALUES ('27', '05', '07', 'VACACIONES', '1');
INSERT INTO `tb_parametros` VALUES ('28', '05', '08', 'OTROS', '1');
INSERT INTO `tb_parametros` VALUES ('29', '06', '01', 'RENUNCIA VOLUNTARIO', '1');
INSERT INTO `tb_parametros` VALUES ('30', '06', '02', 'TERMINO DE OBRA', '1');
INSERT INTO `tb_parametros` VALUES ('31', '06', '03', 'TERMINO DE CONTRATO', '1');
INSERT INTO `tb_parametros` VALUES ('32', '06', '04', 'TERMINO DE FASE', '1');
INSERT INTO `tb_parametros` VALUES ('33', '06', '05', 'ABANDONO DE TRABAJO', '1');

-- ----------------------------
-- Table structure for `tb_proyectofases`
-- ----------------------------
DROP TABLE IF EXISTS `tb_proyectofases`;
CREATE TABLE `tb_proyectofases` (
  `idproyectofase` int(11) NOT NULL AUTO_INCREMENT,
  `ccodigoproyecto` varchar(20) NOT NULL,
  `idfase` int(11) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idproyectofase`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_proyectofases
-- ----------------------------
INSERT INTO `tb_proyectofases` VALUES ('6', '390000', '5', '2024-12-05 10:47:13', '1');
INSERT INTO `tb_proyectofases` VALUES ('7', '390000', '7', '2024-12-05 11:06:19', '1');
INSERT INTO `tb_proyectofases` VALUES ('8', '390000', '8', '2024-12-05 11:06:31', '1');
INSERT INTO `tb_proyectofases` VALUES ('9', '390000', '9', '2024-12-05 11:33:02', '1');
INSERT INTO `tb_proyectofases` VALUES ('10', '390000', '10', '2024-12-05 11:33:46', '1');
INSERT INTO `tb_proyectofases` VALUES ('11', '390000', '11', '2024-12-05 11:33:46', '1');
INSERT INTO `tb_proyectofases` VALUES ('12', '390000', '12', '2024-12-05 11:33:46', '1');
INSERT INTO `tb_proyectofases` VALUES ('13', '390000', '13', '2024-12-05 13:45:33', '1');
INSERT INTO `tb_proyectofases` VALUES ('14', '390000', '14', '2024-12-05 13:45:33', '1');
INSERT INTO `tb_proyectofases` VALUES ('15', '390000', '15', '2024-12-05 13:45:33', '1');
INSERT INTO `tb_proyectofases` VALUES ('16', '390000', '16', '2024-12-05 13:45:33', '1');
INSERT INTO `tb_proyectofases` VALUES ('17', '390000', '17', '2024-12-05 13:45:33', '1');
INSERT INTO `tb_proyectofases` VALUES ('18', '390000', '18', '2024-12-05 13:46:16', '1');
INSERT INTO `tb_proyectofases` VALUES ('19', '390000', '19', '2024-12-05 13:46:16', '1');
INSERT INTO `tb_proyectofases` VALUES ('20', '390000', '20', '2024-12-05 13:46:16', '1');
INSERT INTO `tb_proyectofases` VALUES ('21', '390000', '21', '2024-12-05 13:46:59', '1');
INSERT INTO `tb_proyectofases` VALUES ('22', '390000', '22', '2024-12-05 13:46:59', '1');
INSERT INTO `tb_proyectofases` VALUES ('23', '390000', '23', '2024-12-05 14:17:03', '1');
INSERT INTO `tb_proyectofases` VALUES ('24', '390000', '24', '2024-12-05 14:17:03', '1');
INSERT INTO `tb_proyectofases` VALUES ('25', '390000', '25', '2024-12-05 14:17:03', '1');
INSERT INTO `tb_proyectofases` VALUES ('26', '390000', '26', '2024-12-05 14:17:03', '1');
INSERT INTO `tb_proyectofases` VALUES ('27', '390000', '27', '2024-12-05 14:17:19', '1');
INSERT INTO `tb_proyectofases` VALUES ('28', '390000', '28', '2024-12-05 14:53:09', '1');

-- ----------------------------
-- Table structure for `tb_tareos`
-- ----------------------------
DROP TABLE IF EXISTS `tb_tareos`;
CREATE TABLE `tb_tareos` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `nrodoc` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cproyecto` int(11) DEFAULT NULL,
  `cubicacion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado` varchar(3) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `fingreso` date DEFAULT NULL,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  `fmodificacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `nfgactivo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_tareos
-- ----------------------------
INSERT INTO `tb_tareos` VALUES ('1', '000789910', '20000', 'PISCO', 'd', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('2', '70082701', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('3', '06813229', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('4', '10313207', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('5', '76478671', '20000', 'LIMA ', 'V', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('6', '20036250', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('7', '06708203', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('8', '41667405', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('9', '72890114', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('10', '09680835', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('11', '08934899', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('12', '46067198', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('13', '10751826', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('14', '73830015', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('15', '71932542', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('16', '22284149', '20000', 'PISCO', 'd', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('17', '09383118', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('18', '71942763', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('19', '10281988', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('20', '25608087', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('21', '000853189', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('22', '74174466', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('23', '000458816', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('24', '000692215', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('25', '40802035', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('26', '10634270', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('27', '42778331', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('28', '76640732', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('29', '21301845', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('30', '21276405', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('31', '07038472', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('32', '000821937', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('33', '06097752', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('34', '72306549', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('35', '70613887', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('36', '47425100', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('37', '005982120', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('38', '000148566', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('39', '10307288', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('40', '44660228', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('41', '08165961', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('42', '000435778', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('43', '08488980', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('44', '44068092', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('45', '45077172', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('46', '43281347', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('47', '72701092', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('48', '000685634', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('49', '10712208', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('50', '000540903', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('51', '09619538', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('52', '45882664', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('53', '43095718', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('54', '41310878', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('55', '18217223', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('56', '000809716', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('57', '42284795', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('58', '41095867', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('59', '000426973', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-28 00:00:00', '2024-11-28 00:00:00', '1');
INSERT INTO `tb_tareos` VALUES ('60', '000789910', '20000', 'PISCO', 'M', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('61', '70082701', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('62', '06813229', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('63', '10313207', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('64', '76478671', '20000', 'LIMA ', 'V', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('65', '20036250', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('66', '06708203', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('67', '41667405', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('68', '09680835', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('69', '08934899', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('70', '46067198', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('71', '10751826', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('72', '73830015', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('73', '71932542', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('74', '22284149', '20000', 'PISCO', 'M', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('75', '71942763', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('76', '09383118', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('77', '10281988', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('78', '25608087', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('79', '000853189', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('80', '74174466', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('81', '000458816', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('82', '000692215', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('83', '40802035', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('84', '10634270', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('85', '42778331', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('86', '21276405', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('87', '21301845', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('88', '07038472', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('89', '000821937', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('90', '06097752', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('91', '72306549', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('92', '47425100', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('93', '005982120', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('94', '000148566', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('95', '10307288', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('96', '44660228', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('97', '08165961', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('98', '000435778', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:43', '2024-11-29 15:01:43', '1');
INSERT INTO `tb_tareos` VALUES ('99', '08488980', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('100', '44068092', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('101', '45077172', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('102', '43281347', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('103', '72701092', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('104', '000685634', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('105', '10712208', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('106', '000540903', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('107', '09619538', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('108', '45882664', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('109', '43095718', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('110', '41310878', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('111', '18217223', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('112', '000809716', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('113', '42284795', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('114', '41095867', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('115', '000426973', '20000', 'LIMA ', 'A', '11', '2024', '0000-00-00', null, '2024-11-29 15:01:44', '2024-11-29 15:01:44', '1');
INSERT INTO `tb_tareos` VALUES ('116', '000789910', '20000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('117', '70082701', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('118', '06813229', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('119', '10313207', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('120', '76478671', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('121', '20036250', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('122', '06708203', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('123', '41667405', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('124', '09680835', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('125', '08934899', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('126', '46067198', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('127', '10751826', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('128', '73830015', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('129', '71932542', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('130', '22284149', '20000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('131', '71942763', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('132', '09383118', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('133', '10281988', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('134', '25608087', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('135', '000853189', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('136', '74174466', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('137', '000458816', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('138', '000692215', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('139', '40802035', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('140', '10634270', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('141', '42778331', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('142', '21276405', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('143', '21301845', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('144', '07038472', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('145', '000821937', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('146', '06097752', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('147', '72306549', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('148', '47425100', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('149', '005982120', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('150', '000148566', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('151', '10307288', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('152', '44660228', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('153', '08165961', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('154', '000435778', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('155', '08488980', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('156', '44068092', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('157', '45077172', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('158', '43281347', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('159', '72701092', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('160', '000685634', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('161', '10712208', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('162', '000540903', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('163', '09619538', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('164', '45882664', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('165', '43095718', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('166', '41310878', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('167', '18217223', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('168', '000809716', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('169', '42284795', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('170', '41095867', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('171', '000426973', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-02 10:38:28', '2024-12-02 10:38:28', '1');
INSERT INTO `tb_tareos` VALUES ('172', '47960091', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('173', '46605432', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('174', '40778235', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('175', '42132408', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:13:54', '1');
INSERT INTO `tb_tareos` VALUES ('176', '72890114', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('177', '44823974', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('178', '16123862', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('179', '72654693', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('180', '41929321', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('181', '43162015', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('182', '46078454', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('183', '43164161', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('184', '45711527', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('185', '70613887', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('186', '03897077', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('187', '41090322', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('188', '44085611', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('189', '72433532', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('190', '008536028', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('191', '76742784', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('192', '42743571', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('193', '43563747', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('194', '21136515', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:44', '2024-12-05 11:11:44', '1');
INSERT INTO `tb_tareos` VALUES ('195', '22297859', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:45', '2024-12-05 11:12:01', '1');
INSERT INTO `tb_tareos` VALUES ('196', '40423524', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:45', '2024-12-05 11:11:45', '1');
INSERT INTO `tb_tareos` VALUES ('197', '46831991', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:45', '2024-12-05 11:11:45', '1');
INSERT INTO `tb_tareos` VALUES ('198', '008640258', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-05 11:11:45', '2024-12-05 11:11:45', '1');
INSERT INTO `tb_tareos` VALUES ('199', '47960091', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:14', '2024-12-06 09:37:14', '1');
INSERT INTO `tb_tareos` VALUES ('200', '46605432', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:14', '2024-12-06 09:37:14', '1');
INSERT INTO `tb_tareos` VALUES ('201', '40778235', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:14', '2024-12-06 09:37:14', '1');
INSERT INTO `tb_tareos` VALUES ('202', '42132408', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:14', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('203', '72890114', '390000', 'LIMA ', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('204', '44823974', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('205', '16123862', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:37:15', '1');
INSERT INTO `tb_tareos` VALUES ('206', '72654693', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:37:15', '1');
INSERT INTO `tb_tareos` VALUES ('207', '41929321', '390000', 'PUCALLPA', 'PU', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('208', '43162015', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('209', '46078454', '390000', 'PUCALLPA', 'PU', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('210', '43164161', '390000', 'PUCALLPA', 'PU', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('211', '45711527', '390000', 'PUCALLPA', 'PU', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('212', '70613887', '390000', 'LIMA ', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('213', '03897077', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('214', '41090322', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('215', '44085611', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:37:15', '1');
INSERT INTO `tb_tareos` VALUES ('216', '72433532', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:37:15', '1');
INSERT INTO `tb_tareos` VALUES ('217', '008536028', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('218', '76742784', '390000', 'LIMA ', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('219', '42743571', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('220', '43563747', '390000', 'PUCALLPA', 'PU', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('221', '21136515', '390000', 'PISCO', 'PI', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('222', '22297859', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:37:15', '1');
INSERT INTO `tb_tareos` VALUES ('223', '40423524', '390000', 'LIMA ', 'PI', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('224', '46831991', '390000', 'LIMA ', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('225', '008640258', '390000', 'NUEVO MUNDO', 'L', '12', '2024', '0000-00-00', null, '2024-12-06 09:37:15', '2024-12-06 09:43:00', '1');
INSERT INTO `tb_tareos` VALUES ('226', '000789910', '20000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('227', '70082701', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('228', '06813229', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('229', '10313207', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('230', '76478671', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('231', '20036250', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('232', '06708203', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('233', '41667405', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('234', '72890114', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('235', '09680835', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('236', '08934899', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('237', '46067198', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('238', '10751826', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('239', '73830015', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('240', '71932542', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('241', '22284149', '20000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('242', '09383118', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('243', '71942763', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:51', '2024-12-16 14:14:51', '1');
INSERT INTO `tb_tareos` VALUES ('244', '10281988', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('245', '25608087', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('246', '000853189', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('247', '74174466', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('248', '000458816', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('249', '000692215', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('250', '40802035', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('251', '10634270', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('252', '42778331', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('253', '21276405', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('254', '21301845', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('255', '07038472', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('256', '000821937', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('257', '06097752', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('258', '72306549', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('259', '70613887', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('260', '47425100', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('261', '005982120', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('262', '000148566', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('263', '10307288', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('264', '44660228', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('265', '08165961', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('266', '000435778', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('267', '08488980', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('268', '44068092', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('269', '45077172', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('270', '43281347', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('271', '72701092', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('272', '000685634', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('273', '10712208', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('274', '000540903', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('275', '09619538', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('276', '45882664', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('277', '43095718', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('278', '41310878', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('279', '18217223', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('280', '000809716', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('281', '42284795', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('282', '41095867', '20000', 'LIMA ', 'D', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('283', '000426973', '20000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-16 14:14:52', '2024-12-16 14:14:52', '1');
INSERT INTO `tb_tareos` VALUES ('284', '47960091', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:31', '2024-12-20 09:37:31', '1');
INSERT INTO `tb_tareos` VALUES ('285', '46605432', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:31', '2024-12-20 09:37:31', '1');
INSERT INTO `tb_tareos` VALUES ('286', '70055164', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:31', '2024-12-20 09:37:31', '1');
INSERT INTO `tb_tareos` VALUES ('287', '40778235', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:31', '2024-12-20 09:37:31', '1');
INSERT INTO `tb_tareos` VALUES ('288', '42132408', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:31', '2024-12-20 09:37:31', '1');
INSERT INTO `tb_tareos` VALUES ('289', '07473313', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('290', '44823974', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('291', '42363352', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('292', '16123862', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('293', '72654693', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('294', '41929321', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('295', '43162015', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('296', '40908346', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('297', '41413571', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('298', '46078454', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('299', '43164161', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('300', '43178225', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('301', '45711527', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('302', '03897077', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('303', '008639724', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('304', '41090322', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('305', '44085611', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('306', '15855546', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('307', '22308082', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('308', '72433532', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('309', '008536028', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('310', '76742784', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('311', '42743571', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('312', '43563747', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('313', '21136515', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('314', '22297859', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('315', '40423524', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('316', '25849265', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('317', '46831991', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('318', '008640258', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-20 09:37:32', '2024-12-20 09:37:32', '1');
INSERT INTO `tb_tareos` VALUES ('319', '47960091', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('320', '46605432', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('321', '70055164', '390000', 'LIMA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('322', '40778235', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('323', '42132408', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('324', '07473313', '390000', 'LIMA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('325', '44823974', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('326', '42363352', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('327', '16123862', '390000', 'DESCANSO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('328', '72654693', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('329', '41929321', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('330', '43162015', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('331', '40908346', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('332', '41413571', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('333', '46078454', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('334', '43164161', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('335', '43178225', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('336', '45711527', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('337', '03897077', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:33', '2024-12-21 10:50:33', '1');
INSERT INTO `tb_tareos` VALUES ('338', '008639724', '390000', 'LIMA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('339', '41090322', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('340', '44085611', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('341', '15855546', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('342', '22308082', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('343', '72433532', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('344', '008536028', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('345', '76742784', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('346', '42743571', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('347', '43563747', '390000', 'PUCALLPA', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('348', '21136515', '390000', 'PISCO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('349', '22297859', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('350', '40423524', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('351', '25849265', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('352', '46831991', '390000', 'LIMA ', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');
INSERT INTO `tb_tareos` VALUES ('353', '008640258', '390000', 'NUEVO MUNDO', 'A', '12', '2024', '0000-00-00', null, '2024-12-21 10:50:34', '2024-12-21 10:50:34', '1');

-- ----------------------------
-- Table structure for `tb_ubicacion`
-- ----------------------------
DROP TABLE IF EXISTS `tb_ubicacion`;
CREATE TABLE `tb_ubicacion` (
  `idubicacion` int(11) NOT NULL AUTO_INCREMENT,
  `cubicacion` varchar(50) NOT NULL,
  `fregesys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tb_ubicacion
-- ----------------------------
INSERT INTO `tb_ubicacion` VALUES ('1', 'NUEVO MUNDO', '2024-12-12 13:51:41', '1');
INSERT INTO `tb_ubicacion` VALUES ('2', 'PISCO', '2024-12-12 13:52:08', '1');
INSERT INTO `tb_ubicacion` VALUES ('3', 'PUCALLPA', '2024-12-12 13:52:08', '1');
INSERT INTO `tb_ubicacion` VALUES ('4', 'DESCANSO', '2024-12-12 13:52:26', '1');
INSERT INTO `tb_ubicacion` VALUES ('5', 'LIMA', '2024-12-12 13:52:37', '1');

-- ----------------------------
-- Table structure for `tm_userproyectos`
-- ----------------------------
DROP TABLE IF EXISTS `tm_userproyectos`;
CREATE TABLE `tm_userproyectos` (
  `idreg` int(11) NOT NULL AUTO_INCREMENT,
  `cdocumento` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ccodigo` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescripcion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idreg`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tm_userproyectos
-- ----------------------------
INSERT INTO `tm_userproyectos` VALUES ('1', '20036250', '020000', 'ADMINISTRACION DE OFICINA / Sede Lima', '2024-08-11 17:55:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('2', '20036250', '390000', 'EPC RECAPEX II', '2024-08-11 17:55:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('3', '42132408', '390000', 'EPC RECAPEX II', '2024-08-11 18:00:04', '1');
INSERT INTO `tm_userproyectos` VALUES ('4', '76478671', '020000', 'ADMINISTRACION DE OFICINA / Sede Lima', '2024-10-23 09:24:58', '1');
INSERT INTO `tm_userproyectos` VALUES ('5', '76478671', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-10-23 09:26:44', '1');
INSERT INTO `tm_userproyectos` VALUES ('6', '76478671', '340000', 'SERV. REEMPLAZO DE AISLAMIENTO TÉRMICO Y RECUPERACION DE ESPESOR POR SOLDADURA EN CRIOGÉNICAS 3,4Y5', '2024-10-23 09:37:13', '1');
INSERT INTO `tm_userproyectos` VALUES ('7', '00000000', '380000', 'EPC INSTALACIÓN DE PANTALLAS DE PILOTES EN LOCACIÓN KINTERONI', '2024-10-24 14:11:36', '1');
INSERT INTO `tm_userproyectos` VALUES ('8', '00000000', '350000', 'EPC PLANTA DE COMPRESION MIPAYA L56', '2024-10-24 14:11:47', '1');
INSERT INTO `tm_userproyectos` VALUES ('9', '41667546', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-04 12:09:10', '1');
INSERT INTO `tm_userproyectos` VALUES ('10', '76478671', '380000', 'EPC INSTALACIÓN DE PANTALLAS DE PILOTES EN LOCACIÓN KINTERONI', '2024-11-05 08:20:51', '1');
INSERT INTO `tm_userproyectos` VALUES ('11', '76478671', '050000', 'SEDE PISCO', '2024-11-05 09:33:00', '0');
INSERT INTO `tm_userproyectos` VALUES ('12', '20036250', '350000', 'EPC PLANTA DE COMPRESION MIPAYA L56', '2024-11-07 10:24:53', '1');
INSERT INTO `tm_userproyectos` VALUES ('13', '42132408', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('14', '42132408', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('15', '42132408', '390000', 'EPC RECAPEX II', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('16', '70566358', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('17', '70566358', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('18', '27690290', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('19', '78720030', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('20', '76175725', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('21', '71972542', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('22', '43856063', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('23', '43856063', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('24', '43856063', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('25', '43856063', '060000', 'ALMACENES / Sede Pucallpa', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('26', '43856063', '030000', 'MANTENIMIENTO MECÁNICO / Sede Pucallpa', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('27', '111111', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('28', '111111', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('29', '111111', '390000', 'EPC RECAPEX II', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('30', '111111', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('31', '111111', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('32', '111111', '060000', 'ALMACENES / Sede Pucallpa', '2024-11-11 11:02:01', '1');
INSERT INTO `tm_userproyectos` VALUES ('33', '111111', '030000', 'MANTENIMIENTO MECÁNICO / Sede Pucallpa', '2024-11-11 11:02:01', '1');

-- ----------------------------
-- Procedure structure for `getEstadosColaborador`
-- ----------------------------
DROP PROCEDURE IF EXISTS `getEstadosColaborador`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEstadosColaborador`(IN `doc_num` VARCHAR(20))
BEGIN
-- Eliminar la tabla temporal si ya existe
DROP TEMPORARY TABLE IF EXISTS temporal_table;
DROP TEMPORARY TABLE IF EXISTS temporal_dates;

-- Definir el rango de fechas
-- SET @fechamin = (SELECT DATE(MIN(fregsys)) FROM tb_tareos WHERE nrodoc = doc_num);
-- SET @fechamax = (SELECT DATE(MAX(fregsys)) FROM tb_tareos WHERE nrodoc = doc_num);
SET @fechamin = COALESCE((SELECT DATE(MIN(fregsys)) FROM tb_tareos WHERE nrodoc = doc_num), CURDATE());
set @fechamax= (select DATE(MAX(fregsys)) from tb_tareos);

-- Verificar que las fechas no sean NULL al momento de crear las tablas temporales
-- Si @fechamin y @fechamax no son NULL, continúa con la creación de las tablas

-- Crear tabla temporal con fechas intermedias solo si @fechamin y @fechamax no son NULL
CREATE TEMPORARY TABLE IF NOT EXISTS temporal_dates AS
SELECT CAST(date_field AS DATE) AS date_field
FROM (
    WITH RECURSIVE date_range AS (
        SELECT @fechamin AS date_field
        UNION ALL
        SELECT DATE_ADD(date_field, INTERVAL 1 DAY)
        FROM date_range
        WHERE DATE_ADD(date_field, INTERVAL 1 DAY) <= @fechamax
    )
    SELECT date_field
    FROM date_range
) AS temp
WHERE @fechamin IS NOT NULL AND @fechamax IS NOT NULL;

-- Crear tabla temporal con los datos de tb_tareos y las fechas generadas solo si las fechas no son NULL
CREATE TEMPORARY TABLE IF NOT EXISTS temporal_table AS
SELECT td.date_field, 
       COALESCE(t.nrodoc, doc_num) AS nrodoc,
       COALESCE(t.estado, 'A') AS estado -- Si no hay datos en tb_tareos, asigna 'A'
FROM temporal_dates td
LEFT JOIN tb_tareos t ON DATE(t.fregsys) = td.date_field AND t.nrodoc = doc_num;

-- Consultar los resultados solo si las fechas no son NULL
SELECT * 
FROM temporal_table
WHERE @fechamin IS NOT NULL AND @fechamax IS NOT NULL
ORDER BY date_field;
END
;;
DELIMITER ;
