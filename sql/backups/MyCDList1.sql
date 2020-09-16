-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 04, 2019 at 10:07 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MyCDList`
--

-- --------------------------------------------------------

--
-- Table structure for table `Artist`
--

CREATE TABLE `Artist` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `active_years` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT 'images/artist/default_artist.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Artist`
--

INSERT INTO `Artist` (`id`, `name`, `genre`, `active_years`, `image`) VALUES
(1, 'AC/DC', 'Hard Rock', '1970-present', 'images/artist/default_artist.png'),
(2, 'Miles Davis', 'Jazz', '1940-1990', 'images/artist/miles-davis.jpeg'),
(3, 'Cream', 'Rock', '1966-1968', 'images/artist/cream.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `Collection`
--

CREATE TABLE `Collection` (
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `gotdate` date DEFAULT NULL,
  `artist` int(11) NOT NULL,
  `type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Follow`
--

CREATE TABLE `Follow` (
  `username` varchar(30) NOT NULL,
  `artist` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Follow`
--

INSERT INTO `Follow` (`username`, `artist`) VALUES
('pino', 1),
('pino', 2),
('pino', 3);

-- --------------------------------------------------------

--
-- Table structure for table `List`
--

CREATE TABLE `List` (
  `username` varchar(30) NOT NULL,
  `list_name` varchar(100) NOT NULL,
  `record` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Record`
--

CREATE TABLE `Record` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `artist` int(11) NOT NULL,
  `style` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT 'images/default_record.png',
  `genre` varchar(100) NOT NULL,
  `producer` varchar(100) DEFAULT NULL,
  `tracks` text NOT NULL,
  `year` int(11) NOT NULL,
  `n_votes` int(11) NOT NULL DEFAULT 0,
  `ratings_sum` int(11) NOT NULL DEFAULT 0,
  `avg_rating` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Record`
--

INSERT INTO `Record` (`id`, `title`, `artist`, `style`, `image`, `genre`, `producer`, `tracks`, `year`, `n_votes`, `ratings_sum`, `avg_rating`) VALUES
(1, 'Wheels Of Fire', 3, 'Blues rock, Hard Rock', 'images/record/wheels-of-fire.jpeg', 'Rock', 'Cream', 'Wheels of Fire\r\netc', 1967, 0, 0, 0),
(2, 'Back in Black', 1, 'Hard Rock', 'images/record/back-in-black.jpg', 'Rock', 'AC/DC', 'Back in black\r\netc', 1981, 0, 0, 0),
(3, 'Kindle of Blue', 2, 'Hard Bop, Bebop', 'images/record/kind-of-blue.jpg', 'Jazz', 'Miles Davis', 'Kindle of Blue\r\netc', 1954, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Review`
--

CREATE TABLE `Review` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `artist` int(11) NOT NULL,
  `body` text NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `Review`
--
DELIMITER $$
CREATE TRIGGER `Update_rating` AFTER INSERT ON `Review` FOR EACH ROW BEGIN

	UPDATE Record SET Record.n_votes = Record.n_votes + 1, 
	                  Record.ratings_sum = Record.ratings_sum + NEW.rating
    
    WHERE Record.id = NEW.record 
          AND 
          Record.artist = NEW.artist;
    
    
	UPDATE Record SET Record.avg_rating = Record.ratings_sum/Record.n_votes
	WHERE Record.id = NEW.record 
	      AND 
	      Record.artist = NEW.artist; 

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `image` varchar(100) DEFAULT 'images/default_profile.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`username`, `password`, `email`, `birthday`, `image`) VALUES
('pino', 'grepolis', 'pino@gmail.com', '1999-02-23', 'images/default_profile.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Artist`
--
ALTER TABLE `Artist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Collection`
--
ALTER TABLE `Collection`
  ADD PRIMARY KEY (`username`,`record`,`artist`),
  ADD KEY `record` (`record`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `Follow`
--
ALTER TABLE `Follow`
  ADD PRIMARY KEY (`username`,`artist`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `List`
--
ALTER TABLE `List`
  ADD PRIMARY KEY (`username`,`list_name`),
  ADD KEY `record` (`record`);

--
-- Indexes for table `Record`
--
ALTER TABLE `Record`
  ADD PRIMARY KEY (`id`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `Review`
--
ALTER TABLE `Review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `record` (`record`),
  ADD KEY `artist` (`artist`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Artist`
--
ALTER TABLE `Artist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Record`
--
ALTER TABLE `Record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Review`
--
ALTER TABLE `Review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Collection`
--
ALTER TABLE `Collection`
  ADD CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Users` (`username`),
  ADD CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`record`) REFERENCES `Record` (`id`),
  ADD CONSTRAINT `collection_ibfk_3` FOREIGN KEY (`artist`) REFERENCES `Artist` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `Follow`
--
ALTER TABLE `Follow`
  ADD CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Users` (`username`),
  ADD CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`artist`) REFERENCES `Artist` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `List`
--
ALTER TABLE `List`
  ADD CONSTRAINT `list_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Users` (`username`),
  ADD CONSTRAINT `list_ibfk_2` FOREIGN KEY (`record`) REFERENCES `Record` (`id`);

--
-- Constraints for table `Record`
--
ALTER TABLE `Record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `Artist` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `Review`
--
ALTER TABLE `Review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Users` (`username`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`record`) REFERENCES `Record` (`id`),
  ADD CONSTRAINT `review_ibfk_3` FOREIGN KEY (`artist`) REFERENCES `Artist` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
