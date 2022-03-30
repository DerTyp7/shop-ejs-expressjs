-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 30. Mrz 2022 um 14:57
-- Server-Version: 10.4.22-MariaDB
-- PHP-Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `onlineshop`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `street` varchar(60) NOT NULL,
  `housenumber` int(11) NOT NULL,
  `country` varchar(60) NOT NULL,
  `userId` int(11) NOT NULL,
  `cityId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(3, 'Bauwaren'),
(1, 'Elektrowaren'),
(6, 'Lebensmittel'),
(5, 'Technik'),
(4, 'Television');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `postcode` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `cities`
--

INSERT INTO `cities` (`id`, `name`, `postcode`) VALUES
(1, 'Bremerhaven', '27574'),
(2, 'Bremerhaven', '27574'),
(3, 'Bremerhaven', '27574');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_statusId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `orders`
--

INSERT INTO `orders` (`id`, `order_statusId`, `userId`) VALUES
(19, 34, 28),
(20, 35, 28),
(21, 36, 28),
(22, 37, 28);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_products`
--

CREATE TABLE `order_products` (
  `id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `order_products`
--

INSERT INTO `order_products` (`id`, `price`, `quantity`, `productId`, `orderId`) VALUES
(17, '130.99', 1, 4, 19),
(18, '130.99', 1, 4, 20),
(19, '130.99', 1, 4, 21),
(20, '130.99', 1, 4, 22);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_status`
--

CREATE TABLE `order_status` (
  `id` int(11) NOT NULL,
  `received` tinyint(1) NOT NULL DEFAULT 0,
  `trackingnumber` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `order_status`
--

INSERT INTO `order_status` (`id`, `received`, `trackingnumber`) VALUES
(5, 0, 'undefined'),
(8, 0, 'tasdadse'),
(9, 0, 'tasddadse'),
(11, 0, 'e19f1b04-8eb8-42ad-b0e0-ca0de80565fa'),
(12, 0, '1f96e5bc-5e21-4dd5-b977-e49953b2ffd4'),
(13, 0, '8775feb6-f561-4ef0-8788-77e4af006726'),
(14, 0, '6ffd662f-547a-484b-b84d-6c1cd0e6135c'),
(15, 0, '3e0c73e6-2243-401a-9ef4-88db0903d600'),
(16, 0, '76bec49c-f51a-4690-aed3-2405ff7fb626'),
(17, 0, 'd6343eaf-719d-4e66-821f-f2c70ee4aa08'),
(18, 0, 'b291d096-4f4c-4fc4-8c4a-3684f1ad4c93'),
(19, 0, 'e5f7c5c0-273c-4c53-97c9-4656f1e57262'),
(20, 0, '8ca728ff-e52d-4199-95f1-681b032aedba'),
(21, 0, '0ba2e8f3-475b-4645-acac-d4a188b762aa'),
(22, 0, 'd4ec8293-7007-4274-bdd3-965a6bef36cd'),
(23, 0, '2e639e69-7397-40a9-aa46-12d689c2306b'),
(24, 0, 'd265236b-78d7-4324-b35c-a0ea81d7984b'),
(25, 0, '23baa6d0-e5cb-4a88-a545-9512029dc774'),
(26, 0, '08361df5-1155-42dc-9748-2b8ab07fe068'),
(27, 0, '20a59258-4af8-429c-9619-cc1da7bf9c53'),
(28, 0, 'ed78d8ea-c598-42aa-8cdf-c2d5e997b1fc'),
(29, 0, '607940f4-3b01-4e72-89cd-4035eea4c45a'),
(30, 0, '94f05435-4347-4b6d-9cef-dfbfe0f7ee53'),
(31, 0, 'c5750318-a6c4-43d1-ba74-1f2ca1739d3a'),
(32, 0, 'e5344302-a3ec-428a-8161-7d6c3aee1d9e'),
(33, 0, 'e36028f1-ff70-4f1e-95af-4777d1899e5b'),
(34, 0, '2941ab9c-3a14-4aa3-9814-2e88d119b2c4'),
(35, 0, '472965da-1de5-427d-ab2b-a6a49afae530'),
(36, 0, 'a2e69c68-00d3-44a6-8214-b1ce7061ee59'),
(37, 0, 'eefc615e-63a2-430f-8656-36a4229e434e');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `delivery_time` int(11) NOT NULL,
  `sellerId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `quantity`, `delivery_time`, `sellerId`) VALUES
(1, 'LED Leiste mit RGBW', '3.56', 'Mit warmweiß funktion', 0, 2, 1),
(2, 'Nagel ', '2.00', 'Gut zum nageln', 83, 2, 1),
(3, 'Glühbirne x35 10000000 Watt', '1.60', 'Glühbirne mit viel Watt', 0, 2, 1),
(4, 'LG TV 500x QHD', '130.99', 'Richtig guter TV mit perfekter Qualität', 23, 3, 1),
(5, 'Raspberry Pi 4, Raspberry Pi Starter Kit (4GB RAM / 32GB SD)', '209.99', 'Raspberry Pi 4 4GB RAM: New SOC Broadcom BCM2711, 1.5GHz Quad-Core ARM Cortex-A72 CPU. Dual band 802.11b/g/n/ac WiFi (2.4/5.0 GHz) and BT 5.0 module for fast wireless networking with less interference and better reception.\r\nHigh Capacity - 2×USB 3 0 Ports, 2 × USB 2 0 ports and 2 × Micro HDMI ports. The HEVC 4K streams can support at 60 fps and manage 2 screens in 4K.\r\n32GB Class 10 SD Card: pre-installed with Raspberry Pi OS (Raspbian), can be easily booted with Raspbian for Raspberry Pi 4. Equipped with an SD card reader that is compatible with USB-A & USB-C C, easy to connect microSD to the computer.\r\nPowerful Cooling System: Equipped with 1 mini heat sink fan and 3 copper heat sink, your Raspberry Pi 4 can provide impeccable heat dissipation and prevent system failure. Uniquely designed premium housing provides enough space for fan and gap for heat dissipation.\r\nProfessional power supply with on/off switch: 1.5M/5V 3A USB-C power supply with noise filter and on/off switch, specially designed and tested for Raspberry Pi 4 (UL Listed) low-loss power transmission, thick and durable.\r\n', 8345, 3, 2),
(6, 'Be Quiet Straight Power 11 Power Supply, Black 1000W', '179.43', 'Ausgestattet mit einem nahezu unhörbaren SilentWings3 135mm Lüfter\nDas be quiet! Straight Power 11 1000W setzt neue Maßstäbe für flüsterleise Systeme, ohne auch nur geringste Kompromisse bei der Stromversorgung einzugehen\nGesteigerte Spannungsregulierung und Stabilität dank fortschrittlicher LLC, SR und DC/DC Technologie\nKomfortables vollmodulares Kabelmanagement sorgt für maximale Flexibilität und einfache Bedienung\nProduktkonzeption, Design und Qualitätskontrolle in Deutschland\n', 453, 4, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
(6, 1),
(4, 5),
(4, 4),
(4, 1),
(2, 3),
(5, 1),
(5, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `product_images`
--

CREATE TABLE `product_images` (
  `product_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `product_images`
--

INSERT INTO `product_images` (`product_id`, `image_id`, `url`) VALUES
(1, 1, 'https://m.media-amazon.com/images/I/51i6Fa5p5FL._AC_SX679_.jpg'),
(1, 2, 'https://www.kirstein.de/out/pictures/master/product/4/b1df4be1c26466cc20d05efc5c734_4.jpg'),
(2, 3, 'https://media.bahag.cloud/m/494972/12.jpg'),
(3, 4, 'https://microsites.pearl.de/i/76/nx2952_2.jpg'),
(4, 5, 'https://www.lg.com/de/images/tv/md07529053/gallery/medium01.jpg'),
(6, 6, 'https://m.media-amazon.com/images/I/81EU0ntJC-L._AC_SL1500_.jpg'),
(3, 7, 'https://www.lampe.de/media/product/69220/343x343/gluehbirne-ambiance-warm-white-e27-60-watt-662-lumen-h3340783-do1-0.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `title` varchar(60) NOT NULL,
  `content` text NOT NULL,
  `rating` int(2) NOT NULL DEFAULT 0,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `reviews`
--

INSERT INTO `reviews` (`id`, `title`, `content`, `rating`, `userId`, `productId`) VALUES
(9, 'asd', 'ads', 3, 28, 5),
(10, 'ompatible with USB-A & USB-C C, easy to connect microSD to t', 'i 4 4GB RAM: New SOC Broadcom BCM2711, 1.5GHz Quad-Core ARM Cortex-A72 CPU. Dual band 802.11b/g/n/ac WiFi (2.4/5.0 GHz) and BT 5.0 module for fast wireless networking with less interference and better reception. High Capacity - 2×USB 3 0 Ports, 2 × USB 2 0 ports and 2 × Micro HDMI ports. The HEVC 4K streams can support at 60 fps and manage 2 screens in 4K. 32GB Class 10 SD Card: pre-installed with Raspberry Pi OS (Raspbian), can be easily booted with Raspbian for Raspberry Pi 4. Equipped with an SD card reader that is compatible with USB-A & USB-C C, easy to connect microSD to the computer. Powerful Cooling System: Equipped with 1 mini heat sink fan and 3 copper heat sink, your Raspberry Pi 4 can provide impeccable heat dissipation and prevent system failure. Uniquely designed premium housing provides enough space f', 5, 28, 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sellers`
--

CREATE TABLE `sellers` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `sellers`
--

INSERT INTO `sellers` (`id`, `name`, `description`) VALUES
(1, 'Rüdiger', 'Hersteller für Wasserleitungen'),
(2, 'Hans-Jürgen GmbH', 'Hersteller von Elektrowaren'),
(3, 'Peter-Schmit', 'Hersteller von lauten Baugeräuschen während der Arbeitszeit.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `shopping_cart_item`
--

CREATE TABLE `shopping_cart_item` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `userinfos`
--

CREATE TABLE `userinfos` (
  `id` int(11) NOT NULL,
  `firstname` varchar(60) NOT NULL,
  `lastname` varchar(60) NOT NULL,
  `gender` varchar(60) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `userinfos`
--

INSERT INTO `userinfos` (`id`, `firstname`, `lastname`, `gender`, `userId`) VALUES
(7, 'Janis', 'Meister', 'Herr', 28);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(255) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `isAdmin`) VALUES
(28, 'janis', 'janis.meister87@', '$2a$10$E2nEjP/LkKhF750iYiyEIuzrGCMYStAWwE9d8iGWwhIoof4JOC/we', 0);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_ibfk_1` (`userId`),
  ADD KEY `cityId` (`cityId`);

--
-- Indizes für die Tabelle `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indizes für die Tabelle `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `orders_ibfk_2` (`order_statusId`);

--
-- Indizes für die Tabelle `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_products_ibfk_1` (`productId`),
  ADD KEY `orderId` (`orderId`);

--
-- Indizes für die Tabelle `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trackingnumber` (`trackingnumber`);

--
-- Indizes für die Tabelle `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `article_ibfk_1` (`sellerId`);

--
-- Indizes für die Tabelle `product_categories`
--
ALTER TABLE `product_categories`
  ADD KEY `product_id` (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indizes für die Tabelle `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indizes für die Tabelle `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indizes für die Tabelle `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indizes für die Tabelle `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `userinfos`
--
ALTER TABLE `userinfos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userinfos_ibfk_1` (`userId`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT für Tabelle `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT für Tabelle `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `userinfos`
--
ALTER TABLE `userinfos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`cityId`) REFERENCES `cities` (`id`);

--
-- Constraints der Tabelle `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`order_statusId`) REFERENCES `order_status` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`sellerId`) REFERENCES `sellers` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints der Tabelle `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints der Tabelle `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`);

--
-- Constraints der Tabelle `userinfos`
--
ALTER TABLE `userinfos`
  ADD CONSTRAINT `userinfos_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
