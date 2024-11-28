-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-11-2024 a las 20:56:56
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
-- Base de datos: `masterworkrrhh`
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
(1, '76478671', '1', 3, 11, 'DESARROLLO DE SISTEMAS', 7, '330000', 'PRUEBA', 'LIMA', '28/7', '2024-11-25', '2024-11-30', '2024-12-01', 1, 0, 5, 0, 'observaciones123', 24, '0000-00-00', 29, 12, 14, 1, '2024-11-06 19:41:57'),
(12, '20036250', '', 4, -1, '', 7, '', '', '', '', '2024-11-15', '0000-00-00', '0000-00-00', 0, 0, 0, NULL, '', NULL, '0000-00-00', NULL, 13, 17, 1, '2024-11-07 14:15:45'),
(13, '04412417', 'Don Ramon', 4, 10, 'DESARROLLO DE SISTEMAS', 6, '020000', 'PRUEBA', 'LIMA', '28/7', '2024-11-25', '2026-02-14', '2024-11-23', 112, 7, 449, 445, 'rqr444646', 0, '0000-00-00', 0, 13, 17, 1, '2024-11-12 15:42:22');

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

INSERT INTO `tb_datosterceros` (`id`, `dni`, `paterno`, `materno`, `nombres`, `cargo`, `sede`, `estado`, `cut`, `sucursal`, `correo`, `cesado`, `nacimiento`, `direccion`, `ubigeo`, `departamento`, `provincia`, `distrito`, `origen`, `ingreso`, `telefono`, `sangre`, `proyecto`, `regimen`, `pais`, `cod_pais`, `empresa`) VALUES
(1, '10001088', 'FUJIMORI', 'HIGUCHI', 'KEIKO SOFIA', 'D', NULL, 'ACTIVO', '979887', 'LIMA', 'kfujimori@gmail.com', NULL, '1990-03-15', 'San Borja', '140140', NULL, NULL, NULL, NULL, NULL, '975149289', 'A-', '380000', 'LABORAL', 'PERÚ', NULL, 'FUERZA POPULAR'),
(2, '74294745', 'VELASQUEZ', 'ROLDAN', 'SAMIR EDUARDO', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', '054887', 'LIMA', 'svelasquez@gmail.com', NULL, '1995-01-07', 'ASOC. SEOR DE LOS MILAGROS', '140109', NULL, NULL, NULL, NULL, NULL, '984562178', 'A+', '380000', 'PRACTICANTES', 'PERÚ', NULL, 'S'),
(3, '04412417', 'VIZCARRA', 'CORNEJO', 'MARTIN ALBERTO', 'PRESIDENTE DEL PERU', NULL, 'ACTIVO', '013348', 'LIMA', 'vizcarra@gmail.com', NULL, '1989-02-07', 'av. ferrocarril s/n', '150131', 'LIMA', 'LIMA', 'SAN ISIDRO', NULL, NULL, '963852741', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'PARTIDO DEMOCRATICO SOMOS PERU'),
(9, '27427864', 'CASTILLO', 'TERRONES', 'JOSE PEDRO', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', NULL, 'LIMA', 'pcastillo@gmail.com', NULL, '2024-11-01', 'AV. san borja 445', '150101', NULL, NULL, NULL, NULL, NULL, '963852741', 'o+', '020000', 'LABORAL', 'PERÚ', NULL, 'SEPCON'),
(10, '07845838', 'LOPEZ', 'ALIAGA', 'CAZORLA RAFAEL', 'Practicante de Tecnología e Informática', NULL, 'ACTIVO', NULL, 'LIMA', 'rlopez@gmail.com', NULL, '1982-03-11', 'AV. san borja 445', NULL, NULL, NULL, NULL, NULL, NULL, '999999999', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'RENOVACION POPULAR'),
(24, '06256217', 'BOLUARTE', 'ZEGARRA', 'DINA ERCILIA', 'Desarrollador de Sistemas', NULL, 'ACTIVO', NULL, 'LIMA', 'dboluarte@gmail.com', NULL, '1979-03-15', 'san borja', NULL, 'LIMA', 'LIMA', 'SAN BORJA', NULL, NULL, '777888999', 'O+', '020000', 'LABORAL', 'PERÚ', NULL, 'PERU LIBRE'),
(25, '76478671', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '-1', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_encargadoproyectos`
--

CREATE TABLE `tb_encargadoproyectos` (
  `idencargadoproyecto` int(11) NOT NULL,
  `ccodigoproyecto` int(11) NOT NULL,
  `idencargado` int(11) NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_encargadoproyectos`
--

INSERT INTO `tb_encargadoproyectos` (`idencargadoproyecto`, `ccodigoproyecto`, `idencargado`, `fregsys`, `nflgactivo`) VALUES
(1, 3500, 1, '2024-11-28 16:57:32', 1);

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
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_encargados`
--

INSERT INTO `tb_encargados` (`idencargado`, `cnumdoc`, `cnombres`, `capellidopat`, `capellidomat`, `fregsys`, `nflgactivo`) VALUES
(1, '78978797', 'kñlskdaopdk', 'ppokpo', 'kop', '2024-11-28 16:02:59', 1),
(2, '8889984984', 'Roly', 'Ari', 'Coaquira', '2024-11-28 18:51:54', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_fases`
--

CREATE TABLE `tb_fases` (
  `idfase` int(11) NOT NULL,
  `cnombre` text NOT NULL,
  `cdescripcion` text NOT NULL,
  `fregsys` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_fases`
--

INSERT INTO `tb_fases` (`idfase`, `cnombre`, `cdescripcion`, `fregsys`, `nflgactivo`) VALUES
(2, 'pruebajjora', 'pjjfpwia', '2024-11-27 14:10:43', 1),
(3, 'a', 'b', '2024-11-27 14:10:57', 1),
(4, 'c', 'd', '2024-11-27 14:10:57', 1),
(5, '49849', '49489', '2024-11-27 19:22:57', 1);

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
(6, '01', '01', 'DIRECTA', 1),
(7, '01', '02', 'INDIRECTA', 1),
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
  `nflgactivo` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tb_proyectofases`
--

INSERT INTO `tb_proyectofases` (`idproyectofase`, `ccodigoproyecto`, `idfase`, `fregsys`, `nflgactivo`) VALUES
(1, '350000', 4, '2024-11-27 19:26:07', 1),
(2, '020000', 2, '2024-11-28 19:51:55', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_tareos`
--

CREATE TABLE `tb_tareos` (
  `idreg` int(11) NOT NULL,
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
  `nfgactivo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `tb_tareos`
--

INSERT INTO `tb_tareos` (`idreg`, `nrodoc`, `cproyecto`, `cubicacion`, `estado`, `mes`, `anio`, `fecha`, `fingreso`, `fregsys`, `fmodificacion`, `nfgactivo`) VALUES
(1, '000789910', 20000, 'PISCO', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-08 17:17:27', 1),
(2, '70082701', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(3, '06813229', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(4, '10313207', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(5, '76478671', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(6, '20036250', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(7, '06708203', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(8, '41667405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(9, '71820627', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(10, '72890114', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(11, '09680835', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(12, '08934899', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(13, '46067198', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(14, '10751826', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(15, '73830015', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(16, '71932542', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(17, '22284149', 20000, 'PISCO', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(18, '09383118', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(19, '71942763', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(20, '10281988', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(21, '25608087', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(22, '000853189', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(23, '74174466', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(24, '000458816', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(25, '000692215', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(26, '40802035', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(27, '10634270', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(28, '42778331', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(29, '76640732', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(30, '21301845', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(31, '21276405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(32, '07038472', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(33, '000821937', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(34, '06097752', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(35, '72306549', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(36, '70613887', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(37, '47425100', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(38, '005982120', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(39, '000148566', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(40, '10307288', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(41, '44660228', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(42, '08165961', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(43, '000435778', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(44, '08488980', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(45, '44068092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(46, '45077172', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(47, '43281347', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(48, '72701092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(49, '000685634', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(50, '10712208', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(51, '000540903', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(52, '09619538', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(53, '45882664', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(54, '43095718', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(55, '41310878', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(56, '18217223', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(57, '000809716', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(58, '42284795', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(59, '41095867', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(60, '000426973', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-06 05:00:00', '2024-11-06 05:00:00', 1),
(61, '47866224', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(62, '74526162', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(63, '61379323', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(64, '41263201', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(65, '74756110', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(66, '72727791', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(67, '32221006', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(68, '45610494', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(69, '43005751', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:57:27', '2024-11-07 19:57:27', 1),
(70, '000789910', 20000, 'PISCO', 'F', 11, 2024, '0000-00-00', NULL, '2024-11-07 16:16:00', '2024-11-08 17:10:19', 1),
(71, '70082701', 20000, 'LIMA ', 'G', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-08 17:11:05', 1),
(72, '06813229', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(73, '10313207', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(74, '76478671', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(75, '20036250', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(76, '06708203', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(77, '41667405', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(78, '71820627', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(79, '72890114', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(80, '09680835', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(81, '08934899', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(82, '46067198', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(83, '10751826', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(84, '73830015', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(85, '71932542', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(86, '22284149', 20000, 'PISCO', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(87, '09383118', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(88, '71942763', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(89, '10281988', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(90, '25608087', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(91, '000853189', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(92, '74174466', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(93, '000458816', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(94, '000692215', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(95, '40802035', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(96, '10634270', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(97, '42778331', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(98, '76640732', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(99, '21301845', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(100, '21276405', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(101, '07038472', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(102, '000821937', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(103, '06097752', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(104, '72306549', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(105, '70613887', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(106, '47425100', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(107, '005982120', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(108, '000148566', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(109, '10307288', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(110, '44660228', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(111, '08165961', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(112, '000435778', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(113, '08488980', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(114, '44068092', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(115, '45077172', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(116, '43281347', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(117, '72701092', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(118, '000685634', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(119, '10712208', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(120, '000540903', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(121, '09619538', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(122, '45882664', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(123, '43095718', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(124, '41310878', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(125, '18217223', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(126, '000809716', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(127, '42284795', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(128, '41095867', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(129, '000426973', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 19:59:46', '2024-11-07 19:59:46', 1),
(130, '000789910', 20000, 'PISCO', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:10:10', '2024-11-08 15:10:10', 1),
(131, '70082701', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-08 16:53:34', '2024-11-08 16:53:34', 1),
(132, '06813229', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-08 16:01:14', '2024-11-08 17:09:55', 1),
(133, '10313207', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-08 16:15:43', '2024-11-08 16:15:43', 1),
(134, '76478671', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(135, '20036250', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(136, '06708203', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(137, '41667405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(138, '71820627', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(139, '72890114', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(140, '09680835', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(141, '08934899', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(142, '46067198', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(143, '10751826', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(144, '73830015', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(145, '71932542', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(146, '22284149', 20000, 'PISCO', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(147, '09383118', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(148, '71942763', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(149, '10281988', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(150, '25608087', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(151, '000853189', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(152, '74174466', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(153, '000458816', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(154, '000692215', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(155, '40802035', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(156, '10634270', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(157, '42778331', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(158, '76640732', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(159, '21301845', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(160, '21276405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(161, '07038472', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(162, '000821937', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(163, '06097752', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(164, '72306549', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(165, '70613887', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(166, '47425100', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(167, '005982120', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(168, '000148566', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(169, '10307288', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(170, '44660228', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(171, '08165961', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(172, '000435778', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(173, '08488980', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(174, '44068092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(175, '45077172', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(176, '43281347', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(177, '72701092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(178, '000685634', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(179, '10712208', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(180, '000540903', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(181, '09619538', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(182, '45882664', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(183, '43095718', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(184, '41310878', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(185, '18217223', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(186, '000809716', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(187, '42284795', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(188, '41095867', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(189, '000426973', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 15:09:42', '2024-11-08 15:09:42', 1),
(190, '47866224', 340000, 'MALVINAS', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(191, '74526162', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(192, '61379323', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(193, '41263201', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(194, '74756110', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(195, '72727791', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(196, '32221006', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(197, '45610494', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(198, '43005751', 340000, 'MALVINAS', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-08 14:32:23', '2024-11-08 14:32:23', 1),
(200, '04412417', 20000, 'LIMA', 'D', 11, 2024, '0000-00-00', NULL, '2024-11-07 18:41:25', '2024-11-08 20:08:29', 1),
(201, '27427864', 20000, 'LIMA', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-07 18:41:25', '2024-11-08 20:08:29', 1),
(208, '000789910', 20000, 'PISCO', 'D', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 14:09:34', 1),
(209, '70082701', 20000, 'LIMA ', 'D', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 14:09:34', 1),
(210, '06813229', 20000, 'LIMA ', 'D', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 14:09:34', 1),
(211, '10313207', 20000, 'LIMA ', 'V', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(212, '76478671', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(213, '20036250', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(214, '06708203', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(215, '41667405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(216, '71820627', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(217, '72890114', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(218, '09680835', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(219, '08934899', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(220, '46067198', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(221, '10751826', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(222, '73830015', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(223, '71932542', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(224, '22284149', 20000, 'PISCO', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(225, '09383118', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(226, '71942763', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(227, '10281988', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(228, '25608087', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(229, '000853189', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(230, '74174466', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(231, '000458816', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(232, '000692215', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(233, '40802035', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(234, '10634270', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(235, '42778331', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(236, '76640732', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(237, '21301845', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(238, '21276405', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(239, '07038472', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(240, '000821937', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(241, '06097752', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(242, '72306549', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(243, '70613887', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(244, '47425100', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(245, '005982120', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(246, '000148566', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(247, '10307288', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(248, '44660228', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(249, '08165961', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(250, '000435778', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(251, '08488980', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(252, '44068092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(253, '45077172', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(254, '43281347', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(255, '72701092', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(256, '000685634', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(257, '10712208', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(258, '000540903', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(259, '09619538', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(260, '45882664', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(261, '43095718', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(262, '41310878', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(263, '18217223', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(264, '000809716', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(265, '42284795', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(266, '41095867', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(267, '000426973', 20000, 'LIMA ', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-11 13:51:48', '2024-11-11 13:51:48', 1),
(268, '04412417', 20000, 'LIMA', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-12 16:22:15', '2024-11-12 16:22:15', 1),
(269, '27427864', 20000, 'LIMA', 'D', 11, 2024, '0000-00-00', NULL, '2024-11-12 16:22:15', '2024-11-12 16:22:15', 1),
(270, '07845838', 20000, 'LIMA', 'A', 11, 2024, '0000-00-00', NULL, '2024-11-12 16:22:15', '2024-11-12 16:22:15', 1);

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
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tb_datosterceros`
--
ALTER TABLE `tb_datosterceros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `tb_encargadoproyectos`
--
ALTER TABLE `tb_encargadoproyectos`
  MODIFY `idencargadoproyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tb_encargados`
--
ALTER TABLE `tb_encargados`
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_fases`
--
ALTER TABLE `tb_fases`
  MODIFY `idfase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tb_parametros`
--
ALTER TABLE `tb_parametros`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `tb_proyectofases`
--
ALTER TABLE `tb_proyectofases`
  MODIFY `idproyectofase` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tb_tareos`
--
ALTER TABLE `tb_tareos`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT de la tabla `tm_userproyectos`
--
ALTER TABLE `tm_userproyectos`
  MODIFY `idreg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
