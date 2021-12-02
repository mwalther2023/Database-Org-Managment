DROP TABLE IF EXISTS vg_sale;
DROP TABLE IF EXISTS vg_platform;
DROP TABLE IF EXISTS vg_genre;
DROP TABLE IF EXISTS vg_publisher;
DROP TABLE IF EXISTS vg_game;

DROP TABLE IF EXISTS vg_link;
CREATE TABLE vg_sale(
	sale_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    game BIGINT,
    platform_id INT,
    Global DOUBLE,
    NA DOUBLE,
    EU DOUBLE,
    JP DOUBLE,
    OTHER DOUBLE
);


CREATE TABLE vg_platform(
	platform_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    platform VARCHAR(20)
);
INSERT INTO vg_platform(platform)
(SELECT distinct(Platform) FROM vgsales);

CREATE TABLE vg_genre(
	genre_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    genre VARCHAR(20)
);
INSERT INTO vg_genre(genre)
(SELECT distinct(Genre) FROM vgsales);

CREATE TABLE vg_publisher(
	publisher_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    publisher VARCHAR(40)
);
INSERT INTO vg_publisher(publisher)
(SELECT distinct(Publisher) FROM vgsales);

CREATE TABLE vg_game(
	game_id INT AUTO_INCREMENT PRIMARY KEY,
    rank_id BIGINT,
    name VARCHAR(150),
    -- platform_id BIGINT,
    year INT -- ,
    -- genre_id BIGINT,
    -- publisher_id BIGINT,
    -- sale_id BIGINT
);
INSERT INTO vg_game(name,rank_id,year)
(SELECT DISTINCT(Name), vgsales.Rank, CASE WHEN year = 'N/A' THEN NULL ELSE year END
FROM vgsales
);

INSERT INTO vg_sale (game,platform_id,Global, NA, EU, JP, Other)
(SELECT vg_game.game_id,platform_id,Global_Sales, NA_Sales, EU_Sales, JP_Sales, Other_Sales 
FROM vgsales 
	JOIN vg_platform 
    on vgsales.platform = vg_platform.platform
    JOIN vg_game
    ON vgsales.rank = vg_game.rank_id);

CREATE TABLE vg_link(
	link_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    game_id BIGINT,
    platform_id INT,
    publisher_id INT,
    genre_id INT,
    sale_id INT
);
INSERT INTO vg_link(game_id,platform_id,publisher_id,genre_id,sale_id)
(SELECT game_id,vg_platform.platform_id,publisher_id,genre_id, sale_id
FROM vgsales
	JOIN vg_platform
    ON vg_platform.platform = vgsales.platform
    JOIN vg_publisher
	ON vg_publisher.publisher = vgsales.publisher
    JOIN vg_genre
    ON vg_genre.genre = vgsales.genre
    JOIN vg_game
    ON vg_game.name = vgsales.name
    JOIN vg_sale
    ON vg_sale.sale_id = vg_game.rank_id
);


