-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 11, 2019 at 12:10 PM
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
(1, 'AC/DC', 'hard rock, heavy metal, blues metal', '1973-present', 'images/artist/default_artist.png'),
(2, 'Miles Davis', 'jazz, cool jazz, bebop, fusion', '1944-1975, 1980-1991', 'images/artist/miles-davis.jpeg'),
(3, 'Cream', 'rock, hard rock, blues rock', '1966-1968', 'images/artist/cream.jpg'),
(4, 'James Brown', 'funk, jazz-funk, soul, soul-funk', '1953–1988, 1991–2006', 'images/artist/james-brown.jpg'),
(5, 'Bob Seger', 'rock, blues rock, garage rock', '1965-present', 'images/artist/bob-seger.jpg'),
(6, 'Los Bravos', 'pop rock, soft rock, beat', '1965-1968', 'images/artist/los-bravos.jpg'),
(7, 'Deep Purple', 'rock, progressive rock, blues rock', '1968-1976', 'images/artist/deep-purple.jpg'),
(8, 'Aphex Twin', 'techno, ambient techno', '1985-present', 'images/artist/aphex-twin.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `Collection`
--

CREATE TABLE `Collection` (
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `added` date NOT NULL,
  `artist` int(11) NOT NULL,
  `media` varchar(30) NOT NULL,
  `notes` varchar(240) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Collection`
--

INSERT INTO `Collection` (`username`, `record`, `added`, `artist`, `media`, `notes`) VALUES
('pino', 1, '2019-11-09', 3, 'CD', 'I very much like this CD. Nice quality'),
('pino', 3, '2019-11-09', 2, 'Vynil', 'This is an old record that my grandpa left me'),
('pino', 9, '2019-11-09', 2, 'Vynil', 'Love this'),
('pino', 10, '2019-11-09', 2, 'Digital', 'Nice miles'),
('pino', 11, '2019-11-09', 3, 'CD', 'Awesome rock stuff'),
('pino', 15, '2019-11-09', 8, 'Digital', 'Perfect techno'),
('pino', 16, '2019-11-09', 8, 'CD', 'Aphex is aphex'),
('pino', 17, '2019-11-09', 8, 'Vynil', NULL),
('pino', 19, '2019-11-09', 8, 'CD', NULL),
('pino', 21, '2019-11-09', 8, 'CD', NULL),
('pino', 22, '2019-11-09', 8, 'Cassette', 'I\'m one of the luckiest man on earth. I\'m one of the luckiest man on earth. I\'m one of the luckiest man on earth. I\'m one of the luckiest man on earth.  ');

-- --------------------------------------------------------

--
-- Table structure for table `Comment`
--

CREATE TABLE `Comment` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `added` datetime NOT NULL DEFAULT current_timestamp(),
  `content` longtext NOT NULL,
  `artist` int(11) NOT NULL
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
(1, 'Wheels Of Fire', 3, 'blues rock, hard rock', 'images/record/wheels-of-fire.jpeg', 'rock', 'Cream', 'White Room 4:56\r\nSitting On Top Of The World 4:56\r\nPassing The Time 4:31\r\nAs You Said 4:19\r\nPressed Rat And Warthog	3:13\r\nPolitician 4:11\r\nThose Were The Days 2:52\r\nBorn Under A Bad Sign 3:08\r\nDeserted Cities Of The Heart 4:36', 1967, 0, 0, 0),
(2, 'Back in Black', 1, 'hard rock', 'images/record/back-in-black.jpg', 'rock', 'AC/DC', 'Hells Bells 5:10\r\nShoot To Thrill	5:17\r\nWhat Do You Do For Money Honey 3:36\r\nGiven The Dog A Bone 3:31\r\nLet Me Put My Love Into You 4:12\r\nBack In Black 4:17\r\nYou Shook Me All Night Long 3:29\r\nHave A Drink On Me 4:01\r\nShake A Leg 4:04\r\nRock And Roll Ain\'t Noise Pollution 4:12\r\n', 1981, 0, 0, 0),
(3, 'Kind of Blue', 2, 'hard bop, bebop', 'images/record/kind-of-blue.jpg', 'jazz', 'Miles Davis', 'So What	8:56\r\nFreddie Freeloader 9:32\r\nBlue In Green 5:27\r\nAll Blues 11:34\r\nFlamenco Sketches 9:32\r\n', 1954, 0, 0, 0),
(4, 'The New Sounds', 2, 'jazz', 'images/record/the-new-sounds.jpg', 'jazz', 'Bob Weinstock', 'Conception 4:03\r\nDig	7:33\r\nMy Old Flame	6:36\r\nIt\'s Only A Paper Moon	5:23', 1951, 0, 0, 0),
(5, 'Young Man With A Horn', 2, 'bop', 'images/record/young-man-with-a-horn.jpg', 'jazz', 'Alfred Lion', 'Dear Old Stockholm  4:10\r\nChance It  3:00\r\nYesterdays  3:42\r\nDonna 3:10\r\nWould\'n You  3:19\r\nHow Deep Is the Ocean?  4:36', 1953, 0, 0, 0),
(6, 'Blue Period', 2, 'cool jazz', 'images/record/blue-period.jpg', 'jazz', 'Bob Weinstock', 'Bluing 9:55\r\nBlue Room 2:48\r\nOut of the Blue 6:15\r\n', 1953, 0, 0, 0),
(7, 'Vol. 2', 2, 'bop', 'images/record/vol-2.jpg', 'jazz', 'Alfred Lion', 'Take Off 3:37\r\nWeirdo  4:42\r\nWould\'n You  3:19\r\nI Waited for You 3:26\r\nRay\'s Idea (Alternate Master) 3:48\r\nDonna 3:10\r\nWell, You Needn\'t  5:20\r\nThe Leap  4:28\r\nLazy Susan  4:00\r\nTempus Fugit (Alternate Master)  3:55\r\nIt Never Entered My Mind 4:02', 1955, 0, 0, 0),
(8, 'Blue Moods', 2, 'hard bop', 'images/record/blue-moods.jpg', 'jazz', ' Charles Mingus', 'Nature Boy 6:14\r\nAlone Together 7:17\r\nThere\'s No You 8:06\r\nEasy Living 5:03', 1955, 0, 0, 0),
(9, 'Birth Of The Cool', 2, 'cool jazz', 'images/record/birth-of-the-cool.jpg', 'jazz', 'Walter Rivers & Pete Rugolo', 'Move 2:33\r\nJeru 3:13\r\nMoon Dreams 3:19\r\nVenus de Milo 3:13\r\nBudo 2:34\r\nDeception 2:49\r\nGodchild 3:11\r\nBoplicity 3:00\r\nRocker 3:06\r\nIsrael 2:18\r\nRouge 3:15\r\nDarn That Dream 3:25', 1957, 0, 0, 0),
(10, '\'Round About Midnight', 2, 'hard bop', 'images/record/round-about-midnight.jpg', 'jazz', 'George Avakian', 'Round Midnight 5:55\r\nAh-Leu-Cha 5:53\r\nAll of You 7:01\r\nBye Bye Blackbird 7:54\r\nTadd\'s Delight 4:26\r\nDear Old Stockholm  7:49\r\nTwo Bass Hit  3:45\r\nLittle Melonae 7:18\r\nBudo 4:14\r\nSweet Sue, Just You 3:39', 1957, 0, 0, 0),
(11, 'Disraeli Gears', 3, 'blues rock, psychedelic rock', 'images/record/disraeli-gears.jpg', 'rock', 'Felix Pappalardi', 'Strange Brew	2:45\r\nSunshine Of Your Love	4:08\r\nWorld Of Pain	3:05\r\nDance The Night Away	3:31\r\nBlue Condition 3:26\r\nTales Of Brave Ulysses 2:50\r\nSwlabr 2:32\r\nWe\'re Going Wrong 3:25\r\nOutside Woman Blues 2:20\r\nTake It Back 3:05\r\nMother\'s Lament 1:47', 1967, 0, 0, 0),
(12, 'Fresh Cream', 3, 'blues rock, electric blues, psychedelic rock', 'images/record/fresh-cream.jpg', 'rock', 'Robert Stigwood', 'N.S.U.	\r\nSleepy Time Time	\r\nDreaming	\r\nSweet Wine	\r\nSpoonful	\r\nCat\'s Squirrel	\r\nFour Until Late	\r\nRollin\' And Tumblin\'	\r\nI\'m So Glad	\r\nToad', 1966, 0, 0, 0),
(13, 'Black Is Black', 6, 'beat, pop rock, rythm & blyes, soul-funk', 'images/record/black-is-black.jpg', 'rock, funk, pop', 'Ivor Raymonde', 'Trapped	2:53\r\nBaby, Baby	2:18\r\nMake It Easy For Me	2:33\r\nShe Believes In Me	2:39\r\nWill You Always Love Me	2:58\r\nBlack Is Black	2:38\r\nStop That Girl	2:23\r\nGive Me A Chance	2:34\r\nCuttin\' Out	2:57\r\nTwo Kinds Of Lovers	2:10\r\nYou Won\'t Get Far	2:15\r\nBaby, Believe Me	2:14', 1966, 0, 0, 0),
(14, 'Bring A Little Lovin\'', 6, 'pop rock, classic rock', 'images/record/bring-a-little-lovin.jpg', 'rock', 'none', '\r\nBring A Little Lovin\'	\r\nMake It Last	\r\nYou Got Until The Morning	\r\nThen The Sun Goes Down	\r\nGet Out Of My Life	\r\nShow Me	\r\nPlay With Fire And You\'ll Get Burned	\r\nDon\'t Get In My Way	\r\nSympathy	\r\nShe\'s My Girl	\r\nIf I Were A River	\r\nBlack Is Black', 1968, 0, 0, 0),
(15, 'Selected Ambient Works 85-92', 8, 'ambient techno, electronica', 'images/record/selected-ambient-works-85-92.jpg', 'techno IDM', 'Richard D. James', 'Xtal	4:51\r\nTha	9:01\r\nPulsewidth	3:47\r\nAgeispolis	5:21\r\ni	1:13\r\nGreen Calx	6:02\r\nHeliosphan	4:51\r\nWe Are The Music Makers	7:42\r\nSchottkey 7th Path	5:07\r\nPtolemy	7:12\r\nHedphelym	6:02\r\nDelphium	5:36\r\nActium	7:35', 1992, 0, 0, 0),
(16, 'Selected Ambient Works Volume II', 8, 'ambient, dark ambient, drone', 'images/record/selected-ambient-works-volume-ii.jpg', 'techno', 'Richard D. James', 'Untitled	7:28\r\nUntitled	6:34\r\nUntitled	7:44\r\nUntitled	4:40\r\nUntitled	8:51\r\nUntitled	3:31\r\nUntitled	8:51\r\nUntitled	5:08\r\nUntitled	6:55\r\nUntitled	9:58\r\nUntitled	7:18\r\nUntitled	2:40\r\nBlue Calx	7:20\r\nUntitled	8:00\r\nUntitled	5:34\r\nUntitled	4:46\r\nUntitled	2:05\r\nUntitled	7:17\r\nUntitled	5:58\r\nUntitled	4:15\r\nUntitled	7:10\r\nUntitled	7:30\r\nUntitled	11:27\r\nUntitled	5:40', 1994, 0, 0, 0),
(17, 'Analogue Bubblebath 5', 8, 'ambient', 'images/record/analogue-bubblebath-5.jpg', 'IDM', 'Richard D. James', 'A1	Untitled	9:06\r\nA2	Untitled	5:55\r\nA3	Untitled	0:31\r\nA4	Untitled	4:20\r\nA5	Untitled	6:38\r\nB1	Untitled	6:13\r\nB2	Untitled	4:49\r\nB3	Untitled	6:46\r\nB4	Untitled	6:04', 1995, 0, 0, 0),
(18, '...I Care Because You Do', 8, 'IDM, techno, ambient, acid', 'images/record/i-care-because-you-do.jpg', 'electronic', 'Richard D. James', 'Acrid Avid Jam Shred	7:38\r\nThe Waxen Pith	4:49\r\nWax The Nip	4:18\r\nIcct Hedral (Edit)	6:07\r\nVentolin (Video Version)	4:29\r\nCome On You Slags!	5:44\r\nStart As You Mean To Go On	6:05\r\nWet Tip Hen Ax	5:17\r\nMookid	3:51\r\nAlberto Balsalm	5:10\r\nCow Cud Is A Twin	5:33\r\nNext Heap With	4:43', 1995, 0, 0, 0),
(19, 'Richard D. James Album', 8, 'IDM, drum n bass, acid', 'images/record/richard-d-james-album.jpg', 'Electronic', 'Richard D. James', '4	3:37\r\nCornish Acid	2:14\r\nPeek 824545201	3:05\r\nFingerbib	3:48\r\nCarn Marth	2:33\r\nTo Cure A Weakling Child	4:03\r\nGoon Gumpas	2:02\r\nYellow Calx	3:04\r\nGirl/Boy Song	4:52\r\nLogan Rock Witch	3:33', 1996, 0, 0, 0),
(20, 'Drukqs', 8, 'drum n bass, idm', 'images/record/drukqn.jpg', 'electronic', 'Richard D. James', 'Jynweythek	2:23\r\nVordhosbn	4:51\r\nKladfvgbung Micshk	2:06\r\nOmgyjya-Switch7	4:52\r\nStrotha Tynhe	2:12\r\nGwely Mernans	5:08\r\nBbydhyonchord	2:33\r\nCock/Ver10	5:18\r\nAvril 14th	2:05\r\nMt Saint Michel + Saint Michaels Mount	8:10\r\nGwarek2	6:46\r\nOrban Eq Trx4	1:35\r\nAussois	0:13\r\nHy A Scullyas Lyf A Dhagrow	2:14\r\nKesson Dalef	1:21\r\n54 Cymru Beats	6:06\r\nBtoum-Roumada	1:58\r\nLornaderek	0:31\r\nQKThr	1:27\r\nMeltphace 6	6:24\r\nBit 4	0:25\r\nPrep Gwarlek 3b	1:19\r\nFather	0:57\r\nTaking Control	7:14\r\nPetiatil Cx Htdui	2:11\r\nRuglen Holon	1:49\r\nAfx237 V.7	4:23\r\nZiggomatic 17	8:35\r\nBeskhu3epnm	2:10\r\nNanou 2	3:25', 2001, 0, 0, 0),
(21, 'Syro', 8, 'breakbeat, idm, downtempo', 'images/record/syro.jpg', 'electronic', 'Richard D. James', 'Minipops 67 (Source Field Mix)	4:47\r\nXmas_Evet10 (Thanaton3 Mix)	10:31\r\nProduk 29	5:03\r\n4 Bit 9d Api+e+6	4:28\r\n180db_	3:11\r\nCirclont6a (Syrobonkus Mix)	6:00\r\nFz Pseudotimestretch+e+3	0:58\r\nCirclont14 (Shrymoming Mix)	7:21\r\nSyro U473t8+e (Piezoluminescence Mix)	6:32\r\nPapat4 (Pineal Mix)	4:18\r\nS950tx16wasr10 (Earth Portal Mix)	6:01\r\nAisatsana	5:21', 2014, 0, 0, 0),
(22, 'Aphex Mt. Fuji 2017', 8, 'experimental, glitch, noise', 'images/record/aphex-mt-fuji-2017.jpg', 'electronic', 'Richard D. James', '\r\n1	Nqz 9 Chaos Rave 1st Edit +6	\r\n2	19 Osc Freeze Edit	\r\n3	33,000 Note Sweeps	\r\n4	Buchla 200 Rhtym 2B	\r\n5	2 Tran 1 Env 4 Decay B Edit	\r\n6	Short Forgotten Produk Trk	\r\n7	2nd Neotek Test B + 11	\r\n8	Nqz 2 Edit + 6	\r\n9	Buchla 200e Pulses 8LP9	\r\n10	Buchla 200e XY MARF	\r\n11	3buchla + MARF B + 6	\r\n12	@FX - MATRIXT9	\r\n13	ModularT4 [Spektral Modblues]	\r\n14	Nqz FS AK9	\r\n15	Nqz 25	\r\n16	Nqz 27	\r\n17	Nqz 3 Singing Montage Chaos +6	\r\n18	Talkin2u Mix2	\r\n19	Matrix Del1 Edit	\r\n20	Buchla 200 6	\r\n21	Buchla 200QUAD EQ,FM OSC F6 Net 2dk Edit	\r\n22	Marshall Chords 01	\r\n23	ModularT8 Spectral Modular 2	\r\n24	ModularT3 Schmoo Pulse	\r\n25	Springs 3-AFX Edit	\r\n26	Rebrab	\r\n27	Buchla 200e 31patches	\r\n28	291E Buchla Talk 1	\r\n29	Nqz 18 Impulse B	\r\n30	Nqz 7 Dark Rave	\r\n31	Sines 2 Seq Edit	\r\n32	10 Partial Gen	\r\n33	FREEZE QRS Edit	\r\n34	Nqz 14 ENV DelFS Edit	\r\n35	Nagradrums 2+7	\r\n36	Buchla Master Edit Rend	\r\n37	DOT PATTERNS	\r\n38	10 Partial Gen 2	\r\n39	Nqz 21	\r\n40	Nqz Baby	\r\n41	SH MATRIXT1	\r\n42	Z Freqdelay Serve	\r\n43	Nqz 11 Fucked PWM F6 Edit +6	\r\n44	Nqz 12 FS Del	\r\n45	Snh Edit B', 2017, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Review`
--

CREATE TABLE `Review` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `artist` int(11) NOT NULL,
  `body` text DEFAULT NULL,
  `rating` float DEFAULT NULL
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
('pino', 'grepolis', 'pino@gmail.com', '1999-02-23', 'images/default_profile.png'),
('pinocchio', 'grepolis', 'matteodelseppiaomm@gmail.com', '2000-02-22', 'images/default_profile.png');

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
-- Indexes for table `Comment`
--
ALTER TABLE `Comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `artist` (`artist`),
  ADD KEY `username` (`username`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Comment`
--
ALTER TABLE `Comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Record`
--
ALTER TABLE `Record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
-- Constraints for table `Comment`
--
ALTER TABLE `Comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `Artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`username`) REFERENCES `Users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

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
