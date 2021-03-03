-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Мар 02 2021 г., 11:23
-- Версия сервера: 5.6.43
-- Версия PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `workshops_ptk`
--
CREATE DATABASE IF NOT EXISTS `workshops_ptk` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `workshops_ptk`;

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`%` PROCEDURE `authorization` (IN `login` VARCHAR(35) CHARSET utf8mb4, IN `pass` VARCHAR(35) CHARSET utf8mb4)  NO SQL
SELECT IF ( EXISTS(SELECT * FROM users WHERE ((users.login = login) OR (users.email = login)) AND (users.password = PASSWORD(SHA(pass)))), true, false)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `activity`
--

CREATE TABLE `activity` (
  `activityID` int(11) NOT NULL AUTO_INCREMENT,
  `type_activity` smallint(6) NOT NULL,
  `time_interval` smallint(6) NOT NULL,
  `workshop` smallint(6) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `owner` smallint(6) NOT NULL,
  `status` smallint(2) NOT NULL,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `report`
--

CREATE TABLE `report` (
  `reportID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `report_file` mediumblob NOT NULL,
  PRIMARY KEY (`reportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `report_template`
--

CREATE TABLE `report_template` (
  `reporttemplateID` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `template_configeration` mediumblob NOT NULL,
  `template_file` mediumblob NOT NULL,
  PRIMARY KEY (`reporttemplateID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `time_intervals`
--

CREATE TABLE `time_intervals` (
  `timeintervalID` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  PRIMARY KEY (`timeintervalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `type_activity`
--

CREATE TABLE `type_activity` (
  `typeactivityID` smallint(3) NOT NULL AUTO_INCREMENT,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`typeactivityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `workshops_ptk`.`users` (
  `userID` SMALLINT NOT NULL AUTO_INCREMENT ,
  `login` VARCHAR(35) NOT NULL ,
  `password` VARBINARY(41) NOT NULL ,
  `email` VARCHAR(35) NULL ,
  `rights` SMALLINT(3) NOT NULL ,
  `name` VARCHAR(35) NOT NULL ,
  `lastname` VARCHAR(35) NOT NULL ,
  `middlename` VARCHAR(35) NOT NULL ,
  PRIMARY KEY (`userID`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `workshops`
--

CREATE TABLE `workshops` (
  `workshopsID` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `owner` smallint(6) DEFAULT NULL,
  `kabinet` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`workshopsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
--
-- Индексы таблицы `activity`
--
ALTER TABLE `activity`
  ADD KEY `owner` (`owner`),
  ADD KEY `workshop` (`workshop`),
  ADD KEY `time_interval` (`time_interval`),
  ADD KEY `type_activity` (`type_activity`);

ALTER TABLE `workshops`
  ADD KEY `owner` (`owner`);

--
-- Ограничения внешнего ключа таблицы `activity`
--
ALTER TABLE `activity`
  ADD CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`workshop`) REFERENCES `workshops` (`workshopsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_3` FOREIGN KEY (`time_interval`) REFERENCES `time_intervals` (`timeintervalID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `activity_ibfk_4` FOREIGN KEY (`type_activity`) REFERENCES `type_activity` (`typeactivityID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `workshops`
--
ALTER TABLE `workshops`
  ADD CONSTRAINT `workshops_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
