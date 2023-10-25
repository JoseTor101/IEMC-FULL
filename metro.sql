-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-05-2023 a las 17:38:11
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `metro`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipousuario`
--

CREATE TABLE `tipousuario` (
  `codigo` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipousuario`
--

INSERT INTO `tipousuario` (`codigo`, `descripcion`) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `codigo` int(11) NOT NULL DEFAULT 2,
  `clave` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `correo`, `nombre`, `telefono`, `cedula`, `codigo`, `clave`) VALUES
(1, 'veronica@gmail.com', 'Camila', '3017468798', '1013456695', 2, '123'),
(2, 'vmvalencia@eafit.edu.co', 'Valentina Mor Valencia', '3137253243', '1013456695', 2, '123'),
(3, 'gabriela123@gmail.com', 'Gabriela', '134567796', '123', 2, 'Gabriela12345678@');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `descripcion` (`descripcion`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`) USING BTREE,
  ADD KEY `clave` (`clave`),
  ADD KEY `codigo` (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tipousuario`
--
ALTER TABLE `tipousuario`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

-- TABLA CITAS
CREATE TABLE `citas` (
    `codigo_cita` VARCHAR(10) NOT NULL,
    `nombre` VARCHAR(25) NOT NULL,
    `cedula` VARCHAR(10) NOT NULL,
    `fecha_prestacion` DATETIME NOT NULL,
    `fecha_final` DATETIME NOT NULL,
    `nombre_dispositivo` VARCHAR(100) NOT NULL,
    `modelo_dispositivo` VARCHAR(100) NOT NULL,
    `especificaciones` VARCHAR(300) NOT NULL,
    `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `servicio` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`codigo_cita`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `citas`
--

INSERT INTO `citas` (`codigo_cita`, `nombre`, `cedula`, `fecha_prestacion`, `fecha_final`, `nombre_dispositivo`, `modelo_dispositivo`, `especificaciones`, `fecha_creacion`, `servicio`) VALUES
('5R1MnTMlfT', 'Camilo', '1013456695', '2023-05-29 19:55:00', '2023-05-29 19:55:00', 'Huawei', '2', 'quiero un antivirus', '2023-05-30 00:55:41', 'instalacion'),
('JG0nApJLL1', 'Gabriela', '123', '2023-05-30 21:27:00', '2023-06-02 21:27:00', 'Huawei', '232', 'no prende', '2023-05-30 02:27:14', 'reparacion'),
('NjjHIbShAt', 'Camilo', '1013456695', '2023-05-29 19:55:00', '2023-05-30 19:55:00', 'Huawei', '1', 'Se rompió', '2023-05-30 00:55:14', 'reparacion');


CREATE TABLE `citas_eliminadas` (
  `codigo_cita` varchar(10) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `cedula` varchar(10) NOT NULL,
  `fecha_prestacion` datetime NOT NULL,
  `fecha_final` datetime NOT NULL,
  `nombre_dispositivo` varchar(100) NOT NULL,
  `modelo_dispositivo` varchar(100) NOT NULL,
  `especificaciones` varchar(300) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `servicio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- PROCEDIMIENTO 
DELIMITER //

CREATE PROCEDURE `eliminar_cita` (
  IN `codigo_cita_param` VARCHAR(10)
)
BEGIN
  -- Variable para almacenar los detalles de la cita eliminada
  DECLARE `v_nombre` VARCHAR(25);
  DECLARE `v_cedula` VARCHAR(10);
  DECLARE `v_fecha_prestacion` DATETIME;
  DECLARE `v_fecha_final` DATETIME;
  DECLARE `v_nombre_dispositivo` VARCHAR(100);
  DECLARE `v_modelo_dispositivo` VARCHAR(100);
  DECLARE `v_especificaciones` VARCHAR(300);
  DECLARE `v_fecha_creacion` TIMESTAMP;
  DECLARE `v_servicio` VARCHAR(20);

  -- Obtener los detalles de la cita eliminada
  SELECT `nombre`, `cedula`, `fecha_prestacion`, `fecha_final`, `nombre_dispositivo`, `modelo_dispositivo`, `especificaciones`, `fecha_creacion`, `servicio`
  INTO `v_nombre`, `v_cedula`, `v_fecha_prestacion`, `v_fecha_final`, `v_nombre_dispositivo`, `v_modelo_dispositivo`, `v_especificaciones`, `v_fecha_creacion`, `v_servicio`
  FROM `citas`
  WHERE `citas`.`codigo_cita` = `codigo_cita_param`;

  -- Insertar los detalles de la cita eliminada en la tabla citas_eliminadas
  INSERT INTO `citas_eliminadas` (`codigo_cita`, `nombre`, `cedula`, `fecha_prestacion`, `fecha_final`, `nombre_dispositivo`, `modelo_dispositivo`, `especificaciones`, `fecha_creacion`, `servicio`)
  VALUES (`codigo_cita_param`, `v_nombre`, `v_cedula`, `v_fecha_prestacion`, `v_fecha_final`, `v_nombre_dispositivo`, `v_modelo_dispositivo`, `v_especificaciones`, `v_fecha_creacion`, `v_servicio`);

  -- Eliminar la cita de la tabla citas
  DELETE FROM `citas`
  WHERE `citas`.`codigo_cita` = `codigo_cita_param`;
  
END //

DELIMITER ;

-- Crear el trigger
DELIMITER //
CREATE TRIGGER `mayusculas` BEFORE INSERT ON `citas`
FOR EACH ROW
BEGIN
    SET NEW.`especificaciones` = UPPER(NEW.`especificaciones`);
END //
DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
