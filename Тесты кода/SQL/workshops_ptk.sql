-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 03 2021 г., 14:13
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_activity` (IN `startDate` DATE, IN `endDate` DATE)  NO SQL
SELECT
activity.activityID AS 'ID', activity.title AS 'title', activity.date AS 'date', time_intervals.title AS 'time_title', time_intervals.time_start AS 'time_start', time_intervals.time_end AS 'time_end', users.lastname AS 'lastname', users.name AS 'name', users.middlename AS 'midelename', workshops.kabinet AS 'kabinet', activity.description AS 'description', type_activity.title AS 'type_title'
FROM activity
LEFT OUTER JOIN time_intervals ON activity.time_interval = time_intervals.timeintervalID
LEFT OUTER JOIN type_activity ON activity.type_activity = type_activity.typeactivityID
LEFT OUTER JOIN workshops ON activity.workshop = workshops.workshopsID
LEFT OUTER JOIN users ON activity.owner = users.userID
WHERE (activity.date >= startDate) AND (activity.date <= endDate)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_my_workshop` (IN `userID` SMALLINT)  NO SQL
SELECT * FROM workshops WHERE workshops.owner = userID$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `activity`
--

CREATE TABLE `activity` (
  `activityID` int(11) NOT NULL,
  `type_activity` smallint(6) NOT NULL,
  `time_interval` smallint(6) NOT NULL,
  `date` date NOT NULL,
  `workshop` smallint(6) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner` smallint(6) NOT NULL,
  `status` smallint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `activity`
--

INSERT INTO `activity` (`activityID`, `type_activity`, `time_interval`, `date`, `workshop`, `title`, `description`, `owner`, `status`) VALUES
(3, 1, 1, '2021-04-05', 1, 'ТРиЗБД', NULL, 2, 1),
(4, 2, 2, '2021-04-06', 1, 'БД', NULL, 2, 1),
(5, 1, 5, '2021-04-07', 1, 'БД', NULL, 2, 0),
(6, 2, 4, '2021-04-08', 1, 'ТРиЗБД', NULL, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `report`
--

CREATE TABLE `report` (
  `reportID` int(11) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `report_file` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `report_template`
--

CREATE TABLE `report_template` (
  `reporttemplateID` smallint(6) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `template_configeration` mediumblob NOT NULL,
  `template_file` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `time_intervals`
--

CREATE TABLE `time_intervals` (
  `timeintervalID` smallint(6) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `time_intervals`
--

INSERT INTO `time_intervals` (`timeintervalID`, `title`, `time_start`, `time_end`) VALUES
(1, 'Первая пара', '08:30:00', '10:10:00'),
(2, 'Вторая пара', '10:20:00', '12:00:00'),
(3, 'Третья пара', '12:45:00', '14:25:00'),
(4, 'Четвёртая пара', '14:35:00', '16:15:00'),
(5, 'Пятая пара', '16:25:00', '18:05:00');

-- --------------------------------------------------------

--
-- Структура таблицы `type_activity`
--

CREATE TABLE `type_activity` (
  `typeactivityID` smallint(3) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `type_activity`
--

INSERT INTO `type_activity` (`typeactivityID`, `title`, `description`) VALUES
(1, 'Лекция', NULL),
(2, 'Практика', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `userID` smallint(6) NOT NULL,
  `login` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `password` varbinary(41) NOT NULL,
  `email` varchar(35) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rights` smallint(3) NOT NULL,
  `name` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `middlename` varchar(35) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`userID`, `login`, `password`, `email`, `rights`, `name`, `lastname`, `middlename`) VALUES
(1, 'dradinc', 0x2a36373431433644303343384142443932373845434339394338343735424142433330384234354634, 'dradinc@yandex.ru', 0, 'Артём', 'Дубогрей', 'Евгеньевич'),
(2, 'loric23', 0x2a39324242453646393133433845374144413046333032463042413331384537423232314238453445, NULL, 0, 'Лариса', 'Цымбалюк', 'Николаевна');

-- --------------------------------------------------------

--
-- Структура таблицы `workshops`
--

CREATE TABLE `workshops` (
  `workshopsID` smallint(6) NOT NULL,
  `title` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner` smallint(6) DEFAULT NULL,
  `kabinet` varchar(4) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `workshops`
--

INSERT INTO `workshops` (`workshopsID`, `title`, `description`, `owner`, `kabinet`) VALUES
(1, 'Веб дизайн и разработка', NULL, 2, '124');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`activityID`),
  ADD KEY `owner` (`owner`),
  ADD KEY `workshop` (`workshop`),
  ADD KEY `time_interval` (`time_interval`),
  ADD KEY `type_activity` (`type_activity`);

--
-- Индексы таблицы `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`reportID`);

--
-- Индексы таблицы `report_template`
--
ALTER TABLE `report_template`
  ADD PRIMARY KEY (`reporttemplateID`);

--
-- Индексы таблицы `time_intervals`
--
ALTER TABLE `time_intervals`
  ADD PRIMARY KEY (`timeintervalID`);

--
-- Индексы таблицы `type_activity`
--
ALTER TABLE `type_activity`
  ADD PRIMARY KEY (`typeactivityID`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- Индексы таблицы `workshops`
--
ALTER TABLE `workshops`
  ADD PRIMARY KEY (`workshopsID`),
  ADD KEY `owner` (`owner`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `activity`
--
ALTER TABLE `activity`
  MODIFY `activityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `report`
--
ALTER TABLE `report`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `report_template`
--
ALTER TABLE `report_template`
  MODIFY `reporttemplateID` smallint(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `time_intervals`
--
ALTER TABLE `time_intervals`
  MODIFY `timeintervalID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `type_activity`
--
ALTER TABLE `type_activity`
  MODIFY `typeactivityID` smallint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `userID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `workshops`
--
ALTER TABLE `workshops`
  MODIFY `workshopsID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

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
