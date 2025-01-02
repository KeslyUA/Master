-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-01-2025 a las 21:05:53
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `masterwork`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEstadosColaborador` (IN `doc_num` VARCHAR(20))  BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cm_users`
--

CREATE TABLE `cm_users` (
  `idreg` int(11) NOT NULL,
  `cusername` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cuserpass` varchar(250) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cuserdoc` varchar(20) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cusermail` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1,
  `freg` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `cm_users`
--

INSERT INTO `cm_users` (`idreg`, `cusername`, `cuserpass`, `cuserdoc`, `cusermail`, `nflgactivo`, `freg`) VALUES
(1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', '20036250', 'carroyo@sepcon.net', 1, '2024-11-07 15:56:44'),
(2, 'lcatacora', '75a0f3342a2fbcbe1254fa8d49b31cefadd630ec', '42132408', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(3, 'rari', 'e2f6ade5854bb9988360fb232c55998507688780', '76478671', 'rari@sepcon.net', 2, '2024-11-27 13:55:35'),
(4, 'invitado', '0c0438a2d770051789cbafdd47fe25a9d7f74587', '00000000', 'invitado', 1, '2024-10-24 19:10:12'),
(5, 'fquicana', 'df19ef3b0d0b16c91e28f7e53ca8687529e96e3e', '41667546', 'felimonjose@gmail.com', 1, '2024-11-11 19:23:53'),
(8, 'alujan', 'e3b39a53542820ba6db569dd2c9ab71e03406bf7', '70566358', '@sepcon.net', 1, '2024-11-11 15:25:56'),
(9, 'egamarra', '89ddeabe87c653d60ee115afdbc19156b44c1d0a', '27690290', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(10, 'jcuello', 'c872676f6664374c512e9bcf2714ea210193d1f7', '78720030', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(11, 'jsaavedra', '6413b38fe61fef3e8bd99f608c1d2cada1a46702', '76175725', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(12, 'lgutierrez', 'c81d6266a2989b250582af63e0db863f42caf121', '71972542', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(13, 'allaque', '2e3d152df4664eb45c3215a57159b3e900ea3b01', '43856063', '@sepcon.net', 1, '2024-11-11 19:23:53'),
(14, 'adminrrhh', '6ca6f27ca3a9a0318b5e5ff5eac02ad7fc988cc5', '111111', '@sepcon.net', 1, '2024-11-11 16:06:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_datostareo`
--

CREATE TABLE `tb_datostareo` (
  `idreg` int(11) NOT NULL,
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
  `fregsys` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tb_datostareo`
--

INSERT INTO `tb_datostareo` (`idreg`, `nddoc`, `cencargado`, `ncondicion`, `npersonal`, `cespecialidad`, `nmanoobra`, `cproyecto`, `cfase`, `cubicacion`, `cregimen`, `fingreso`, `fsalida`, `fretorno`, `dgoce`, `dlibre`, `dcampo`, `dreales`, `cobservaciones`, `cdescanso`, `fcese`, `cmotivocese`, `nregimen`, `nespecificacion`, `nflgactivo`, `fregsys`) VALUES
(1, '76478671', '-1', 3, 10, '-1', 7, '020000', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-03 14:15:01'),
(2, '04412417', '2', 3, 10, 'DESARROLLO DE SISTEMAS', 7, '020000', '1', 'LIMA', '2x1', '2024-12-03', '2024-12-17', '0000-00-00', 7, 0, 14, 0, 'observaciones de prueba teceros', 24, '0000-00-00', 29, 13, 17, 1, '2024-12-03 15:54:28'),
(3, '42132408', '9', 3, 9, NULL, 7, '390000', '8', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 13, 19, 1, '2024-12-05 16:08:25'),
(4, '000789910', '9', 3, 11, 'GERENTE DE CONSTRUCCION', 7, '390000', '-1', 'NUEVO MUNDO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, -1, 1, '2024-12-05 16:18:57'),
(5, '008640258', '9', 3, 11, '-1', 7, '390000', '7', '-1', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:20:44'),
(6, '40778235', '9', 3, 9, NULL, 7, '390000', '9', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 13, 19, 1, '2024-12-05 16:27:23'),
(7, '40778235', '9', 3, 9, NULL, 7, '390000', '9', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 13, 19, 1, '2024-12-05 16:27:41'),
(8, '47960091', '4', 3, 9, 'Inspector de SSMA', 7, '390000', '13', 'NUEVO MUNDO', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:50:40'),
(9, '46605432', '9', 3, 9, 'Supervisor de Obras Civiles', 7, '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:56:29'),
(10, '46605432', '9', 3, 9, 'Supervisor de Obras Civiles', 7, '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:56:42'),
(11, '46605432', '9', 3, 9, 'Supervisor de Obras Civiles', 7, '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:56:47'),
(12, '46605432', '9', 3, 9, 'Supervisor de Obras Civiles', 7, '390000', '19', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 16:56:54'),
(13, '72890114', '3', 3, 9, 'Asistente de RR.HH. ', 7, '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:00:01'),
(14, '44823974', '9', 3, 9, 'Jefe de SSMA', 7, '390000', '13', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:06:10'),
(15, '16123862', '11', 2, 9, '-1', 6, '390000', '11', '4', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:09:56'),
(16, '72654693', '9', 2, 9, 'Peón', 6, '390000', '27', 'PUCALLPA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:13:48'),
(17, '41929321', '9', 2, 9, 'Operario Mecánico de Mtto. de Equipos Pesados', 6, '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:15:22'),
(18, '43162015', '9', 3, 9, 'Coordinador Eléctrico e Instrumentista', 6, '390000', '18', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 17:21:57'),
(19, '46078454', '9', 2, 9, 'Operario Mecánico de Mtto. de Equipos Pesados', 6, '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:27:21'),
(20, '43164161', '9', 2, 9, '-1', 6, '390000', '27', '-1', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:28:34'),
(21, '45711527', '9', 2, 9, 'Operario Mecánico de Mtto. de Equipos Pesados', 6, '390000', '27', 'PUCALLPA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:33:49'),
(22, '70613887', '-1', 3, 9, '-1', 7, '390000', '-1', '-1', '6X1', '2024-12-13', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:35:39'),
(23, '03897077', '9', 3, 9, 'Coordinador de Logística', 7, '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:36:55'),
(24, '41090322', '9', 3, 9, 'Asistente de Tecnología e Informática', 7, '390000', '15', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:39:22'),
(25, '44085611', '11', 2, 9, 'Oficial de Topografía', 6, '390000', '11', 'NUEVO MUNDO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:40:32'),
(26, '72433532', '11', 2, 9, 'Oficial de Topografía', 7, '390000', '11', 'NUEVO MUNDO', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:42:25'),
(27, '008536028', '9', 3, 11, 'Jefe de QA/QC', 7, '390000', '10', 'LIMA', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:43:38'),
(28, '76742784', '9', 3, 9, 'Asistente de Compras', 7, '390000', '25', 'LIMA', '6X1', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:46:53'),
(29, '42743571', '4', 3, 9, 'Enfermero Ocupacional', 7, '390000', '13', 'LIMA', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:48:00'),
(30, '43563747', '9', 3, 9, 'Auxiliar de Logística', -1, '390000', '25', 'PUCALLPA', '6X1', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:49:07'),
(31, '21136515', '9', 3, 9, 'Jefe de Almacén', 7, '390000', '28', 'PISCO', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:52:03'),
(32, '22297859', '9', 3, 9, 'Supervisor de Armado de Campamento', 7, '390000', '17', 'LIMA', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:55:12'),
(33, '40423524', '9', 3, 9, 'Jefe de Oficina Técnica', 7, '390000', '11', 'LIMA', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:56:34'),
(34, '46831991', '9', 3, 9, 'Asistente de Logística', 7, '390000', '25', 'LIMA', '6X1', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-05 19:58:14'),
(35, '42363352', '12', 2, 9, 'Operario Pintor Civil', 6, '390000', '16', 'PISCO', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-06 13:55:12'),
(36, '41413571', '12', 2, 9, 'Operario de Almacén', 6, '390000', '16', 'PISCO', '14X7', '2024-12-06', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, -1, 1, '2024-12-06 13:56:32'),
(37, '25849265', '9', 3, 9, 'Coordinador de Logística', 7, '390000', '20', 'NUEVO MUNDO', '14X7', '2024-12-10', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-10 15:18:56'),
(38, '07473313', '-1', 2, 9, '-1', 6, '390000', '28', '5', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-10 16:19:55'),
(39, '15855546', '9', 3, 9, 'Coordinador de Logística', 7, '390000', '28', 'PISCO', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-10 16:26:43'),
(40, '22308082', '9', 2, 9, 'Operario Rigger', 6, '390000', '28', 'PISCO', '6X1', '2024-12-10', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-10 20:35:50'),
(41, '43178225', '9', 2, 9, '1', 6, '390000', '27', '3', '14X7', '2024-12-12', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-12 18:51:05'),
(42, '40908346', '12', 2, 9, '-1', 6, '390000', '16', '1', '14X7', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-17 20:34:22'),
(43, '70055164', '9', 2, 9, '-1', 6, '390000', '26', '5', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-18 21:14:18'),
(44, '008639724', '9', 2, 11, '-1', 6, '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 12, 19, 1, '2024-12-20 14:40:52'),
(52, '07845838', '11', 2, 10, '1', 6, '390000', '25', '5', '2x1', '2024-12-26', '2024-12-31', '2025-01-02', 2, 0, 5, 0, 'dadsadasda', -1, '0000-00-00', -1, 12, 14, 1, '2024-12-26 14:40:51'),
(56, '27427864', '-1', 2, 9, '1', 7, '020000', '-1', '2', '28/7', '2024-12-26', '2024-12-31', '2025-01-01', 1, 0, 5, 0, 'hoh', -1, '0000-00-00', 29, 12, 18, 1, '2024-12-26 14:51:03'),
(57, '43523880', '-1', 3, 10, '1', 6, '060000', '-1', '-1', '', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, -1, 1, '2024-12-30 16:47:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_datostareo_historico`
--

CREATE TABLE `tb_datostareo_historico` (
  `idreg` int(11) NOT NULL,
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
  `fregsys` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tb_datostareo_historico`
--

INSERT INTO `tb_datostareo_historico` (`idreg`, `nddoc`, `cencargado`, `ncondicion`, `npersonal`, `cespecialidad`, `nmanoobra`, `cproyecto`, `cfase`, `cubicacion`, `cregimen`, `fingreso`, `fsalida`, `fretorno`, `dgoce`, `dlibre`, `dcampo`, `dreales`, `cobservaciones`, `cdescanso`, `fcese`, `cmotivocese`, `nregimen`, `nespecificacion`, `nflgactivo`, `fregsys`) VALUES
(1, '07473313', '12', 2, 9, '-1', 6, '390000', '28', '-1', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:22:12'),
(2, '07473313', '-1', 2, 9, '-1', 6, '390000', '28', '5', '6X1', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:24:32'),
(3, '16123862', '11', 2, 9, NULL, 6, '390000', '11', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:04'),
(4, '16123862', '11', 2, 9, NULL, 6, '390000', '11', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:11'),
(5, '16123862', '11', 2, 9, NULL, 6, '390000', '11', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:12'),
(6, '16123862', '11', 2, 9, NULL, 6, '390000', '11', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:13'),
(7, '16123862', '11', 2, 9, '-1', 6, '390000', '11', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:24'),
(8, '16123862', '11', 2, 9, '-1', 6, '390000', '11', '4', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:39:36'),
(9, '008639724', '9', 2, 11, '-1', 6, '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-20 14:40:52'),
(10, '42132408', '9', 3, 9, NULL, 7, '390000', '8', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 13, 19, 1, '2024-12-20 14:47:08'),
(11, '40778235', '9', 3, 9, NULL, 7, '390000', '9', NULL, '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 13, 19, 1, '2024-12-20 14:47:58'),
(12, '008639724', '9', 2, 11, '-1', 6, '390000', '12', '5', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, 12, 19, 1, '2024-12-21 15:05:34'),
(13, '16123862', '11', 2, 9, '-1', 6, '390000', '11', '4', '14X7', '2024-11-19', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-21 15:57:14'),
(14, '43164161', '9', 2, 10, NULL, 6, '390000', '27', NULL, '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-23 16:12:29'),
(15, '43164161', '9', 2, 10, NULL, 6, '390000', '27', NULL, '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-23 16:12:30'),
(16, '43164161', '9', 2, 10, NULL, 6, '390000', '27', NULL, '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-23 16:12:31'),
(17, '43164161', '9', 2, 10, '-1', 6, '390000', '27', '-1', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-23 16:12:42'),
(18, '43164161', '9', 2, 9, '-1', 6, '390000', '27', '-1', '6X1', '0000-00-00', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-23 16:14:17'),
(19, '76478671', '8', 3, 10, '1', 7, '390000', '27', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 15:19:32'),
(20, '76478671', '-1', 3, 10, '1', 7, '-1', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 15:35:59'),
(21, '76478671', '-1', 3, 10, '1', 7, '-1', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 15:35:59'),
(22, '76478671', '-1', 3, 10, '1', 7, '390000', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 15:41:03'),
(23, '76478671', '9', 3, 10, '1', 7, '390000', '23', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 15:41:25'),
(24, '76478671', '-1', 3, 10, '1', 7, '-1', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 16:04:49'),
(25, '76478671', '6', 3, 10, '1', 7, '390000', '25', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-26 16:08:27'),
(26, '008640258', '9', 3, 11, '-1', 7, '390000', '7', '-1', '14X7', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-27 19:58:30'),
(27, '008640258', '9', 3, 11, '-1', 7, '390000', '7', '-1', '14X7', '2024-12-23', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-27 20:00:02'),
(28, '008640258', '9', 3, 11, '-1', 7, '390000', '7', '-1', '14X7', '2024-12-23', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-27 20:00:02'),
(29, '008640258', '9', 3, 11, '-1', 7, '390000', '7', '-1', '14X7', '2024-12-05', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, 19, 1, '2024-12-27 20:01:13'),
(30, '76478671', '-1', 3, 10, '-1', 7, '020000', '-1', '3', '2x1', '0000-00-00', '2024-12-10', '0000-00-00', 3, 0, 7, 0, 'observacion prueba', 23, '0000-00-00', -1, 12, 16, 1, '2024-12-30 16:32:23'),
(31, '43523880', '-1', 3, 10, '1', 6, '060000', '-1', '-1', '', '2024-12-20', '0000-00-00', '0000-00-00', 0, 0, 0, 0, '', -1, '0000-00-00', -1, -1, -1, 1, '2024-12-30 16:47:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_datosterceros`
--

CREATE TABLE `tb_datosterceros` (
  `id` int(11) NOT NULL,
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
  `iniContrato` date DEFAULT NULL,
  `finContrato` date DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `sangre` varchar(255) DEFAULT NULL,
  `proyecto` varchar(255) DEFAULT NULL,
  `regimen` varchar(255) DEFAULT NULL,
  `pais` varchar(255) DEFAULT NULL,
  `cod_pais` varchar(255) DEFAULT NULL,
  `empresa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_datosterceros`
--

INSERT INTO `tb_datosterceros` (`id`, `dni`, `paterno`, `materno`, `nombres`, `cargo`, `sede`, `estado`, `cut`, `sucursal`, `correo`, `cesado`, `nacimiento`, `direccion`, `ubigeo`, `departamento`, `provincia`, `distrito`, `origen`, `ingreso`, `iniContrato`, `finContrato`, `telefono`, `sangre`, `proyecto`, `regimen`, `pais`, `cod_pais`, `empresa`) VALUES
(1, '10001088', 'FUJIMORI', 'HIGUCHI', 'KEIKO SOFIA', 'D', NULL, 'ACTIVO', '979887', 'LIMA', 'kfujimori@gmail.com', NULL, '1990-03-15', 'San Borja', '140140', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '975149289', 'A-', '380000', 'LABORAL', 'PERÚ', NULL, 'FUERZA POPULAR'),
(2, '74294745', 'VELASQUEZ', 'ROLDAN', 'SAMIR EDUARDO', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', '054887', 'LIMA', 'svelasquez@gmail.com', NULL, '1995-01-07', 'ASOC. SEOR DE LOS MILAGROS', '140109', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '984562178', 'A+', '380000', 'PRACTICANTES', 'PERÚ', NULL, 'S'),
(3, '04412417', 'VIZCARRA', 'CORNEJO', 'MARTIN ALBERTO', 'PRESIDENTE DEL PERU', NULL, 'ACTIVO', '013348', 'LIMA', 'vizcarra@gmail.com', NULL, '1989-02-07', 'av. ferrocarril s/n', '150131', 'LIMA', 'LIMA', 'SAN ISIDRO', NULL, NULL, NULL, NULL, '963852741', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'PARTIDO DEMOCRATICO SOMOS PERU'),
(9, '27427864', 'CASTILLO', 'TERRONES', 'JOSE PEDRO', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', '000197', 'LIMA', 'pcastillo@gmail.com', NULL, '2024-11-01', 'AV. san borja 445', '150101', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '963852741', 'o+', '020000', 'LABORAL', 'PERÚ', NULL, 'SEPCON'),
(10, '07845838', 'LOPEZ', 'ALIAGA', 'CAZORLA RAFAEL', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', '000152', 'LIMA', 'rlopez@gmail.com', NULL, '1982-03-11', 'AV. san borja 445', NULL, 'LIMA', 'LIMA', 'SAN BORJA', NULL, '2024-12-14', '2024-12-14', '2024-12-31', '999999999', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'RENOVACION POPULAR'),
(24, '06256217', 'BOLUARTE', 'ZEGARRA', 'DINA ERCILIA', 'Desarrollador de Sistemas', NULL, 'ACTIVO', NULL, 'LIMA', 'dboluarte@gmail.com', NULL, '1979-03-15', 'san borja', NULL, 'LIMA', 'LIMA', 'SAN BORJA', NULL, NULL, NULL, NULL, '777888999', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'PERU LIBRE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_encargadoproyectos`
--

CREATE TABLE `tb_encargadoproyectos` (
  `idencargadoproyecto` int(11) NOT NULL,
  `ccodigoproyecto` int(11) NOT NULL,
  `idencargado` int(11) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) DEFAULT 1,
  `updatedBy` varchar(100) DEFAULT NULL,
  `createdBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_encargadoproyectos`
--

INSERT INTO `tb_encargadoproyectos` (`idencargadoproyecto`, `ccodigoproyecto`, `idencargado`, `fregsys`, `nflgactivo`, `updatedBy`, `createdBy`) VALUES
(1, 20000, 1, '2024-12-03 14:51:51', 1, NULL, NULL),
(2, 20000, 2, '2024-12-03 14:52:02', 1, NULL, NULL),
(3, 390000, 3, '2024-12-05 15:36:27', 1, NULL, NULL),
(4, 390000, 4, '2024-12-05 15:40:14', 1, NULL, NULL),
(5, 390000, 5, '2024-12-05 15:40:28', 1, NULL, NULL),
(6, 390000, 6, '2024-12-05 15:42:33', 1, NULL, NULL),
(7, 390000, 8, '2024-12-05 15:45:06', 1, NULL, NULL),
(8, 390000, 9, '2024-12-05 16:03:35', 1, NULL, NULL),
(9, 390000, 10, '2024-12-05 16:03:35', 1, NULL, NULL),
(10, 390000, 11, '2024-12-05 16:39:41', 1, 'admin', NULL),
(11, 390000, 12, '2024-12-05 16:43:57', 1, 'admin', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_encargados`
--

CREATE TABLE `tb_encargados` (
  `idencargado` int(11) NOT NULL,
  `cnumdoc` varchar(20) NOT NULL,
  `cnombres` varchar(50) NOT NULL,
  `capellidopat` varchar(50) NOT NULL,
  `capellidomat` varchar(50) NOT NULL,
  `cnombrecompleto` varchar(255) DEFAULT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  `updatedBy` varchar(100) DEFAULT NULL,
  `createdBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_encargados`
--

INSERT INTO `tb_encargados` (`idencargado`, `cnumdoc`, `cnombres`, `capellidopat`, `capellidomat`, `cnombrecompleto`, `fregsys`, `nflgactivo`, `updatedBy`, `createdBy`) VALUES
(3, '42132408', 'LUZMERY PAULA', 'CATACORA', 'RAZO', 'LUZMERY PAULA CATACORA RAZO', '2024-12-05 15:35:56', 1, NULL, NULL),
(4, '44823974  ', ' JOSE ENRIQUE', 'COSSIO ', 'LOPEZ', ' JOSE ENRIQUE COSSIO  LOPEZ', '2024-12-05 15:38:27', 1, NULL, NULL),
(5, '40778235  ', 'ANDRES CRISTHIAN', 'BERRU ', 'GUEVARA', 'ANDRES CRISTHIAN BERRU  GUEVARA', '2024-12-05 15:39:44', 1, NULL, NULL),
(6, '008536028', 'ROBERTO', 'ROCA ', 'AVENDAÑO', 'ROBERTO ROCA  AVENDAÑO', '2024-12-05 15:42:18', 1, NULL, NULL),
(7, '43162015  ', 'ALEJANDRO', 'FLORES', ' CARMONA', 'ALEJANDRO FLORES  CARMONA', '2024-12-05 15:44:14', 1, NULL, NULL),
(8, '22297859  ', 'BENIGNO ANTONIO RUPE', 'TIZON ', 'RAMIREZ', 'BENIGNO ANTONIO RUPE TIZON  RAMIREZ', '2024-12-05 15:44:14', 1, NULL, NULL),
(9, '000529179', 'HERNAN', 'QUEVEDO ', 'ROJAS', 'HERNAN QUEVEDO  ROJAS', '2024-12-05 16:02:52', 1, NULL, NULL),
(10, '46605432 ', 'KATHIA GIULIANA', 'ACUÑA ', 'CAMPOS', 'KATHIA GIULIANA ACUÑA  CAMPOS', '2024-12-05 16:02:52', 1, NULL, NULL),
(11, '40423524', 'ELISEO WILFREDO', 'TURPO ', 'CHILE ', 'ELISEO WILFREDO TURPO  CHILE ', '2024-12-05 16:38:54', 1, NULL, NULL),
(12, '21136515', 'ESTHER NANCY', 'SILVESTRE', 'BEJARANO', 'ESTHER NANCY SILVESTRE BEJARANO', '2024-12-05 16:43:36', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_especialidad`
--

CREATE TABLE `tb_especialidad` (
  `idespecialidad` int(11) NOT NULL,
  `cespecialidad` varchar(100) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  `updatedBy` varchar(100) DEFAULT NULL,
  `createdBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_especialidad`
--

INSERT INTO `tb_especialidad` (`idespecialidad`, `cespecialidad`, `fregsys`, `nflgactivo`, `updatedBy`, `createdBy`) VALUES
(1, 'Operario Mecánico de Mtto. De Equipos Pesados', '2024-12-12 18:53:23', 1, 'admin', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_fases`
--

CREATE TABLE `tb_fases` (
  `idfase` int(11) NOT NULL,
  `cnombre` text NOT NULL,
  `cdescripcion` text NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  `createdBy` varchar(100) DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_fases`
--

INSERT INTO `tb_fases` (`idfase`, `cnombre`, `cdescripcion`, `fregsys`, `nflgactivo`, `createdBy`, `updatedBy`) VALUES
(7, '390001', 'Dirección y Control de Obra', '2024-12-05 15:48:18', 1, NULL, NULL),
(8, '390002', 'Recursos Humanos', '2024-12-05 16:05:12', 1, NULL, NULL),
(9, '390003', 'Control de Proyectos', '2024-12-05 16:28:11', 1, NULL, NULL),
(10, '390004', 'Control de Calidad', '2024-12-06 18:55:40', 1, NULL, NULL),
(11, '390005', 'Ingeniería y Topografía', '2024-12-06 18:55:47', 1, NULL, NULL),
(12, '390006', 'Mantenimiento de Equipos Mecánicos', '2024-12-06 18:55:57', 1, NULL, NULL),
(13, '390007', 'SSMA - Seguridad', '2024-12-05 18:38:37', 1, NULL, NULL),
(14, '390008', 'Precom . con', '2024-12-05 18:38:37', 1, NULL, NULL),
(15, '390009', 'Soporte de Sistemas', '2024-12-05 18:38:37', 1, NULL, NULL),
(16, '390010', 'Almacenes Generales', '2024-12-05 18:38:37', 1, NULL, NULL),
(17, '390011', 'Armado de Campamento', '2024-12-06 18:59:53', 1, NULL, NULL),
(18, '390012', 'Electricidad e Instrumentación', '2024-12-05 18:41:03', 1, NULL, NULL),
(19, '390013', 'Obras Civiles', '2024-12-05 18:41:03', 1, NULL, NULL),
(20, '390014', 'Logistica, Operadores y Rigger', '2024-12-10 20:11:09', 1, NULL, NULL),
(21, '390015', 'Montaje de Andamios', '2024-12-05 18:44:28', 1, NULL, NULL),
(22, '390016', 'Montaje - Soldadura - Piping', '2024-12-05 18:44:28', 1, NULL, NULL),
(23, '390017', 'Pruebas Hidrostaticas', '2024-12-05 19:16:19', 1, NULL, NULL),
(24, '390018', 'Pintura y Granallado', '2024-12-05 19:16:20', 1, NULL, NULL),
(25, '390060', 'Oficina -  Lima', '2024-12-05 19:16:20', 1, NULL, NULL),
(26, '390061', 'Almacen Lurin', '2024-12-05 19:16:20', 1, NULL, NULL),
(27, '390062', 'Almacen - Pucallpa', '2024-12-05 19:16:20', 1, NULL, NULL),
(28, '390063', 'Oficina - Pisco', '2024-12-05 19:52:51', 1, NULL, NULL),
(29, '', '', '2024-12-05 19:52:51', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_parametros`
--

CREATE TABLE `tb_parametros` (
  `idreg` int(11) NOT NULL,
  `nclase` varchar(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ncod` varchar(6) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescripcion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `nflgactivo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tb_parametros`
--

INSERT INTO `tb_parametros` (`idreg`, `nclase`, `ncod`, `cdescripcion`, `nflgactivo`) VALUES
(1, '00', '00', 'CONDICION', 1),
(2, '00', '01', 'OBRERO', 1),
(3, '00', '02', 'STAFF', 1),
(4, '01', '00', 'TERCERO', 1),
(5, '01', '00', 'MANO DE OBRA', 1),
(6, '01', '01', 'DIRECTO', 1),
(7, '01', '02', 'INDIRECTO', 1),
(8, '02', '00', 'PERSONAL', 1),
(9, '02', '01', 'FORANEO', 1),
(10, '02', '02', 'LOCAL', 1),
(11, '02', '03', 'EXTRANJERO', 1),
(12, '03', '01', 'CIVL', 1),
(13, '03', '02', 'COMUN', 1),
(14, '04', '01', 'FACILIDADES', 1),
(15, '04', '02', 'SOPORTE', 1),
(16, '04', '03', 'CIVIL', 1),
(17, '04', '04', 'MECANICA', 1),
(18, '04', '05', 'E&I', 1),
(19, '04', '06', 'DIRECTO', 1),
(20, '04', '07', 'INDIRECTO', 1),
(21, '05', '01', 'INGRESO', 1),
(22, '05', '02', 'PERMISO', 1),
(23, '05', '03', 'DESCANSO MEDICO', 1),
(24, '05', '04', 'BAJADA PROGRAMADA', 1),
(25, '05', '05', 'CESE', 1),
(26, '05', '06', 'AMONESTACION', 1),
(27, '05', '07', 'VACACIONES', 1),
(28, '05', '08', 'OTROS', 1),
(29, '06', '01', 'RENUNCIA VOLUNTARIO', 1),
(30, '06', '02', 'TERMINO DE OBRA', 1),
(31, '06', '03', 'TERMINO DE CONTRATO', 1),
(32, '06', '04', 'TERMINO DE FASE', 1),
(33, '06', '05', 'ABANDONO DE TRABAJO', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_proyectofases`
--

CREATE TABLE `tb_proyectofases` (
  `idproyectofase` int(11) NOT NULL,
  `ccodigoproyecto` varchar(20) NOT NULL,
  `idfase` int(11) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  `createdBy` varchar(100) DEFAULT NULL,
  `updatedBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_proyectofases`
--

INSERT INTO `tb_proyectofases` (`idproyectofase`, `ccodigoproyecto`, `idfase`, `fregsys`, `nflgactivo`, `createdBy`, `updatedBy`) VALUES
(6, '390000', 6, '2024-12-05 15:47:13', 1, NULL, NULL),
(7, '390000', 7, '2024-12-05 16:06:19', 1, NULL, NULL),
(8, '390000', 8, '2024-12-05 16:06:31', 1, NULL, NULL),
(9, '390000', 9, '2024-12-05 16:33:02', 1, NULL, NULL),
(10, '390000', 10, '2024-12-05 16:33:46', 1, NULL, NULL),
(11, '390000', 12, '2024-12-05 16:33:46', 1, NULL, NULL),
(12, '390000', 12, '2024-12-05 16:33:46', 1, NULL, NULL),
(13, '390000', 13, '2024-12-05 18:45:33', 1, NULL, NULL),
(14, '390000', 14, '2024-12-05 18:45:33', 1, NULL, NULL),
(15, '390000', 15, '2024-12-05 18:45:33', 1, NULL, NULL),
(16, '390000', 16, '2024-12-05 18:45:33', 1, NULL, NULL),
(17, '390000', 17, '2024-12-05 18:45:33', 1, NULL, NULL),
(18, '390000', 18, '2024-12-05 18:46:16', 1, NULL, NULL),
(19, '390000', 19, '2024-12-05 18:46:16', 1, NULL, NULL),
(20, '390000', 20, '2024-12-05 18:46:16', 1, NULL, NULL),
(21, '390000', 21, '2024-12-05 18:46:59', 1, NULL, NULL),
(22, '390000', 22, '2024-12-05 18:46:59', 1, NULL, NULL),
(23, '390000', 23, '2024-12-05 19:17:03', 1, NULL, NULL),
(24, '390000', 24, '2024-12-05 19:17:03', 1, NULL, NULL),
(25, '390000', 25, '2024-12-05 19:17:03', 1, NULL, NULL),
(26, '390000', 26, '2024-12-05 19:17:03', 1, NULL, 'admin'),
(27, '390000', 27, '2024-12-05 19:17:19', 1, NULL, 'admin'),
(28, '390000', 28, '2024-12-05 19:53:09', 1, NULL, 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tareos`
--

CREATE TABLE `tb_tareos` (
  `idreg` int(11) NOT NULL,
  `nrodoc` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cproyecto` int(11) DEFAULT NULL,
  `cubicacion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `estado` varchar(5) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `fingreso` date DEFAULT NULL,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  `fmodificacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `nfgactivo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tb_tareos`
--

INSERT INTO `tb_tareos` (`idreg`, `nrodoc`, `cproyecto`, `cubicacion`, `estado`, `mes`, `anio`, `fecha`, `fingreso`, `fregsys`, `fmodificacion`, `nfgactivo`) VALUES
(1, '000789910', 20000, 'PISCO', 'd', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(2, '70082701', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(3, '06813229', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(4, '10313207', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(5, '76478671', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(6, '20036250', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(7, '06708203', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(8, '41667405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(9, '72890114', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(10, '09680835', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(11, '08934899', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(12, '46067198', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(13, '10751826', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(14, '73830015', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(15, '71932542', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(16, '22284149', 20000, 'PISCO', 'd', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(17, '09383118', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(18, '71942763', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(19, '10281988', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(20, '25608087', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(21, '000853189', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(22, '74174466', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(23, '000458816', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(24, '000692215', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(25, '40802035', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(26, '10634270', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(27, '42778331', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(28, '76640732', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(29, '21301845', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(30, '21276405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(31, '07038472', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(32, '000821937', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(33, '06097752', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(34, '72306549', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(35, '70613887', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(36, '47425100', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(37, '005982120', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(38, '000148566', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(39, '10307288', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(40, '44660228', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(41, '08165961', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(42, '000435778', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(43, '08488980', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(44, '44068092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(45, '45077172', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(46, '43281347', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(47, '72701092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(48, '000685634', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(49, '10712208', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(50, '000540903', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(51, '09619538', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(52, '45882664', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(53, '43095718', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(54, '41310878', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(55, '18217223', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(56, '000809716', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(57, '42284795', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(58, '41095867', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(59, '000426973', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-28 05:00:00', '2024-11-28 05:00:00', 1),
(60, '000789910', 20000, 'PISCO', 'M', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(61, '70082701', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(62, '06813229', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(63, '10313207', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(64, '76478671', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(65, '20036250', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(66, '06708203', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(67, '41667405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(68, '09680835', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(69, '08934899', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(70, '46067198', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(71, '10751826', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(72, '73830015', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(73, '71932542', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(74, '22284149', 20000, 'PISCO', 'M', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(75, '71942763', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(76, '09383118', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(77, '10281988', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(78, '25608087', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(79, '000853189', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(80, '74174466', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(81, '000458816', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(82, '000692215', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(83, '40802035', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(84, '10634270', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(85, '42778331', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(86, '21276405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(87, '21301845', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(88, '07038472', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(89, '000821937', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(90, '06097752', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(91, '72306549', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(92, '47425100', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(93, '005982120', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(94, '000148566', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(95, '10307288', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(96, '44660228', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(97, '08165961', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(98, '000435778', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:43', '2024-11-29 20:01:43', 1),
(99, '08488980', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(100, '44068092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(101, '45077172', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(102, '43281347', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(103, '72701092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(104, '000685634', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(105, '10712208', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(106, '000540903', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(107, '09619538', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(108, '45882664', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(109, '43095718', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(110, '41310878', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(111, '18217223', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(112, '000809716', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(113, '42284795', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(114, '41095867', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(115, '000426973', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-29 20:01:44', '2024-11-29 20:01:44', 1),
(116, '000789910', 20000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(117, '70082701', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(118, '06813229', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(119, '10313207', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(120, '76478671', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(121, '20036250', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(122, '06708203', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(123, '41667405', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(124, '09680835', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(125, '08934899', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(126, '46067198', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(127, '10751826', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(128, '73830015', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(129, '71932542', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(130, '22284149', 20000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(131, '71942763', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(132, '09383118', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(133, '10281988', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(134, '25608087', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(135, '000853189', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(136, '74174466', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(137, '000458816', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(138, '000692215', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(139, '40802035', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(140, '10634270', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(141, '42778331', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(142, '21276405', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(143, '21301845', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(144, '07038472', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(145, '000821937', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(146, '06097752', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(147, '72306549', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(148, '47425100', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(149, '005982120', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(150, '000148566', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(151, '10307288', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(152, '44660228', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(153, '08165961', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(154, '000435778', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(155, '08488980', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(156, '44068092', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(157, '45077172', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(158, '43281347', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(159, '72701092', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(160, '000685634', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(161, '10712208', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(162, '000540903', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(163, '09619538', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(164, '45882664', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(165, '43095718', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(166, '41310878', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(167, '18217223', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(168, '000809716', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(169, '42284795', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(170, '41095867', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(171, '000426973', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-02 15:38:28', '2024-12-02 15:38:28', 1),
(172, '47960091', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(173, '46605432', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(174, '40778235', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(175, '42132408', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:13:54', 1),
(176, '72890114', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(177, '44823974', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(178, '16123862', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(179, '72654693', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(180, '41929321', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(181, '43162015', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(182, '46078454', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(183, '43164161', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(184, '45711527', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(185, '70613887', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(186, '03897077', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(187, '41090322', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(188, '44085611', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(189, '72433532', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(190, '008536028', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(191, '76742784', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(192, '42743571', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(193, '43563747', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(194, '21136515', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:44', '2024-12-05 16:11:44', 1),
(195, '22297859', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:45', '2024-12-05 16:12:01', 1),
(196, '40423524', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:45', '2024-12-05 16:11:45', 1),
(197, '46831991', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:45', '2024-12-05 16:11:45', 1),
(198, '008640258', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-05 16:11:45', '2024-12-05 16:11:45', 1),
(199, '47960091', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:14', '2024-12-06 14:37:14', 1),
(200, '46605432', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:14', '2024-12-06 14:37:14', 1),
(201, '40778235', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:14', '2024-12-06 14:37:14', 1),
(202, '42132408', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:14', '2024-12-06 14:43:00', 1),
(203, '72890114', 390000, 'LIMA ', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(204, '44823974', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(205, '16123862', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:37:15', 1),
(206, '72654693', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:37:15', 1),
(207, '41929321', 390000, 'PUCALLPA', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(208, '43162015', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(209, '46078454', 390000, 'PUCALLPA', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(210, '43164161', 390000, 'PUCALLPA', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(211, '45711527', 390000, 'PUCALLPA', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(212, '70613887', 390000, 'LIMA ', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(213, '03897077', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(214, '41090322', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(215, '44085611', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:37:15', 1),
(216, '72433532', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:37:15', 1),
(217, '008536028', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(218, '76742784', 390000, 'LIMA ', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(219, '42743571', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(220, '43563747', 390000, 'PUCALLPA', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(221, '21136515', 390000, 'PISCO', 'PI', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(222, '22297859', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:37:15', 1),
(223, '40423524', 390000, 'LIMA ', 'PI', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(224, '46831991', 390000, 'LIMA ', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(225, '008640258', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-06 14:37:15', '2024-12-06 14:43:00', 1),
(226, '000789910', 20000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(227, '70082701', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(228, '06813229', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(229, '10313207', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(230, '76478671', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(231, '20036250', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(232, '06708203', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(233, '41667405', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(234, '72890114', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(235, '09680835', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(236, '08934899', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(237, '46067198', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(238, '10751826', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(239, '73830015', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(240, '71932542', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(241, '22284149', 20000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(242, '09383118', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(243, '71942763', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:51', '2024-12-16 19:14:51', 1),
(244, '10281988', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(245, '25608087', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(246, '000853189', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(247, '74174466', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(248, '000458816', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(249, '000692215', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(250, '40802035', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(251, '10634270', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(252, '42778331', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(253, '21276405', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(254, '21301845', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(255, '07038472', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(256, '000821937', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(257, '06097752', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(258, '72306549', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(259, '70613887', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(260, '47425100', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(261, '005982120', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(262, '000148566', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(263, '10307288', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(264, '44660228', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(265, '08165961', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(266, '000435778', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(267, '08488980', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(268, '44068092', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(269, '45077172', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(270, '43281347', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(271, '72701092', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(272, '000685634', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(273, '10712208', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(274, '000540903', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(275, '09619538', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(276, '45882664', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(277, '43095718', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(278, '41310878', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(279, '18217223', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(280, '000809716', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(281, '42284795', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(282, '41095867', 20000, 'LIMA ', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(283, '000426973', 20000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-16 19:14:52', '2024-12-16 19:14:52', 1),
(284, '47960091', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:31', '2024-12-20 14:37:31', 1),
(285, '46605432', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:31', '2024-12-20 14:37:31', 1),
(286, '70055164', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:31', '2024-12-20 14:37:31', 1),
(287, '40778235', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:31', '2024-12-20 14:37:31', 1),
(288, '42132408', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:31', '2024-12-20 14:37:31', 1),
(289, '07473313', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(290, '44823974', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(291, '42363352', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(292, '16123862', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(293, '72654693', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(294, '41929321', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(295, '43162015', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(296, '40908346', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(297, '41413571', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(298, '46078454', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(299, '43164161', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(300, '43178225', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(301, '45711527', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(302, '03897077', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(303, '008639724', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(304, '41090322', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(305, '44085611', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(306, '15855546', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(307, '22308082', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(308, '72433532', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(309, '008536028', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(310, '76742784', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(311, '42743571', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(312, '43563747', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(313, '21136515', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(314, '22297859', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(315, '40423524', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(316, '25849265', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(317, '46831991', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(318, '008640258', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-20 14:37:32', '2024-12-20 14:37:32', 1),
(319, '47960091', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(320, '46605432', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(321, '70055164', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(322, '40778235', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(323, '42132408', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(324, '07473313', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(325, '44823974', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(326, '42363352', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(327, '16123862', 390000, 'DESCANSO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(328, '72654693', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(329, '41929321', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(330, '43162015', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(331, '40908346', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(332, '41413571', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(333, '46078454', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(334, '43164161', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(335, '43178225', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(336, '45711527', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(337, '03897077', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:33', '2024-12-21 15:50:33', 1),
(338, '008639724', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(339, '41090322', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(340, '44085611', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(341, '15855546', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(342, '22308082', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(343, '72433532', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(344, '008536028', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(345, '76742784', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(346, '42743571', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(347, '43563747', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(348, '21136515', 390000, 'PISCO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(349, '22297859', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(350, '40423524', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(351, '25849265', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(352, '46831991', 390000, 'LIMA ', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(353, '008640258', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-21 15:50:34', '2024-12-21 15:50:34', 1),
(354, '47960091', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(355, '46605432', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(356, '70055164', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(357, '40778235', 390000, 'NUEVO MUNDO', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(358, '42132408', 390000, 'NUEVO MUNDO', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(359, '07473313', 390000, 'LIMA', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(360, '44823974', 390000, 'NUEVO MUNDO', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(361, '42363352', 390000, 'PISCO', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(362, '16123862', 390000, 'DESCANSO', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(363, '72654693', 390000, 'PUCALLPA', 'D', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(364, '41929321', 390000, 'PUCALLPA', 'TI', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(365, '43162015', 390000, 'NUEVO MUNDO', 'TI', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(366, '40908346', 390000, 'NUEVO MUNDO', 'TI-S', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:48:25', 1),
(367, '41413571', 390000, 'PISCO', 'TS-S', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:48:25', 1),
(368, '46078454', 390000, 'PUCALLPA', 'LSG', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(369, '43164161', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(370, '43178225', 390000, 'PUCALLPA', 'TS', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(371, '45711527', 390000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(372, '03897077', 390000, 'NUEVO MUNDO', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(373, '008639724', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(374, '41090322', 390000, 'NUEVO MUNDO', 'SUSP', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:48:25', 1),
(375, '44085611', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(376, '15855546', 390000, 'PISCO', 'PI', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(377, '22308082', 390000, 'PISCO', 'PI', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(378, '72433532', 390000, 'NUEVO MUNDO', 'L', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(379, '008536028', 390000, 'NUEVO MUNDO', 'TTR', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(380, '76742784', 390000, 'LIMA ', 'TTR', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(381, '42743571', 390000, 'NUEVO MUNDO', 'PU', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(382, '43563747', 390000, 'PUCALLPA', 'LCG', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(383, '21136515', 390000, 'PISCO', 'TS', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(384, '22297859', 390000, 'NUEVO MUNDO', 'M', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(385, '40423524', 390000, 'NUEVO MUNDO', 'V', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(386, '25849265', 390000, 'NUEVO MUNDO', 'V', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(387, '46831991', 390000, 'LIMA ', 'V', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(388, '008640258', 390000, 'NUEVO MUNDO', 'M', 12, 2024, '0000-00-00', NULL, '2024-12-23 20:42:57', '2024-12-23 20:42:57', 1),
(389, '07845838', 390000, 'LIMA', 'A', 12, 2024, '0000-00-00', '2024-12-26', '2024-12-26 16:46:20', '2024-12-26 16:46:20', 1),
(390, '07845838', 390000, 'LIMA', 'TTR', 12, 2024, '2024-12-25', '2024-12-26', '2024-12-25 05:00:00', '2024-12-26 16:48:46', 1),
(391, '07845838', 390000, 'LIMA', 'TI-S', 12, 2024, '0000-00-00', NULL, '2024-12-27 13:33:17', '2024-12-27 13:33:56', 1),
(392, '43523880', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(393, '00091831', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(394, '43129822', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(395, '42514167', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(396, '46095545', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(397, '40298546', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(398, '47430495', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(399, '09304892', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(400, '75796473', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1),
(401, '00109561', 60000, 'PUCALLPA', 'A', 12, 2024, '0000-00-00', NULL, '2024-12-30 16:33:31', '2024-12-30 16:33:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_ubicacion`
--

CREATE TABLE `tb_ubicacion` (
  `idubicacion` int(11) NOT NULL,
  `cubicacion` varchar(50) NOT NULL,
  `fregesys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1,
  `updatedBy` varchar(100) DEFAULT NULL,
  `createdBy` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_ubicacion`
--

INSERT INTO `tb_ubicacion` (`idubicacion`, `cubicacion`, `fregesys`, `nflgactivo`, `updatedBy`, `createdBy`) VALUES
(1, 'NUEVO MUNDO', '2024-12-12 18:51:41', 1, NULL, NULL),
(2, 'PISCO', '2024-12-12 18:52:08', 1, NULL, NULL),
(3, 'PUCALLPA', '2024-12-12 18:52:08', 1, NULL, NULL),
(4, 'DESCANSO', '2024-12-12 18:52:26', 1, 'admin', NULL),
(5, 'LIMA', '2024-12-12 18:52:37', 1, 'admin', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_userproyectos`
--

CREATE TABLE `tm_userproyectos` (
  `idreg` int(11) NOT NULL,
  `cdocumento` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ccodigo` varchar(32) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cdescripcion` text COLLATE utf8_spanish2_ci DEFAULT NULL,
  `fregsys` timestamp NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tm_userproyectos`
--

INSERT INTO `tm_userproyectos` (`idreg`, `cdocumento`, `ccodigo`, `cdescripcion`, `fregsys`, `nflgactivo`) VALUES
(1, '20036250', '020000', 'ADMINISTRACION DE OFICINA / Sede Lima', '2024-08-11 22:55:01', 1),
(2, '20036250', '390000', 'EPC RECAPEX II', '2024-08-11 22:55:01', 1),
(3, '42132408', '390000', 'EPC RECAPEX II', '2024-08-11 23:00:04', 1),
(4, '76478671', '020000', 'ADMINISTRACION DE OFICINA / Sede Lima', '2024-10-23 14:24:58', 1),
(5, '76478671', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-10-23 14:26:44', 1),
(6, '76478671', '340000', 'SERV. REEMPLAZO DE AISLAMIENTO TÉRMICO Y RECUPERACION DE ESPESOR POR SOLDADURA EN CRIOGÉNICAS 3,4Y5', '2024-10-23 14:37:13', 1),
(7, '00000000', '380000', 'EPC INSTALACIÓN DE PANTALLAS DE PILOTES EN LOCACIÓN KINTERONI', '2024-10-24 19:11:36', 1),
(8, '00000000', '350000', 'EPC PLANTA DE COMPRESION MIPAYA L56', '2024-10-24 19:11:47', 1),
(9, '41667546', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-04 17:09:10', 1),
(10, '76478671', '380000', 'EPC INSTALACIÓN DE PANTALLAS DE PILOTES EN LOCACIÓN KINTERONI', '2024-11-05 13:20:51', 1),
(11, '76478671', '050000', 'SEDE PISCO', '2024-11-05 14:33:00', 0),
(12, '20036250', '350000', 'EPC PLANTA DE COMPRESION MIPAYA L56', '2024-11-07 15:24:53', 1),
(13, '42132408', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 16:02:01', 1),
(14, '42132408', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 16:02:01', 1),
(15, '42132408', '390000', 'EPC RECAPEX II', '2024-11-11 16:02:01', 1),
(16, '70566358', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 16:02:01', 1),
(17, '70566358', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 16:02:01', 1),
(18, '27690290', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 16:02:01', 1),
(19, '78720030', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 16:02:01', 1),
(20, '76175725', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 16:02:01', 1),
(21, '71972542', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 16:02:01', 1),
(22, '43856063', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 16:02:01', 1),
(23, '43856063', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 16:02:01', 1),
(24, '43856063', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 16:02:01', 1),
(25, '43856063', '060000', 'ALMACENES / Sede Pucallpa', '2024-11-11 16:02:01', 1),
(26, '43856063', '030000', 'MANTENIMIENTO MECÁNICO / Sede Pucallpa', '2024-11-11 16:02:01', 1),
(27, '111111', '370000', 'EPC03 - PROYECTOS DE ASEGURAMIENTO PLANTA MALVINAS', '2024-11-11 16:02:01', 1),
(28, '111111', '320000', 'EPC LEAN CLUSTER PAGORENI B Y CASHIRIARI 3', '2024-11-11 16:02:01', 1),
(29, '111111', '390000', 'EPC RECAPEX II', '2024-11-11 16:02:01', 1),
(30, '111111', '350000', 'SERVICIO DE INSTALACIÓN DE COMPRESIÓN DE GAS EN CAMPO MIPAYA - LOTE 56', '2024-11-11 16:02:01', 1),
(31, '111111', '380000', 'EPC INSTALACIÓN PANTALLA (PILOTES) B57 – REPSOL', '2024-11-11 16:02:01', 1),
(32, '111111', '060000', 'ALMACENES / Sede Pucallpa', '2024-11-11 16:02:01', 1),
(33, '111111', '030000', 'MANTENIMIENTO MECÁNICO / Sede Pucallpa', '2024-11-11 16:02:01', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cm_users`
--
ALTER TABLE `cm_users`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- Indices de la tabla `tb_datostareo`
--
ALTER TABLE `tb_datostareo`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- Indices de la tabla `tb_datostareo_historico`
--
ALTER TABLE `tb_datostareo_historico`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- Indices de la tabla `tb_datosterceros`
--
ALTER TABLE `tb_datosterceros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tb_encargadoproyectos`
--
ALTER TABLE `tb_encargadoproyectos`
  ADD PRIMARY KEY (`idencargadoproyecto`);

--
-- Indices de la tabla `tb_encargados`
--
ALTER TABLE `tb_encargados`
  ADD PRIMARY KEY (`idencargado`);

--
-- Indices de la tabla `tb_especialidad`
--
ALTER TABLE `tb_especialidad`
  ADD PRIMARY KEY (`idespecialidad`);

--
-- Indices de la tabla `tb_fases`
--
ALTER TABLE `tb_fases`
  ADD PRIMARY KEY (`idfase`);

--
-- Indices de la tabla `tb_parametros`
--
ALTER TABLE `tb_parametros`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- Indices de la tabla `tb_proyectofases`
--
ALTER TABLE `tb_proyectofases`
  ADD PRIMARY KEY (`idproyectofase`);

--
-- Indices de la tabla `tb_tareos`
--
ALTER TABLE `tb_tareos`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- Indices de la tabla `tb_ubicacion`
--
ALTER TABLE `tb_ubicacion`
  ADD PRIMARY KEY (`idubicacion`);

--
-- Indices de la tabla `tm_userproyectos`
--
ALTER TABLE `tm_userproyectos`
  ADD PRIMARY KEY (`idreg`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cm_users`
--
ALTER TABLE `cm_users`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tb_datostareo`
--
ALTER TABLE `tb_datostareo`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `tb_datostareo_historico`
--
ALTER TABLE `tb_datostareo_historico`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tb_datosterceros`
--
ALTER TABLE `tb_datosterceros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `tb_encargadoproyectos`
--
ALTER TABLE `tb_encargadoproyectos`
  MODIFY `idencargadoproyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tb_encargados`
--
ALTER TABLE `tb_encargados`
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tb_especialidad`
--
ALTER TABLE `tb_especialidad`
  MODIFY `idespecialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_fases`
--
ALTER TABLE `tb_fases`
  MODIFY `idfase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `tb_parametros`
--
ALTER TABLE `tb_parametros`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `tb_proyectofases`
--
ALTER TABLE `tb_proyectofases`
  MODIFY `idproyectofase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tb_tareos`
--
ALTER TABLE `tb_tareos`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=402;

--
-- AUTO_INCREMENT de la tabla `tb_ubicacion`
--
ALTER TABLE `tb_ubicacion`
  MODIFY `idubicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tm_userproyectos`
--
ALTER TABLE `tm_userproyectos`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
