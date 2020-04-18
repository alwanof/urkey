-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2020 at 04:41 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `urkeydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `configurations`
--

CREATE TABLE `configurations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `configurations`
--

INSERT INTO `configurations` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(6, 'receive-noti-4new-users', '0', NULL, '2019-12-09 13:14:03'),
(7, 'notifications-show-limit', '10', '2019-12-10 15:33:31', '2019-12-12 13:20:27'),
(10, 'new-user-welcome-email', '1', '2019-12-10 15:38:22', '2019-12-10 15:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_11_27_141818_add_apitoken_to_users', 2),
(4, '2019_11_30_112021_create_permission_tables', 3),
(7, '2019_12_04_104044_create_settings_table', 4),
(8, '2019_12_04_153357_create_config_table', 5),
(9, '2019_12_04_164728_create_role_configuration_table', 5),
(10, '2019_12_09_161836_create_notifications_table', 6),
(11, '2019_12_10_170236_create_jobs_table', 7);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 3),
(1, 'App\\User', 17),
(2, 'App\\User', 1),
(2, 'App\\User', 2);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('854e7b61-fb3b-456b-bdc8-da403419bb6a', 'App\\Notifications\\YourOrderApproved', 'App\\User', 3, '{\"data\":\"Murad Alwan has been approved your order(d1fe1-79)\",\"user\":{\"id\":1,\"name\":\"Murad Alwan\",\"email\":\"free1soft@gmail.com\",\"email_verified_at\":null,\"api_token\":\"XNYF5A6XgsKGoRiPwQ8gE2sLmt01uKSQ65VxUb3KaZNEEpJkujnP2ktFqDFo\",\"created_at\":\"2019-11-26 11:57:41\",\"updated_at\":\"2020-03-03 11:27:22\",\"avatar\":\"http:\\/\\/localhost\\/meazafood\\/public\\/storage\\/users\\/1.jpg\",\"getroles\":[{\"id\":2,\"name\":\"developer\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 16:53:41\",\"updated_at\":\"2019-11-30 16:53:41\",\"getpermissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}],\"pivot\":{\"model_id\":1,\"role_id\":2,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}]}],\"roles\":[{\"id\":2,\"name\":\"developer\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 16:53:41\",\"updated_at\":\"2019-11-30 16:53:41\",\"getpermissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}],\"pivot\":{\"model_id\":1,\"role_id\":2,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}]}]},\"link\":\"http:\\/\\/localhost\\/meazafood\\/public\\/order\\/details\\/79\"}', '2020-03-04 10:42:15', '2020-03-03 10:20:32', '2020-03-04 10:42:15'),
('ab0b5e60-97d4-44c3-9342-297acaa0c9db', 'App\\Notifications\\NewOrderFromAgent', 'App\\User', 1, '{\"data\":\"New order from israr totil\",\"user\":{\"id\":3,\"name\":\"israr totil\",\"email\":\"isrartoteel@yahoo.com\",\"email_verified_at\":null,\"api_token\":\"MEjJPgqdI7dnW8xnXEHcERxMG39cOSnYAbK9SjbdHf2ZJRrDKQxJ1MqE9JcR\",\"created_at\":\"2019-12-02 08:43:53\",\"updated_at\":\"2020-03-03 13:19:23\",\"avatar\":\"http:\\/\\/localhost\\/meazafood\\/public\\/storage\\/users\\/0.jpg\",\"getroles\":[{\"id\":1,\"name\":\"agent\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 11:30:28\",\"updated_at\":\"2020-02-29 08:43:40\",\"getpermissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}],\"pivot\":{\"model_id\":3,\"role_id\":1,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}]}],\"roles\":[{\"id\":1,\"name\":\"agent\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 11:30:28\",\"updated_at\":\"2020-02-29 08:43:40\",\"getpermissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}],\"pivot\":{\"model_id\":3,\"role_id\":1,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}]}]},\"link\":\"http:\\/\\/localhost\\/meazafood\\/public\\/admin\\/order\\/details\\/81\"}', '2020-03-04 05:55:54', '2020-03-03 10:34:10', '2020-03-04 05:55:54');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('eac75c0f-20fd-46d6-9b62-353e19c3360a', 'App\\Notifications\\YourOrderTrackingNo', 'App\\User', 3, '{\"data\":\"Your order with reference number: d1fe1-79 is on the way for delivery\",\"user\":{\"id\":1,\"name\":\"Murad Alwan\",\"email\":\"free1soft@gmail.com\",\"email_verified_at\":null,\"api_token\":\"XNYF5A6XgsKGoRiPwQ8gE2sLmt01uKSQ65VxUb3KaZNEEpJkujnP2ktFqDFo\",\"created_at\":\"2019-11-26 11:57:41\",\"updated_at\":\"2020-03-03 11:27:22\",\"avatar\":\"http:\\/\\/localhost\\/meazafood\\/public\\/storage\\/users\\/1.jpg\",\"getroles\":[{\"id\":2,\"name\":\"developer\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 16:53:41\",\"updated_at\":\"2019-11-30 16:53:41\",\"getpermissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}],\"pivot\":{\"model_id\":1,\"role_id\":2,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}]}],\"roles\":[{\"id\":2,\"name\":\"developer\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 16:53:41\",\"updated_at\":\"2019-11-30 16:53:41\",\"getpermissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}],\"pivot\":{\"model_id\":1,\"role_id\":2,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":4,\"name\":\"access-roles\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:28:55\",\"updated_at\":\"2019-12-09 13:28:55\",\"pivot\":{\"role_id\":2,\"permission_id\":4}},{\"id\":5,\"name\":\"access-users\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:06\",\"updated_at\":\"2019-12-09 13:29:06\",\"pivot\":{\"role_id\":2,\"permission_id\":5}},{\"id\":6,\"name\":\"access-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:25\",\"updated_at\":\"2019-12-09 13:29:25\",\"pivot\":{\"role_id\":2,\"permission_id\":6}},{\"id\":7,\"name\":\"access-configs\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 13:29:43\",\"updated_at\":\"2019-12-09 13:29:43\",\"pivot\":{\"role_id\":2,\"permission_id\":7}},{\"id\":8,\"name\":\"give-permissions\",\"guard_name\":\"web\",\"created_at\":\"2019-12-09 15:03:45\",\"updated_at\":\"2019-12-09 15:03:45\",\"pivot\":{\"role_id\":2,\"permission_id\":8}},{\"id\":11,\"name\":\"access_products\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 10:57:14\",\"updated_at\":\"2020-02-18 17:27:43\",\"pivot\":{\"role_id\":2,\"permission_id\":11}},{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":2,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":2,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":2,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":2,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":2,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":2,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":2,\"permission_id\":18}},{\"id\":19,\"name\":\"isAdmin\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 10:10:55\",\"updated_at\":\"2020-02-27 10:10:55\",\"pivot\":{\"role_id\":2,\"permission_id\":19}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":2,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":2,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":2,\"permission_id\":22}},{\"id\":23,\"name\":\"admin_edit_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:25\",\"updated_at\":\"2020-02-27 18:23:26\",\"pivot\":{\"role_id\":2,\"permission_id\":23}},{\"id\":24,\"name\":\"admin_delete_pending_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:33\",\"updated_at\":\"2020-02-27 18:23:33\",\"pivot\":{\"role_id\":2,\"permission_id\":24}},{\"id\":25,\"name\":\"admin_edit_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:40\",\"updated_at\":\"2020-02-27 18:23:40\",\"pivot\":{\"role_id\":2,\"permission_id\":25}},{\"id\":26,\"name\":\"admin_delete_approved_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:49\",\"updated_at\":\"2020-02-27 18:23:49\",\"pivot\":{\"role_id\":2,\"permission_id\":26}},{\"id\":27,\"name\":\"admin_edit_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:59\",\"updated_at\":\"2020-02-27 18:23:59\",\"pivot\":{\"role_id\":2,\"permission_id\":27}},{\"id\":28,\"name\":\"admin_delete_completed_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:24:08\",\"updated_at\":\"2020-02-27 18:24:08\",\"pivot\":{\"role_id\":2,\"permission_id\":28}},{\"id\":29,\"name\":\"admin_add_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:13:48\",\"updated_at\":\"2020-02-28 09:13:48\",\"pivot\":{\"role_id\":2,\"permission_id\":29}},{\"id\":30,\"name\":\"admin_delete_transaction\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:31\",\"updated_at\":\"2020-02-28 09:16:31\",\"pivot\":{\"role_id\":2,\"permission_id\":30}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":2,\"permission_id\":32}},{\"id\":33,\"name\":\"access_financial_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:51\",\"updated_at\":\"2020-03-01 09:23:51\",\"pivot\":{\"role_id\":2,\"permission_id\":33}}]}]},\"link\":\"http:\\/\\/localhost\\/meazafood\\/public\\/admin\\/order\\/details\\/79\"}', '2020-03-04 10:42:15', '2020-03-03 11:44:18', '2020-03-04 10:42:15'),
('f7ace33d-d6fa-4898-8aec-79360dc7a907', 'App\\Notifications\\NewOrderFromAgent', 'App\\User', 2, '{\"data\":\"New order from israr totil\",\"user\":{\"id\":3,\"name\":\"israr totil\",\"email\":\"isrartoteel@yahoo.com\",\"email_verified_at\":null,\"api_token\":\"MEjJPgqdI7dnW8xnXEHcERxMG39cOSnYAbK9SjbdHf2ZJRrDKQxJ1MqE9JcR\",\"created_at\":\"2019-12-02 08:43:53\",\"updated_at\":\"2020-03-03 13:19:23\",\"avatar\":\"http:\\/\\/localhost\\/meazafood\\/public\\/storage\\/users\\/0.jpg\",\"getroles\":[{\"id\":1,\"name\":\"agent\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 11:30:28\",\"updated_at\":\"2020-02-29 08:43:40\",\"getpermissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}],\"pivot\":{\"model_id\":3,\"role_id\":1,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}]}],\"roles\":[{\"id\":1,\"name\":\"agent\",\"guard_name\":\"web\",\"created_at\":\"2019-11-30 11:30:28\",\"updated_at\":\"2020-02-29 08:43:40\",\"getpermissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}],\"pivot\":{\"model_id\":3,\"role_id\":1,\"model_type\":\"App\\\\User\"},\"permissions\":[{\"id\":12,\"name\":\"access_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:26:58\",\"updated_at\":\"2020-02-18 17:26:58\",\"pivot\":{\"role_id\":1,\"permission_id\":12}},{\"id\":13,\"name\":\"access_draft_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-18 17:29:15\",\"updated_at\":\"2020-02-18 17:29:15\",\"pivot\":{\"role_id\":1,\"permission_id\":13}},{\"id\":14,\"name\":\"access_pending_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:25\",\"updated_at\":\"2020-02-20 20:20:25\",\"pivot\":{\"role_id\":1,\"permission_id\":14}},{\"id\":15,\"name\":\"access_approved_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:35\",\"updated_at\":\"2020-02-20 20:20:35\",\"pivot\":{\"role_id\":1,\"permission_id\":15}},{\"id\":16,\"name\":\"access_completed_orders\",\"guard_name\":\"web\",\"created_at\":\"2020-02-20 20:20:43\",\"updated_at\":\"2020-02-20 20:20:43\",\"pivot\":{\"role_id\":1,\"permission_id\":16}},{\"id\":17,\"name\":\"access_bills\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:20:27\",\"updated_at\":\"2020-02-25 12:20:27\",\"pivot\":{\"role_id\":1,\"permission_id\":17}},{\"id\":18,\"name\":\"access_transactions\",\"guard_name\":\"web\",\"created_at\":\"2020-02-25 12:22:17\",\"updated_at\":\"2020-02-25 12:22:17\",\"pivot\":{\"role_id\":1,\"permission_id\":18}},{\"id\":20,\"name\":\"agent_create_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:22:57\",\"updated_at\":\"2020-02-27 18:22:57\",\"pivot\":{\"role_id\":1,\"permission_id\":20}},{\"id\":21,\"name\":\"agent_edit_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:06\",\"updated_at\":\"2020-02-27 18:23:06\",\"pivot\":{\"role_id\":1,\"permission_id\":21}},{\"id\":22,\"name\":\"agent_delete_draft_order\",\"guard_name\":\"web\",\"created_at\":\"2020-02-27 18:23:17\",\"updated_at\":\"2020-02-27 18:23:17\",\"pivot\":{\"role_id\":1,\"permission_id\":22}},{\"id\":31,\"name\":\"isAgent\",\"guard_name\":\"web\",\"created_at\":\"2020-02-28 09:16:48\",\"updated_at\":\"2020-02-28 09:16:48\",\"pivot\":{\"role_id\":1,\"permission_id\":31}},{\"id\":32,\"name\":\"access_orders_statistic\",\"guard_name\":\"web\",\"created_at\":\"2020-03-01 09:23:18\",\"updated_at\":\"2020-03-01 09:23:18\",\"pivot\":{\"role_id\":1,\"permission_id\":32}}]}]},\"link\":\"http:\\/\\/localhost\\/meazafood\\/public\\/admin\\/order\\/details\\/81\"}', NULL, '2020-03-03 10:34:11', '2020-03-03 10:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'access-roles', 'web', '2019-12-09 10:28:55', '2019-12-09 10:28:55'),
(5, 'access-users', 'web', '2019-12-09 10:29:06', '2019-12-09 10:29:06'),
(6, 'access-permissions', 'web', '2019-12-09 10:29:25', '2019-12-09 10:29:25'),
(7, 'access-configs', 'web', '2019-12-09 10:29:43', '2019-12-09 10:29:43'),
(8, 'give-permissions', 'web', '2019-12-09 12:03:45', '2019-12-09 12:03:45'),
(11, 'access_products', 'web', '2020-02-18 07:57:14', '2020-02-18 14:27:43'),
(12, 'access_orders', 'web', '2020-02-18 14:26:58', '2020-02-18 14:26:58'),
(13, 'access_draft_orders', 'web', '2020-02-18 14:29:15', '2020-02-18 14:29:15'),
(14, 'access_pending_orders', 'web', '2020-02-20 17:20:25', '2020-02-20 17:20:25'),
(15, 'access_approved_orders', 'web', '2020-02-20 17:20:35', '2020-02-20 17:20:35'),
(16, 'access_completed_orders', 'web', '2020-02-20 17:20:43', '2020-02-20 17:20:43'),
(17, 'access_bills', 'web', '2020-02-25 09:20:27', '2020-02-25 09:20:27'),
(18, 'access_transactions', 'web', '2020-02-25 09:22:17', '2020-02-25 09:22:17'),
(19, 'isAdmin', 'web', '2020-02-27 07:10:55', '2020-02-27 07:10:55'),
(20, 'agent_create_draft_order', 'web', '2020-02-27 15:22:57', '2020-02-27 15:22:57'),
(21, 'agent_edit_draft_order', 'web', '2020-02-27 15:23:06', '2020-02-27 15:23:06'),
(22, 'agent_delete_draft_order', 'web', '2020-02-27 15:23:17', '2020-02-27 15:23:17'),
(23, 'admin_edit_pending_order', 'web', '2020-02-27 15:23:25', '2020-02-27 15:23:26'),
(24, 'admin_delete_pending_order', 'web', '2020-02-27 15:23:33', '2020-02-27 15:23:33'),
(25, 'admin_edit_approved_order', 'web', '2020-02-27 15:23:40', '2020-02-27 15:23:40'),
(26, 'admin_delete_approved_order', 'web', '2020-02-27 15:23:49', '2020-02-27 15:23:49'),
(27, 'admin_edit_completed_order', 'web', '2020-02-27 15:23:59', '2020-02-27 15:23:59'),
(28, 'admin_delete_completed_order', 'web', '2020-02-27 15:24:08', '2020-02-27 15:24:08'),
(29, 'admin_add_transaction', 'web', '2020-02-28 06:13:48', '2020-02-28 06:13:48'),
(30, 'admin_delete_transaction', 'web', '2020-02-28 06:16:31', '2020-02-28 06:16:31'),
(31, 'isAgent', 'web', '2020-02-28 06:16:48', '2020-02-28 06:16:48'),
(32, 'access_orders_statistic', 'web', '2020-03-01 06:23:18', '2020-03-01 06:23:18'),
(33, 'access_financial_statistic', 'web', '2020-03-01 06:23:51', '2020-03-01 06:23:51');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'agent', 'web', '2019-11-30 08:30:28', '2020-02-29 05:43:40'),
(2, 'developer', 'web', '2019-11-30 13:53:41', '2019-11-30 13:53:41');

-- --------------------------------------------------------

--
-- Table structure for table `role_configuration`
--

CREATE TABLE `role_configuration` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `configuration_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_configuration`
--

INSERT INTO `role_configuration` (`id`, `role_id`, `configuration_id`, `created_at`, `updated_at`) VALUES
(41, 2, 10, NULL, NULL),
(44, 1, 7, NULL, NULL),
(46, 2, 6, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(11, 2),
(12, 1),
(12, 2),
(13, 1),
(13, 2),
(14, 1),
(14, 2),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(17, 1),
(17, 2),
(18, 1),
(18, 2),
(19, 2),
(20, 1),
(20, 2),
(21, 1),
(21, 2),
(22, 1),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 1),
(32, 1),
(32, 2),
(33, 2);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `user_id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(9, 1, 'dev-setting-1', '77', '2019-12-09 06:29:33', '2019-12-09 06:29:33'),
(10, 1, 'receive-noti-4new-users', '1', '2019-12-09 13:14:21', '2019-12-09 13:14:21'),
(11, 1, 'notifications-show-limit', '4', '2019-12-12 13:20:51', '2019-12-12 13:20:51'),
(13, 2, 'receive-noti-4new-users', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Murad Alwan', 'free1soft@gmail.com', NULL, '$2y$10$7XCBy.NbQfLDXAWnnkiUze7MunO79FCjmVVK5fx0LCZggALBY/IoC', 'daCnjQdkYpxXGS3Rcxmu2G5nCgMLJ4hNM3iknxoy7VFvBI1exWnyIj1TSPlY', '5aVoI6e9C83qkt5OxTqbrIsnnzVq9vULL8fMA2zih1PjG02ED3e6mF1PgY0N', '2019-11-26 08:57:41', '2020-04-18 10:38:54'),
(2, 'Hussam Totile', 'hussam@gmail.com', NULL, '$2y$10$BOSA8NOUXDdVg/ST0v/LDeMnP.PaRBYiHE/Zedus4Qwz.M1Tr7PsK', NULL, NULL, '2019-12-01 05:22:11', '2019-12-01 05:22:11'),
(3, 'israr totil', 'isrartoteel@yahoo.com', NULL, '$2y$10$ydw1JpTEB5D5iXLjfZsgy.nM8wq8Sb4UJ.3xHIACHwlS0jqhBZkD6', 'opRktPxjliGAqkT6I6fhAjvXoYJJQ4yu2xcmK8kEgQY230F8l0rJaCYDIOI5', NULL, '2019-12-02 05:43:53', '2020-03-04 10:42:15'),
(4, 'Ashtyn Herman', 'mortimer.luettgen@example.com', '2019-12-06 12:06:51', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'uFSfHEz3ia', '2019-12-06 12:06:51', '2019-12-06 12:06:51'),
(5, 'Amie Ebert Jr.', 'jett13@example.org', '2019-12-06 12:06:51', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'HOmCfrFkeD', '2019-12-06 12:06:51', '2019-12-06 12:06:51'),
(6, 'Prof. Jett Borer V', 'kameron.luettgen@example.com', '2019-12-06 12:06:51', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, 'w9xlijyPo5', '2019-12-06 12:06:51', '2019-12-06 12:06:51'),
(17, 'Besha', 'besha@gmail.com', NULL, '$2y$10$cK.TJnTfwKcGYl9irYhIR.noG9lh6JqHN/MSMHMlfRnVqeBtl8ZTa', NULL, NULL, '2019-12-13 06:57:58', '2019-12-13 06:57:58'),
(18, 'Samer', 'samer@hotmail.com', NULL, '$2y$10$/Ghch8SUezwUzbCFk8fqDOXgtgD1KPUC51LUqkFgutqBLHwtwrIAq', NULL, NULL, '2019-12-16 04:46:14', '2019-12-16 04:46:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `configurations`
--
ALTER TABLE `configurations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_configuration`
--
ALTER TABLE `role_configuration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `configurations`
--
ALTER TABLE `configurations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role_configuration`
--
ALTER TABLE `role_configuration`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
