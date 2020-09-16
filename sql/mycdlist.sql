DROP DATABASE IF EXISTS MyCDList;
CREATE DATABASE MyCDList;
USE MyCDList;

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
	username VARCHAR(30) NOT NULL,
	password VARCHAR(30) NOT NULL,
	email VARCHAR(100) NOT NULL,
	birthday DATE NOT NULL,
	image VARCHAR(100) DEFAULT 'images/default_profile.png',
	PRIMARY KEY(username)
);

DROP TABLE IF EXISTS Artist;
CREATE TABLE Artist (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	genre VARCHAR(100) NOT NULL,
	active_years VARCHAR(100) NOT NULL,
	image VARCHAR(100) DEFAULT 'images/artist/default_artist.png',
	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Record;
CREATE TABLE Record (
	id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	artist INT NOT NULL,
	style VARCHAR(100),
	image VARCHAR(100) DEFAULT 'images/default_record.png',
	genre VARCHAR(100) NOT NULL,
	producer VARCHAR(100) DEFAULT NULL,
	tracks TEXT NOT NULL,
	year INT NOT NULL,
	n_votes INT NOT NULL DEFAULT 0,
	ratings_sum INT NOT NULL DEFAULT 0,
	avg_rating DOUBLE NOT NULL DEFAULT 0,
	PRIMARY KEY(id),
	FOREIGN KEY(artist) REFERENCES Artist(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Collection;
CREATE TABLE Collection (
   username VARCHAR(30) NOT NULL,
   record INT NOT NULL,
   gotdate DATE DEFAULT NULL,
   artist INT NOT NULL,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY(username, record, artist),
   FOREIGN KEY(username) REFERENCES Users(username),
   FOREIGN KEY(record) REFERENCES Record(id),
   FOREIGN KEY(artist) REFERENCES Artist(id) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
	id INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(30) NOT NULL,
	record INT NOT NULL,
	artist INT NOT NULL,
	body TEXT NOT NULL,
	rating INT NOT NULL,
	PRIMARY KEY(id),
    FOREIGN KEY(username) REFERENCES Users(username),
    FOREIGN KEY(record) REFERENCES Record(id),
    FOREIGN KEY(artist) REFERENCES Artist(id) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS List;
CREATE TABLE List (
    username VARCHAR(30) NOT NULL,
    list_name VARCHAR(100) NOT NULL,
    record INT NOT NULL,
    PRIMARY KEY(username, list_name),
    FOREIGN KEY(username) REFERENCES Users(username),
    FOREIGN KEY(record) REFERENCES Record(id)
);

DROP TABLE IF EXISTS Follow;
CREATE TABLE Follow (
	username VARCHAR(30) NOT NULL,
	artist INT NOT NULL,
	PRIMARY KEY(username, artist),
	FOREIGN KEY(username) REFERENCES Users(username),
	FOREIGN KEY(artist) REFERENCES Artist(id) ON DELETE CASCADE
);

DROP TRIGGER IF EXISTS Update_rating;
DELIMITER $$
CREATE TRIGGER Update_rating AFTER INSERT ON Review
FOR EACH ROW
BEGIN

	UPDATE Record SET Record.n_votes = Record.n_votes + 1, 
	                  Record.ratings_sum = Record.ratings_sum + NEW.rating
    
    WHERE Record.id = NEW.record 
          AND 
          Record.artist = NEW.artist;
    
    
	UPDATE Record SET Record.avg_rating = Record.ratings_sum/Record.n_votes
	WHERE Record.id = NEW.record 
	      AND 
	      Record.artist = NEW.artist; 

END $$

DELIMITER ;





