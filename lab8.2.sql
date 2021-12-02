-- 0.125 sec
-- 0.110 sec
DROP PROCEDURE IF EXISTS mySelectTest;

delimiter //
CREATE PROCEDURE mySelectTest(IN v INT, IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
    DECLARE o INT DEFAULT 0;
    WHILE (i < num) DO
		SELECT COUNT(*) INTO @val FROM lab8_Table WHERE pos = i AND val = v;
		SET i = i+1;
        SET o = o + @val;
	END WHILE;
    -- SELECT o;
END //

CALL mySelectTest(50,1000);