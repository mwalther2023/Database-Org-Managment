DROP TABLE IF EXISTS candy_matview;
CREATE TABLE candy_matview(
	mat_name VARCHAR(30),
    mat_type VARCHAR(20),
    mat_desc VARCHAR(30),
    pounds FLOAT
);
INSERT INTO candy_matview(mat_name,mat_type,mat_desc,pounds)(
	SELECT cust_name,cust_type_desc,prod_desc,pounds
	FROM candy_purchase
		JOIN candy_product
		ON candy_purchase.prod_id = candy_product.prod_id
		JOIN candy_customer
		ON candy_purchase.cust_id = candy_customer.cust_id
		JOIN candy_cust_type
		ON candy_customer.cust_type = candy_cust_type.cust_type
);

DROP TRIGGER IF EXISTS mat_update;
delimiter //
CREATE TRIGGER mat_update
	AFTER INSERT
    ON candy_purchase
    FOR EACH ROW
BEGIN
	INSERT INTO candy_matview(pounds,mat_name,mat_type,mat_desc)
    VALUES(
		NEW.pounds,
		(SELECT cust_name FROM candy_customer WHERE cust_id = NEW.cust_id),
        (SELECT cust_type_desc FROM candy_cust_type JOIN candy_customer ON candy_cust_type.cust_type = candy_customer.cust_type WHERE cust_id = NEW.cust_id),
        (SELECT prod_desc FROM candy_product WHERE prod_id = NEW.prod_id)
        
    
    );
END//
DELETE FROM candy_purchase WHERE purch_id = 100;

-- DELETE FROM candy_matview WHERE mat_name LIKE "%The Candy Kid%" AND mat_type LIKE "%Wholesale%" AND mat_desc LIKE "%Nuts for Nachos%";
 