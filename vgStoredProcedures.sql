DROP PROCEDURE IF EXISTS gameProfitByRegion;
DROP PROCEDURE IF EXISTS genreRankingByRegion;
DROP PROCEDURE IF EXISTS publishedReleases;
DROP PROCEDURE IF EXISTS addNewRelease;
delimiter //
CREATE PROCEDURE gameProfitByRegion (IN min_profit INT, IN place CHAR(2))
BEGIN
	IF place = "WD" THEN
		-- SELECT name, SUM(vg_sale.Global) FROM vg_game JOIN vg_sale ON vg_game.game_id = vg_sale.game  WHERE Global >= min_profit GROUP BY vg_game.game_id;
        
        SELECT name, SUM(vg_sale.Global) as profit 
        FROM vg_sale  JOIN vg_game ON vg_sale.game = vg_game.game_id 
		GROUP BY vg_game.name HAVING SUM(vg_sale.Global) >= min_profit
        ORDER BY SUM(vg_sale.Global) DESC;


	ELSEIF place = "NA" THEN
		SELECT name, SUM(vg_sale.NA) as profit 
        FROM vg_sale  JOIN vg_game ON vg_sale.game = vg_game.game_id 
		GROUP BY vg_game.name HAVING SUM(vg_sale.NA) >= min_profit
        ORDER BY SUM(vg_sale.NA) DESC;
	ELSEIF place = "EU" THEN
		SELECT name, SUM(vg_sale.EU) as profit 
        FROM vg_sale  JOIN vg_game ON vg_sale.game = vg_game.game_id 
		GROUP BY vg_game.name HAVING SUM(vg_sale.EU) >= min_profit
        ORDER BY SUM(vg_sale.EU) DESC;
	ELSEIF place = "JP" THEN
		SELECT name, SUM(vg_sale.JP) as profit 
        FROM vg_sale  JOIN vg_game ON vg_sale.game = vg_game.game_id 
		GROUP BY vg_game.name HAVING SUM(vg_sale.JP) >= min_profit
        ORDER BY SUM(vg_sale.JP) DESC;
	ELSE
		SELECT name, SUM(vg_sale.Other) as profit 
        FROM vg_sale  JOIN vg_game ON vg_sale.game = vg_game.game_id 
		GROUP BY vg_game.name HAVING SUM(vg_sale.Other) >= min_profit
        ORDER BY SUM(vg_sale.Other) DESC;
	END IF;
END //
delimiter ;

delimiter //
CREATE PROCEDURE genreRankingByRegion (IN gName VARCHAR(30), IN place CHAR(2))
BEGIN
	IF place = "WD" THEN
		SELECT RANK() OVER(
				ORDER BY Global DESC
			) Sale_Rank,
			game_id as ID,Global
		FROM vg_sale
			JOIN vg_link
				ON vg_sale.sale_id = vg_link.game_id 
			JOIN vg_genre 
				ON vg_link.genre_id = vg_genre.genre_id 
			
		WHERE genre =  gName;
	ELSEIF place = "NA" THEN
		SELECT RANK() OVER(
				ORDER BY NA DESC
			) Sale_Rank,
			game_id as ID, NA
		FROM vg_sale 
			JOIN vg_link 
				ON vg_sale.sale_id = vg_link.game_id 
			JOIN vg_genre 
				ON vg_link.genre_id = vg_genre.genre_id 
		WHERE genre =  gName;
	ELSEIF place = "EU" THEN
		SELECT RANK() OVER(
				ORDER BY EU DESC
			) Sale_Rank,
			game_id as ID, EU
		FROM vg_sale 
			JOIN vg_link 
				ON vg_sale.sale_id = vg_link.game_id 
			JOIN vg_genre 
				ON vg_link.genre_id = vg_genre.genre_id 
		WHERE genre =  gName;
	ELSEIF place = "JP" THEN
		SELECT RANK() OVER(
				ORDER BY JP DESC
			) Sale_Rank,
			game_id as ID, JP
		FROM vg_sale 
			JOIN vg_link 
				ON vg_sale.sale_id = vg_link.game_id 
			JOIN vg_genre 
				ON vg_link.genre_id = vg_genre.genre_id 
		WHERE genre =  gName;
	ELSE
		SELECT RANK() OVER(
				ORDER BY Other DESC
			) Sale_Rank,
			game_id as ID, Other
		FROM vg_sale 
			JOIN vg_link 
				ON vg_sale.sale_id = vg_link.game_id 
			JOIN vg_genre 
				ON vg_link.genre_id = vg_genre.genre_id 
		WHERE genre =  gName;
	END IF;
END //
delimiter ;

delimiter //
CREATE PROCEDURE publishedReleases (IN pub VARCHAR(50), IN gName VARCHAR(30))
BEGIN
	SELECT COUNT(DISTINCT(vg_game.name)) FROM vg_game 
		JOIN vg_link 
			ON vg_link.game_id = vg_game.game_id
		JOIN vg_genre
			ON vg_genre.genre_id = vg_link.genre_id
		JOIN vg_publisher
			ON vg_publisher.publisher_id = vg_link.publisher_id
	WHERE publisher = pub AND genre = gName;
END //
delimiter ;

delimiter //
CREATE PROCEDURE addNewRelease (IN title VARCHAR(50), IN plat VARCHAR(10), IN gName VARCHAR(30), IN pub VARCHAR(30))
BEGIN
	DECLARE new_rank INT DEFAULT 0;
    DECLARE new_genre INT DEFAULT 0;
    DECLARE new_plat INT DEFAULT 0;
    DECLARE new_pub INT DEFAULT 0;
	IF (SELECT count(*) FROM vg_game WHERE name like title) = 0 THEN
        INSERT INTO vg_game (name) VALUES (title);
    END IF;
    
    IF (SELECT count(*) FROM vg_platform WHERE platform like plat) = 0 THEN
        INSERT INTO vg_platform (platform) VALUES (plat);
    END IF;

    IF (SELECT count(*) FROM vg_genre WHERE genre like gName) = 0 THEN
        INSERT INTO vg_genre (genre) VALUES (gName);
    END IF;

    IF (SELECT count(*) FROM vg_publisher WHERE publisher like pub) = 0 THEN
        INSERT INTO vg_publisher (publisher) VALUES (pub);
    END IF;

    INSERT INTO vg_link (game_id, publisher_id, genre_id,platform_id) 
    VALUES (
        (SELECT game_id FROM vg_game WHERE name like title), 
        (SELECT publisher_id FROM vg_publisher WHERE publisher like pub), 
        (SELECT genre_id FROM vg_genre WHERE genre like gName),
        (SELECT platform_id FROM vg_platform WHERE platform like plat)
    );
    

        
	INSERT INTO vg_sale (sale_id, platform_id, NA, EU, JP, Other, Global) 
    VALUES (
        (SELECT game_id FROM vg_game WHERE name like title), 
        (SELECT platform_id FROM vg_platform WHERE platform like plat),0,0,0,0,0
    );
END //
delimiter ;