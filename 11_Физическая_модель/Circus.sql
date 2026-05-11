-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 11 2026 г., 16:19
-- Версия сервера: 10.1.48-MariaDB
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Circus`
--

-- --------------------------------------------------------

--
-- Структура таблицы `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `customer`
--

INSERT INTO `customer` (`id`, `full_name`, `email`, `phone`, `password_hash`, `registration_date`) VALUES
(1, 'Воробьёв Артём Петрович', 'artem.vorobyov@mail.ru', '+7 (999) 123-45-67', '12345', '2026-05-08 05:40:15'),
(2, 'Лебедева Мария Сергеевна', 'maria.lebedeva@gmail.com', '+7 (999) 234-56-78', '67890', '2026-04-15 05:52:31'),
(3, 'Сидоров Владимир Александрович', 'v.sidorov@yandex.ru', '+7 (999) 345-67-89', '54321', '2026-03-31 21:00:00'),
(4, 'Котова Анна Владимировна', 'anna.kotova@mail.ru', '+7 (999) 456-78-90', '09876', '2026-03-19 17:08:36'),
(5, 'Новиков Дмитрий Игоревич', 'dmitry.novikov@gmail.com', '+7 (999) 567-89-01', '10293', '2026-02-10 09:40:15');

-- --------------------------------------------------------

--
-- Структура таблицы `hall`
--

CREATE TABLE `hall` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `hall`
--

INSERT INTO `hall` (`id`, `name`, `capacity`) VALUES
(1, 'Главная арена', 500),
(2, 'Малый зал', 120),
(3, 'Детская арена', 80);

-- --------------------------------------------------------

--
-- Структура таблицы `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_sum` decimal(10,2) NOT NULL DEFAULT '0.00',
  `check_number` varchar(100) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `order`
--

INSERT INTO `order` (`id`, `customer_id`, `status_id`, `created_at`, `total_sum`, `check_number`, `payment_date`, `payment_method`) VALUES
(1, 1, 3, '2026-05-11 12:26:49', '4500.00', 'CHK-101', '2026-05-10 07:35:00', 'card'),
(2, 2, 3, '2026-05-11 12:26:49', '3300.00', 'CHK-102', '2026-05-11 11:25:00', 'card'),
(3, 3, 1, '2026-05-11 12:26:49', '2200.00', NULL, NULL, NULL),
(4, 4, 3, '2026-05-11 12:26:49', '2600.00', 'CHK-104', '2026-05-12 13:50:00', 'cash'),
(5, 5, 4, '2026-05-11 12:26:49', '2000.00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `order_status`
--

CREATE TABLE `order_status` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `order_status`
--

INSERT INTO `order_status` (`id`, `name`, `description`) VALUES
(1, 'pending', 'Ожидает оплаты'),
(2, 'reserved', 'Забронирован'),
(3, 'paid', 'Оплачен'),
(4, 'cancelled', 'Отменён'),
(5, 'refunded', 'Возвращён');

-- --------------------------------------------------------

--
-- Структура таблицы `performance`
--

CREATE TABLE `performance` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `artists` text,
  `duration_minutes` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `performance`
--

INSERT INTO `performance` (`id`, `title`, `description`, `artists`, `duration_minutes`, `created_at`) VALUES
(1, 'Великолепное цирковое шоу', 'Грандиозное представление с акробатами и животными', 'Михаил Леонов, Дарья Ростова, труппа акробатов', 120, '2026-05-11 12:26:49'),
(2, 'Магия иллюзий', 'Шоу фокусов от мировых звёзд', 'Уилл Волшебник, команда иллюзионистов', 90, '2026-05-11 12:26:49'),
(3, 'Цирк шапито', 'Классическое представление для всей семьи', 'Труппа цирковых артистов, дрессированные животные', 100, '2026-05-11 12:26:49'),
(4, 'Акробатическое безумие', 'Невероятные трюки и полёты под куполом', 'Команда акробатов из Китая', 80, '2026-05-11 12:26:49');

-- --------------------------------------------------------

--
-- Структура таблицы `seat`
--

CREATE TABLE `seat` (
  `id` int(11) NOT NULL,
  `hall_id` int(11) NOT NULL,
  `row_number` int(11) NOT NULL,
  `seat_number` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `seat`
--

INSERT INTO `seat` (`id`, `hall_id`, `row_number`, `seat_number`, `category_id`) VALUES
(1, 1, 1, 1, 2),
(2, 1, 1, 2, 2),
(3, 1, 1, 3, 2),
(4, 1, 2, 1, 3),
(5, 1, 2, 2, 3),
(6, 1, 2, 3, 3),
(7, 1, 3, 1, 1),
(8, 1, 3, 2, 1),
(9, 1, 3, 3, 1),
(10, 1, 4, 1, 4),
(11, 2, 1, 1, 2),
(12, 2, 1, 2, 2),
(13, 2, 2, 1, 3),
(14, 2, 2, 2, 3),
(15, 2, 3, 1, 1),
(16, 2, 3, 2, 1),
(17, 2, 4, 1, 4),
(18, 2, 4, 2, 4),
(19, 3, 1, 1, 2),
(20, 3, 1, 2, 2),
(21, 3, 2, 1, 3),
(22, 3, 2, 2, 3),
(23, 3, 3, 1, 1),
(24, 3, 3, 2, 1),
(25, 3, 4, 1, 4),
(26, 3, 4, 2, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `hall_id` int(11) NOT NULL,
  `performance_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `base_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `session`
--

INSERT INTO `session` (`id`, `hall_id`, `performance_id`, `start_time`, `end_time`, `base_price`) VALUES
(1, 1, 1, '2026-05-15 14:00:00', '2026-05-15 16:00:00', '1500.00'),
(2, 1, 3, '2026-05-20 11:00:00', '2026-05-20 12:40:00', '1200.00'),
(3, 2, 1, '2026-05-16 18:00:00', '2026-05-16 20:00:00', '1400.00'),
(4, 2, 4, '2026-05-23 16:00:00', '2026-05-23 17:20:00', '1300.00'),
(5, 3, 2, '2026-05-18 19:00:00', '2026-05-18 20:30:00', '1100.00'),
(6, 3, 3, '2026-05-21 11:00:00', '2026-05-21 12:40:00', '1000.00');

-- --------------------------------------------------------

--
-- Структура таблицы `ticket`
--

CREATE TABLE `ticket` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `session_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `unique_code` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `purchased_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `ticket`
--

INSERT INTO `ticket` (`id`, `order_id`, `session_id`, `seat_id`, `unique_code`, `price`, `purchased_at`) VALUES
(1, 1, 1, 1, 'QR-A1B2C3', '3000.00', '2026-05-11 12:26:49'),
(2, 1, 1, 4, 'QR-D4E5F6', '1500.00', '2026-05-11 12:26:49'),
(3, 2, 3, 11, 'QR-G7H8I9', '2800.00', '2026-05-11 12:26:49'),
(4, 2, 3, 13, 'QR-J0K1L2', '1500.00', '2026-05-11 12:26:49'),
(5, 3, 5, 21, 'QR-M3N4O5', '2200.00', '2026-05-11 12:26:49'),
(6, 4, 4, 12, 'QR-P6Q7R8', '2600.00', '2026-05-11 12:26:49'),
(7, 5, 6, 23, 'QR-S9T0U1', '2000.00', '2026-05-11 12:26:49');

-- --------------------------------------------------------

--
-- Структура таблицы `ticket_category`
--

CREATE TABLE `ticket_category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price_multiplier` decimal(3,2) DEFAULT '1.00',
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `ticket_category`
--

INSERT INTO `ticket_category` (`id`, `name`, `price_multiplier`, `description`) VALUES
(1, 'standard', '1.00', 'Обычные места'),
(2, 'vip', '2.00', 'VIP ряды у сцены'),
(3, 'premium', '1.50', 'Улучшенный обзор'),
(4, 'budget', '0.75', 'Бюджетные места');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_customer_email` (`email`);

--
-- Индексы таблицы `hall`
--
ALTER TABLE `hall`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_customer` (`customer_id`),
  ADD KEY `fk_order_status` (`status_id`);

--
-- Индексы таблицы `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_status_name` (`name`);

--
-- Индексы таблицы `performance`
--
ALTER TABLE `performance`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `seat`
--
ALTER TABLE `seat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_seat_location` (`hall_id`,`row_number`,`seat_number`),
  ADD KEY `fk_seat_category` (`category_id`);

--
-- Индексы таблицы `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_session_hall` (`hall_id`),
  ADD KEY `fk_session_perf` (`performance_id`);

--
-- Индексы таблицы `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_session_seat` (`session_id`,`seat_id`),
  ADD UNIQUE KEY `uk_ticket_code` (`unique_code`),
  ADD KEY `fk_ticket_order` (`order_id`),
  ADD KEY `fk_ticket_seat` (`seat_id`);

--
-- Индексы таблицы `ticket_category`
--
ALTER TABLE `ticket_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_category_name` (`name`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `hall`
--
ALTER TABLE `hall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `performance`
--
ALTER TABLE `performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `seat`
--
ALTER TABLE `seat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `ticket_category`
--
ALTER TABLE `ticket_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_status` FOREIGN KEY (`status_id`) REFERENCES `order_status` (`id`);

--
-- Ограничения внешнего ключа таблицы `seat`
--
ALTER TABLE `seat`
  ADD CONSTRAINT `fk_seat_category` FOREIGN KEY (`category_id`) REFERENCES `ticket_category` (`id`),
  ADD CONSTRAINT `fk_seat_hall` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_session_hall` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_session_perf` FOREIGN KEY (`performance_id`) REFERENCES `performance` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `fk_ticket_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ticket_seat` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ticket_session` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
