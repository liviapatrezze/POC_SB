-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 30/03/2026 às 11:28
-- Versão do servidor: 9.1.0
-- Versão do PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sportbridge`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sprint`
--

DROP TABLE IF EXISTS `sprint`;
CREATE TABLE IF NOT EXISTS `sprint` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `goal` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Options:\n- planned;\n- active;\n- closed;\n- canceled;',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sprint`
--

INSERT INTO `sprint` (`id`, `name`, `goal`, `start_date`, `end_date`, `status`) VALUES
(1, 'Sprint 1', '', '2026-01-01 00:00:00', '2026-01-15 00:00:00', 'planned'),
(2, 'Sprint 2', '', '2026-01-16 00:00:00', '2026-01-30 00:00:00', 'planned'),
(3, 'Sprint 3', '', '2026-01-31 00:00:00', '2026-02-14 00:00:00', 'planned'),
(4, 'Sprint 4', '', '2026-02-15 00:00:00', '2026-03-01 00:00:00', 'planned'),
(5, 'Sprint 5', '', '2026-03-02 00:00:00', '2026-03-16 00:00:00', 'planned'),
(6, 'Sprint 6', '', '2026-03-17 00:00:00', '2026-03-31 00:00:00', 'planned'),
(7, 'Sprint 7', '', '2026-04-01 00:00:00', '2026-04-15 00:00:00', 'planned'),
(8, 'Sprint 8', '', '2026-04-16 00:00:00', '2026-04-30 00:00:00', 'planned'),
(9, 'Sprint 9', '', '2026-05-01 00:00:00', '2026-05-15 00:00:00', 'planned'),
(10, 'Sprint 10', '', '2026-05-16 00:00:00', '2026-05-30 00:00:00', 'planned'),
(11, 'Sprint 11', '', '2026-05-31 00:00:00', '2026-06-14 00:00:00', 'planned'),
(12, 'Sprint 12', '', '2026-06-15 00:00:00', '2026-06-29 00:00:00', 'planned'),
(13, 'Sprint 13', '', '2026-06-30 00:00:00', '2026-07-14 00:00:00', 'planned'),
(14, 'Sprint 14', '', '2026-07-15 00:00:00', '2026-07-29 00:00:00', 'planned'),
(15, 'Sprint 15', '', '2026-07-30 00:00:00', '2026-08-13 00:00:00', 'planned'),
(16, 'Sprint 16', '', '2026-08-14 00:00:00', '2026-08-28 00:00:00', 'planned'),
(17, 'Sprint 17', '', '2026-08-29 00:00:00', '2026-09-12 00:00:00', 'planned'),
(18, 'Sprint 18', '', '2026-09-13 00:00:00', '2026-09-27 00:00:00', 'planned'),
(19, 'Sprint 19', '', '2026-09-28 00:00:00', '2026-10-12 00:00:00', 'planned'),
(20, 'Sprint 20', '', '2026-10-13 00:00:00', '2026-10-27 00:00:00', 'planned'),
(21, 'Sprint 21', '', '2026-10-28 00:00:00', '2026-11-11 00:00:00', 'planned'),
(22, 'Sprint 22', '', '2026-11-12 00:00:00', '2026-11-26 00:00:00', 'planned'),
(23, 'Sprint 23', '', '2026-11-27 00:00:00', '2026-12-11 00:00:00', 'planned'),
(24, 'Sprint 24', '', '2026-12-12 00:00:00', '2026-12-26 00:00:00', 'planned');

-- --------------------------------------------------------

--
-- Estrutura para tabela `squad`
--

DROP TABLE IF EXISTS `squad`;
CREATE TABLE IF NOT EXISTS `squad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `mission` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `contact_channel` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `squad`
--

INSERT INTO `squad` (`id`, `name`, `description`, `mission`, `contact_channel`, `created_at`, `is_active`) VALUES
(1, 'Alunos Univesp', 'Composto por alunos da disciplina PI.', 'Responsáveis pelo desenvolvimento do app de controle de entregue de task em cada sprint.', 'Whatsapp', '2026-03-26 17:25:22', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `squad_member`
--

DROP TABLE IF EXISTS `squad_member`;
CREATE TABLE IF NOT EXISTS `squad_member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `squad_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_squad_member_squad1_idx` (`squad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `priority` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Options:\n- low;\n- medium;\n- high',
  `created_at` datetime NOT NULL,
  `deadline` datetime NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `squad_id` int NOT NULL,
  `sprint_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_squad_idx` (`squad_id`),
  KEY `fk_task_sprint1_idx` (`sprint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `task`
--

INSERT INTO `task` (`id`, `title`, `description`, `priority`, `created_at`, `deadline`, `completed_at`, `squad_id`, `sprint_id`) VALUES
(1, 'Correção do botão de inserir no sistema X', 'O botão apresentava problemas quando...', 'medium', '2026-01-07 11:25:26', '2026-01-14 11:25:26', '2026-01-09 11:25:26', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `task_image`
--

DROP TABLE IF EXISTS `task_image`;
CREATE TABLE IF NOT EXISTS `task_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `caption` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `uploaded_at` datetime NOT NULL,
  `task_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_task_image_task1_idx` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `squad_member`
--
ALTER TABLE `squad_member`
  ADD CONSTRAINT `fk_squad_member_squad1` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`);

--
-- Restrições para tabelas `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `fk_task_sprint1` FOREIGN KEY (`sprint_id`) REFERENCES `sprint` (`id`),
  ADD CONSTRAINT `fk_task_squad` FOREIGN KEY (`squad_id`) REFERENCES `squad` (`id`);

--
-- Restrições para tabelas `task_image`
--
ALTER TABLE `task_image`
  ADD CONSTRAINT `fk_task_image_task1` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
