-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 31. Mrz 2022 um 11:40
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
(1, 'Elektronik'),
(4, 'Fernseher'),
(6, 'Kabel'),
(7, 'Kameras');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `postcode` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_statusId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `order_status`
--

CREATE TABLE `order_status` (
  `id` int(11) NOT NULL,
  `received` tinyint(1) NOT NULL DEFAULT 0,
  `trackingnumber` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'Canon PowerShot SX620 HS Digital Camera', '389.00', 'Capture stunning faraway detail using this tiny, pocketable 25x zoom camera with HS System\r\nWi-Fi* with NFC and Image Sync make it simple to connect to your smart device, capture shots remotely, then share or back up your creations\r\nMake the most of the incredible zoom and effortlessly record steady, shareable Full HD movies with Auto Zoom and Dynamic IS\r\nJust point and shoot to capture fantastic photos or movies with Hybrid Auto and Intelligent IS\r\nDigital Camera PowerShotSX620 HS Wrist Strap WS-800 Battery Pack NB-13L Battery Charger CB-2LHE AC Cable User Manual Kit', 44, 3, 1),
(2, 'Canon EOS 4000D DSLR Kamera', '505.00', 'HOHE BILDQUALITÄT - DSLR-Kamera, 18 Megapixel, Wunderschöne Fotos und Videos mit attraktiver Hintergrundunschärfe aufnehmen mit unserer Spiegelreflex-Kamera in Full HD, auch in schwierigen Lichtverhältnissen ganz einfach gute Aufnahmen machen\r\nWLAN - Ganz einfach unterwegs verbinden, aufnehmen und teilen, LC-Display\r\nKOMBINATIONSMÖGLICHKEITEN - Erkunde die Möglichkeiten einer DSLR und von Wechselobjektiven\r\nKREATIV WERDEN - Einfach verständliche Anleitungen helfen dir beim Ausdrücken deiner Kreativität\r\nLIEFERUMFANG - EOS 4000D Gehäuse; Objektiv EF-S 18-55mm f/3.5-5.6 III; Augenmuschel; Gehäusedeckel; Trageriemen; Akku LP-E10; Akkuladegerät LC-E10E; Netzkabel; Objektivdeckel; Objektivrückdeckel; Anleitung', 12, 3, 1),
(3, 'Canon PowerShot G3 X Digitalkamera', '880.43', 'HOHE BILDQUALITÄT - 20,2 Megapixel CMOS-Sensor; Leistungsstarker DIGIC6 Bildprozessor\r\nIM FOKUS - 25-fach optischer Zoom, Ultra-Weitwinkelobjektiv\r\nDISPLAY - Ein großer, hochauflösender (1.620.000 Bildpunkte) und klappbarer LCD-Touchscreen\r\nSETTINGS - Blende, Belichtung und ISO-Empfindlichkeit der Digital-Kamera sind im Movie-Modus einstellbar; Optischer Bildstabilisator\r\nLIEFERUMFANG - Canon PowerShot G3 X Digitalkamera; Objektivdeckel; Umhängegurt NS-DC11; Akku NB-10L; Akkuladegerät CB-2LCE; Netzkabel; Anleitungen', 4, 3, 1),
(4, 'Canon EOS M50 Systemkamera spiegellos', '699.00', 'HOHE BILDQUALITÄT - Hochauflösende spiegellose System-Kamera mit 24,1 Megapixeln\r\nPROFESSIONELLE VIDEOAUFNAHMEN - Videos in 4 K Qualität\r\nEINFACHES HANDLING - 7,5 cm drehbares und schwenkbares Touchscreen Display; Kompakt und leicht zu bedienen; Kompatibel mit allen EF und EF-S Objektiven (mit optionalem EF-Mount Adapter)\r\nWLAN UND BLUETOOTH - Teilen und Drucken, direkt von der Kamera\r\nLIEFERUMFANG - Canon EOS M50 spiegellose Systemkamera, Objektiv EF-M 15-45mm IS STM, Tragegurt; Akkuladegerät; Netzkabel; Akku; Anleitungen; schwarz\r\n', 1, 3, 1),
(5, 'Sony RX100 III | Premium-Kompaktkamera', '469.99', 'ATEMBERAUBENDE BILDQUALITÄT: Der große Bildsensor vom Typ 1.0 hat eine Auflösung von 20,1 Megapixeln, die mit der Back-Illuminated-Technologie einen großen Empfindlichkeitsbereich erreichen\r\nIDEAL FÜR VIDEO-CREATOR: Bildstabilisierung und neigbares Display für Vlogging\r\nENTSCHEIDENDE MOMENTE FESTHALTEN: Ein elektronischer Sucher ist die Wahl vieler Fotografen, da sie die Kamera so sicher halten können\r\nTEILEN SIE IHRE KREATIONEN: Einfache Freigabe auf Ihren mobilen Geräten über die Imaging Edge Mobile-App (Wi-Fi)\r\nIM RAHMEN: Mit dem neigbaren Touchdisplay können Sie Ihr Motiv bei Aufnahmen aus niedrigen oder hohen Winkeln leicht einrahmen\r\nBatterien enthalten', 30, 3, 2),
(6, 'Sony RX10 IV | Premium-Kompaktkamera', '1651.18', 'GROßER ZOOMBEREICH: ZEISS Vario-Sonnar T* 24-600mm F2.4-4 Große Blende, hochvergrößerndes Zoom-Objektiv\r\nATEMBERAUBENDE BILDQUALITÄT: Der große Bildsensor vom Typ 1.0 hat eine Auflösung von 20,1 Megapixeln, die mit der Back-Illuminated-Technologie einen großen Empfindlichkeitsbereich erreichen\r\nSCHNELLER UND PRÄZISER AUTOFOKUS: Verlassen Sie sich auf 0,03s AF, Real Time Tracking und Augen AF, um Ihr Motiv in jeder Situation scharf zu halten\r\nKEINEN MOMENT VERPASSEN: Bis zu 24fps mit Autofokus\r\nIDEAL FÜR VIDEO-CREATOR: Interne 4K Video-Aufnahmen mit Pro-Funktionen und Bildstabilisierung', 2, 3, 2),
(7, 'Sony DSC-H300 Digitalkamera', '213.70', '20,1 Megapixel Super HAD CCD Sensor\r\nOptischer 35fach-Zoom\r\nOptischer SteadyShot verringert Unschärfen sogar bei schlechten Lichtverhältnissen\r\nHD-Videofunktion für exzellentes Video\r\nSchwenkpanorama zum Erfassen der gesamten Szene\r\nLieferumfang: AA-Batterie, Schultergurt, Objektivkappe, Objektivband, USB-Multikabel, Bedienungsanleitung', 14, 3, 2),
(8, 'Sony DSC-HX60 Digitalkamera', '249.00', 'Exmor R CMOS Sensor und 30x opt. Zoom (60x Klarbild-Zoom)\r\nBIONZ X Bildprozessor - 3 mal schnellere Bildverarbeitung imVergleich zum Vorgänger\r\n24mm Sony G Weitwinkelobjektiv mit 4K Bilder\r\nNFC/ WiFi Funktion (u.a. Übertragung von Bildern aufs Smartphone)\r\nLieferumfang : Akkusatz (NP-BX1) ,Bedienungsanleitung,Blitzschuhkappe,Handgelenkschlaufe, Micro-USB-Kabel,Netzkabel,Netzteil (AC-UB10C/UB10D)\r\nSICHTWINKEL (ENTSPRICHT 35 MM) (FOTO):84°–3° 30 Min. (24–720 mm )\r\nWenn Sie mit der Funktion Send to Smartphone (An Smartphone senden) der App Imaging Edge Mobile (Nachfolger von PlayMemories Mobile) keine Videos an Ihr Smartphone senden können, überprüfen Sie das Dateiformat des Videos, das Sie senden möchten. Die Funktion kann nur für MP4-Dateien verwendet werden. Die Funktion kann nicht bei AVCHD-Dateien verwendet werden. Außerdem ist die Nutzung der Funktion nicht möglich, wenn der Flugmodus auf EIN eingestellt ist. HINWEIS: Nicht alle Kameras verfügen über die Wi-Fi-Funktion oder den Flugmodus. Um festzustellen, ob Ihre Kamera diese Funktionen aufweist, sehen Sie in den technischen Daten nach', 66, 3, 2),
(9, 'Panasonic LUMIX DMC-TZ58EG-K', '395.00', '20x optischer Zoom (KB: 24-480mm) und hochwertiges 24mm Weitwinkel Objektiv\r\n180° kippbares 7,5cm Tilt-LC-Display (1.040.000 Bildpunkte)\r\nWiFi-Funktion: Zoomen & Auslösen über mobile Endgeräte und verbesserter Selbstportrait-Funktionen\r\nFull HD Videos [1920x1080; AVCHD] mit AF und optischem Zoom\r\nStromversorgung: Li-ion Akku (3,6V, 1250mAh, 4,5 Wh) (inkludiert)/AC Adapter (Eingang: 110 - 240V AC) (inkludiert, über USB Kabel)\r\nLieferumfang: Kamera; Li-Ionen-Akku; Netzteil; USB-Kabel; Handschlaufe; Bedienungsanleitung', 6, 3, 3),
(10, 'Panasonic DC-FZ1000', '669.00', 'Exzellente Bildqualität - dank 1-Zoll großem MOS Sensor mit 20 Megapixel\r\nBeeindruckende Optik - 16x Zoom LEICA Objektiv F2.8-4/ 25-400 mm\r\nPräzise Bildkontrolle - Großer OLED Sucher (2, 4 MP, 0, 74x) und schwenkbares 3-Zoll Touch LCD\r\n4K Funktionen – 4K Foto 30 B/s, Post Fokus, Focus Stacking, 4K30p bzw. Full HD 60p Video\r\nSchnelligkeit – Sehr schneller DFD-Autofokus (0, 09 s), bis zu 12 B/s Serien', 5, 3, 3),
(11, 'Panasonic Lumix DC-FZ82', '299.99', '20 mm Weitwinkel und 60x Zoom - 20 - 1200 mm, F2.8-5.9\r\n4K Foto-& Video-Funktion - 4K Foto mit 30 B/s, Post Focus & Focus Stacking, 4K Video 30p\r\nWiFi Funktion - u.a. Fernsteuerung und Backup\r\nHochauflösender Sucher - 1,2 Megapixel\r\nSpeichermedium: Kompatibel mit UHS-I-Speed-Klasse-3-Standard-SD/SDHC-/SDXC-Speicherkarten\r\nLieferumfang: Kamera DC-FZ82, Li-Ionen Akku, AC-Adapter, USB-Kabel, Schultergurt, Objektivdeckel, Objektivdeckelband', 21, 3, 3),
(12, 'Panasonic LUMIX DMC-FZ1000G9', '599.99', 'Exzellente Bildqualität - dank 1 Zoll großem Sensor mit 20,1 Megapixel\r\nBeeindruckende Optik - LEICA Objektiv F2.8-4 / 25-400 mm mit 16x Zoom\r\nPräzise Bildkontrolle - Großer OLED Sucher und schwenkbarer LCD-Monitor\r\nGestochen scharfe Aufnahmen – dank 4K\r\nSchnelligkeit – Sehr schneller DFD-Autofokus (0, 09 s), bis zu 12 B/s Serien', 19, 3, 3),
(13, 'Sony KD-55X80J BRAVIA 139cm (55 Zoll)', '764.40', 'Mit dem 4K HDR-Prozessor X1 und 4K X-Reality PRO fühlt sich alles, was Sie sehen, unglaublich real an - mit Bildern, die noch näher an die echte 4K-Qualität heranreichen, für eine bemerkenswerte Klarheit.\r\nMehr als eine Milliarde Farben werden von TRILUMINOS PRO zum Leben erweckt - sehen Sie schillernde, lebensechte Farben, die auf Ihrem 4K-Fernseher zum Leben erweckt werden.\r\nDer X-Balanced Speaker sorgt für klaren, hochwertigen Klang aus mehreren Richtungen, sodass Sie direkt in die Szene eintauchen können.\r\nMit der Freisprechfunktion von Google können Sie Ihre Fernbedienung beiseite legen und Ihren 4K-Fernseher nur mit Ihrer Stimme steuern. Versuchen Sie, Ihren 55-Zoll-Fernseher zu bitten, einen bestimmten Titel zu finden, nach Genres zu suchen, und erhalten Sie personalisierte Empfehlungen, was Sie sich ansehen könnten.\r\nDas minimalistisches Design des Fernsehers hilft Ihnen, sich auf das Wesentliche zu konzentrieren - das Bild. Der zentrale Standfuß mit hochwertigem Finish wurde so entworfen, dass er perfekt zu diesem 4K-Fernseher passt und mit Ihrer Einrichtung harmoniert.', 8, 4, 2),
(14, 'Sony KD-49XH8096 Bravia 123 cm (49 Zoll)', '799.00', 'Der leistungsstarke X1 Prozessor von Sony verwendet erweiterte Algorithmen zur Rauschunterdrückung und zum Hervorheben von Details. Mit dem noch klareren 4K Signal wird alles in nahezu 4K Auflösung wiedergegeben, mit intensiveren Farben und mehr Kontrast.\r\nDurch Ausweitung des Farbspektrums gibt Triluminosmit unseren X1-Prozessoren mehr Farben als ein herkömmlicher Fernseher wieder. Er analysiert und verarbeitet Daten in jedem Bild, um Far.ben noch natürlicher und präziser aussehen zu lassen.\r\nUmgeben Sie sich mit dem klaren, hochwertigen Klang aus mehreren Richtungen, sodass Sie direkt in die Szene eintauchen können.\r\nDer schmale Rahmen verleiht Ihrem Fernseher einen eleganten Look, der sich harmonisch in jede moderne Umgebung einfügt.\r\nSuchen Sie mit Ihrer Stimme im Handumdrehen nach Ihren Lieblingsinhalten. Dank der sprachgesteuerten Suche gehört kompliziertes Navigieren oder lästiges Tippen der Vergangenheit an. Fragen Sie einfach\r\n', 4, 4, 2),
(15, 'Panasonic TX-43JXW604 108 cm LED Fernseher', '434.97', '4K ULTRA HD LED Flatscreen TV mit hervorragender Bildqualität, schnellen Bewegtbildern, gestochen scharfen Szenen und hohen Kontrasten\r\nSmarter 43 Zoll Fernseher mit HbbTV, Webbrowser und umfangreicher Auswahl an Apps wie Netflix, Prime Video, YouTube\r\nDer 4K UHD TV mit Multi HDR und USB-Media Player unterstützt die wichtigsten HDR-Formate wie HDR10 und Dolby Vision\r\nTV mit Google Assistant und Amazon Alexa für eine einfache und bequeme Bedienung per Sprachassistent\r\nFlat TV mit Compact Surround Sound Pro & Dolby Atmos für ein herausragendes Klangerlebnis mit klaren Dialogen und tiefen Bässen', 6, 4, 3),
(16, 'Panasonic TX-55JXW704 Android TV 139 cm LED', '769.96', 'Großer 4K ULTRA HD LED TV mit ausgezeichneter Bildqualität, perfekten Bewegtbildern, gestochen scharfen Szenen und hohen Kontrasten\r\n55 Zoll Fernseher mit Android Betriebssystem, Google Play und Apps wie Prime Video, Netflix, YouTube\r\nDer elegante 4K UHD TV mit Multi HDR und USB-Media Player unterstützt die wichtigsten HDR-Formate wie HDR10 und Dolby Vision\r\nSmarter Android TV mit Google Assistant für eine einfache und bequeme Bedienung per Sprachassistent\r\nFlat TV mit Compact Surround Sound Pro & Dolby Atmos für ein herausragendes Klangerlebnis mit klaren Dialogen und intensiven Bässen', 15, 4, 3),
(17, 'Samsung Crystal UHD 4K TV 50 Zoll', '499.00', 'HDR: Spannende Details in verschiedenen Szenen entdecken\r\nCrystal Prozessor 4K: Eine Vielfalt an Farbnuancen genießen\r\nQ-Symphony: TV und Soundbar in neuer Harmonie erleben\r\nContrast Enhancer: Große Tiefenwirkung und hohe Farbkontraste\r\nDesign: Faszinierendes, ultraschlankes Design für den eigenen UHD TV', 2, 4, 4),
(18, 'Philips TV 32PHS5505/12 32 Zoll-LED', '194.99', 'Dieser kompakte, erschwingliche Philips Fernseher hat alles, was Sie brauchen und ist leicht zu transportieren. Genießen Sie ein gestochen scharfes Bild dank der LED-Technologie.\r\nDie Pixel Plus HD-Engine des 32-Zoll-Fernsehers optimiert die Bildqualität und liefert gestochen scharfe Bilder. Genießen Sie kontrastreichere Bilder mit helleren Weißtönen und tieferen Schwarztönen.\r\nDank der Full-Range-Lautsprecher des 32-Zoll-TV genießen Sie einen klaren Ton und verpassen kein Detail. Freuen Sie sich auf kristallklare Dialoge und lebendige Effekte.\r\nDer HD LED-Fernseher verfügt über viele Anschlussmöglichkeiten. 2 HDMI-Anschlüsse und ein USB-Port ermöglichen Konnektivität mit unterschiedlichen externen Geräten.\r\nLieferumfang: Philips 32PHS5505/12 32-Zoll LED Fernseher (80 cm); Fernbedienung, 2 AAA-Batterien, Netzkabel, Kurzanleitung, Broschüre zu rechtlichen und Sicherheitsinformationen, Tischfuß', 3, 4, 5),
(19, 'Grundig Vision 6 - Fire TV', '257.61', 'Die Grundig Vision 6 - Fire TV steht mit ihrer Full-HD Auflösung von 1.920 x 1.080 Pixeln für Fernseherlebnisse, die in der Erinnerung lange nachhallen\r\nMit dem integrierten Fire TV-Erlebnis können Sie Tausende Sender, Apps und Alexa-Skills genießen, darunter Netflix, YouTube, Prime Video, ARD, ZDF, DAZN, waipu.tv und weitere. Möglicherweise fallen Kosten für Abonnements an\r\nFire TV  bietet nahtlose Integration von Live-Fernsehkanälen und Streamingsendern auf einer einzigen Startseite (HD-Antenne erforderlich) Vorbereitet für nach VESA-Norm (in mm) : 200 x 200\r\nSteuern Sie Ihren Fernseher ganz einfach mit der im Lieferumfang enthaltenen Sprachfernbedienung mit Alexa. Zudem können Sie Apps starten, Sendungen suchen, Musik abspielen, Eingänge wechseln, kompatible Smart Home-Geräte steuern und mehr – alles allein mit Ihrer Stimme\r\nMagic Fidelity ist ein Sound-Algorithmus mit speziell angeordneten Lautsprechern sowie einem zusätzlichen Woofer. Das bietet einen besonders klangvollen und brillanten Sound\r\nUm alle Funktionen der Grundig Fire TV Modelle nutzen zu können, ist ein Amazon Konto (Basic oder Prime) erforderlich', 2, 4, 6),
(20, 'LG 43UP75009LF 108 cm (43 Zoll) UHD', '364.93', '4K UHD Smart TV mit 108 cm (43 Zoll) Bildschirmdiagonale, Außenmaße 97,3 x 61,1 cm, VESA Norm: 200 x 200 mm\r\nSmart TV: webOS 6.0 (LG ThinQ) mit Apple Airplay 2, Home Dashboard, Google Assistant & Amazon Alexa verfügbar via Magic Remote-Fernbedienung (nicht enthalten), inkl. LG Fernbedienung\r\nProzessor: Quad Core Processor 4K mit AI Sound\r\nBild und Ton: Active HDR (HDR10 Pro, HLG), 2.0 ch Soundsystem (20W) mit HGiG-Kompatibilität\r\nTunertyp und Konnektivität: Triple Tuner (DVB-T2 HD/-C/-S2), LAN, ac-WLAN, Bluetooth 5.0, 2x HDMI 2.0 (eARC, ALLM), 1x USB, Optischer Ausgang, CI+ 1.4\r\n', 54, 4, 7),
(21, '1m Kaltgerätekabel', '5.99', 'Für TV, PC, Computer, Monitor, Bildschirm, Drucker, Beamer, Projektor, Spielekonsole\r\nSchutzkontakt Stecker auf C13 Buchse // Genormte, passgenaue Anschlüsse\r\nRobuste, langlebige Ausführung // Beidseitiger Kabel Knickschutz // Universell einsetzbar', 166, 2, 8),
(22, 'Gigabit-Ethernet-LAN-Kabel, RJ45, Cat6', '5.98', 'Cat-6-Ethernet-Patchkabel für kabelgebundene Heim- oder Büronetzwerke\r\nIdeal, um Computer in einem kabelgebundenen lokalen Netzwerk (LAN) mit Netzwerkkomponenten zu verbinden\r\nMit den RJ45-Anschlüssen ist eine Kompatibilität mit den meisten Netzwerkkomponenten sichergestellt; Bandbreite: 250 MHz\r\nDas Netzwerkkabel eignet sich für Datenübertragungsgeschwindigkeiten von bis zu 1.000 Mbit/s (oder 1 Gigabit pro Sekunde)', 111, 2, 8),
(23, 'Hochgeschwindigkeitskabel, Ultra HD HDMI 2.0, unterstützt 3D', '6.82', 'Die mit 24-karätigem Gold beschichteten Kontakte garantieren höchste Korrosionsbeständigkeit und eine verbesserte Signalübertragung\r\nMehrdrahtige hochreine Kupferleiter sorgen für eine exzellente Signalintegrität und minimieren Widerstände\r\nEine Abdeckung aus 100 % hochdichtem Polyethylen und eine Polyvinylchlorid-Ummantelung schützen vor Signalstörungen von außen\r\nMetallgeflecht und eine zweilagige Aluminium-Mylar-Abschirmung schützen vor externen Signalinterferenzen, garantieren eine stabile Signalübertragung und minimieren Signalverluste\r\nHDMI-Kabel A-Stecker auf A-Stecker: unterstützt Ethernet, 3D, 4K-Videowiedergabe und Audiorückkanal (ARC)\r\nEntspricht dem HDMI-Standard 2.0 (4K-Videowiedergabe bei 60 Hz, 2160p, 48 bbp Farbtiefe), der Bandbreiten bis 18 Gbit/s unterstützt und abwärtskompatibel mit den vorherigen HDMI-Standards ist\r\nKompatibel mit allen 3D-Blu-Ray-Playern, Real-3D-TV, AV-Receivern mit Full HD sowie mit Ultra HD Unterstützt alle Auflösungen für die Playstation 3 (PS3), Playstation 4 (PS4), Xbox, Xbox One und die Auflösung 4K Ultra HD', 66, 2, 8),
(24, 'Stereo Audio Klinken Verlängerung 3m', '3.99', 'Stereo-Audio Kabel 3,5mm Klinkenstecker auf 3,5mm Klinkenbuchse // Länge: 3,0m // Farbe: schwarz\r\nPerfekte Passform // flexibel // gute Klangqualität // optimale Signalqualität\r\nvergossene Stecker // passgenaue Stecker und Buchse // hohe Komptabilität // fester sitz\r\nIdeal für den Einstig in die Audiowelt // Einfache Verlängerung Ihres vorhandenen 3,5mm Klinken-Kabel // Schonung von Geräten und Stecker Buchsen\r\nFür Geräte wie: Smartphones, Tablets, MP3-Player, Autoradios, tragbare Lautsprecher, Laptop oder diverse andere Hi-Fi Geräte', 55, 2, 8),
(26, 'USB 3.0 Kabel', '7.99', 'Hochleistungs-USB 3.0-Stecker-Stecker-Kabel verbindet USB-Host-Computer mit USB 3.0-Typ-A-Anschluss (abwärtskompatibel mit USB 2.0-Typ-A-Anschluss) mit USB-Peripheriegeräten\r\nDas praktische und kostengünstige USB 3.0-Kabel bietet Ersatz- oder Ersatz-USB 3.0-Kabel, die Sie auf dem Desktop, in Ihrer Zubehörtasche oder im Auto aufbewahren können\r\nPremium USB 3.0-Kabel vom Typ A mit geformten Zugentlastungssteckern für Langlebigkeit und Griffprofilen für einfaches Ein- und Ausstecken. Genießen Sie die SuperSpeed USB 3.0-Datenübertragungsrate mit bis zu 5 Gbit / s, 10x schneller als USB 2.0\r\nDie Kombination aus vergoldeten Steckverbindern, blanken Kupferleitern und Folien- und Geflechtabschirmung bietet überlegene Kabelleistung und fehlerfreie Datenübertragung\r\nUnterstützt nicht die direkte Verbindung zweier Computer', 80, 2, 8);

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
(1, 1),
(1, 7),
(2, 1),
(2, 7),
(3, 1),
(3, 7),
(4, 1),
(4, 7),
(5, 1),
(5, 7),
(6, 1),
(6, 7),
(7, 1),
(7, 7),
(8, 1),
(8, 7),
(9, 1),
(9, 7),
(10, 1),
(10, 7),
(11, 1),
(11, 7),
(12, 1),
(12, 7),
(13, 1),
(13, 4),
(14, 1),
(14, 4),
(15, 1),
(15, 4),
(16, 1),
(16, 4),
(17, 1),
(17, 4),
(18, 1),
(18, 4),
(19, 1),
(19, 4),
(20, 1),
(20, 4),
(21, 6),
(22, 6),
(23, 6),
(24, 6),
(26, 6);

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
(1, 1, 'https://m.media-amazon.com/images/I/81DCmXMs7YL._AC_SL1500_.jpg'),
(1, 2, 'https://m.media-amazon.com/images/I/81n+--qz0mL._AC_SL1500_.jpg'),
(1, 10, 'https://m.media-amazon.com/images/I/71QDw4fv6iL._AC_SL1500_.jpg'),
(1, 11, 'https://m.media-amazon.com/images/I/71rEEWIPfYL._AC_SL1500_.jpg'),
(1, 12, 'https://m.media-amazon.com/images/I/81sSwNXLrwL._AC_SL1500_.jpg'),
(1, 13, 'https://m.media-amazon.com/images/I/71LyrVpqTPL._AC_SL1500_.jpg'),
(1, 14, 'https://m.media-amazon.com/images/I/81YqrQboQiL._AC_SL1500_.jpg'),
(2, 15, 'https://m.media-amazon.com/images/I/510BMH39rFS._AC_SL1000_.jpg'),
(2, 16, 'https://m.media-amazon.com/images/I/41eYZ96P8pL._AC_.jpg'),
(2, 17, 'https://m.media-amazon.com/images/I/41niJbFf-VL._AC_.jpg'),
(2, 18, 'https://m.media-amazon.com/images/I/41ZtGRPVocL._AC_.jpg'),
(2, 19, 'https://m.media-amazon.com/images/I/41rqa-tZ00L._AC_.jpg'),
(2, 20, 'https://m.media-amazon.com/images/I/41lhLsqJFOL._AC_.jpg'),
(2, 21, 'https://m.media-amazon.com/images/I/41tCpbNihVL._AC_.jpg'),
(2, 22, 'https://m.media-amazon.com/images/I/41rPZiX3gZL._AC_.jpg'),
(2, 23, 'https://m.media-amazon.com/images/I/91OJ5Nhpb8L._AC_SL1500_.jpg'),
(2, 24, 'https://m.media-amazon.com/images/I/91gH93vzBtL._AC_SL1500_.jpg'),
(3, 25, 'https://m.media-amazon.com/images/I/91bODLikNBL._AC_SL1500_.jpg'),
(3, 26, 'https://m.media-amazon.com/images/I/91u14mGALbL._AC_SL1500_.jpg'),
(3, 27, 'https://m.media-amazon.com/images/I/91++5sqLrDL._AC_SL1500_.jpg'),
(3, 28, 'https://m.media-amazon.com/images/I/91lKzxy2WLL._AC_SL1500_.jpg'),
(3, 29, 'https://m.media-amazon.com/images/I/91nuDdg4-pL._AC_SL1500_.jpg'),
(3, 30, 'https://m.media-amazon.com/images/I/91BAZKx1EqL._AC_SL1500_.jpg'),
(3, 31, 'https://m.media-amazon.com/images/I/914vIB41aOL._AC_SL1500_.jpg'),
(4, 32, 'https://m.media-amazon.com/images/I/818cwVoR6IL._AC_SL1500_.jpg'),
(4, 33, 'https://m.media-amazon.com/images/I/81NBl6pgjQL._AC_SL1500_.jpg'),
(4, 34, 'https://m.media-amazon.com/images/I/81J97sIUAIL._AC_SL1500_.jpg'),
(4, 35, 'https://m.media-amazon.com/images/I/81grxHee-JL._AC_SL1500_.jpg'),
(4, 36, 'https://m.media-amazon.com/images/I/81QS7x7GD-L._AC_SL1500_.jpg'),
(4, 37, 'https://m.media-amazon.com/images/I/91O52ZfhOOL._AC_SL1500_.jpg'),
(4, 38, 'https://m.media-amazon.com/images/I/81zycBbSrCL._AC_SL1500_.jpg'),
(4, 39, 'https://m.media-amazon.com/images/I/81cHuojOUkL._AC_SL1500_.jpg'),
(4, 40, 'https://m.media-amazon.com/images/I/71Kxzn-0uuL._AC_SL1500_.jpg'),
(5, 41, 'https://m.media-amazon.com/images/I/61bkHDmBG3L._AC_SL1376_.jpg'),
(5, 42, 'https://m.media-amazon.com/images/I/41Yb76r5mZL._AC_SL1000_.jpg'),
(5, 43, 'https://m.media-amazon.com/images/I/415Dpfg4AgL._AC_SL1000_.jpg'),
(5, 44, 'https://m.media-amazon.com/images/I/41l7Cs2oIJL._AC_SL1000_.jpg'),
(5, 45, 'https://m.media-amazon.com/images/I/41JdjymHYDL._AC_SL1000_.jpg'),
(5, 46, 'https://m.media-amazon.com/images/I/41fXt2JX0zL._AC_SL1000_.jpg'),
(5, 47, 'https://m.media-amazon.com/images/I/41UXyA11EaL._AC_SL1000_.jpg'),
(6, 48, 'https://m.media-amazon.com/images/I/81XhIPsp0AL._AC_SL1500_.jpg'),
(6, 49, 'https://m.media-amazon.com/images/I/81+HPW66hHL._AC_SL1500_.jpg'),
(6, 50, 'https://m.media-amazon.com/images/I/81-hAAXEzaL._AC_SL1500_.jpg'),
(6, 51, 'https://m.media-amazon.com/images/I/81+7fAa0RSL._AC_SL1500_.jpg'),
(6, 52, 'https://m.media-amazon.com/images/I/61tQcFe2goL._AC_SL1500_.jpg'),
(6, 53, 'https://m.media-amazon.com/images/I/71FgyoUyEaL._AC_SL1500_.jpg'),
(6, 54, 'https://m.media-amazon.com/images/I/71d1hGUch+L._AC_SL1500_.jpg'),
(6, 55, 'https://m.media-amazon.com/images/I/61Y05S7u4mL._AC_SL1200_.jpg'),
(6, 56, 'https://m.media-amazon.com/images/I/61Z2+tcAdkL._AC_SL1500_.jpg'),
(6, 57, 'https://m.media-amazon.com/images/I/61mkWOnhBDL._AC_SL1500_.jpg'),
(6, 58, 'https://m.media-amazon.com/images/I/71zV0B0NS8L._AC_SL1500_.jpg'),
(7, 59, 'https://m.media-amazon.com/images/I/71hqiLfUgfL._AC_SL1320_.jpg'),
(7, 60, 'https://m.media-amazon.com/images/I/51XBzO+PdSL._AC_SL1014_.jpg'),
(7, 61, 'https://m.media-amazon.com/images/I/51Qco2m46aL._AC_SL1014_.jpg'),
(7, 62, 'https://m.media-amazon.com/images/I/51wS4LWvp7L._AC_SL1014_.jpg'),
(7, 63, 'https://m.media-amazon.com/images/I/41vEoyPDkqL._AC_.jpg'),
(7, 64, 'https://m.media-amazon.com/images/I/51SDsva-UlL._AC_SL1014_.jpg'),
(7, 65, 'https://m.media-amazon.com/images/I/41DZxOVhUTL._AC_SL1014_.jpg'),
(7, 66, 'https://m.media-amazon.com/images/I/61JEOi-k3KL._AC_SL1342_.jpg'),
(8, 67, 'https://m.media-amazon.com/images/I/71HFUmhl6bL._AC_SL1500_.jpg'),
(8, 68, 'https://m.media-amazon.com/images/I/71fI+9kSYjL._AC_SL1500_.jpg'),
(8, 69, 'https://m.media-amazon.com/images/I/616GzHD0CkL._AC_SL1500_.jpg'),
(8, 70, 'https://m.media-amazon.com/images/I/61g2LEtQeaL._AC_SL1500_.jpg'),
(8, 71, 'https://m.media-amazon.com/images/I/611YJ2uMUJL._AC_SL1500_.jpg'),
(8, 72, 'https://m.media-amazon.com/images/I/616ov2jmHOL._AC_SL1500_.jpg'),
(8, 73, 'https://m.media-amazon.com/images/I/61xc9R0kiiL._AC_SL1500_.jpg'),
(8, 74, 'https://m.media-amazon.com/images/I/61rAwgUS1pL._AC_SL1200_.jpg'),
(9, 75, 'https://m.media-amazon.com/images/I/815IMXg9-VL._AC_SL1500_.jpg'),
(9, 76, 'https://m.media-amazon.com/images/I/81c0FEDJxTL._AC_SL1500_.jpg'),
(9, 77, 'https://m.media-amazon.com/images/I/81tLVZxcN2L._AC_SL1500_.jpg'),
(9, 78, 'https://m.media-amazon.com/images/I/71IZcb1i1IL._AC_SL1500_.jpg'),
(9, 79, 'https://m.media-amazon.com/images/I/71TPOViiqCL._AC_SL1500_.jpg'),
(9, 80, 'https://m.media-amazon.com/images/I/81-927conAL._AC_SL1500_.jpg'),
(10, 81, 'https://m.media-amazon.com/images/I/71Ppx85Bg3L._AC_SL1500_.jpg'),
(10, 82, 'https://m.media-amazon.com/images/I/71NcSF60-CL._AC_SL1500_.jpg'),
(10, 83, 'https://m.media-amazon.com/images/I/71bfPhfw8vL._AC_SL1500_.jpg'),
(10, 84, 'https://m.media-amazon.com/images/I/71wwCUL2daL._AC_SL1500_.jpg'),
(11, 85, 'https://m.media-amazon.com/images/I/81qszNigceL._AC_SL1500_.jpg'),
(11, 86, 'https://m.media-amazon.com/images/I/91cTBtz7JKL._AC_SL1500_.jpg'),
(11, 87, 'https://m.media-amazon.com/images/I/81AFDzajnfL._AC_SL1500_.jpg'),
(11, 88, 'https://m.media-amazon.com/images/I/818OYq+es1L._AC_SL1500_.jpg'),
(11, 89, 'https://m.media-amazon.com/images/I/817pU8NY4RL._AC_SL1500_.jpg'),
(11, 90, 'https://m.media-amazon.com/images/I/817S2EoP6NL._AC_SL1500_.jpg'),
(11, 91, 'https://m.media-amazon.com/images/I/81lnp0mHSyL._AC_SL1500_.jpg'),
(11, 92, 'https://m.media-amazon.com/images/I/817fJTUplVL._AC_SL1500_.jpg'),
(12, 93, 'https://m.media-amazon.com/images/I/81Gs3hg4WCL._AC_SL1500_.jpg'),
(12, 94, 'https://m.media-amazon.com/images/I/81q-amUe1eL._AC_SL1500_.jpg'),
(12, 95, 'https://m.media-amazon.com/images/I/81C2erkoy8L._AC_SL1500_.jpg'),
(12, 96, 'https://m.media-amazon.com/images/I/81Ib6XdpvdL._AC_SL1500_.jpg'),
(12, 97, 'https://m.media-amazon.com/images/I/81lJ4bYztHL._AC_SL1500_.jpg'),
(12, 98, 'https://m.media-amazon.com/images/I/71KO4Hm6oEL._AC_SL1500_.jpg'),
(12, 99, 'https://m.media-amazon.com/images/I/81XK5lSvDRL._AC_SL1500_.jpg'),
(12, 100, 'https://m.media-amazon.com/images/I/41jcMDTx2jL._AC_.jpg'),
(13, 101, 'https://m.media-amazon.com/images/I/71iG0VvrRcL._AC_SL1500_.jpg'),
(13, 102, 'https://m.media-amazon.com/images/I/91CwMQ0eiBL._AC_SL1500_.jpg'),
(13, 103, 'https://m.media-amazon.com/images/I/91D0x1arQ2L._AC_SL1500_.jpg'),
(13, 104, 'https://m.media-amazon.com/images/I/81Yx6PgV7pL._AC_SL1500_.jpg'),
(13, 105, 'https://m.media-amazon.com/images/I/81BRtp5RkNL._AC_SL1500_.jpg'),
(13, 106, 'https://m.media-amazon.com/images/I/81omn2D-SoL._AC_SL1500_.jpg'),
(13, 107, 'https://m.media-amazon.com/images/I/81h7nO14xlL._AC_SL1500_.jpg'),
(13, 108, 'https://m.media-amazon.com/images/I/91xMyp9tdNL._AC_SL1500_.jpg'),
(13, 109, 'https://m.media-amazon.com/images/I/81bfsdPa1TL._AC_SL1500_.jpg'),
(14, 110, 'https://m.media-amazon.com/images/I/91Ci6Ae-7aL._AC_SL1500_.jpg'),
(14, 111, 'https://m.media-amazon.com/images/I/91iObyq2BEL._AC_SL1500_.jpg'),
(14, 112, 'https://m.media-amazon.com/images/I/71RHt5vSYAL._AC_SL1500_.jpg'),
(15, 113, 'https://m.media-amazon.com/images/I/91FZq1xq+mL._AC_SL1500_.jpg'),
(15, 114, 'https://m.media-amazon.com/images/I/51+EEzFtRdL._AC_SL1500_.jpg'),
(15, 115, 'https://m.media-amazon.com/images/I/51xkhnMGqEL._AC_SL1500_.jpg'),
(15, 116, 'https://m.media-amazon.com/images/I/71z8dbKlq5L._AC_SL1500_.jpg'),
(16, 117, 'https://m.media-amazon.com/images/I/815ERt6sLTL._AC_SL1500_.jpg'),
(16, 118, 'https://m.media-amazon.com/images/I/81bSNQztLxL._AC_SL1500_.jpg'),
(16, 119, 'https://m.media-amazon.com/images/I/81X+wakhjZL._AC_SL1500_.jpg'),
(17, 120, 'https://m.media-amazon.com/images/I/71xxQighEXS._AC_SL1500_.jpg'),
(17, 123, 'https://m.media-amazon.com/images/I/71NLkGXrr3S._AC_SL1500_.jpg'),
(17, 124, 'https://m.media-amazon.com/images/I/41rvLUgLI0S._AC_SL1500_.jpg'),
(17, 125, 'https://m.media-amazon.com/images/I/81EumbJf42S._AC_SL1500_.jpg'),
(18, 126, 'https://m.media-amazon.com/images/I/81Sp3qkg-AL._AC_SL1500_.jpg'),
(18, 127, 'https://m.media-amazon.com/images/I/81crEGh0lfL._AC_SL1500_.jpg'),
(18, 128, 'https://m.media-amazon.com/images/I/71hl2X8SY1L._AC_SL1500_.jpg'),
(19, 129, 'https://m.media-amazon.com/images/I/614vMfvtebL._AC_SL1500_.jpg'),
(19, 130, 'https://m.media-amazon.com/images/I/61D+O8ISNoL._AC_SL1500_.jpg'),
(19, 131, 'https://m.media-amazon.com/images/I/61B5+iMM1rL._AC_SL1500_.jpg'),
(20, 132, 'https://m.media-amazon.com/images/I/A1U7ujn3BOS._AC_SL1500_.jpg'),
(20, 133, 'https://m.media-amazon.com/images/I/A1O9xH3RRmS._AC_SL1500_.jpg'),
(20, 134, 'https://m.media-amazon.com/images/I/619JH8tvoYL._AC_SL1500_.jpg'),
(20, 135, 'https://m.media-amazon.com/images/I/710exw94drL._AC_SL1500_.jpg'),
(21, 136, 'https://m.media-amazon.com/images/I/61b0iqjkYmS._AC_SL1300_.jpg'),
(21, 137, 'https://m.media-amazon.com/images/I/51g4kUwHEyS._AC_SL1300_.jpg'),
(21, 138, 'https://m.media-amazon.com/images/I/61yHNNgYAwS._AC_SL1300_.jpg'),
(22, 139, 'https://m.media-amazon.com/images/I/61mEMxpYwSL._SL1500_.jpg'),
(22, 140, 'https://m.media-amazon.com/images/I/817wP7ySVTL._SL1500_.jpg'),
(22, 141, 'https://m.media-amazon.com/images/I/61r4K-yQ5bL._SL1500_.jpg'),
(22, 142, 'https://m.media-amazon.com/images/I/71xKLbOyjvL._SL1500_.jpg'),
(23, 143, 'https://m.media-amazon.com/images/I/71pFDaZU8lL._AC_SL1500_.jpg'),
(23, 144, 'https://m.media-amazon.com/images/I/81bGoAXUTdL._AC_SL1500_.jpg'),
(23, 145, 'https://m.media-amazon.com/images/I/71QRhFbimSL._AC_SL1000_.jpg'),
(24, 146, 'https://m.media-amazon.com/images/I/61dmALyn8xL._AC_SL1500_.jpg'),
(24, 147, 'https://m.media-amazon.com/images/I/71PsiAuW7KL._AC_SL1500_.jpg'),
(24, 148, 'https://m.media-amazon.com/images/I/61Tvc1WSgIL._AC_SL1500_.jpg'),
(26, 149, 'https://m.media-amazon.com/images/I/61Dwrp7qfCL._AC_SL1500_.jpg');

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
(1, 'Canon', 'Canon ist ein japanisches Unternehmen mit Sitz in Tokio, das 1937 unter der Bezeichnung Seikikōgaku kenkyūsho von Yoshida Goro, Uchida Saburo und dem Arzt Takeshi Mitarai gegründet wurde. Canon ist Weltmarktführer beim Verkauf von digitalen Kameras mit einem Marktanteil von 45,4 Prozent.'),
(2, 'Sony', 'Sony ist nach Hitachi und Panasonic der drittgrößte japanische Elektronikkonzern, mit Sitz im Tokioter Bezirk Minato. Kerngeschäft ist die Playstation, CMOS-Bildsensoren, das Musik- und Filmgeschäft sowie die Unterhaltungselektronik.'),
(3, 'Panasonic', 'Die Panasonic Corporation ist ein börsennotierter japanischer Elektronikkonzern mit Sitz in Kadoma, Präfektur Osaka, Japan. Seine Produkte werden unter mehreren Markennamen wie Panasonic und Technics vertrieben. Bis zum 30. September 2008 firmierte er unter dem Namen Matsushita Denki Sangyō K.K.'),
(4, 'Samsung', 'Samsung Electronics Co., Ltd. ist einer der größten Elektronikkonzerne weltweit und gehört zur südkoreanischen Samsung Group, dessen Hauptsitz in Seoul liegt. Samsung Electronics ist mit 197 Niederlassungen in 84 Ländern tätig und beschäftigt ca. 105.257 Mitarbeiter'),
(5, 'Philips', 'Koninklijke Philips N.V. ist ein Hersteller von Gesundheitstechnologie und Haushaltsgeräten mit Sitz in Amsterdam.'),
(6, 'Grundig', 'Grundig war ein deutsches Unternehmen für Unterhaltungselektronik mit Sitz in Fürth und später Nürnberg. Es wurde 1930 von dem Radiohändler Max Grundig gegründet. Es wurde zu einem Symbol des westdeutschen Wirtschaftswunders und galt lange Zeit als Traditionsunternehmen.'),
(7, 'LG', 'LG Electronics Home Entertainment ist Hersteller von Bildschirmen, im Jahr 2000 noch in Röhrentechnik[10] und inzwischen von Flachbildschirmen und AV-Produkten für Endanwender und Geschäftskunden. Das Produktspektrum umfasst unter anderem OLED, LED/LCD- und Plasma-Fernseher, Heimkinosysteme, Blu-ray-Player sowie Audio- und Video-Player.'),
(8, 'delyCON', 'Stellt seit 2014 Kabel aller Art in hervorragender Qualität her.');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `order_status`
--
ALTER TABLE `order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT für Tabelle `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT für Tabelle `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `shopping_cart_item`
--
ALTER TABLE `shopping_cart_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `userinfos`
--
ALTER TABLE `userinfos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
