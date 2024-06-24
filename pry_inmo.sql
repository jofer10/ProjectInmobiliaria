-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 24-06-2024 a las 14:18:59
-- Versión del servidor: 8.2.0
-- Versión de PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pry_inmo`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `api_inmo_as_pry_detail_ins_upd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_as_pry_detail_ins_upd` (IN `vp_id_det_asoc` INT, IN `vp_id_as_pry` INT, IN `vp_fec_pago` VARCHAR(50), IN `vp_monto_cuota` DECIMAL(10,2), OUT `mensaje` TEXT)   BEGIN
	IF vp_id_det_asoc=0 THEN
    	INSERT INTO detalle_asoc_proy(id_as_pry,fec_pago,monto_cuota)
        VALUES(vp_id_as_pry,STR_TO_DATE(vp_fec_pago, '%d/%m/%Y'),vp_monto_cuota);
        
        SET mensaje="Detalle de pago insertado correctamente";
    END IF;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_as_pry_detail_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_as_pry_detail_list` (IN `vp_id_as_pry` INT)   BEGIN
	SELECT dap.id_det_asoc, DATE_FORMAT(dap.fec_pago, '%d/%m/%Y') fec_pago,dap.monto_cuota
    FROM asoc_proy ap
    INNER JOIN detalle_asoc_proy dap ON (dap.id_as_pry=ap.id_as_pry)
    WHERE ap.id_as_pry=vp_id_as_pry
    ORDER BY 1;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_as_pry_ins`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_as_pry_ins` (IN `vp_id_cliente` INT, IN `vp_id_proyecto` INT, IN `vp_fecha` VARCHAR(50), OUT `mensaje` TEXT)   BEGIN
	INSERT INTO asoc_proy(id_cliente, id_proyecto, fec_ini_as)
    VALUES(vp_id_cliente,vp_id_proyecto,STR_TO_DATE(vp_fecha, '%d/%m/%Y'));
    
    SET mensaje="Cliente asociado correctamente al proyecto";
END$$

DROP PROCEDURE IF EXISTS `api_inmo_as_pry_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_as_pry_list` (IN `vp_name_pry` VARCHAR(50), IN `vp_fec_ini` VARCHAR(50), IN `vp_fec_fin` VARCHAR(50))   BEGIN
	SELECT ap.id_as_pry, cl.nombres, pr.name_pry, coalesce(dap.monto_cuota,0) monto_cuota,coalesce(SUM(dap.monto_cuota),0) monto_total
    FROM asoc_proy ap
    LEFT JOIN detalle_asoc_proy dap ON (dap.id_as_pry=ap.id_as_pry)
    INNER JOIN proyectos pr ON (pr.id_proyecto=ap.id_proyecto and estado_pry=true)
    INNER JOIN clientes cl ON (cl.id_cliente=ap.id_cliente and estado_cli=true)
    WHERE pr.name_pry = CASE WHEN COALESCE(vp_name_pry, '') = '' THEN pr.name_pry ELSE UPPER(vp_name_pry) END
	AND ap.fec_ini_as BETWEEN STR_TO_DATE(vp_fec_ini, '%d/%m/%Y') AND STR_TO_DATE(vp_fec_fin, '%d/%m/%Y')
    GROUP BY 1,2,3,4
    ORDER BY 1;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_clientes_del`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_clientes_del` (IN `vp_id_cliente` INT, OUT `mensaje` TEXT)   BEGIN
    UPDATE clientes
    SET estado_cli = false
    WHERE id_cliente = vp_id_cliente;
        
    SET mensaje = "Cliente eliminado exitósamente";
END$$

DROP PROCEDURE IF EXISTS `api_inmo_clientes_get_client`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_clientes_get_client` (IN `vp_id_cliente` INT)   BEGIN
	SELECT c.id_cliente, c.nombres, c.email
    FROM clientes c
    WHERE c.id_cliente=vp_id_cliente;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_clientes_ins_upd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_clientes_ins_upd` (IN `vp_id_cliente` INT, IN `vp_nombres` VARCHAR(100), IN `vp_email` VARCHAR(100), OUT `mensaje` TEXT)   BEGIN
	IF vp_id_cliente=0 THEN
    	INSERT INTO clientes(nombres, email, estado_cli)
        VALUES (vp_nombres,vp_email,true);
        
        SET mensaje="Cliente insertado correctamente";
    ELSE
    	UPDATE clientes
        SET nombres=vp_nombres,
        	email=vp_email
        WHERE id_cliente=vp_id_cliente;
        
        SET mensaje="Cliente actualizado correctamente";
    END IF;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_clientes_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_clientes_list` ()   BEGIN
    SELECT c.id_cliente, c.nombres, c.email
    FROM clientes c
    WHERE c.estado_cli=true
    ORDER BY 1;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_proyects_del`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_proyects_del` (IN `vp_id_proyecto` INT, OUT `mensaje` TEXT)   BEGIN
	UPDATE proyectos
    SET estado_pry=false
    WHERE id_proyecto=vp_id_proyecto;
    
    SET mensaje="Proyecto eliminado exitósamente";
END$$

DROP PROCEDURE IF EXISTS `api_inmo_proyects_get_pry`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_proyects_get_pry` (IN `vp_id_proyecto` INT)   BEGIN
	SELECT pr.id_proyecto, pr.name_pry
    FROM proyectos pr
    WHERE pr.id_proyecto=vp_id_proyecto AND pr.estado_pry=true;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_proyects_ins_upd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_proyects_ins_upd` (IN `vp_id_proyecto` INT, IN `vp_name_pry` VARCHAR(50), OUT `mensaje` TEXT)   BEGIN
	IF vp_id_proyecto=0 THEN
    	INSERT INTO proyectos(name_pry,estado_pry)
        VALUES (vp_name_pry,1);
        
        SET mensaje="Proyecto creado exitósamente";
    ELSE
    	UPDATE proyectos
        SET name_pry=vp_name_pry
        WHERE id_proyecto=vp_id_proyecto;
        
        SET mensaje="Proyecto actualizado exitósamente";
    END IF;
END$$

DROP PROCEDURE IF EXISTS `api_inmo_proyects_list`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `api_inmo_proyects_list` ()   BEGIN
	SELECT pr.id_proyecto, pr.name_pry
    FROM proyectos pr
    WHERE pr.estado_pry=true;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asoc_proy`
--

DROP TABLE IF EXISTS `asoc_proy`;
CREATE TABLE IF NOT EXISTS `asoc_proy` (
  `id_as_pry` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int DEFAULT NULL,
  `id_proyecto` int DEFAULT NULL,
  `fec_ini_as` date DEFAULT NULL,
  PRIMARY KEY (`id_as_pry`),
  KEY `fk_asoc_proy_clientes` (`id_cliente`),
  KEY `fk_asoc_proy_proyectos` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `asoc_proy`
--

INSERT INTO `asoc_proy` (`id_as_pry`, `id_cliente`, `id_proyecto`, `fec_ini_as`) VALUES
(4, 10, 1, '2024-01-01'),
(5, 12, 1, '2024-02-15'),
(6, 13, 1, '2024-04-20'),
(7, 14, 1, '2024-07-01'),
(10, 15, 5, '2024-07-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `email` varchar(80) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `estado_cli` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombres`, `email`, `estado_cli`) VALUES
(10, 'KARIN MIDORY DALLAS', 'karmir@hotmail.com', 1),
(11, 'MARTHA PEREZ CASTRO', 'mar_c@hotmail.com', 0),
(12, 'MARTHA CASTRO', 'mar_c@hotmail.com', 1),
(13, 'RAFAEL MENDEZ', 'rafita45@hotmail.com', 1),
(14, 'DANIEL PEREZ', 'danip68@icloud.com', 1),
(15, 'MAFER CUEVA', 'mafe_cu785@icloud.com', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_asoc_proy`
--

DROP TABLE IF EXISTS `detalle_asoc_proy`;
CREATE TABLE IF NOT EXISTS `detalle_asoc_proy` (
  `id_det_asoc` int NOT NULL AUTO_INCREMENT,
  `id_as_pry` int DEFAULT NULL,
  `fec_pago` date DEFAULT NULL,
  `monto_cuota` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_det_asoc`),
  KEY `fk_detalle_asoc_proy_asoc_proy_0` (`id_as_pry`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `detalle_asoc_proy`
--

INSERT INTO `detalle_asoc_proy` (`id_det_asoc`, `id_as_pry`, `fec_pago`, `monto_cuota`) VALUES
(1, 4, '2024-02-01', 369.90),
(2, 4, '2024-03-01', 369.90),
(3, 4, '2024-04-01', 369.90),
(4, 4, '2024-05-01', 369.90),
(5, 4, '2024-06-01', 369.90),
(6, 5, '2024-03-15', 569.90),
(7, 5, '2024-04-15', 569.90),
(8, 5, '2024-05-15', 569.90),
(9, 5, '2024-06-15', 569.90),
(10, 5, '2024-07-15', 569.90),
(11, 6, '2024-05-20', 759.90),
(12, 6, '2024-06-20', 759.90),
(13, 6, '2024-07-20', 759.90),
(14, 6, '2024-08-20', 759.90),
(15, 6, '2024-09-20', 759.90),
(16, 6, '2024-10-20', 759.90),
(17, 6, '2024-11-20', 759.90),
(18, 6, '2024-12-20', 759.90),
(19, 6, '2025-01-20', 759.90),
(20, 6, '2025-02-20', 759.90),
(21, 10, '2024-08-25', 1250.00),
(22, 10, '2024-09-25', 1250.00),
(23, 10, '2024-10-25', 1250.00),
(24, 10, '2024-11-25', 1250.00),
(25, 10, '2024-12-25', 1250.00),
(26, 10, '2025-01-25', 1250.00),
(27, 10, '2025-02-25', 1250.00),
(28, 10, '2025-03-25', 1250.00),
(29, 10, '2025-04-25', 1250.00),
(30, 10, '2025-05-25', 1250.00),
(31, 10, '2025-06-25', 1250.00),
(32, 10, '2025-07-25', 1250.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
CREATE TABLE IF NOT EXISTS `proyectos` (
  `id_proyecto` int NOT NULL AUTO_INCREMENT,
  `name_pry` varchar(50) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `estado_pry` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`id_proyecto`, `name_pry`, `estado_pry`) VALUES
(1, 'DARCI 1', 1),
(2, 'MARK 45', 0),
(3, 'MARK 45', 1),
(4, 'MARK 50', 1),
(5, 'KAMILA 10', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asoc_proy`
--
ALTER TABLE `asoc_proy`
  ADD CONSTRAINT `fk_asoc_proy_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `fk_asoc_proy_proyectos` FOREIGN KEY (`id_proyecto`) REFERENCES `proyectos` (`id_proyecto`);

--
-- Filtros para la tabla `detalle_asoc_proy`
--
ALTER TABLE `detalle_asoc_proy`
  ADD CONSTRAINT `fk_detalle_asoc_proy_asoc_proy_1` FOREIGN KEY (`id_as_pry`) REFERENCES `asoc_proy` (`id_as_pry`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
