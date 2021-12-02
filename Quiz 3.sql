SELECT cust_name
FROM candy_customer 
WHERE cust_type IN 
	(SELECT cust_type 
    FROM candy_cust_type 
    WHERE cust_type_desc LIKE "%Retail");

SELECT cust_name
FROM candy_customer JOIN candy_cust_type
	ON candy_customer.cust_type = candy_cust_type.cust_type
WHERE cust_type_desc LIKE "%Retail%";


SELECT cust_name
FROM candy_customer
WHERE cust_id IN
	(SELECT cust_id 
	FROM candy_purchase
    WHERE status LIKE "%NOT PAID");
    
SELECT cust_name
FROM candy_customer
WHERE cust_id IN 
	(SELECT cust_id
    FROM candy_purchase
    WHERE prod_id IN 
		(SELECT prod_id
		FROM candy_product
        WHERE prod_desc LIKE "%Celestial Cashew Crunch"));
        
    
SELECT prod_desc
FROM candy_product JOIN candy_purchase
	ON candy_product.prod_id = candy_purchase.prod_id
WHERE pounds > 
	(SELECT AVG(pounds) 
    FROM candy_purchase)
GROUP BY prod_desc;