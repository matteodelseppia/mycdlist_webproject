-- Progettazione Web 
DROP DATABASE if exists mycdlist; 
CREATE DATABASE mycdlist; 
USE mycdlist; 
-- MySQL dump 10.13  Distrib 5.6.20, for Win32 (x86)
--
-- Host: localhost    Database: mycdlist
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `active_years` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT 'images/artist/default_artist.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'AC/DC','hard rock, heavy metal, blues metal','1973-present','images/artist/ac-dc.jpg'),(2,'Miles Davis','jazz, cool jazz, bebop, fusion','1944-1975, 1980-1991','images/artist/miles-davis.jpeg'),(3,'Cream','rock, hard rock, blues rock','1966-1968','images/artist/cream.jpg'),(4,'James Brown','funk, jazz-funk, soul, soul-funk','1953–1988, 1991–2006','images/artist/james-brown.jpg'),(5,'Bob Seger','rock, blues rock, garage rock','1965-present','images/artist/bob-seger.jpg'),(6,'Los Bravos','pop rock, soft rock, beat','1965-1968','images/artist/los-bravos.jpg'),(7,'Deep Purple','rock, progressive rock, blues rock','1968-1976','images/artist/deep-purple.jpg'),(8,'Aphex Twin','techno, ambient techno','1985-present','images/artist/aphex-twin.jpg'),(9,'Post Malone','hip hop','2013-present','images/artist/post-malone.jpg'),(10,'Low Roar','pop, rock, electronic','2011-present','images/artist/low-roar.jpg'),(11,'Juice WRLD','hip hop','2018-present','images/artist/juice-wrld.jpg'),(12,'Neil Young','rock, folk rock','1960-present','images/artist/neil-young.jpg'),(13,'Lady Gaga','electronic, pop, house','2005-present','images/artist/ladygaga.jpg'),(14,'Liam Gallagher','rock, alternative rock, britpop','1991-present','images/artist/liamgallagher.jpg'),(15,'Prince','funk, pop, soul','1975-2016','images/artist/prince.jpg');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection` (
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `added` date NOT NULL,
  `artist` int(11) NOT NULL,
  `media` varchar(30) NOT NULL,
  `notes` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`username`,`record`,`artist`),
  KEY `record` (`record`),
  KEY `artist` (`artist`),
  CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`record`) REFERENCES `record` (`id`),
  CONSTRAINT `collection_ibfk_3` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection`
--

LOCK TABLES `collection` WRITE;
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
INSERT INTO `collection` VALUES ('admin',10,'2020-06-20',2,'CD','ciao'),('admin',36,'2020-06-20',2,'CD','ffff'),('admin',38,'2020-06-20',2,'CD',''),('admin',47,'2020-06-20',10,'CD',''),('admin',51,'2020-06-20',12,'CD',''),('admin',52,'2020-06-20',14,'CD',''),('admin',53,'2020-06-20',15,'CD',''),('admin',54,'2020-06-20',12,'CD',''),('astroboy',1,'2019-11-17',3,'Vynil',''),('astroboy',2,'2019-11-17',1,'CD',''),('astroboy',3,'2019-11-17',2,'CD',''),('astroboy',8,'2019-11-17',2,'CD',''),('astroboy',11,'2019-11-17',3,'Cassette',''),('astroboy',12,'2019-11-17',3,'Digital',''),('astroboy',27,'2019-11-17',2,'CD',''),('astroboy',38,'2019-11-17',2,'CD',''),('astroboy',39,'2019-11-17',2,'CD',''),('astroboy',41,'2019-11-17',9,'CD',''),('astroboy',42,'2019-11-17',9,'CD',''),('astroboy',43,'2019-11-17',9,'CD',''),('astroboy',44,'2020-06-20',10,'CD',''),('astroboy',45,'2020-06-20',10,'CD',''),('astroboy',46,'2020-06-20',10,'CD',''),('astroboy',47,'2020-06-20',10,'CD',''),('firefox',1,'2020-06-20',3,'CD','ciao mi chiamo ciao mi chiamo ciao mi chiamo ciao mi chiamo ciao mi chiamo ciao mi chiamo ciao mi chiamo'),('firefox',37,'2020-06-20',2,'CD','aggiungo da firefox'),('kenshiro27',26,'2019-11-17',2,'CD',''),('kenshiro27',30,'2019-11-17',2,'Vynil',''),('matteodelseppia',4,'2020-06-19',2,'CD','ciao'),('matteodelseppia',5,'2020-06-19',2,'CD',''),('matteodelseppia',6,'2020-06-19',2,'CD',''),('matteodelseppia',8,'2020-06-19',2,'CD',''),('matteodelseppia',10,'2020-06-19',2,'CD',''),('matteodelseppia',26,'2020-06-19',2,'CD',''),('matteodelseppia',27,'2020-06-19',2,'CD',''),('matteodelseppia',28,'2020-06-19',2,'CD',''),('matteodelseppia',32,'2020-06-19',2,'CD',''),('matteodelseppia',35,'2020-06-19',2,'CD',''),('matteodelseppia',38,'2020-06-19',2,'CD','mio'),('matteodelseppia',39,'2020-06-19',2,'CD','lool');
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `added` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longtext NOT NULL,
  `artist` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `artist` (`artist`),
  KEY `username` (`username`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (36,'astroboy','2019-11-17 15:04:55','cream are great',3),(37,'astroboy','2019-11-17 15:05:09','miles is great',2),(38,'astroboy','2019-11-17 15:05:59','nice',1),(44,'astroboy','2020-03-04 19:12:18','miles is double great',2),(46,'firefox','2020-06-20 10:30:18','didkkdkdkdkdkdkdkddkdkdkkddkkdkdkdkdh 9wffei0jfe0jg0eijg0ijg0j0ij0giejrig0ei0jg fweijfeij0fe0i',2),(49,'astroboy','2020-06-20 17:08:09','sdss',10),(50,'astroboy','2020-06-20 17:08:11','ss',10),(51,'astroboy','2020-06-20 17:08:12','sss',10),(52,'astroboy','2020-06-20 17:08:14','ssddsd',10),(53,'astroboy','2020-06-20 17:08:16','sdsds',10),(54,'astroboy','2020-06-20 17:08:18','reregege',10),(55,'astroboy','2020-06-20 17:08:20','reette',10),(56,'astroboy','2020-06-20 17:08:21','egtegtg',10),(61,'astroboy','2020-06-20 17:08:29','egergege',10),(62,'astroboy','2020-06-20 17:08:30','eergeg',10),(63,'astroboy','2020-06-20 17:08:32','geegee',10),(64,'astroboy','2020-06-20 17:08:33','gegeegerer',10),(65,'astroboy','2020-06-20 17:08:34','egeegrer',10),(66,'astroboy','2020-06-20 17:08:36','ggegeeg',10),(67,'astroboy','2020-06-20 17:08:38','grerger',10);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follow` (
  `username` varchar(30) NOT NULL,
  `artist` int(11) NOT NULL,
  PRIMARY KEY (`username`,`artist`),
  KEY `artist` (`artist`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES ('astroboy',1),('astroboy',2),('firefox',2),('kenshiro27',2),('matteodelseppia',2),('astroboy',3),('astroboy',9),('kenshiro27',9),('admin',10),('astroboy',10),('firefox',10),('admin',12),('admin',13),('admin',14),('admin',15);
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list` (
  `username` varchar(30) NOT NULL,
  `list_name` varchar(100) NOT NULL,
  `record` int(11) NOT NULL,
  PRIMARY KEY (`username`,`list_name`),
  KEY `record` (`record`),
  CONSTRAINT `list_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `list_ibfk_2` FOREIGN KEY (`record`) REFERENCES `record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list`
--

LOCK TABLES `list` WRITE;
/*!40000 ALTER TABLE `list` DISABLE KEYS */;
/*!40000 ALTER TABLE `list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `artist` int(11) NOT NULL,
  `style` varchar(100) DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `image` varchar(100) DEFAULT 'images/default_record.png',
  `genre` varchar(100) NOT NULL,
  `producer` varchar(300) DEFAULT NULL,
  `tracks` text NOT NULL,
  `n_votes` int(11) NOT NULL DEFAULT '0',
  `ratings_sum` int(11) NOT NULL DEFAULT '0',
  `avg_rating` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `artist` (`artist`),
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`artist`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
INSERT INTO `record` VALUES (1,'Wheels Of Fire',3,'blues rock, hard rock','1968-08-01','images/record/wheels-of-fire.jpeg','rock','Cream','White Room                   \r\nSitting On Top Of The World  \r\nPassing The Time             \r\nAs You Said                   \r\nPressed Rat And Warthog	     \r\nPolitician                   \r\nThose Were The Days          \r\nBorn Under A Bad Sign        \r\nDeserted Cities Of The Heart ',2,19,0),(2,'Back in Black',1,'hard rock','1980-07-25','images/record/back-in-black.jpg','rock','AC/DC','Hells Bells\r\nShoot To Thrill\r\nWhat Do You Do For Money Honey \r\nGiven The Dog A Bone \r\nLet Me Put My Love Into You \r\nBack In Black \r\nYou Shook Me All Night Long \r\nHave A Drink On Me \r\nShake A Leg \r\nRock And Roll Ain\'t Noise Pollution \r\n',2,10,0),(3,'Kind of Blue',2,'hard bop, bebop','1959-08-17','images/record/kind-of-blue.jpg','jazz','Miles Davis','So What	\rFreddie Freeloader \rBlue In Green \rAll Blues 1\rFlamenco Sketches \r',0,0,0),(4,'The New Sounds',2,'jazz','1951-10-05','images/record/the-new-sounds.jpg','jazz','Bob Weinstock','Conception \r\nDig	\r\nMy Old Flame	\r\nIt\'s Only A Paper Moon	',0,0,0),(5,'Young Man With A Horn',2,'bop','1952-05-09','images/record/young-man-with-a-horn.jpg','jazz','Alfred Lion','Dear Old Stockholm  \r\nChance It  \r\nYesterdays  \r\nDonna \r\nWould\'n You  \r\nHow Deep Is the Ocean?  ',0,0,0),(6,'Blue Period',2,'cool jazz','1953-01-01','images/record/blue-period.jpg','jazz','Bob Weinstock','Bluing \rBlue Room \rOut of the Blue \r',0,0,0),(7,'Vol. 2',2,'bop','1953-10-01','images/record/vol-2.jpg','jazz','Alfred Lion','Take Off \r\nWeirdo  \r\nWould\'n You  \r\nI Waited for You \r\nRay\'s Idea (Alternate Master) \r\nDonna \r\nWell, You Needn\'t  \r\nThe Leap  \r\nLazy Susan  \r\nTempus Fugit (Alternate Master)  \r\nIt Never Entered My Mind ',0,0,0),(8,'Blue Moods',2,'hard bop','1955-08-09','images/record/blue-moods.jpg','jazz',' Charles Mingus','Nature Boy\r\nAlone Together\r\nThere\'s No You\r\nEasy Living ',0,0,0),(9,'Birth Of The Cool',2,'cool jazz','1957-01-01','images/record/birth-of-the-cool.jpg','jazz','Walter Rivers & Pete Rugolo','Move \rJeru \rMoon Dreams \rVenus de Milo \rBudo \rDeception \rGodchild \rBoplicity \rRocker \rIsrael \rRouge \rDarn That Dream ',0,0,0),(10,'\'Round About Midnight',2,'hard bop','1957-03-04','images/record/round-about-midnight.jpg','jazz','George Avakian','Round Midnight      \r\nAh-Leu-Cha          \r\nAll of You          \r\nBye Bye Blackbird   \r\nTadd\'s Delight      \r\nDear Old Stockholm  \r\nTwo Bass Hit        \r\nLittle Melonae      \r\nBudo                \r\nSweet Sue, Just You ',2,18,0),(11,'Disraeli Gears',3,'blues rock, psychedelic rock','1967-11-02','images/record/disraeli-gears.jpg','rock','Felix Pappalardi','Strange Brew	\r\nSunshine Of Your Love	\r\nWorld Of Pain	\r\nDance The Night Away\r\nBlue Condition \r\nTales Of Brave Ulysses\r\nSwlabr \r\nWe\'re Going Wrong \r\nOutside Woman Blues \r\nTake It Back \r\nMother\'s Lament ',1,10,0),(12,'Fresh Cream',3,'blues rock, electric blues, psychedelic rock','1966-12-09','images/record/fresh-cream.jpg','rock','Robert Stigwood','N.S.U.	\r\nSleepy Time Time	\r\nDreaming	\r\nSweet Wine	\r\nSpoonful	\r\nCat\'s Squirrel	\r\nFour Until Late	\r\nRollin\' And Tumblin\'	\r\nI\'m So Glad	\r\nToad',3,22,0),(13,'Black Is Black',6,'beat, pop rock, rythm & blyes, soul-funk','1966-08-01','images/record/black-is-black.jpg','rock, funk, pop','Ivor Raymonde','Trapped	\r\nBaby, Baby\r\nMake It Easy For Me\r\nShe Believes In Me\r\nWill You Always Love Me\r\nBlack Is Black\r\nStop That Girl\r\nGive Me A Chance\r\nCuttin\' Out\r\nTwo Kinds Of Lovers\r\nYou Won\'t Get Far\r\nBaby, Believe Me',0,0,0),(14,'Bring A Little Lovin\'',6,'pop rock, classic rock','1968-04-01','images/record/bring-a-little-lovin.jpg','rock','none','\r\nBring A Little Lovin\'	\r\nMake It Last	\r\nYou Got Until The Morning	\r\nThen The Sun Goes Down	\r\nGet Out Of My Life	\r\nShow Me	\r\nPlay With Fire And You\'ll Get Burned	\r\nDon\'t Get In My Way	\r\nSympathy	\r\nShe\'s My Girl	\r\nIf I Were A River	\r\nBlack Is Black',0,0,0),(15,'Selected Ambient Works 85-92',8,'ambient techno, electronica','1992-11-09','images/record/selected-ambient-works-85-92.jpg','techno IDM','Richard D. James','Xtal	\rTha	\rPulsewidth	\rAgeispolis	\ri	\rGreen Calx	\rHeliosphan	\rWe Are The Music Makers	\rSchottkey 7th Path	\rPtolemy	\rHedphelym	\rDelphium	\rActium	',1,5,0),(16,'Selected Ambient Works Volume II',8,'ambient, dark ambient, drone','1994-03-07','images/record/selected-ambient-works-volume-ii.jpg','techno','Richard D. James','Untitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rBlue Calx	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled\rUntitled	',0,0,0),(17,'Analogue Bubblebath 5',8,'ambient','2005-01-01','images/record/analogue-bubblebath-5.jpg','IDM','','Untitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	\rUntitled	',0,0,0),(18,'...I Care Because You Do',8,'IDM, techno, ambient, acid','1995-04-24','images/record/i-care-because-you-do.jpg','electronic','Richard D. James','Acrid Avid Jam Shred	    \rThe Waxen Pith	            \rWax The Nip	            \rIcct Hedral (Edit)	    \rVentolin (Video Version)    \rCome On You Slags!	    \rStart As You Mean To Go On  \rWet Tip Hen Ax	            \rMookid	                    \rAlberto Balsalm	            \rCow Cud Is A Twin	    \rNext Heap With	            ',1,9,0),(19,'Richard D. James Album',8,'IDM, drum n bass, acid','1996-11-04','images/record/richard-d-james-album.jpg','Electronic','Richard D. James','Cornish Acid	\rPeek 824545201	\rFingerbib	\rCarn Marth	\rTo Cure A Weakling Child	\rGoon Gumpas	\rYellow Calx	\rGirl/Boy Song	\rLogan Rock Witch	',0,0,0),(20,'Drukqs',8,'drum n bass, idm','2001-10-22','images/record/drukqn.jpg','electronic','Richard D. James','Jynweythek	\rVordhosbn	\rKladfvgbung Micshk	\rOmgyjya-Switch7	\rStrotha Tynhe	\rGwely Mernans	\rBbydhyonchord	\rCock/Ver10	\rAvril 14th	\rMt Saint Michel + Saint Michaels Mount	\rGwarek2	\rOrban Eq Trx4	\rAussois	\rHy A Scullyas Lyf A Dhagrow	\rKesson Dalef	\r54 Cymru Beats	\rBtoum-Roumada	\rLornaderek	\rQKThr	\rMeltphace 6	\rBit 4	\rPrep Gwarlek 3b	\rFather	\rTaking Control	\rPetiatil Cx Htdui	\rRuglen Holon	\rAfx237 V.7	\rZiggomatic 17	\rBeskhu3epnm	\rNanou 2	',0,0,0),(21,'Syro',8,'breakbeat, idm, downtempo','2014-09-22','images/record/syro.jpg','electronic','Richard D. James','Minipops 67 (Source Field Mix)	\rXmas_Evet10 (Thanaton3 Mix)	1\rProduk 29	\r4 Bit 9d Api+e+6	\r180db_	\rCirclont6a (Syrobonkus Mix)	\rFz Pseudotimestretch+e+3	\rCirclont14 (Shrymoming Mix)	\rSyro U473t8+e (Piezoluminescence Mix)	\rPapat4 (Pineal Mix)	\rS950tx16wasr10 (Earth Portal Mix)	\rAisatsana	',0,0,0),(22,'Aphex Mt. Fuji 2017',8,'experimental, glitch, noise','2017-07-01','images/record/aphex-mt-fuji-2017.jpg','electronic','Richard D. James','\r1	Nqz 9 Chaos Rave 1st Edit +6	\r2	19 Osc Freeze Edit	\r3	33,000 Note Sweeps	\r4	Buchla 200 Rhtym 2B	\r5	2 Tran 1 Env 4 Decay B Edit	\r6	Short Forgotten Produk Trk	\r7	2nd Neotek Test B + 11	\r8	Nqz 2 Edit + 6	\r9	Buchla 200e Pulses 8LP9	\r10	Buchla 200e XY MARF	\r11	3buchla + MARF B + 6	\r12	@FX - MATRIXT9	\r13	ModularT4 [Spektral Modblues]	\r14	Nqz FS AK9	\r15	Nqz 25	\r16	Nqz 27	\r17	Nqz 3 Singing Montage Chaos +6	\r18	Talkin2u Mix2	\r19	Matrix Del1 Edit	\r20	Buchla 200 6	\r21	Buchla 200QUAD EQ,FM OSC F6 Net 2dk Edit	\r22	Marshall Chords 01	\r23	ModularT8 Spectral Modular 2	\r24	ModularT3 Schmoo Pulse	\r25	Springs 3-AFX Edit	\r26	Rebrab	\r27	Buchla 200e 31patches	\r28	291E Buchla Talk 1	\r29	Nqz 18 Impulse B	\r30	Nqz 7 Dark Rave	\r31	Sines 2 Seq Edit	\r32	10 Partial Gen	\r33	FREEZE QRS Edit	\r34	Nqz 14 ENV DelFS Edit	\r35	Nagradrums 2+7	\r36	Buchla Master Edit Rend	\r37	DOT PATTERNS	\r38	10 Partial Gen 2	\r39	Nqz 21	\r40	Nqz Baby	\r41	SH MATRIXT1	\r42	Z Freqdelay Serve	\r43	Nqz 11 Fucked PWM F6 Edit +6	\r44	Nqz 12 FS Del	\r45	Snh Edit B',0,0,0),(24,'The Compisitions Of Al Cohn',2,'cool jazz','1953-02-19','images/record/the-compositions-of-al-cohn.jpg','jazz','Bob Weinstock','\"Tasty Pudding\"	\r\"Floppy\"	\r\"Willie the Wailer\"	\r\"For Adults Only\"	',0,0,0),(25,'Vol. 3 ',2,'bop','1954-03-06','images/record/volume-3.jpg','jazz','Alfred Lion','\"Take Off\" \r\n\"It Never Entered My Mind\"	\r\n\"Well, You Needn\'t\" \r\n\"Lazy Susan\"\r\n\"Weirdo\"\r\n\"The Leap\"',1,5,0),(26,'Miles Davis Quartet',2,'bop','1953-05-19','images/record/miles-davis-quartet.jpg','jazz','Bob Weinstock','\"When Lights Are Low\"	\r\"Tune Up\" \r\"Miles Ahead\" \r\"Smooch\" \r\"Four\" \r\"Old Devil Moon\"	\r\"Blue Haze\" ',1,3,0),(27,'Miles Davis All-Star Sextet',2,'cool jazz, bop','1954-04-29','images/record/miles-davis-all-star-sextet.jpg','jazz','Bob Weinstock','Blue \'n\' Boogie\r\nWalkin',0,0,0),(28,'Miles Davis Quintet',2,'hard bop','1954-04-03','images/record/miles-davis-quintet.jpg','jazz','Bob Weinstock','Solar\r\nYou Don\'t Know What Love Is\r\nI\'ll Remember April ',0,0,0),(29,'Miles Davis with Sonny Rollins',2,'bop','1954-06-29','images/record/miles-davis-with-sonny-rollins.jpg','jazz','Bob Weinstock','Airegin \rOleo \rBut Not for Me \rDoxy ',0,0,0),(30,'The Musings of Miles',2,'hard bop, bop','1955-07-07','images/record/the-musings-of-miles.jpg','jazz','Bob Weinstock','\r\nWill You Still Be Mine?\r\nI See Your Face Before Me\r\nI Didn\'t\r\nA Gal In Calico\r\nA Night In Tunisia\r\nGreen Haze',1,7,0),(31,'The New Miles Davis Quintet',2,'bop','1956-04-01','images/record/the-new-miles-davis-quintet.jpg','jazz','Bob Weinstock','\r\nJust Squeeze Me\r\nThere Is No Greater Love\r\nHow Am I To Know?\r\nS\'Posin	\r\nThe Theme\r\nStablemates',0,0,0),(32,'Miles Davis and Horns',2,'bop','1956-03-25','images/record/miles-davis-and-horns.jpg','jazz','Bob Weinstock','Tasty Pudding	\rFloppy	\rWillie The Wailer	\rFor Adults Only	\rMorpheus	\rDown	\rBlue Room	\rWhispering',0,0,0),(33,'Quintet/Sextet',2,'bop, hard bop','1956-01-01','images/record/miles-davis-and-horns.jpg','jazz','Bob Weinstock','\rDr. Jackle	\rBitty Ditty	\rMinor March	\rChanges	',0,0,0),(34,'Collectors\' Items',2,'bop','1956-12-01','images/record/collectors-items.jpg','jazz','Ira Gitler (1-4), Bob Weinstock (5-7)','\r\nThe Serpent\'s Tooth I	\r\nThe Serpent\'s Tooth II	\r\n\'Round About Midnight	\r\nCompulsion	\r\nNo Line	\r\nVierd Blues	\r\nIn Your Own Sweet Way',0,0,0),(35,'Blue Haze',2,'bebop, hard bop','1956-10-01','images/record/blue-haze.jpg','jazz','Bob Weinstock, Ira Gitler','I\'ll Remember April	\r\nFour \r\nOld Devil Moon\r\nSmooch \r\nBlue Haze \r\nWhen Lights are Low \r\nTune Up \r\nMiles Ahead ',0,0,0),(36,'Bags\' Groove',2,'bop, hard bop','1957-12-01','images/record/bags-groove.jpg','jazz','Bob Weinstock','Bags\' Groove (Take 1)\r\nBags\' Groove (Take 2)\r\nAiregin\r\nOleo\r\nBut Not For Me (Take 2)\r\nDoxy\r\nBut Not For Me (Take 1)',0,0,0),(37,'Relaxin\' With The Miles Davis Quintet',2,'bop, hard bop','1958-03-01','images/record/relaxin-with-the-miles-davis-quintet.jpg','jazz','Bob Weinstock','\r\nIf I Were A Bell\r\nYou\'re My Everything\r\nI Could Write A Book\r\nOleo\r\nIt Could Happen To You\r\nWoody\'n You',0,0,0),(38,'Workin\' With the Miles Davis Quintet',2,'bop, hard bop','1969-01-01','images/record/workin-with-the-miles-davis-quintet.jpg','jazz','Bob Weinstock','\r\nIt Never Entered My Mind	\r\nFour	\r\nIn Your Own Sweet Way	\r\nThe Theme (Take #1)	\r\nTrane\'s Blues	\r\nAhmad\'s Blues	\r\nHalf Nelson	\r\nThe Theme (Take #2)',5,36,0),(39,'Steamin\' with the Miles Davis Quintet',2,'bop, hard bop','1961-07-01','images/record/steamin-with-the-miles-davis-quintet.jpg','jazz','Bob Weinstock','\r\nSurrey With The Fringe On Top	\r\nSalt Peanuts	\r\nSomething I Dreamed Last Night	\r\nDiane	\r\nWell You Needn\'t	\r\nWhen I Fall In Love',1,7,0),(40,'August26',9,'cloud rap','2016-05-12','images/record/august26.jpg','hip hop','FKi, Post Malone, Cashio, Charlie Handsome, Louis Bell, ILoveMakonnen, Rex Kudo','\r\nNever Understand\r\nMoney Made Me Do It\r\nGit Wit U\r\nGod Damn\r\nFuck\r\n40 Funk	\r\nMonta\r\nHollywood Dreams / Come Down\r\nLonely...\r\nOh God',0,0,0),(41,'Stoney',9,'cloud rap','2016-12-09','images/record/stoney.jpg','hip hop','Cashio, Charlie Handsome, Dre London, FKi , Rex Kudo, Andrew Watt, DJ Mustard, Foreign Teck, Frank Dukes, Illangelo, Justin Mosley, Leon Thomas III, Louis Bell, Metro Boomin, Pharrell Williams, RoofeeoTwice ','\r\nBroken Whiskey Glass	\r\nBig Lie	\r\nDeja Vu	\r\nNo Option	\r\nCold	\r\nWhite Iverson	\r\nI Fall Apart	\r\nPatient	\r\nGo Flex	\r\nFeel	\r\nToo Young	\r\nCongratulations	\r\nUp There	\r\nYours Truly, Austin Post',0,0,0),(42,'Beerbongs & Bentleys',9,'cloud rap','2018-04-27','images/record/beerbongs-and-bentleys.jpg','hip hop','Andrew Watt, Aubrey Robinson,  Blueysport,  Cashio,  Diego Ave,  Frank Dukes,  London on da Track, Louis Bell, PartyNextDoor, Post Malone, Prep Bijan, Roark Bailey, RoccStar, Scott Storch, Swish, Tank God, Tariq Bright, Teddy Walton, Twice as Nice','Paranoid\r\nSpoil My Night\r\nRich & Sad\r\nZack And Codeine\r\nTakin\' Shots\r\nRockstar\r\nOver Now\r\nPsycho\r\nBetter Now\r\nBall For Me\r\nOtherside\r\nStay\r\nBlame It On Me\r\nSame Bitches\r\nJonestown (Interlude)\r\n92 Explorer\r\nCandy Paint\r\nSugar Wraith',1,9,0),(43,'Hollywood\'s Bleeding',9,'cloud rap','2019-09-06','images/record/hollywoods-bleeding.jpg','hip hop','Austin Rosen, Dre London, Louis Bell, Andrew Watt, BloodPop, Brian Lee, Carter Lang, DJ Dahi, Emile Haynie, Frank Dukes, Happy Perez, Jahaan Sweet, Matt Tavares, Nick Mira, Post Malone, Wallis Lane','Hollywood\'s Bleeding\r\nSaint Tropez\r\nEnemies\r\nAllergic\r\nA Thousand Bad Times\r\nCircles\r\nDie For Me\r\nOn The Road\r\nTake What You Want\r\nI\'m Gonna Be\r\nStaring At The Sun\r\nSunflower \r\nInternet\r\nGoodbyes\r\nMyself\r\nI Know\r\nWow',2,11,0),(44,'Low Roar',10,'indie rock','2011-11-01','images/record/low-roar-album.jpg','rock','Ryan Karazija','Give Up	\r\nJust A Habit	\r\nNobody Else	\r\nPatience	\r\nLow Roar	\r\nFriends Make Garbage (Good Friends Take It Out)	\r\nThe Painter	\r\nHelp Me	\r\nPuzzle	\r\nRolling Over	\r\nBecause We Have To	\r\nTonight, Tonight, Tonight',0,0,0),(45,'0',10,'indie rock','2014-08-13','images/record/0-zero.jpg','rock','Ryan Karazija','\r\nBreathe In	                                   \r\nEasy Way Out	                                  \r\nNobody Loves Me Like You	\r\nI\'ll Keep Coming	                           \r\nHalf Asleep	                                    \r\nPlease Don\'t Stop (Chapter 1)\r\nI\'m Leaving	                                    \r\nIn The Morning	                            \r\nPhantoms	                                    \r\nAnything You Need	                   \r\nDreamer	                                             \r\nVampire On My Fridge	                   \r\nPlease Don\'t Stop (Chapter 2)	  ',0,0,0),(46,'Once In A Long Long While...',10,'downtempo, minimal','2017-09-01','images/record/once-in-a-long-long-while.jpg','electronic, rock, pop','Ryan Karazija','Don\'t Be So Serious	\r\nBones	\r\nSt. Eriksplan	\r\nGive Me An Answer	\r\nWaiting (10 Years)	\r\nWithout You	\r\nGosia	\r\nOnce In A Long Long While...	\r\nCrawl Back	\r\nPoznan	\r\nMiserably	\r\n13	\r\nI Won\'t Be Long',0,0,0),(47,'Ross',10,'indie pop','2019-11-08','images/record/ross.jpg','pop','Ryan Karazija','Darkest Hour	       \r\nSlow Down	       \r\nH.A.F.H.	                \r\nI\'ll Make You Feel   \r\nNot Around	        \r\n222	                         \r\nFeel Like Dying	\r\nThe Machine	        \r\nBlue Eyes	        \r\nEmpty House	      ',1,9,0),(48,'Goodbye & Good Riddance',11,'emo','2018-05-23','images/record/goodbye-and-good-riddance.jpg','hip hop','Benny Blanco, Cardo, Cashmere Cat, CBMix, Dre Moon, JR Hitmaker, Mitch Mula, Nick Mira, Ric & Thadeus, Sidepce, Taz Taylor','Intro	\r\nAll Girls Are the Same	\r\nLucid Dreams	\r\nLean Wit Me	\r\nI\'m Still	\r\nBetrayal (Skit)	\r\nCandles	\r\nScared of Love	\r\nUsed To	\r\nKarma (Skit)	\r\nHurt Me	\r\nBlack & White	\r\nLong Gone	\r\nEnd of the Road	\r\nI\'ll Be Fine',0,0,0),(49,'Death Race for Love',11,'emo','2019-03-08','images/record/death-race-for-love.png','hip hop','Andrew Watt, Atu, Boi-1da','Empty	\r\nMaze	\r\nHeMotions	\r\nDemonz (Interlude)	\r\nFast	\r\nHear Me Calling	\r\nBig	\r\nRobbery	\r\nFlaws And Sins	\r\nFeeling	\r\nSyphils	\r\nWho Shot Cupid?	\r\nRing Ring	\r\nDesire	\r\nOut My Way	\r\nThe Bees Knees	\r\nOn God	\r\n10 Feet	\r\nWon\'t Let Go	\r\nShe\'s The One	\r\nRider	\r\nMake Believe',1,7,0),(50,'Chromatica',13,'house','2020-05-29','images/record/chromatica.jpg','electronic, pop','Morgan Kibby, Lady Gaga, BloodPop, Axwell, Klahr, Tchami, Burns, Madeon, Skrillex, Liohn ','Chromatica I\r\nAlice\r\nStupid Love\r\nRain on Me\r\nFree Woman\r\nFun Tonight\r\nChromatica II\r\n911\r\nPlastic Doll\r\nSour Candy\r\nEnigma',0,0,0),(51,'Homegrown',12,'folk, country','2020-06-19','images/record/homegrown.jpg','rock','Neil Young, Elliot Mazer','Separate Ways 	\r\nTry 	\r\nMexico 	\r\nLove Is A Rose 	\r\nHomegrown 	\r\nFlorida 	\r\nKansas 	\r\nWe Don\'t Smoke It No More 	\r\nWhite Line 	\r\nVacancy 	\r\nLittle Wing \r\nStar Of Bethlehem',0,0,0),(52,'MTV Unplugged',14,'alternative rock','2020-06-12','images/record/mtv-unplugged.jpg','rock, live event','Liam Gallagher','Wall Of Glass 	\r\nSome Might Say 	\r\nNow That I\'ve Found You 	\r\nOne Of Us 	\r\nStand By Me 	\r\nSad Song 	\r\nCast No Shadow 	\r\nOnce 	\r\nGone 	\r\nChampagne Supernova',0,0,0),(53,'The Rainbow Children',15,'soul-funk, jazz-funk','2020-05-28','images/record/the-rainbow-children.jpg','funk','Prince','Rainbow Children 	\r\nMuse 2 The Pharaoh 	\r\nDigital Garden 	\r\nThe Work Pt. 1 	\r\nEverywhere 	\r\nThe Sensual Everafter\r\nMellow 	\r\n1+1+1 Is 3 	\r\nDeconstruction 	\r\nWedding Feast 	\r\nShe Loves Me 4 Me 	\r\nFamily Name 	\r\nThe Everlasting Now 	\r\nLast December 	\r\nLast December (Reprise)',0,0,0),(54,'Neil Young + Stray Gators + Tuscaloosa',12,'country','2020-06-16','images/record/neilyoung-straygators-tuscaloosa.jpg','rock, folk rock','Neil Young','Here We Are In The Years 	\r\nAfter The Gold Rush 	\r\nOut On The Weekend 	\r\nHarvest 	\r\nOld Man 	\r\nHeart Of Gold 	\r\nTime Fades Away 	\r\nLookout Joe 	\r\nNew Mama 	\r\nAlabama 	\r\nDonâ€™t Be Denied',0,0,0);
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `username` varchar(30) NOT NULL,
  `record` int(11) NOT NULL,
  `vote` int(11) NOT NULL,
  `added` datetime DEFAULT CURRENT_TIMESTAMP,
  `text` text NOT NULL,
  PRIMARY KEY (`username`,`record`),
  KEY `record` (`record`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`record`) REFERENCES `record` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES ('astroboy',1,10,'2019-11-17 15:07:17','great record'),('astroboy',11,10,'2019-11-17 15:07:04','classic'),('astroboy',38,10,'2019-11-17 15:08:44','maybe the best'),('astroboy',43,8,'2019-11-17 15:06:44','i liked this'),('claudio',10,9,'2020-06-19 21:42:17','posto qui'),('kenshiro27',2,7,'2019-11-17 15:20:30','like this'),('kenshiro27',18,9,'2019-11-17 15:10:38','one of his bests'),('kenshiro27',25,5,'2019-11-17 15:17:34','didnt like this'),('kenshiro27',26,3,'2019-11-17 15:16:36','i wanna give this a 102'),('kenshiro27',30,7,'2019-11-17 15:09:41','under the average miles record'),('kenshiro27',38,7,'2019-11-17 15:10:14','i dont agree with astroboy'),('matteodelseppia',1,9,'2020-06-19 10:01:23','mi piace molto');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_votes` AFTER INSERT ON `Review` FOR EACH ROW UPDATE Record 
SET n_votes = n_votes + 1,
	ratings_sum = ratings_sum + NEW.vote
WHERE id = NEW.record */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_votes_after_edit` AFTER UPDATE ON `Review` FOR EACH ROW UPDATE Record R
SET R.ratings_sum = R.ratings_sum - (OLD.vote - NEW.vote)
WHERE R.id = NEW.record */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `image` varchar(100) DEFAULT 'images/default_profile.png',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','administrator','admin@admin.com','2000-02-22','images/default_profile.png'),('astroboy','astroboy','astroboy@gmail.com','2000-02-22','images/default_profile.png'),('claudio','Grepolis','claudio@gmail.com','2000-02-22','images/default_profile.png'),('firefox','firefoxb','firefox@browser.it','2000-02-22','images/default_profile.png'),('kenshiro27','kenshiro','kenshiro@gmail.com','2000-02-22','images/default_profile.png'),('matteodelseppia','pidivd','matteodelseppia@email.com','2000-02-22','images/default_profile.png'),('renato','grepolis','renato@gmail.com','2000-02-22','images/default_profile.png'),('ronald','Grepolis','ronald@gmail.com','2000-02-22','images/default_profile.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 19:27:44
