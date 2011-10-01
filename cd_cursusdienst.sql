-- phpMyAdmin SQL Dump
-- version 3.4.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 01, 2011 at 05:54 PM
-- Server version: 5.0.92
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cd_cursusdienst`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE IF NOT EXISTS `action_logs` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `action` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=151 ;

--
-- Table structure for table `attachments`
--

CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(11) NOT NULL auto_increment,
  `material_id` int(11) default NULL,
  `item` varchar(255) collate utf8_unicode_ci default NULL,
  `content_type` varchar(255) collate utf8_unicode_ci default NULL,
  `file_size` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `attachments`
--

INSERT INTO `attachments` (`id`, `material_id`, `item`, `content_type`, `file_size`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 1, '23A_-_Politicologie__algemene_inleiding_Samenvatting.pdf', 'application/pdf', 9222, '2011-09-28 14:27:18', '2011-09-28 14:27:18', 0),
(2, 1, '23A-rv_-_Politicologie__algemene_inleiding_Samenvatting.pdf', 'application/pdf', 9742, '2011-09-28 14:27:18', '2011-09-28 14:27:18', 0),
(3, 1, '23C_-_Politicologie__algemene_inleiding_Samenvatting.pdf', 'application/pdf', 558734, '2011-09-28 14:27:18', '2011-09-28 14:27:18', 0),
(5, 2, '33C_-_Macro-Economie_Samenvatting.pdf', 'application/pdf', 4307627, '2011-09-28 16:41:02', '2011-09-28 16:41:02', 0),
(6, 2, '33A-rv_-_Macro-Economie_Samenvatting.pdf', 'application/pdf', 7374, '2011-09-28 16:41:02', '2011-09-28 16:41:02', 0),
(7, 2, '33A_-_Macro-Economie_Samenvatting.pdf', 'application/pdf', 7256, '2011-09-28 16:41:02', '2011-09-28 16:41:02', 0);

-- --------------------------------------------------------

--
-- Table structure for table `book_costs`
--

CREATE TABLE IF NOT EXISTS `book_costs` (
  `id` int(11) NOT NULL auto_increment,
  `amount` float default NULL,
  `supply_id` int(11) default NULL,
  `deleted` tinyint(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `book_costs`
--

INSERT INTO `book_costs` (`id`, `amount`, `supply_id`, `deleted`, `created_at`, `updated_at`) VALUES
(1, 5, 4, NULL, '2011-10-01 11:54:25', '2011-10-01 11:54:25'),
(2, 5, 5, NULL, '2011-10-01 12:01:36', '2011-10-01 12:01:36');

-- --------------------------------------------------------

--
-- Table structure for table `disciplines`
--

CREATE TABLE IF NOT EXISTS `disciplines` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `faculty_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `disciplines`
--

INSERT INTO `disciplines` (`id`, `name`, `faculty_id`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'Computerwetenschappen', 1, '2011-09-28 14:12:52', '2011-09-28 14:12:52', 0),
(2, 'Fysica', 1, '2011-09-28 14:13:25', '2011-09-28 14:13:25', 0),
(3, 'Chemie', 1, '2011-09-28 14:13:51', '2011-09-28 14:13:51', 0),
(4, 'Biologie', 1, '2011-09-28 14:14:22', '2011-09-28 14:14:22', 0),
(5, 'Wiskunde', 1, '2011-09-28 14:14:52', '2011-09-28 14:14:52', 0),
(6, 'Geografie', 1, '2011-09-28 14:15:15', '2011-09-28 14:15:15', 0),
(7, 'Bio-ingenieurswetenschappen', 1, '2011-09-28 14:16:03', '2011-09-28 14:16:03', 0),
(8, 'Politieke Wetenschappen', 7, '2011-09-28 14:16:32', '2011-09-28 14:16:32', 0),
(9, 'Ingenieurswetenschappen', 5, '2011-09-28 14:20:36', '2011-09-28 14:40:02', 0),
(10, 'Geschiedenis', 4, '2011-09-28 14:21:25', '2011-09-28 14:21:25', 0),
(11, ' Lichamelijke opvoeding en bewegingswetenschappen', 6, '2011-09-28 14:23:03', '2011-09-28 14:23:03', 0),
(12, 'psychologie', 3, '2011-09-28 14:24:48', '2011-09-28 14:24:48', 0),
(13, 'Rechten', 2, '2011-09-28 14:25:23', '2011-09-28 14:25:23', 0),
(14, 'Communicatiewetenschappen', 4, '2011-09-28 14:32:13', '2011-09-28 14:32:13', 0),
(15, 'Handelsingenieur', 7, '2011-09-28 14:36:25', '2011-09-28 14:36:25', 0),
(16, 'Criminologie', 2, '2011-09-30 09:02:56', '2011-09-30 09:02:56', 0),
(17, 'SEP', 8, '2011-10-01 10:33:01', '2011-10-01 10:33:01', 0);

-- --------------------------------------------------------

--
-- Table structure for table `disciplines_guilds`
--

CREATE TABLE IF NOT EXISTS `disciplines_guilds` (
  `guild_id` int(11) default NULL,
  `discipline_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `disciplines_guilds`
--

INSERT INTO `disciplines_guilds` (`guild_id`, `discipline_id`) VALUES
(1, 14),
(2, 6),
(3, 12),
(4, 15),
(5, 8),
(6, 10),
(7, 9),
(8, 13),
(9, 1),
(10, 17);

-- --------------------------------------------------------

--
-- Table structure for table `disciplines_users`
--

CREATE TABLE IF NOT EXISTS `disciplines_users` (
  `user_id` int(11) default NULL,
  `discipline_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE IF NOT EXISTS `faculties` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `institute_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `initials` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  KEY `index_faculties_on_institute_id` (`institute_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `faculties`
--

INSERT INTO `faculties` (`id`, `name`, `institute_id`, `created_at`, `updated_at`, `initials`, `deleted`) VALUES
(1, 'Wetenschappen en Bio-ingenieurswetenschappen', 1, '2011-09-28 14:12:35', '2011-09-28 14:12:35', 'WE', 0),
(2, 'Recht en Criminologie', 1, '2011-09-28 14:12:58', '2011-09-28 14:12:58', 'RC', 0),
(3, 'Psychologie en Educatiewetenschappen', 1, '2011-09-28 14:13:36', '2011-09-28 14:13:36', 'PE', 0),
(4, 'Letteren en Wijsbegeerte', 1, '2011-09-28 14:14:06', '2011-09-28 14:14:06', 'LW', 0),
(5, 'Ingenieurswetenschappen', 1, '2011-09-28 14:14:32', '2011-09-28 14:14:32', 'IR', 0),
(6, 'Lichamelijke Opvoeding en Kinesitherapie', 1, '2011-09-28 14:15:01', '2011-09-28 14:15:01', 'LK', 0),
(7, 'Faculteit Economische, Sociale en Politieke Wetenschappen & Solvay Business School', 1, '2011-09-28 14:15:58', '2011-09-28 14:15:58', 'ES', 0),
(8, 'Open Bibliotheek', 2, '2011-10-01 10:32:53', '2011-10-01 12:33:11', 'OB', 0);

-- --------------------------------------------------------

--
-- Table structure for table `foobars`
--

CREATE TABLE IF NOT EXISTS `foobars` (
  `id` int(11) NOT NULL auto_increment,
  `deleted` tinyint(1) default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `guilds`
--

CREATE TABLE IF NOT EXISTS `guilds` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `initials` varchar(255) collate utf8_unicode_ci default NULL,
  `discipline_id` int(11) default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `guilds`
--

INSERT INTO `guilds` (`id`, `name`, `initials`, `discipline_id`, `deleted`) VALUES
(1, 'Perskring', 'PERS', NULL, 0),
(2, 'Wetenschappelijke Kring ', 'WK', NULL, 0),
(3, 'Psycho-Pedagogische Kring ', 'PPK', NULL, 0),
(4, 'Solvay', 'SOLVAY', NULL, 0),
(5, 'Economie, Sociale en Politieke Wetenschappen', 'ESP', NULL, 0),
(6, 'Letteren -en Wijsbegeerte Kring ', 'LWK', NULL, 0),
(7, 'Polytechnische Kring ', 'PK', NULL, 0),
(8, 'Het Vlaams Rechtsgenootschap', 'VRG', NULL, 0),
(9, 'Infogroep', 'ig', NULL, 0),
(10, 'Overkoepelende StudentencursusDienst', 'OSD', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `guilds_users`
--

CREATE TABLE IF NOT EXISTS `guilds_users` (
  `guild_id` int(11) default NULL,
  `user_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `guilds_users`
--

INSERT INTO `guilds_users` (`guild_id`, `user_id`) VALUES
(5, 3),
(5, 6),
(5, 7),
(5, 8),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(3, 15),
(7, 16),
(6, 14),
(8, 17),
(8, 24),
(8, 25),
(4, 26),
(8, 28),
(5, 31),
(9, 5),
(5, 4),
(9, 2),
(5, 33),
(5, 34),
(5, 35);

-- --------------------------------------------------------

--
-- Table structure for table `info_strings`
--

CREATE TABLE IF NOT EXISTS `info_strings` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(255) collate utf8_unicode_ci default NULL,
  `content` varchar(255) collate utf8_unicode_ci default NULL,
  `guild_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `info_strings`
--

INSERT INTO `info_strings` (`id`, `key`, `content`, `guild_id`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'cash', '<p>hahaha</p>', 5, '2011-09-30 14:46:39', '2011-09-30 14:46:39', 0),
(2, 'cash', '<p>hahahahaha ge gaat betalen</p>', 5, '2011-09-30 14:47:05', '2011-09-30 14:47:05', 0),
(3, 'transfer', '<p>lalalala</p>', 5, '2011-09-30 14:49:08', '2011-09-30 14:49:08', 0),
(4, 'general_payment', '<p>keicool</p>', 5, '2011-09-30 14:49:25', '2011-09-30 14:49:25', 0);

-- --------------------------------------------------------

--
-- Table structure for table `institutes`
--

CREATE TABLE IF NOT EXISTS `institutes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `initials` varchar(255) collate utf8_unicode_ci default NULL,
  `location` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `institutes`
--

INSERT INTO `institutes` (`id`, `name`, `initials`, `location`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'Vrije Universiteit Brussel', 'VUB', 'Brussels Gewest', '2011-09-28 14:09:24', '2011-10-01 12:36:29', 0),
(2, 'Tyca', 'Tyca', 'Brussels Gewest', '2011-10-01 10:32:09', '2011-10-01 10:32:09', 0);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE IF NOT EXISTS `materials` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `subject_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `nr` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `path_name` varchar(255) collate utf8_unicode_ci default NULL,
  `typee` varchar(255) collate utf8_unicode_ci default NULL,
  `info` varchar(255) collate utf8_unicode_ci default NULL,
  `page_count` int(11) default '-1',
  `printable` tinyint(1) default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `name`, `subject_id`, `created_at`, `updated_at`, `nr`, `parent_id`, `path_name`, `typee`, `info`, `page_count`, `printable`, `deleted`) VALUES
(1, '2011', 2, '2011-09-28 14:27:18', '2011-09-28 14:27:18', NULL, NULL, NULL, 'Samenvatting', '', 40, 1, 0),
(2, '2011', 3, '2011-09-28 16:41:02', '2011-09-28 16:41:02', NULL, NULL, NULL, 'Samenvatting', 'steunt op het boek van 2009', 250, 0, 0),
(3, '2000', 4, '2011-09-30 09:08:29', '2011-09-30 09:08:29', NULL, NULL, NULL, 'Boek', 'Officieel handboek', -1, 0, 0),
(4, '2011-2012', 7, '2011-09-30 10:44:02', '2011-09-30 10:44:02', NULL, NULL, NULL, 'Boek', '', -1, 0, 0),
(5, '2011-2012', 8, '2011-09-30 10:45:57', '2011-09-30 10:45:57', NULL, NULL, NULL, 'Boek', '', -1, 0, 0),
(6, 'Versie 2010', 12, '2011-10-01 11:14:38', '2011-10-01 11:14:38', NULL, NULL, NULL, 'Samenvatting', '', -1, 1, 0),
(7, 'Versie 2007', 13, '2011-10-01 11:50:25', '2011-10-01 13:08:58', NULL, NULL, NULL, 'Samenvatting', '', 139, 1, 0),
(8, 'Versie 2007', 13, '2011-10-01 11:53:42', '2011-10-01 11:53:42', NULL, NULL, NULL, 'Samenvatting', '', 139, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `materials_options`
--

CREATE TABLE IF NOT EXISTS `materials_options` (
  `material_id` int(11) default NULL,
  `option_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `material_orders`
--

CREATE TABLE IF NOT EXISTS `material_orders` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL,
  `material_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `guild_id` int(11) default NULL,
  `amount` int(11) default NULL,
  `deleted` tinyint(1) default '0',
  `price` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `material_orders`
--

INSERT INTO `material_orders` (`id`, `order_id`, `material_id`, `created_at`, `updated_at`, `guild_id`, `amount`, `deleted`, `price`) VALUES
(1, 14, 1, '2011-09-30 22:25:43', '2011-09-30 22:25:43', 5, 1, 0, 5),
(2, 17, 6, '2011-10-01 14:48:26', '2011-10-01 14:48:26', 5, 1, 0, 101.4);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL auto_increment,
  `guild_id` int(11) default NULL,
  `content` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `guild_id`, `content`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 10, '<p>TEST</p>', '2011-10-01 10:33:46', '2011-10-01 10:33:46', 0),
(2, 5, '<p>test</p>', '2011-10-01 14:39:07', '2011-10-01 14:39:07', 0);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE IF NOT EXISTS `options` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `typee` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `created_at`, `updated_at`, `name`, `typee`, `deleted`) VALUES
(11, '2011-09-28 16:15:25', '2011-09-28 16:15:25', 'single sided - black and white', 'printer', 0),
(12, '2011-09-28 16:15:57', '2011-09-28 16:15:57', 'Single sided - color', 'printer', 0),
(13, '2011-09-28 16:16:02', '2011-09-28 16:16:02', 'Duplex - black and white', 'printer', 0),
(14, '2011-09-28 16:16:08', '2011-09-28 16:16:08', 'Duplex - color', 'printer', 0),
(15, '2011-09-28 16:16:15', '2011-09-28 16:16:15', 'Inbinding: Lijm + plastiek', 'printer', 0),
(16, '2011-09-28 16:16:20', '2011-09-28 16:16:20', 'Inbinding: Lijm + zonder plastiek', 'printer', 0),
(17, '2011-09-28 16:16:25', '2011-09-28 16:16:25', 'Inbinding: Ringen + plastiek', 'printer', 0),
(18, '2011-09-28 16:16:32', '2011-09-28 16:16:32', 'Inbinding: Ringen + zonder plastiek', 'printer', 0),
(19, '2011-09-28 16:16:39', '2011-09-28 16:16:39', '1 slide per pagina', 'user', 0),
(20, '2011-09-28 16:16:48', '2011-09-28 16:16:48', '3 slides per pagina', 'user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `order_key` varchar(255) collate utf8_unicode_ci default NULL,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `institute_id` int(11) default NULL,
  `payment_type` varchar(255) collate utf8_unicode_ci default NULL,
  `label` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_key`, `status`, `created_at`, `updated_at`, `institute_id`, `payment_type`, `label`, `deleted`) VALUES
(13, 4, '8555056', 'Posted', '2011-09-30 22:24:35', '2011-09-30 22:24:35', 1, 'cash', NULL, 0),
(14, 4, '8569795', 'Posted', '2011-09-30 22:25:43', '2011-09-30 22:25:43', 1, 'transfer', NULL, 0),
(15, 4, '6056806', 'Posted', '2011-09-30 22:27:23', '2011-09-30 22:27:23', 1, 'cash', NULL, 0),
(16, 13, '2933100', 'Posted', '2011-10-01 11:36:06', '2011-10-01 11:36:06', 1, NULL, NULL, 0),
(17, 34, '5541587', 'Posted', '2011-10-01 14:48:26', '2011-10-01 14:48:26', 1, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `permission_groups`
--

CREATE TABLE IF NOT EXISTS `permission_groups` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `level` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=100 ;

--
-- Dumping data for table `permission_groups`
--

INSERT INTO `permission_groups` (`id`, `name`, `level`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'use_control_panel', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(2, 'sell_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(3, 'sell_all_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(4, 'create_all_messages', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(5, 'view_all_stock', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(6, 'view_all_orders', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(7, 'print', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(8, 'download_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(9, 'edit_users', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(10, 'delete_users', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(11, 'view_users', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(12, 'edit_permissions', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(13, 'delete_permissions', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(14, 'view_permissions', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(15, 'create_permissions', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(16, 'edit_disciplines', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(17, 'delete_disciplines', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(18, 'view_disciplines', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(19, 'create_disciplines', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(20, 'edit_subjects', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(21, 'delete_subjects', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(22, 'view_subjects', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(23, 'create_subjects', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(24, 'edit_permission_groups', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(25, 'delete_permission_groups', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(26, 'view_permission_groups', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(27, 'create_permission_groups', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(28, 'edit_options', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(29, 'delete_options', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(30, 'view_options', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(31, 'create_options', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(32, 'edit_institutes', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(33, 'delete_institutes', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(34, 'view_institutes', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(35, 'create_institutes', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(36, 'edit_guilds', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(37, 'delete_guilds', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(38, 'view_guilds', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(39, 'create_guilds', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(40, 'edit_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(41, 'delete_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(42, 'view_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(43, 'create_materials', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(44, 'edit_faculties', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(45, 'delete_faculties', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(46, 'view_faculties', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(47, 'create_faculties', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(48, 'edit_messages', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(49, 'delete_messages', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(50, 'create_messages', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(51, 'edit_stock', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(52, 'delete_stock', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(53, 'view_stock', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(54, 'edit_printers', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(55, 'delete_printers', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(56, 'view_printers', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(57, 'create_printers', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(58, 'edit_prices', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(59, 'delete_prices', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(60, 'view_prices', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(61, 'create_prices', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(62, 'edit_price_sets', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(63, 'delete_price_sets', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(64, 'view_price_sets', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(65, 'create_price_sets', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(66, 'edit_action_logs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(67, 'delete_action_logs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(68, 'view_action_logs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(69, 'create_action_logs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(70, 'edit_attachments', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(71, 'delete_attachments', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(72, 'view_attachments', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(73, 'create_attachments', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(74, 'edit_info_strings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(75, 'delete_info_strings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(76, 'view_info_strings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(77, 'create_info_strings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(78, 'edit_orders', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(79, 'delete_orders', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(80, 'view_orders', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(81, 'create_orders', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(82, 'edit_print_jobs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(83, 'delete_print_jobs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(84, 'view_print_jobs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(85, 'create_print_jobs', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(86, 'edit_ratings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(87, 'delete_ratings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(88, 'view_ratings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(89, 'create_ratings', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(90, 'edit_supplies', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(91, 'delete_supplies', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(92, 'view_supplies', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(93, 'create_supplies', NULL, '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0),
(95, 'set_order_status', NULL, '2011-10-01 08:17:09', '2011-10-01 08:17:09', 0),
(96, 'view_side_supply', NULL, '2011-10-01 08:20:05', '2011-10-01 08:20:05', 0),
(98, 'view_all_guilds', NULL, '2011-10-01 08:31:14', '2011-10-01 08:31:14', 0),
(99, 'join_guilds', NULL, '2011-10-01 08:34:11', '2011-10-01 08:34:11', 0);

-- --------------------------------------------------------

--
-- Table structure for table `permission_groups_users`
--

CREATE TABLE IF NOT EXISTS `permission_groups_users` (
  `permission_group_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permission_groups_users`
--

INSERT INTO `permission_groups_users` (`permission_group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(2, 1, NULL, NULL),
(3, 1, NULL, NULL),
(4, 1, NULL, NULL),
(5, 1, NULL, NULL),
(6, 1, NULL, NULL),
(7, 1, NULL, NULL),
(8, 1, NULL, NULL),
(9, 1, NULL, NULL),
(10, 1, NULL, NULL),
(11, 1, NULL, NULL),
(12, 1, NULL, NULL),
(13, 1, NULL, NULL),
(14, 1, NULL, NULL),
(15, 1, NULL, NULL),
(16, 1, NULL, NULL),
(17, 1, NULL, NULL),
(18, 1, NULL, NULL),
(19, 1, NULL, NULL),
(20, 1, NULL, NULL),
(21, 1, NULL, NULL),
(22, 1, NULL, NULL),
(23, 1, NULL, NULL),
(24, 1, NULL, NULL),
(25, 1, NULL, NULL),
(26, 1, NULL, NULL),
(27, 1, NULL, NULL),
(28, 1, NULL, NULL),
(29, 1, NULL, NULL),
(30, 1, NULL, NULL),
(31, 1, NULL, NULL),
(32, 1, NULL, NULL),
(33, 1, NULL, NULL),
(34, 1, NULL, NULL),
(35, 1, NULL, NULL),
(36, 1, NULL, NULL),
(37, 1, NULL, NULL),
(38, 1, NULL, NULL),
(39, 1, NULL, NULL),
(40, 1, NULL, NULL),
(41, 1, NULL, NULL),
(42, 1, NULL, NULL),
(43, 1, NULL, NULL),
(44, 1, NULL, NULL),
(45, 1, NULL, NULL),
(46, 1, NULL, NULL),
(47, 1, NULL, NULL),
(48, 1, NULL, NULL),
(49, 1, NULL, NULL),
(50, 1, NULL, NULL),
(51, 1, NULL, NULL),
(52, 1, NULL, NULL),
(53, 1, NULL, NULL),
(54, 1, NULL, NULL),
(55, 1, NULL, NULL),
(56, 1, NULL, NULL),
(57, 1, NULL, NULL),
(58, 1, NULL, NULL),
(59, 1, NULL, NULL),
(60, 1, NULL, NULL),
(61, 1, NULL, NULL),
(62, 1, NULL, NULL),
(63, 1, NULL, NULL),
(64, 1, NULL, NULL),
(65, 1, NULL, NULL),
(66, 1, NULL, NULL),
(67, 1, NULL, NULL),
(68, 1, NULL, NULL),
(69, 1, NULL, NULL),
(70, 1, NULL, NULL),
(71, 1, NULL, NULL),
(72, 1, NULL, NULL),
(73, 1, NULL, NULL),
(74, 1, NULL, NULL),
(75, 1, NULL, NULL),
(76, 1, NULL, NULL),
(77, 1, NULL, NULL),
(78, 1, NULL, NULL),
(79, 1, NULL, NULL),
(80, 1, NULL, NULL),
(81, 1, NULL, NULL),
(82, 1, NULL, NULL),
(83, 1, NULL, NULL),
(84, 1, NULL, NULL),
(85, 1, NULL, NULL),
(86, 1, NULL, NULL),
(87, 1, NULL, NULL),
(88, 1, NULL, NULL),
(89, 1, NULL, NULL),
(90, 1, NULL, NULL),
(91, 1, NULL, NULL),
(92, 1, NULL, NULL),
(93, 1, NULL, NULL),
(1, 2, NULL, NULL),
(2, 2, NULL, NULL),
(3, 2, NULL, NULL),
(4, 2, NULL, NULL),
(5, 2, NULL, NULL),
(6, 2, NULL, NULL),
(7, 2, NULL, NULL),
(8, 2, NULL, NULL),
(9, 2, NULL, NULL),
(10, 2, NULL, NULL),
(11, 2, NULL, NULL),
(12, 2, NULL, NULL),
(13, 2, NULL, NULL),
(14, 2, NULL, NULL),
(15, 2, NULL, NULL),
(16, 2, NULL, NULL),
(17, 2, NULL, NULL),
(18, 2, NULL, NULL),
(19, 2, NULL, NULL),
(20, 2, NULL, NULL),
(21, 2, NULL, NULL),
(22, 2, NULL, NULL),
(23, 2, NULL, NULL),
(24, 2, NULL, NULL),
(25, 2, NULL, NULL),
(26, 2, NULL, NULL),
(27, 2, NULL, NULL),
(28, 2, NULL, NULL),
(29, 2, NULL, NULL),
(30, 2, NULL, NULL),
(31, 2, NULL, NULL),
(32, 2, NULL, NULL),
(33, 2, NULL, NULL),
(34, 2, NULL, NULL),
(35, 2, NULL, NULL),
(36, 2, NULL, NULL),
(37, 2, NULL, NULL),
(38, 2, NULL, NULL),
(39, 2, NULL, NULL),
(40, 2, NULL, NULL),
(41, 2, NULL, NULL),
(42, 2, NULL, NULL),
(43, 2, NULL, NULL),
(44, 2, NULL, NULL),
(45, 2, NULL, NULL),
(46, 2, NULL, NULL),
(47, 2, NULL, NULL),
(48, 2, NULL, NULL),
(49, 2, NULL, NULL),
(50, 2, NULL, NULL),
(51, 2, NULL, NULL),
(52, 2, NULL, NULL),
(53, 2, NULL, NULL),
(54, 2, NULL, NULL),
(55, 2, NULL, NULL),
(56, 2, NULL, NULL),
(57, 2, NULL, NULL),
(58, 2, NULL, NULL),
(59, 2, NULL, NULL),
(60, 2, NULL, NULL),
(61, 2, NULL, NULL),
(62, 2, NULL, NULL),
(63, 2, NULL, NULL),
(64, 2, NULL, NULL),
(65, 2, NULL, NULL),
(66, 2, NULL, NULL),
(67, 2, NULL, NULL),
(68, 2, NULL, NULL),
(69, 2, NULL, NULL),
(70, 2, NULL, NULL),
(71, 2, NULL, NULL),
(72, 2, NULL, NULL),
(73, 2, NULL, NULL),
(74, 2, NULL, NULL),
(75, 2, NULL, NULL),
(76, 2, NULL, NULL),
(77, 2, NULL, NULL),
(78, 2, NULL, NULL),
(79, 2, NULL, NULL),
(80, 2, NULL, NULL),
(81, 2, NULL, NULL),
(82, 2, NULL, NULL),
(83, 2, NULL, NULL),
(84, 2, NULL, NULL),
(85, 2, NULL, NULL),
(86, 2, NULL, NULL),
(87, 2, NULL, NULL),
(88, 2, NULL, NULL),
(89, 2, NULL, NULL),
(90, 2, NULL, NULL),
(91, 2, NULL, NULL),
(92, 2, NULL, NULL),
(93, 2, NULL, NULL),
(1, 3, NULL, NULL),
(2, 3, NULL, NULL),
(3, 3, NULL, NULL),
(4, 3, NULL, NULL),
(5, 3, NULL, NULL),
(6, 3, NULL, NULL),
(7, 3, NULL, NULL),
(8, 3, NULL, NULL),
(9, 3, NULL, NULL),
(10, 3, NULL, NULL),
(11, 3, NULL, NULL),
(12, 3, NULL, NULL),
(13, 3, NULL, NULL),
(14, 3, NULL, NULL),
(15, 3, NULL, NULL),
(16, 3, NULL, NULL),
(17, 3, NULL, NULL),
(18, 3, NULL, NULL),
(19, 3, NULL, NULL),
(20, 3, NULL, NULL),
(21, 3, NULL, NULL),
(22, 3, NULL, NULL),
(23, 3, NULL, NULL),
(24, 3, NULL, NULL),
(25, 3, NULL, NULL),
(26, 3, NULL, NULL),
(27, 3, NULL, NULL),
(28, 3, NULL, NULL),
(29, 3, NULL, NULL),
(30, 3, NULL, NULL),
(31, 3, NULL, NULL),
(32, 3, NULL, NULL),
(33, 3, NULL, NULL),
(34, 3, NULL, NULL),
(35, 3, NULL, NULL),
(36, 3, NULL, NULL),
(37, 3, NULL, NULL),
(38, 3, NULL, NULL),
(39, 3, NULL, NULL),
(40, 3, NULL, NULL),
(41, 3, NULL, NULL),
(42, 3, NULL, NULL),
(43, 3, NULL, NULL),
(44, 3, NULL, NULL),
(45, 3, NULL, NULL),
(46, 3, NULL, NULL),
(47, 3, NULL, NULL),
(48, 3, NULL, NULL),
(49, 3, NULL, NULL),
(50, 3, NULL, NULL),
(51, 3, NULL, NULL),
(52, 3, NULL, NULL),
(53, 3, NULL, NULL),
(54, 3, NULL, NULL),
(55, 3, NULL, NULL),
(56, 3, NULL, NULL),
(57, 3, NULL, NULL),
(58, 3, NULL, NULL),
(59, 3, NULL, NULL),
(60, 3, NULL, NULL),
(61, 3, NULL, NULL),
(62, 3, NULL, NULL),
(63, 3, NULL, NULL),
(64, 3, NULL, NULL),
(65, 3, NULL, NULL),
(66, 3, NULL, NULL),
(67, 3, NULL, NULL),
(68, 3, NULL, NULL),
(69, 3, NULL, NULL),
(70, 3, NULL, NULL),
(71, 3, NULL, NULL),
(72, 3, NULL, NULL),
(73, 3, NULL, NULL),
(74, 3, NULL, NULL),
(75, 3, NULL, NULL),
(76, 3, NULL, NULL),
(77, 3, NULL, NULL),
(78, 3, NULL, NULL),
(79, 3, NULL, NULL),
(80, 3, NULL, NULL),
(81, 3, NULL, NULL),
(82, 3, NULL, NULL),
(83, 3, NULL, NULL),
(84, 3, NULL, NULL),
(85, 3, NULL, NULL),
(86, 3, NULL, NULL),
(87, 3, NULL, NULL),
(88, 3, NULL, NULL),
(89, 3, NULL, NULL),
(90, 3, NULL, NULL),
(91, 3, NULL, NULL),
(92, 3, NULL, NULL),
(93, 3, NULL, NULL),
(1, 5, NULL, NULL),
(2, 5, NULL, NULL),
(3, 5, NULL, NULL),
(4, 5, NULL, NULL),
(5, 5, NULL, NULL),
(6, 5, NULL, NULL),
(7, 5, NULL, NULL),
(8, 5, NULL, NULL),
(9, 5, NULL, NULL),
(10, 5, NULL, NULL),
(11, 5, NULL, NULL),
(12, 5, NULL, NULL),
(13, 5, NULL, NULL),
(14, 5, NULL, NULL),
(15, 5, NULL, NULL),
(16, 5, NULL, NULL),
(17, 5, NULL, NULL),
(18, 5, NULL, NULL),
(19, 5, NULL, NULL),
(20, 5, NULL, NULL),
(21, 5, NULL, NULL),
(22, 5, NULL, NULL),
(23, 5, NULL, NULL),
(24, 5, NULL, NULL),
(25, 5, NULL, NULL),
(26, 5, NULL, NULL),
(27, 5, NULL, NULL),
(28, 5, NULL, NULL),
(29, 5, NULL, NULL),
(30, 5, NULL, NULL),
(31, 5, NULL, NULL),
(32, 5, NULL, NULL),
(33, 5, NULL, NULL),
(34, 5, NULL, NULL),
(35, 5, NULL, NULL),
(36, 5, NULL, NULL),
(37, 5, NULL, NULL),
(38, 5, NULL, NULL),
(39, 5, NULL, NULL),
(40, 5, NULL, NULL),
(41, 5, NULL, NULL),
(42, 5, NULL, NULL),
(43, 5, NULL, NULL),
(44, 5, NULL, NULL),
(45, 5, NULL, NULL),
(46, 5, NULL, NULL),
(47, 5, NULL, NULL),
(48, 5, NULL, NULL),
(49, 5, NULL, NULL),
(50, 5, NULL, NULL),
(51, 5, NULL, NULL),
(52, 5, NULL, NULL),
(53, 5, NULL, NULL),
(54, 5, NULL, NULL),
(55, 5, NULL, NULL),
(56, 5, NULL, NULL),
(57, 5, NULL, NULL),
(58, 5, NULL, NULL),
(59, 5, NULL, NULL),
(60, 5, NULL, NULL),
(61, 5, NULL, NULL),
(62, 5, NULL, NULL),
(63, 5, NULL, NULL),
(64, 5, NULL, NULL),
(65, 5, NULL, NULL),
(66, 5, NULL, NULL),
(67, 5, NULL, NULL),
(68, 5, NULL, NULL),
(69, 5, NULL, NULL),
(70, 5, NULL, NULL),
(71, 5, NULL, NULL),
(72, 5, NULL, NULL),
(73, 5, NULL, NULL),
(74, 5, NULL, NULL),
(75, 5, NULL, NULL),
(76, 5, NULL, NULL),
(77, 5, NULL, NULL),
(78, 5, NULL, NULL),
(79, 5, NULL, NULL),
(80, 5, NULL, NULL),
(81, 5, NULL, NULL),
(82, 5, NULL, NULL),
(83, 5, NULL, NULL),
(84, 5, NULL, NULL),
(85, 5, NULL, NULL),
(86, 5, NULL, NULL),
(87, 5, NULL, NULL),
(88, 5, NULL, NULL),
(89, 5, NULL, NULL),
(90, 5, NULL, NULL),
(91, 5, NULL, NULL),
(92, 5, NULL, NULL),
(93, 5, NULL, NULL),
(50, 9, NULL, NULL),
(1, 9, NULL, NULL),
(2, 9, NULL, NULL),
(3, 9, NULL, NULL),
(4, 9, NULL, NULL),
(5, 9, NULL, NULL),
(6, 9, NULL, NULL),
(7, 9, NULL, NULL),
(8, 9, NULL, NULL),
(9, 9, NULL, NULL),
(10, 9, NULL, NULL),
(11, 9, NULL, NULL),
(12, 9, NULL, NULL),
(13, 9, NULL, NULL),
(14, 9, NULL, NULL),
(15, 9, NULL, NULL),
(16, 9, NULL, NULL),
(17, 9, NULL, NULL),
(18, 9, NULL, NULL),
(19, 9, NULL, NULL),
(20, 9, NULL, NULL),
(21, 9, NULL, NULL),
(22, 9, NULL, NULL),
(23, 9, NULL, NULL),
(24, 9, NULL, NULL),
(25, 9, NULL, NULL),
(26, 9, NULL, NULL),
(27, 9, NULL, NULL),
(28, 9, NULL, NULL),
(29, 9, NULL, NULL),
(30, 9, NULL, NULL),
(31, 9, NULL, NULL),
(32, 9, NULL, NULL),
(33, 9, NULL, NULL),
(34, 9, NULL, NULL),
(35, 9, NULL, NULL),
(36, 9, NULL, NULL),
(37, 9, NULL, NULL),
(38, 9, NULL, NULL),
(39, 9, NULL, NULL),
(40, 9, NULL, NULL),
(41, 9, NULL, NULL),
(42, 9, NULL, NULL),
(43, 9, NULL, NULL),
(44, 9, NULL, NULL),
(45, 9, NULL, NULL),
(46, 9, NULL, NULL),
(47, 9, NULL, NULL),
(48, 9, NULL, NULL),
(49, 9, NULL, NULL),
(51, 9, NULL, NULL),
(52, 9, NULL, NULL),
(53, 9, NULL, NULL),
(54, 9, NULL, NULL),
(55, 9, NULL, NULL),
(56, 9, NULL, NULL),
(57, 9, NULL, NULL),
(58, 9, NULL, NULL),
(59, 9, NULL, NULL),
(60, 9, NULL, NULL),
(61, 9, NULL, NULL),
(62, 9, NULL, NULL),
(63, 9, NULL, NULL),
(64, 9, NULL, NULL),
(65, 9, NULL, NULL),
(66, 9, NULL, NULL),
(67, 9, NULL, NULL),
(68, 9, NULL, NULL),
(69, 9, NULL, NULL),
(70, 9, NULL, NULL),
(71, 9, NULL, NULL),
(72, 9, NULL, NULL),
(73, 9, NULL, NULL),
(74, 9, NULL, NULL),
(75, 9, NULL, NULL),
(76, 9, NULL, NULL),
(77, 9, NULL, NULL),
(78, 9, NULL, NULL),
(79, 9, NULL, NULL),
(80, 9, NULL, NULL),
(81, 9, NULL, NULL),
(82, 9, NULL, NULL),
(83, 9, NULL, NULL),
(84, 9, NULL, NULL),
(85, 9, NULL, NULL),
(86, 9, NULL, NULL),
(87, 9, NULL, NULL),
(88, 9, NULL, NULL),
(89, 9, NULL, NULL),
(90, 9, NULL, NULL),
(91, 9, NULL, NULL),
(92, 9, NULL, NULL),
(93, 9, NULL, NULL),
(1, 17, NULL, NULL),
(2, 17, NULL, NULL),
(3, 17, NULL, NULL),
(4, 17, NULL, NULL),
(5, 17, NULL, NULL),
(6, 17, NULL, NULL),
(7, 17, NULL, NULL),
(8, 17, NULL, NULL),
(9, 17, NULL, NULL),
(10, 17, NULL, NULL),
(11, 17, NULL, NULL),
(12, 17, NULL, NULL),
(13, 17, NULL, NULL),
(14, 17, NULL, NULL),
(15, 17, NULL, NULL),
(16, 17, NULL, NULL),
(17, 17, NULL, NULL),
(18, 17, NULL, NULL),
(19, 17, NULL, NULL),
(20, 17, NULL, NULL),
(21, 17, NULL, NULL),
(22, 17, NULL, NULL),
(23, 17, NULL, NULL),
(24, 17, NULL, NULL),
(25, 17, NULL, NULL),
(26, 17, NULL, NULL),
(27, 17, NULL, NULL),
(28, 17, NULL, NULL),
(29, 17, NULL, NULL),
(30, 17, NULL, NULL),
(31, 17, NULL, NULL),
(32, 17, NULL, NULL),
(33, 17, NULL, NULL),
(34, 17, NULL, NULL),
(35, 17, NULL, NULL),
(36, 17, NULL, NULL),
(37, 17, NULL, NULL),
(38, 17, NULL, NULL),
(39, 17, NULL, NULL),
(40, 17, NULL, NULL),
(41, 17, NULL, NULL),
(42, 17, NULL, NULL),
(43, 17, NULL, NULL),
(44, 17, NULL, NULL),
(45, 17, NULL, NULL),
(46, 17, NULL, NULL),
(47, 17, NULL, NULL),
(48, 17, NULL, NULL),
(49, 17, NULL, NULL),
(50, 17, NULL, NULL),
(51, 17, NULL, NULL),
(52, 17, NULL, NULL),
(53, 17, NULL, NULL),
(54, 17, NULL, NULL),
(55, 17, NULL, NULL),
(56, 17, NULL, NULL),
(57, 17, NULL, NULL),
(58, 17, NULL, NULL),
(59, 17, NULL, NULL),
(60, 17, NULL, NULL),
(61, 17, NULL, NULL),
(62, 17, NULL, NULL),
(63, 17, NULL, NULL),
(64, 17, NULL, NULL),
(65, 17, NULL, NULL),
(66, 17, NULL, NULL),
(67, 17, NULL, NULL),
(68, 17, NULL, NULL),
(69, 17, NULL, NULL),
(70, 17, NULL, NULL),
(71, 17, NULL, NULL),
(72, 17, NULL, NULL),
(73, 17, NULL, NULL),
(74, 17, NULL, NULL),
(75, 17, NULL, NULL),
(76, 17, NULL, NULL),
(77, 17, NULL, NULL),
(78, 17, NULL, NULL),
(79, 17, NULL, NULL),
(80, 17, NULL, NULL),
(81, 17, NULL, NULL),
(82, 17, NULL, NULL),
(83, 17, NULL, NULL),
(84, 17, NULL, NULL),
(85, 17, NULL, NULL),
(86, 17, NULL, NULL),
(87, 17, NULL, NULL),
(88, 17, NULL, NULL),
(89, 17, NULL, NULL),
(90, 17, NULL, NULL),
(91, 17, NULL, NULL),
(92, 17, NULL, NULL),
(93, 17, NULL, NULL),
(1, 11, NULL, NULL),
(2, 11, NULL, NULL),
(3, 11, NULL, NULL),
(4, 11, NULL, NULL),
(5, 11, NULL, NULL),
(6, 11, NULL, NULL),
(7, 11, NULL, NULL),
(8, 11, NULL, NULL),
(9, 11, NULL, NULL),
(10, 11, NULL, NULL),
(11, 11, NULL, NULL),
(12, 11, NULL, NULL),
(13, 11, NULL, NULL),
(14, 11, NULL, NULL),
(15, 11, NULL, NULL),
(16, 11, NULL, NULL),
(17, 11, NULL, NULL),
(18, 11, NULL, NULL),
(19, 11, NULL, NULL),
(20, 11, NULL, NULL),
(21, 11, NULL, NULL),
(22, 11, NULL, NULL),
(23, 11, NULL, NULL),
(24, 11, NULL, NULL),
(25, 11, NULL, NULL),
(26, 11, NULL, NULL),
(27, 11, NULL, NULL),
(28, 11, NULL, NULL),
(29, 11, NULL, NULL),
(30, 11, NULL, NULL),
(31, 11, NULL, NULL),
(32, 11, NULL, NULL),
(33, 11, NULL, NULL),
(34, 11, NULL, NULL),
(35, 11, NULL, NULL),
(36, 11, NULL, NULL),
(37, 11, NULL, NULL),
(38, 11, NULL, NULL),
(39, 11, NULL, NULL),
(40, 11, NULL, NULL),
(41, 11, NULL, NULL),
(42, 11, NULL, NULL),
(43, 11, NULL, NULL),
(44, 11, NULL, NULL),
(45, 11, NULL, NULL),
(46, 11, NULL, NULL),
(47, 11, NULL, NULL),
(48, 11, NULL, NULL),
(49, 11, NULL, NULL),
(50, 11, NULL, NULL),
(51, 11, NULL, NULL),
(52, 11, NULL, NULL),
(53, 11, NULL, NULL),
(54, 11, NULL, NULL),
(55, 11, NULL, NULL),
(56, 11, NULL, NULL),
(57, 11, NULL, NULL),
(58, 11, NULL, NULL),
(59, 11, NULL, NULL),
(60, 11, NULL, NULL),
(61, 11, NULL, NULL),
(62, 11, NULL, NULL),
(63, 11, NULL, NULL),
(64, 11, NULL, NULL),
(65, 11, NULL, NULL),
(66, 11, NULL, NULL),
(67, 11, NULL, NULL),
(68, 11, NULL, NULL),
(69, 11, NULL, NULL),
(70, 11, NULL, NULL),
(71, 11, NULL, NULL),
(72, 11, NULL, NULL),
(73, 11, NULL, NULL),
(74, 11, NULL, NULL),
(75, 11, NULL, NULL),
(76, 11, NULL, NULL),
(77, 11, NULL, NULL),
(78, 11, NULL, NULL),
(79, 11, NULL, NULL),
(80, 11, NULL, NULL),
(81, 11, NULL, NULL),
(82, 11, NULL, NULL),
(83, 11, NULL, NULL),
(84, 11, NULL, NULL),
(85, 11, NULL, NULL),
(86, 11, NULL, NULL),
(87, 11, NULL, NULL),
(88, 11, NULL, NULL),
(89, 11, NULL, NULL),
(90, 11, NULL, NULL),
(91, 11, NULL, NULL),
(92, 11, NULL, NULL),
(93, 11, NULL, NULL),
(1, 22, NULL, NULL),
(2, 22, NULL, NULL),
(3, 22, NULL, NULL),
(4, 22, NULL, NULL),
(5, 22, NULL, NULL),
(6, 22, NULL, NULL),
(7, 22, NULL, NULL),
(8, 22, NULL, NULL),
(9, 22, NULL, NULL),
(10, 22, NULL, NULL),
(11, 22, NULL, NULL),
(12, 22, NULL, NULL),
(13, 22, NULL, NULL),
(14, 22, NULL, NULL),
(15, 22, NULL, NULL),
(16, 22, NULL, NULL),
(17, 22, NULL, NULL),
(18, 22, NULL, NULL),
(19, 22, NULL, NULL),
(20, 22, NULL, NULL),
(21, 22, NULL, NULL),
(22, 22, NULL, NULL),
(23, 22, NULL, NULL),
(24, 22, NULL, NULL),
(25, 22, NULL, NULL),
(26, 22, NULL, NULL),
(27, 22, NULL, NULL),
(28, 22, NULL, NULL),
(29, 22, NULL, NULL),
(30, 22, NULL, NULL),
(31, 22, NULL, NULL),
(32, 22, NULL, NULL),
(33, 22, NULL, NULL),
(34, 22, NULL, NULL),
(35, 22, NULL, NULL),
(36, 22, NULL, NULL),
(37, 22, NULL, NULL),
(38, 22, NULL, NULL),
(39, 22, NULL, NULL),
(40, 22, NULL, NULL),
(41, 22, NULL, NULL),
(42, 22, NULL, NULL),
(43, 22, NULL, NULL),
(44, 22, NULL, NULL),
(45, 22, NULL, NULL),
(46, 22, NULL, NULL),
(47, 22, NULL, NULL),
(48, 22, NULL, NULL),
(49, 22, NULL, NULL),
(50, 22, NULL, NULL),
(51, 22, NULL, NULL),
(52, 22, NULL, NULL),
(53, 22, NULL, NULL),
(54, 22, NULL, NULL),
(55, 22, NULL, NULL),
(56, 22, NULL, NULL),
(57, 22, NULL, NULL),
(58, 22, NULL, NULL),
(59, 22, NULL, NULL),
(60, 22, NULL, NULL),
(61, 22, NULL, NULL),
(62, 22, NULL, NULL),
(63, 22, NULL, NULL),
(64, 22, NULL, NULL),
(65, 22, NULL, NULL),
(66, 22, NULL, NULL),
(67, 22, NULL, NULL),
(68, 22, NULL, NULL),
(69, 22, NULL, NULL),
(70, 22, NULL, NULL),
(71, 22, NULL, NULL),
(72, 22, NULL, NULL),
(73, 22, NULL, NULL),
(74, 22, NULL, NULL),
(75, 22, NULL, NULL),
(76, 22, NULL, NULL),
(77, 22, NULL, NULL),
(78, 22, NULL, NULL),
(79, 22, NULL, NULL),
(80, 22, NULL, NULL),
(81, 22, NULL, NULL),
(82, 22, NULL, NULL),
(83, 22, NULL, NULL),
(84, 22, NULL, NULL),
(85, 22, NULL, NULL),
(86, 22, NULL, NULL),
(87, 22, NULL, NULL),
(88, 22, NULL, NULL),
(89, 22, NULL, NULL),
(90, 22, NULL, NULL),
(91, 22, NULL, NULL),
(92, 22, NULL, NULL),
(93, 22, NULL, NULL),
(1, 20, NULL, NULL),
(2, 20, NULL, NULL),
(3, 20, NULL, NULL),
(4, 20, NULL, NULL),
(5, 20, NULL, NULL),
(6, 20, NULL, NULL),
(7, 20, NULL, NULL),
(8, 20, NULL, NULL),
(9, 20, NULL, NULL),
(10, 20, NULL, NULL),
(11, 20, NULL, NULL),
(12, 20, NULL, NULL),
(13, 20, NULL, NULL),
(14, 20, NULL, NULL),
(15, 20, NULL, NULL),
(16, 20, NULL, NULL),
(17, 20, NULL, NULL),
(18, 20, NULL, NULL),
(19, 20, NULL, NULL),
(20, 20, NULL, NULL),
(21, 20, NULL, NULL),
(22, 20, NULL, NULL),
(23, 20, NULL, NULL),
(24, 20, NULL, NULL),
(25, 20, NULL, NULL),
(26, 20, NULL, NULL),
(27, 20, NULL, NULL),
(28, 20, NULL, NULL),
(29, 20, NULL, NULL),
(30, 20, NULL, NULL),
(31, 20, NULL, NULL),
(32, 20, NULL, NULL),
(33, 20, NULL, NULL),
(34, 20, NULL, NULL),
(35, 20, NULL, NULL),
(36, 20, NULL, NULL),
(37, 20, NULL, NULL),
(38, 20, NULL, NULL),
(39, 20, NULL, NULL),
(40, 20, NULL, NULL),
(41, 20, NULL, NULL),
(42, 20, NULL, NULL),
(43, 20, NULL, NULL),
(44, 20, NULL, NULL),
(45, 20, NULL, NULL),
(46, 20, NULL, NULL),
(47, 20, NULL, NULL),
(48, 20, NULL, NULL),
(49, 20, NULL, NULL),
(50, 20, NULL, NULL),
(51, 20, NULL, NULL),
(52, 20, NULL, NULL),
(53, 20, NULL, NULL),
(54, 20, NULL, NULL),
(55, 20, NULL, NULL),
(56, 20, NULL, NULL),
(57, 20, NULL, NULL),
(58, 20, NULL, NULL),
(59, 20, NULL, NULL),
(60, 20, NULL, NULL),
(61, 20, NULL, NULL),
(62, 20, NULL, NULL),
(63, 20, NULL, NULL),
(64, 20, NULL, NULL),
(65, 20, NULL, NULL),
(66, 20, NULL, NULL),
(67, 20, NULL, NULL),
(68, 20, NULL, NULL),
(69, 20, NULL, NULL),
(70, 20, NULL, NULL),
(71, 20, NULL, NULL),
(72, 20, NULL, NULL),
(73, 20, NULL, NULL),
(74, 20, NULL, NULL),
(75, 20, NULL, NULL),
(76, 20, NULL, NULL),
(77, 20, NULL, NULL),
(78, 20, NULL, NULL),
(79, 20, NULL, NULL),
(80, 20, NULL, NULL),
(81, 20, NULL, NULL),
(82, 20, NULL, NULL),
(83, 20, NULL, NULL),
(84, 20, NULL, NULL),
(85, 20, NULL, NULL),
(86, 20, NULL, NULL),
(87, 20, NULL, NULL),
(88, 20, NULL, NULL),
(89, 20, NULL, NULL),
(90, 20, NULL, NULL),
(91, 20, NULL, NULL),
(92, 20, NULL, NULL),
(93, 20, NULL, NULL),
(1, 15, NULL, NULL),
(2, 15, NULL, NULL),
(3, 15, NULL, NULL),
(4, 15, NULL, NULL),
(5, 15, NULL, NULL),
(6, 15, NULL, NULL),
(7, 15, NULL, NULL),
(8, 15, NULL, NULL),
(9, 15, NULL, NULL),
(10, 15, NULL, NULL),
(11, 15, NULL, NULL),
(12, 15, NULL, NULL),
(13, 15, NULL, NULL),
(14, 15, NULL, NULL),
(15, 15, NULL, NULL),
(16, 15, NULL, NULL),
(17, 15, NULL, NULL),
(18, 15, NULL, NULL),
(19, 15, NULL, NULL),
(20, 15, NULL, NULL),
(21, 15, NULL, NULL),
(22, 15, NULL, NULL),
(23, 15, NULL, NULL),
(24, 15, NULL, NULL),
(25, 15, NULL, NULL),
(26, 15, NULL, NULL),
(27, 15, NULL, NULL),
(28, 15, NULL, NULL),
(29, 15, NULL, NULL),
(30, 15, NULL, NULL),
(31, 15, NULL, NULL),
(32, 15, NULL, NULL),
(33, 15, NULL, NULL),
(34, 15, NULL, NULL),
(35, 15, NULL, NULL),
(36, 15, NULL, NULL),
(37, 15, NULL, NULL),
(38, 15, NULL, NULL),
(39, 15, NULL, NULL),
(40, 15, NULL, NULL),
(41, 15, NULL, NULL),
(42, 15, NULL, NULL),
(43, 15, NULL, NULL),
(44, 15, NULL, NULL),
(45, 15, NULL, NULL),
(46, 15, NULL, NULL),
(47, 15, NULL, NULL),
(48, 15, NULL, NULL),
(49, 15, NULL, NULL),
(50, 15, NULL, NULL),
(51, 15, NULL, NULL),
(52, 15, NULL, NULL),
(53, 15, NULL, NULL),
(54, 15, NULL, NULL),
(55, 15, NULL, NULL),
(56, 15, NULL, NULL),
(57, 15, NULL, NULL),
(58, 15, NULL, NULL),
(59, 15, NULL, NULL),
(60, 15, NULL, NULL),
(61, 15, NULL, NULL),
(62, 15, NULL, NULL),
(63, 15, NULL, NULL),
(64, 15, NULL, NULL),
(65, 15, NULL, NULL),
(66, 15, NULL, NULL),
(67, 15, NULL, NULL),
(68, 15, NULL, NULL),
(69, 15, NULL, NULL),
(70, 15, NULL, NULL),
(71, 15, NULL, NULL),
(72, 15, NULL, NULL),
(73, 15, NULL, NULL),
(74, 15, NULL, NULL),
(75, 15, NULL, NULL),
(76, 15, NULL, NULL),
(77, 15, NULL, NULL),
(78, 15, NULL, NULL),
(79, 15, NULL, NULL),
(80, 15, NULL, NULL),
(81, 15, NULL, NULL),
(82, 15, NULL, NULL),
(83, 15, NULL, NULL),
(84, 15, NULL, NULL),
(85, 15, NULL, NULL),
(86, 15, NULL, NULL),
(87, 15, NULL, NULL),
(88, 15, NULL, NULL),
(89, 15, NULL, NULL),
(90, 15, NULL, NULL),
(91, 15, NULL, NULL),
(92, 15, NULL, NULL),
(93, 15, NULL, NULL),
(95, 3, NULL, NULL),
(96, 3, NULL, NULL),
(98, 3, NULL, NULL),
(99, 3, NULL, NULL),
(95, 2, NULL, NULL),
(96, 2, NULL, NULL),
(98, 2, NULL, NULL),
(99, 2, NULL, NULL),
(50, 8, NULL, NULL),
(1, 8, NULL, NULL),
(95, 1, NULL, NULL),
(96, 1, NULL, NULL),
(98, 1, NULL, NULL),
(99, 1, NULL, NULL),
(2, 8, NULL, NULL),
(3, 8, NULL, NULL),
(4, 8, NULL, NULL),
(5, 8, NULL, NULL),
(6, 8, NULL, NULL),
(7, 8, NULL, NULL),
(8, 8, NULL, NULL),
(9, 8, NULL, NULL),
(10, 8, NULL, NULL),
(11, 8, NULL, NULL),
(16, 8, NULL, NULL),
(17, 8, NULL, NULL),
(18, 8, NULL, NULL),
(19, 8, NULL, NULL),
(20, 8, NULL, NULL),
(21, 8, NULL, NULL),
(22, 8, NULL, NULL),
(23, 8, NULL, NULL),
(28, 8, NULL, NULL),
(29, 8, NULL, NULL),
(30, 8, NULL, NULL),
(31, 8, NULL, NULL),
(36, 8, NULL, NULL),
(37, 8, NULL, NULL),
(38, 8, NULL, NULL),
(39, 8, NULL, NULL),
(40, 8, NULL, NULL),
(41, 8, NULL, NULL),
(42, 8, NULL, NULL),
(43, 8, NULL, NULL),
(48, 8, NULL, NULL),
(49, 8, NULL, NULL),
(51, 8, NULL, NULL),
(52, 8, NULL, NULL),
(53, 8, NULL, NULL),
(54, 8, NULL, NULL),
(55, 8, NULL, NULL),
(56, 8, NULL, NULL),
(57, 8, NULL, NULL),
(58, 8, NULL, NULL),
(59, 8, NULL, NULL),
(60, 8, NULL, NULL),
(61, 8, NULL, NULL),
(62, 8, NULL, NULL),
(63, 8, NULL, NULL),
(64, 8, NULL, NULL),
(65, 8, NULL, NULL),
(70, 8, NULL, NULL),
(71, 8, NULL, NULL),
(72, 8, NULL, NULL),
(73, 8, NULL, NULL),
(74, 8, NULL, NULL),
(75, 8, NULL, NULL),
(76, 8, NULL, NULL),
(77, 8, NULL, NULL),
(78, 8, NULL, NULL),
(79, 8, NULL, NULL),
(80, 8, NULL, NULL),
(81, 8, NULL, NULL),
(82, 8, NULL, NULL),
(83, 8, NULL, NULL),
(84, 8, NULL, NULL),
(85, 8, NULL, NULL),
(86, 8, NULL, NULL),
(87, 8, NULL, NULL),
(88, 8, NULL, NULL),
(89, 8, NULL, NULL),
(90, 8, NULL, NULL),
(91, 8, NULL, NULL),
(92, 8, NULL, NULL),
(93, 8, NULL, NULL),
(95, 8, NULL, NULL),
(96, 8, NULL, NULL),
(98, 8, NULL, NULL),
(99, 8, NULL, NULL),
(44, 8, NULL, NULL),
(46, 8, NULL, NULL),
(1, 33, NULL, NULL),
(2, 33, NULL, NULL),
(3, 33, NULL, NULL),
(7, 33, NULL, NULL),
(8, 33, NULL, NULL),
(9, 33, NULL, NULL),
(10, 33, NULL, NULL),
(11, 33, NULL, NULL),
(16, 33, NULL, NULL),
(17, 33, NULL, NULL),
(18, 33, NULL, NULL),
(19, 33, NULL, NULL),
(20, 33, NULL, NULL),
(21, 33, NULL, NULL),
(22, 33, NULL, NULL),
(23, 33, NULL, NULL),
(34, 33, NULL, NULL),
(36, 33, NULL, NULL),
(38, 33, NULL, NULL),
(40, 33, NULL, NULL),
(41, 33, NULL, NULL),
(42, 33, NULL, NULL),
(43, 33, NULL, NULL),
(46, 33, NULL, NULL),
(48, 33, NULL, NULL),
(49, 33, NULL, NULL),
(50, 33, NULL, NULL),
(51, 33, NULL, NULL),
(52, 33, NULL, NULL),
(53, 33, NULL, NULL),
(56, 33, NULL, NULL),
(58, 33, NULL, NULL),
(59, 33, NULL, NULL),
(60, 33, NULL, NULL),
(61, 33, NULL, NULL),
(64, 33, NULL, NULL),
(70, 33, NULL, NULL),
(71, 33, NULL, NULL),
(72, 33, NULL, NULL),
(73, 33, NULL, NULL),
(74, 33, NULL, NULL),
(75, 33, NULL, NULL),
(76, 33, NULL, NULL),
(77, 33, NULL, NULL),
(78, 33, NULL, NULL),
(79, 33, NULL, NULL),
(80, 33, NULL, NULL),
(81, 33, NULL, NULL),
(84, 33, NULL, NULL),
(86, 33, NULL, NULL),
(87, 33, NULL, NULL),
(88, 33, NULL, NULL),
(89, 33, NULL, NULL),
(90, 33, NULL, NULL),
(91, 33, NULL, NULL),
(92, 33, NULL, NULL),
(93, 33, NULL, NULL),
(95, 33, NULL, NULL),
(96, 33, NULL, NULL),
(99, 33, NULL, NULL),
(5, 33, NULL, NULL),
(1, 34, NULL, NULL),
(2, 34, NULL, NULL),
(3, 34, NULL, NULL),
(4, 34, NULL, NULL),
(5, 34, NULL, NULL),
(6, 34, NULL, NULL),
(7, 34, NULL, NULL),
(8, 34, NULL, NULL),
(9, 34, NULL, NULL),
(10, 34, NULL, NULL),
(11, 34, NULL, NULL),
(14, 34, NULL, NULL),
(16, 34, NULL, NULL),
(17, 34, NULL, NULL),
(18, 34, NULL, NULL),
(19, 34, NULL, NULL),
(20, 34, NULL, NULL),
(21, 34, NULL, NULL),
(22, 34, NULL, NULL),
(23, 34, NULL, NULL),
(34, 34, NULL, NULL),
(36, 34, NULL, NULL),
(37, 34, NULL, NULL),
(38, 34, NULL, NULL),
(39, 34, NULL, NULL),
(40, 34, NULL, NULL),
(41, 34, NULL, NULL),
(42, 34, NULL, NULL),
(43, 34, NULL, NULL),
(44, 34, NULL, NULL),
(45, 34, NULL, NULL),
(46, 34, NULL, NULL),
(47, 34, NULL, NULL),
(48, 34, NULL, NULL),
(49, 34, NULL, NULL),
(50, 34, NULL, NULL),
(51, 34, NULL, NULL),
(52, 34, NULL, NULL),
(53, 34, NULL, NULL),
(54, 34, NULL, NULL),
(55, 34, NULL, NULL),
(56, 34, NULL, NULL),
(57, 34, NULL, NULL),
(58, 34, NULL, NULL),
(59, 34, NULL, NULL),
(60, 34, NULL, NULL),
(61, 34, NULL, NULL),
(62, 34, NULL, NULL),
(63, 34, NULL, NULL),
(64, 34, NULL, NULL),
(65, 34, NULL, NULL),
(66, 34, NULL, NULL),
(67, 34, NULL, NULL),
(68, 34, NULL, NULL),
(69, 34, NULL, NULL),
(70, 34, NULL, NULL),
(71, 34, NULL, NULL),
(72, 34, NULL, NULL),
(73, 34, NULL, NULL),
(74, 34, NULL, NULL),
(75, 34, NULL, NULL),
(76, 34, NULL, NULL),
(77, 34, NULL, NULL),
(78, 34, NULL, NULL),
(79, 34, NULL, NULL),
(80, 34, NULL, NULL),
(81, 34, NULL, NULL),
(82, 34, NULL, NULL),
(83, 34, NULL, NULL),
(84, 34, NULL, NULL),
(85, 34, NULL, NULL),
(86, 34, NULL, NULL),
(87, 34, NULL, NULL),
(88, 34, NULL, NULL),
(89, 34, NULL, NULL),
(90, 34, NULL, NULL),
(91, 34, NULL, NULL),
(92, 34, NULL, NULL),
(93, 34, NULL, NULL),
(95, 34, NULL, NULL),
(96, 34, NULL, NULL),
(98, 34, NULL, NULL),
(99, 34, NULL, NULL),
(26, 34, NULL, NULL),
(28, 34, NULL, NULL),
(29, 34, NULL, NULL),
(30, 34, NULL, NULL),
(31, 34, NULL, NULL),
(18, 35, NULL, NULL),
(22, 35, NULL, NULL),
(38, 35, NULL, NULL),
(42, 35, NULL, NULL),
(46, 35, NULL, NULL),
(60, 35, NULL, NULL),
(76, 35, NULL, NULL),
(88, 35, NULL, NULL),
(99, 35, NULL, NULL),
(89, 35, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE IF NOT EXISTS `prices` (
  `id` int(11) NOT NULL auto_increment,
  `price_set_id` int(11) default NULL,
  `amount` float default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `option_id` int(11) default NULL,
  `typee` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=26 ;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `price_set_id`, `amount`, `created_at`, `updated_at`, `option_id`, `typee`, `deleted`) VALUES
(18, 17, 0.0175, '2011-09-28 16:17:28', '2011-09-28 16:17:28', 11, 'per_page', 0),
(19, 17, 0.0175, '2011-09-28 16:17:38', '2011-09-28 16:17:38', 13, 'per_page', 0),
(20, 17, 0.15, '2011-09-28 16:18:13', '2011-09-28 16:18:13', 12, 'per_page', 0),
(21, 17, 0.15, '2011-09-28 16:18:22', '2011-09-28 16:18:22', 14, 'per_page', 0),
(22, 17, 0.8, '2011-09-28 16:18:58', '2011-09-28 16:18:58', 16, 'once', 0),
(23, 17, 1, '2011-09-28 16:19:07', '2011-09-28 16:19:07', 15, 'once', 0),
(24, 17, 1, '2011-09-28 16:19:15', '2011-09-28 16:19:15', 17, 'once', 0),
(25, 17, 1, '2011-09-28 16:19:27', '2011-09-28 16:19:27', 18, 'once', 0);

-- --------------------------------------------------------

--
-- Table structure for table `price_sets`
--

CREATE TABLE IF NOT EXISTS `price_sets` (
  `id` int(11) NOT NULL auto_increment,
  `printer_id` int(11) default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `price_sets`
--

INSERT INTO `price_sets` (`id`, `printer_id`, `name`, `created_at`, `updated_at`, `deleted`) VALUES
(17, 1, 'Standaard', '2011-09-28 16:17:06', '2011-09-28 16:17:06', 0);

-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE IF NOT EXISTS `printers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `printers`
--

INSERT INTO `printers` (`id`, `name`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'Prima Copy', '2011-09-28 14:38:19', '2011-09-28 14:38:19', 0);

-- --------------------------------------------------------

--
-- Table structure for table `print_jobs`
--

CREATE TABLE IF NOT EXISTS `print_jobs` (
  `id` int(11) NOT NULL auto_increment,
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `print_jobs`
--

INSERT INTO `print_jobs` (`id`, `status`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'ordered', '2011-09-28 20:14:24', '2011-09-28 20:14:24', 0),
(2, 'ordered', '2011-09-29 09:47:09', '2011-09-29 09:47:09', 0),
(3, 'ordered', '2011-09-30 19:02:34', '2011-09-30 19:02:34', 0);

-- --------------------------------------------------------

--
-- Table structure for table `print_job_items`
--

CREATE TABLE IF NOT EXISTS `print_job_items` (
  `id` int(11) NOT NULL auto_increment,
  `print_job_id` int(11) default NULL,
  `material_id` int(11) default NULL,
  `amount` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `print_job_items`
--

INSERT INTO `print_job_items` (`id`, `print_job_id`, `material_id`, `amount`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 1, 1, 2, '2011-09-28 20:14:24', '2011-09-28 20:14:24', 0),
(2, 2, 1, 6, '2011-09-29 09:47:09', '2011-09-29 09:47:09', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `id` int(11) NOT NULL auto_increment,
  `score` int(11) default NULL,
  `message` varchar(255) collate utf8_unicode_ci default NULL,
  `user_id` int(11) default NULL,
  `rateable_id` int(11) default NULL,
  `rateable_type` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `material_id` int(11) default NULL,
  `status` int(11) default NULL,
  `reference_key` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20110824110709'),
('20110825100827'),
('20110825152829'),
('20110829094105'),
('20110829134806'),
('20110830120958'),
('20110830140642'),
('20110830143845'),
('20110831130957'),
('20110831134227'),
('20110831161640'),
('20110901132709'),
('20110901133944'),
('20110905141932'),
('20110906110449'),
('20110913130732'),
('20110914124736'),
('20110914184151'),
('20110915162216'),
('20110916134946'),
('20110916142919'),
('20110916162051'),
('20110916162218'),
('20110916162341'),
('20110920115801'),
('20110920124836'),
('20110920134212'),
('20110920134214'),
('20110922004140'),
('20110923121507'),
('20110926144302'),
('20110926144356'),
('20110927113641'),
('20110930100530'),
('20110930194312');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart_items`
--

CREATE TABLE IF NOT EXISTS `shopping_cart_items` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `material_id` int(11) default NULL,
  `amount` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `guild_id` int(11) default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `shopping_cart_items`
--

INSERT INTO `shopping_cart_items` (`id`, `user_id`, `material_id`, `amount`, `created_at`, `updated_at`, `guild_id`, `deleted`) VALUES
(11, 34, 6, 1, '2011-10-01 14:45:26', '2011-10-01 14:45:26', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE IF NOT EXISTS `stocks` (
  `id` int(11) NOT NULL auto_increment,
  `material_id` int(11) default NULL,
  `guild_id` int(11) default NULL,
  `amount` int(11) default NULL,
  `threshold` int(11) default NULL,
  `step` int(11) default NULL,
  `typee` varchar(255) collate utf8_unicode_ci default NULL,
  `floating` int(11) default NULL,
  `floating_period` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `year` int(11) default NULL,
  `year_type` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `prof` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `name`, `year`, `year_type`, `created_at`, `updated_at`, `prof`, `deleted`) VALUES
(1, 'Algoritmen en data structuren 1 ', 1, 'Bachelor', '2011-09-28 14:18:01', '2011-10-01 12:55:22', 'De Meuter Wolfgan', 0),
(2, 'Politicologie', 1, 'Bachelor', '2011-09-28 14:21:32', '2011-09-28 14:21:32', 'Deschouwer C.', 0),
(3, 'Sociologie: Een inleiding', 1, 'Bachelor', '2011-09-28 16:37:29', '2011-10-01 12:57:58', 'Elchardus', 0),
(4, 'Verbintenissenrecht', 2, 'Bachelor', '2011-09-30 09:05:03', '2011-09-30 09:05:03', 'Cornelis L.', 0),
(5, 'geschiedenis van België', 1, 'Bachelor', '2011-09-30 10:39:06', '2011-09-30 10:39:06', 'De Metsenaere M.', 0),
(6, 'geschiedenis van België', 1, 'Bachelor', '2011-09-30 10:40:16', '2011-09-30 10:40:16', 'De Metsenaere M.', 0),
(7, 'historische inleiding tot het recht', 1, 'Bachelor', '2011-09-30 10:42:42', '2011-09-30 10:42:42', 'De Ruysscher D.', 0),
(8, 'Bronnen en beginselen van het recht', 1, 'Bachelor', '2011-09-30 10:45:31', '2011-09-30 10:45:31', 'Wirtgen A.', 0),
(9, 'Fiscaal recht', 2, 'Bachelor', '2011-09-30 10:50:26', '2011-09-30 10:50:26', 'Maus M.', 0),
(10, 'Hoe maak ik een nieuwe cursus aan?', 1, 'Bachelor', '2011-10-01 10:53:20', '2011-10-01 10:53:20', 'Sergeant', 0),
(11, 'Hoe maak ik een nieuwe cursus aan?', 1, 'Bachelor', '2011-10-01 10:54:13', '2011-10-01 10:54:13', 'Sergeant', 0),
(12, 'Geschiedenis van het Politieke denken', 2, 'Bachelor', '2011-10-01 11:11:17', '2011-10-01 11:11:17', 'Coppieters', 0),
(13, 'Theorie van de inernationale betrekkingen', 3, 'Bachelor', '2011-10-01 11:48:35', '2011-10-01 11:48:35', 'Geeraerts G', 0);

-- --------------------------------------------------------

--
-- Table structure for table `supplies`
--

CREATE TABLE IF NOT EXISTS `supplies` (
  `id` int(11) NOT NULL auto_increment,
  `guild_id` int(11) default NULL,
  `material_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `price_set_id` int(11) default NULL,
  `price` float default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `supplies`
--

INSERT INTO `supplies` (`id`, `guild_id`, `material_id`, `created_at`, `updated_at`, `price_set_id`, `price`, `deleted`) VALUES
(1, 5, 1, '2011-09-28 16:22:47', '2011-09-28 16:22:47', 17, 5, 0),
(2, 5, 2, '2011-09-28 16:41:39', '2011-09-28 16:41:39', 17, 12, 0),
(3, 5, 6, '2011-10-01 11:19:46', '2011-10-01 11:19:46', 17, 101.4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `teachings`
--

CREATE TABLE IF NOT EXISTS `teachings` (
  `id` int(11) NOT NULL auto_increment,
  `discipline_id` int(11) default NULL,
  `subject_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=27 ;

--
-- Dumping data for table `teachings`
--

INSERT INTO `teachings` (`id`, `discipline_id`, `subject_id`, `created_at`, `updated_at`, `deleted`) VALUES
(2, 8, 2, '2011-09-28 14:21:32', '2011-09-28 14:21:32', 0),
(5, 13, 4, '2011-09-30 09:05:03', '2011-09-30 09:05:03', 0),
(6, 13, 6, '2011-09-30 10:40:16', '2011-09-30 10:40:16', 0),
(7, 13, 7, '2011-09-30 10:42:42', '2011-09-30 10:42:42', 0),
(8, 13, 8, '2011-09-30 10:45:31', '2011-09-30 10:45:31', 0),
(9, 13, 9, '2011-09-30 10:50:26', '2011-09-30 10:50:26', 0),
(13, 17, 11, '2011-10-01 10:54:41', '2011-10-01 10:54:41', 0),
(14, 8, 12, '2011-10-01 11:11:17', '2011-10-01 11:11:17', 0),
(16, 8, 13, '2011-10-01 12:31:32', '2011-10-01 12:31:32', 0),
(23, 1, 1, '2011-10-01 12:57:05', '2011-10-01 12:57:05', 0),
(26, 15, 3, '2011-10-01 12:57:58', '2011-10-01 12:57:58', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(255) collate utf8_unicode_ci default NULL,
  `rolno` int(11) default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `permission_group_id` int(11) default '0',
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `last_name` varchar(255) collate utf8_unicode_ci default NULL,
  `password` varchar(255) collate utf8_unicode_ci default NULL,
  `encrypted_password` varchar(255) collate utf8_unicode_ci default NULL,
  `salt` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=36 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_name`, `rolno`, `email`, `created_at`, `updated_at`, `permission_group_id`, `name`, `last_name`, `password`, `encrypted_password`, `salt`, `deleted`) VALUES
(1, 'Enermis', NULL, 'fulgens.ailurus@gmail.com', '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0, 'Roeland', 'Matthijssens', NULL, 'e7e7957076b51ebeb12f515e91168f3ae4b876255f789cd03272ae26fcddb9fa', '138d00f56d8295ed3f754dfa8f44e73e878c553c76b49a8fd75a4c553c95c865', 0),
(2, 'rik', NULL, 'rik.vanmechelen@gmail.com', '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0, 'Rik', 'Vanmechelen', NULL, 'e7e7957076b51ebeb12f515e91168f3ae4b876255f789cd03272ae26fcddb9fa', '138d00f56d8295ed3f754dfa8f44e73e878c553c76b49a8fd75a4c553c95c865', 0),
(3, 'Tyca', NULL, 'Tyca@tyca.com', '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0, 'Tyca', 'Tyca', NULL, '19adf0217de5a017c3404347212a0c92cc09e03c78c742085e33e899824e9b7f', '4c9a99b1cb8f5a15ec32f872b454d3b9228cefac7acf40486eb91e238dc6e1ad', 0),
(4, 'test', NULL, 'Test@gmail.com', '2011-09-28 13:51:30', '2011-09-28 13:51:30', 0, 'Test', 'Test', NULL, 'e7e7957076b51ebeb12f515e91168f3ae4b876255f789cd03272ae26fcddb9fa', '138d00f56d8295ed3f754dfa8f44e73e878c553c76b49a8fd75a4c553c95c865', 0),
(5, 'rivmeche', NULL, 'rik.vanmechelen@vub.ac.be', '2011-09-28 13:52:34', '2011-09-28 13:52:34', 0, 'Rik', 'Vanmechelen', NULL, 'ce901fb764588b9bf2706a5511c4f268a01dba469e4a799de0074d27c82ff477', '6c21c2490f929824675c48416d7757479eb7259da393682d93abe79512d8f4bf', 0),
(6, 'jscheppe', NULL, 'schepper@gmail.com', '2011-09-28 16:14:30', '2011-09-28 16:14:30', 0, 'Jeremy', 'Scheppers', NULL, '4abdea16ef2b9a348e42471660d3d560498dddcb2e02dcfc573de978e555b3ef', 'e3e1e0b79f5464905de56517b8a5d094e17b8f16b266729386a6b61f4b5f11ca', 0),
(7, 'gvdseype', NULL, 'gillesvanderseypen@gmail.com', '2011-09-28 16:29:45', '2011-09-28 16:29:45', 0, 'Gilles', 'Vanderseypen', NULL, '38681a1fc13d735248bd6f7a71f429a1f7c40284883d0125dd145ea9192f0247', '20b6cea034ab37f7e154290d8756cedfd97fc5e2cd835442677405a774f9d272', 0),
(8, 'novdberg', NULL, 'novandenberg@gmail.com', '2011-09-28 16:30:06', '2011-09-28 16:30:06', 0, 'Noémie', 'van den Berg', NULL, '65841b40d2e1c9d1a54f8ddf0d5d642c70bde085178670c3ae0e0445c21551a1', '81e5c6ed5579ef38da64bc71e62e65798d6d6c7e3c780ad4484e6820879d943f', 0),
(9, 'sbollu', NULL, 'stoffel.bollu@gmail.com', '2011-09-28 16:30:27', '2011-09-28 16:30:27', 0, 'Stoffel', 'Bollu', NULL, '141bd86159b0e12855ed214ba3f66765082b52bcb51e315f37c577781dd4b76f', '4858c58ae9b25ce5f16101018a71606df7ae7a1fc182634144fa5e30cc87ecf3', 0),
(10, 'mrichard', NULL, 'mrichard@vub.ac.be', '2011-09-28 16:30:47', '2011-09-28 16:30:47', 0, 'Maya', 'Richard', NULL, '58e08da7f59f82ab6bf4e0f8770ae3aa9a0fdf64b7b130458e7c01e19bfb3c90', '175c6853927444c4665e5d4f750357a6e035dbec3204826c31b0f784c651543a', 0),
(11, 'leggeric', NULL, 'leggeric@hotmail.com', '2011-09-28 16:30:58', '2011-09-28 16:30:58', 0, 'Laurence', 'Eggerickx', NULL, '083bc8db7839a174aa0af1a74066fad645194c56c1bcfd0afa5a722a6cb7b868', 'da2f8d7fa7bbb076eaffd36fa949b39f46acf2782b13b89eefb343f1e6f859e9', 0),
(12, 'chvhelle', NULL, 'chvhelle@vub.ac.be', '2011-09-28 16:31:54', '2011-09-28 16:31:54', 0, 'Charlotte', 'Van Hellemont', NULL, '80ac9cb772bafd13bce2d41fcff97b9f36cc162e247a5220db6cd51001d8a6e6', '4089f0d66f2ffb83f7eedea050cdda3951c9a160344f25b65fe9173f9eb2e70e', 0),
(13, 'jvbeljou', NULL, 'jessevanbeljouw@live.nl', '2011-09-28 16:32:07', '2011-09-28 16:32:07', 0, 'Jesse', 'van Beljouw', NULL, '8e2da5ab11f220bacb903486f122c3bcb5f57e3094cd79b45a996fa46ffabdcb', 'abdc3f35061a4185c1c06b318081737e047db1a3b45aa4aa6cc8641d1e9e8acd', 0),
(14, 'mvlysebe', NULL, 'mvlysebe@vub.ac.be', '2011-09-28 16:32:39', '2011-09-28 16:32:39', 0, 'Michael', 'Van Lysebetten', NULL, '845ba90770ff3a5e3239e0c2038171373aeab21d600e7bd432b986511767401d', '2de54ef722e4a8fc8e36137adebc023b3426d1b3608888ca78ccc8ed190926b3', 0),
(15, 'mpouille', NULL, 'mpouille@vub.ac.be', '2011-09-28 16:40:38', '2011-09-28 16:40:38', 0, 'max', 'Pouille', NULL, '7280a1869f84b677a98a6d5e587d312184507db1445fbdcec0b49d1d65b99433', 'c299c09afd82a92b57b775791504d3be20d102d9b7840c2f7467458ba4c57e63', 0),
(16, 'gsmedts', NULL, 'gsmedts@vub.ac.be', '2011-09-28 16:45:23', '2011-09-28 16:45:23', 0, 'Gaelle', 'Smedts', NULL, 'dcb5dbf7a32f87a25bc0f71d582d3031bfc47d9ff873072654e6a34636277bd9', '9cfb2b923f416f208ba40849c487d96494ce9cd7470b280e52e85bfde08672c9', 0),
(17, 'sdeketel', NULL, 'Sofie.Deketelaere@vub.ac.be', '2011-09-28 16:51:13', '2011-09-28 16:51:13', 0, 'Sofie', 'Deketelaere', NULL, 'cbeeb8b6ba857c4009bace367721a7a998ba4977f5484857d4161482a91c9a5d', '3655450e3ab37927dbd2f788a361be2b535c5159a4369ae34b5a76ac198f03e7', 0),
(18, 'kverbest', NULL, 'kverbest@vub.ac.be', '2011-09-28 18:13:03', '2011-09-28 18:13:03', 0, 'Karel', 'Verbestel', NULL, '3c129fcf09a259369ff07a26e1a73fb7240b7e81b3328110b2f1ca63953d00c7', 'c82b953f7c290571cfc11984648d5638fec2a99b3b687b5aa719e97cfccd3ada', 0),
(19, 'zmoortga', NULL, 'zoe.moortgat@vub.ac.be', '2011-09-28 18:22:01', '2011-09-28 18:22:01', 0, 'Zoë', 'Moortgat', NULL, '0b47d4a2e08ed66b9fce2c16c05dcf941337804ec59161fc0697e5cbb2dc6c61', '97abaefc428b136c67c4db73ff31965cced7a1c6e5facc1967b3235f96d8ea21', 0),
(20, 'jesmathi', NULL, 'jessicarosario_76@hotmail.com', '2011-09-28 18:28:51', '2011-09-28 18:28:51', 0, 'jessica', 'mathieu', NULL, '4fb8304cbe12359f96c693140c88b1f1b07d2f7ea44b0a76b606e3126138d4e0', 'ae806c5721cbeb6dac0583257ee1251005ad517350c6d08ea949e30cb33e3982', 0),
(21, 'lvermass', NULL, 'lvermass@vub.ac.be', '2011-09-28 18:43:23', '2011-09-28 18:43:23', 0, 'Lynn', 'Vermassen', NULL, 'bb9aa831a71774ea10b40c70adb6c93d30fbf78cbf7e2d33171c5909511c2530', 'e84d967f3d771899f29a5a4a16e0545ba7d62bec8aebdcbedca6d780a75bfa32', 0),
(22, 'ielmoude', NULL, 'Illias.Elmouden@vub.ac.be', '2011-09-28 19:10:52', '2011-09-28 19:10:52', 0, 'Illias', 'Elmouden', NULL, 'd7867e71237e3fa8efe143493a2d56b335055e1a8f8a85f2c5e3e66f09dd76a0', 'dbe358d5ede0ef8cb1104e4ab70d1c7c3e7aa93c108981d544da63aee0eb7578', 0),
(23, 'suleuz', NULL, 'kks@live.be', '2011-09-28 21:26:57', '2011-09-28 21:26:57', 0, 'Süleyman', 'Uz', NULL, '791438bc086f7dac1c0d7c396d85549e3e33bc49d85c5dbe706668b73505f2a8', '8315a733343d3c964607dc1d235018cc9f3ca9717a1d2fda76a3deeb45424bb9', 0),
(24, 'lpapikya', NULL, 'Lusine.Papikyan@vub.ac.be', '2011-09-28 22:42:11', '2011-09-28 22:42:11', 0, 'lusine', 'papikyan', NULL, '7fa90c3b7f62c142d63a974b0302d792761f7286ef9f4bfafcb929067df54233', '86f18e40c32ab875564542c4ba3ffd53fca36477345e0bdefe19787f6f1e0aae', 0),
(25, 'evpauwel', NULL, 'evi.pauwels@vub.ac.be', '2011-09-29 06:25:00', '2011-09-29 06:25:00', 0, 'Evi', 'Pauwels', NULL, '17dea6949b6abe21edcbf2a707f184c1c40778659d28d73bb53bf5b1d1530d03', 'ac74601d942ad560ef6928037ccbe35df2d29b3f863d221122c1b36cdc475805', 0),
(26, 'dimidas', NULL, 'dimidas@vub.ac.be', '2011-09-29 07:34:42', '2011-09-29 07:34:42', 0, 'Dimitri', 'Das', NULL, 'b3ae1fab776ec1fc34972969a4e256aac2ba11b8cacaf571b758d75082328c22', '47cc18f91b9e0d00ea8b4e206b478eec5ace0817ff3c282277e1b1f58ba87681', 0),
(27, 'gkeppens', NULL, 'gilkeppens@hotmail.com', '2011-09-29 09:59:56', '2011-09-29 09:59:56', 0, 'gil', 'keppens', NULL, '0f6342816339463f90b340c57b1a843a9b61867c2b6b6135af1ad452bf5c9d06', '4e6be8d6caf4996d24b53aa5e00c14ec138a4661fb8433f9c49ca38441b662bd', 0),
(28, 'elinboon', NULL, 'Eline.Boon@vub.ac.be', '2011-09-29 11:59:03', '2011-09-29 11:59:03', 0, 'Eline', 'Boon', NULL, '8b1976af97ee5906ddf7195381813b117b3c690b454511299ac82e940bc9f9e5', 'c4f31d1f1bf191e85b86b1847c8ae76fbbbce93e4c8d5f3a966c08e01428d62f', 0),
(29, 'wgrauls', NULL, 'Wim.grauls@vub.ac.be', '2011-09-29 12:29:56', '2011-09-29 12:29:56', 0, 'Wim', 'Grauls', NULL, '319c2d92639c24cc949e3aa73421290a957849b43eddc804941c02a6be35f9d4', '097be75db825fba80e16486dc965cb00f4e7b3f962dad34b374a9181eea2007b', 0),
(30, 'jomoerma', NULL, 'moermansjoris@hotmail.com', '2011-09-29 12:33:21', '2011-09-29 12:33:21', 0, 'Joris', 'Moermans', NULL, 'ca2f5702becd6f56cbb3d3eddf8b49dfb79e0a01fc44a6d5b6b81003e1c6edcd', '0f0cdeeef9756ee6c37844ec96b0db2e37ccbc2c9f838a7d1c01d8413a5deafe', 0),
(31, 'gdeschuy', NULL, 'gdeschuy@vub.ac.be', '2011-09-29 12:34:12', '2011-09-29 12:34:12', 0, 'Gregory', 'Deschuyteneer', NULL, 'd170af3b6c1e16fe2d012a37bbc423c65933d0b8ab1adef470d4b91127557d7c', '6295af217d3c4158341fb14a7cac82234cc678c765540c0d397e2d58a0bceffc', 0),
(32, 'jvkevela', NULL, 'jvkevela@vub.ac.be', '2011-09-29 12:54:37', '2011-09-29 12:54:37', 0, 'Jules', 'Vankevelaer', NULL, '837744087ffdd28841d6b88b4016f59f34a88088a09537fff0b4038c864a873c', 'ecfa4a9f59da7cc86940db69e5b42aa35efa8f1c042114c6c51bb0ff31190e99', 0),
(33, 'junior', NULL, 'JM@cursusdienst.be', '2011-10-01 10:16:07', '2011-10-01 10:16:07', 0, 'Junior', 'Manager', NULL, '29881447b68b0bd1fde720ba45e6a74fa92b81f7dbc09b7fa5dc3fc6ee881c72', '03a742820e01e6c2bb4d076af77c926dc59a6a02b98daea57257a8543d7321cd', 0),
(34, 'senior', NULL, 'senior@cursusdienst.be', '2011-10-01 13:57:24', '2011-10-01 13:57:24', 0, 'serior', 'manager', NULL, 'af55a5897e146d51418e538be92af23ebfde6ccc70d87def8c5abc6a1a3b3d87', '335e6d75b840e0287c04c2d3eaa61fdfa9b6989a17f0ec9bdf5de033c59b2e7c', 0),
(35, 'student', NULL, 'student@cursusdienst.net', '2011-10-01 13:58:44', '2011-10-01 13:58:44', 0, 'student', 'student', NULL, 'f9815919d9b6b8bddf78ced2b46e57dcf81c0b478e0b32b6e76fbe885ed2ce86', 'e5fe96d75abef8c5ea29b865907c0a15f62025a72009092f9961ba3873a1da93', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
