SELECT cust_name
FROM candy_customer JOIN candy_cust_type
	ON candy_customer.cust_type = candy_cust_type.cust_type
WHERE cust_type_desc LIKE "%Retail%";

SELECT cust_type,COUNT(cust_type)
FROM candy_customer
GROUP BY cust_type;

SELECT cust_name
FROM candy_purchase JOIN candy_customer
	ON candy_customer.cust_id = candy_purchase.cust_id
    JOIN candy_product
    ON candy_purchase.prod_id = candy_product.prod_id
WHERE candy_product.prod_desc LIKE "%Celestial Cashew Crunch%";


SELECT prod_id, AVG(pounds)
FROM candy_purchase
GROUP BY prod_id
HAVING COUNT(cust_id) > 3;


SELECT prod_desc 
FROM candy_product LEFT JOIN candy_purchase  
	ON candy_purchase.prod_id = candy_product.prod_id 
WHERE candy_purchase.prod_id IS NULL;