-- 982.61 sec
-- 1213.547 sec
DROP TABLE IF EXISTS lab8_Table;
DROP PROCEDURE IF EXISTS myCreateTable;
delimiter //
CREATE PROCEDURE myCreateTable (IN entries INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	CREATE TABLE lab8_Table(
		pos BIGINT AUTO_INCREMENT PRIMARY KEY,
		val INT
        -- ,INDEX val_index(val DESC)
    );
    
	WHILE (i <= entries) DO
	INSERT INTO lab8_Table (val) VALUES (FLOOR(RAND()*1000));
	SET i = i+1;
	END WHILE;
END //
delimiter ;
CALL myCreateTable(100000);
SELECT * FROM lab8_Table;