DROP TABLE IF EXISTS `music_album`;
DROP TABLE IF EXISTS `music_artist`;
DROP TABLE IF EXISTS `music_label`;
DROP TABLE IF EXISTS `music_format`;
DROP TABLE IF EXISTS `music_genre`;
CREATE TABLE `music_artist`(
	`artist_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `artist_name` varchar(100) DEFAULT NULL,
    `origin_city` varchar(50) DEFAULT NULL,
    `genre_name` varchar(100) DEFAULT NULL
);
CREATE TABLE `music_label`(
	`label_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `label_name` varchar(75) DEFAULT NULL
);

CREATE TABLE `music_format`(
	`format_id` CHAR PRIMARY KEY,
    `format_name` varchar(50) DEFAULT NULL
);
CREATE TABLE `music_album`(
	`album_id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `album_name` varchar(100) DEFAULT NULL,
    `artist_id` BIGINT DEFAULT NULL,
    `release_date` DATE DEFAULT NULL,
    `records_sold` BIGINT DEFAULT NULL,
    `original_format` CHAR DEFAULT NULL,
    `label_id` BIGINT DEFAULT NULL,
	CONSTRAINT music_album_artist_id_fk FOREIGN KEY (artist_id) REFERENCES music_artist(artist_id),
    CONSTRAINT music_label_label_id_fk FOREIGN KEY (label_id) REFERENCES music_label(label_id),
	CONSTRAINT music_format_format_id_fk FOREIGN KEY (original_format) REFERENCES music_format(format_id)
);
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES (NULL,NULL,NULL);
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES ("Nirvana","Seattle, WA","Rock");
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES ("Miles Davis","Alton, IL","Jazz");
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES ("Michael Jackson","Gary, IN","Pop");
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES ("Lil' Wayne","New Orleans, LA","Hip Hop");
INSERT INTO music_artist (artist_name, origin_city, genre_name)
VALUES ("Willie Nelson","Abbott, TX","Country");


INSERT INTO music_label (label_name)
VALUES (NULL);
INSERT INTO music_label (label_name)
VALUES ("DGC Records");
INSERT INTO music_label (label_name)
VALUES ("Columbia");
INSERT INTO music_label (label_name)
VALUES ("Epic Records");
INSERT INTO music_label (label_name)
VALUES ("Cash Money");


INSERT INTO music_format (format_id,format_name)
VALUES ("V", "Vinyl");
INSERT INTO music_format (format_id,format_name)
VALUES ("T","Cassette Tape");
INSERT INTO music_format (format_id,format_name)
VALUES ("C", "Compact Disc");
INSERT INTO music_format (format_id,format_name)
VALUES ("D", "Digital");

INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES (NULL,NULL,NULL,NULL,NULL,NULL);
-- INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
-- VALUES ("Nevermind",'2','1991-09-23','30000000','C','2');

INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Nevermind",(SELECT artist_id FROM music_artist where artist_name = "Nirvana"),'1991-09-23','30000000','C',(SELECT label_id FROM music_label where label_name = "DGC Records"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("In Utero",(SELECT artist_id FROM music_artist where artist_name = "Nirvana"),'1993-09-21','15000000','C',(SELECT label_id FROM music_label where label_name = "DGC Records"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Kind of Blue",(SELECT artist_id FROM music_artist where artist_name = "Miles Davis"),'1959-08-17','4000000','V',(SELECT label_id FROM music_label where label_name = "Columbia"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Thriller",(SELECT artist_id FROM music_artist where artist_name = "Michael Jackson"),'1982-11-30','65000000','T',(SELECT label_id FROM music_label where label_name = "Epic Records"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Bad",(SELECT artist_id FROM music_artist where artist_name = "Michael Jackson"),'1987-09-01','45000000','T',(SELECT label_id FROM music_label where label_name = "Epic Records"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Tha Carter III",(SELECT artist_id FROM music_artist where artist_name = "Lil' Wayne"),'2008-06-09','3800000','D',(SELECT label_id FROM music_label where label_name = "Cash Money"));
INSERT INTO music_album (album_name,artist_id,release_date,records_sold,original_format,label_id)
VALUES ("Red Headed Stranger",(SELECT artist_id FROM music_artist where artist_name = "Willie Nelson"),'1975-05-01','2000000','V',(SELECT label_id FROM music_label where label_name = "Columbia"));




CREATE TABLE `music_genre`(
	`genre_id` CHAR PRIMARY KEY,
    `genre_name` varchar(25) DEFAULT NULL
);
INSERT INTO music_genre (genre_id,genre_name)
VALUES ('R', "Rock");
INSERT INTO music_genre (genre_id,genre_name)
VALUES ('P', "Pop");
INSERT INTO music_genre (genre_id,genre_name)
VALUES ('J', "Jazz");
INSERT INTO music_genre (genre_id,genre_name)
VALUES ('C', "Country");
INSERT INTO music_genre (genre_id,genre_name)
VALUES ('H', "Hip Hop");

UPDATE music_artist
SET genre_name = 'R'
WHERE genre_name = "Rock";
UPDATE music_artist
SET genre_name = 'P'
WHERE genre_name = "Pop";
UPDATE music_artist
SET genre_name = 'J'
WHERE genre_name = "Jazz";
UPDATE music_artist
SET genre_name = 'C'
WHERE genre_name = "Country";
UPDATE music_artist
SET genre_name = 'H'
WHERE genre_name = "Hip Hop";

ALTER TABLE music_artist
  RENAME COLUMN genre_name TO genre_id;
ALTER TABLE music_artist
  MODIFY genre_id CHAR DEFAULT NULL;
ALTER TABLE music_artist
  ADD CONSTRAINT music_artist_genre_id_fk FOREIGN KEY (genre_id) REFERENCES music_genre(genre_id);
  
DELETE FROM music_album
WHERE artist_id = (SELECT artist_id FROM music_artist WHERE artist_name = "Lil' Wayne");

DELETE FROM music_artist
WHERE artist_name = "Lil' Wayne";