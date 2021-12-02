SELECT * FROM cany_customer;

SELECT cust_id, cust_name
FROM candy_customer
WHERE cust_type = 'W';

SELECT username
FROM candy_customer
WHERE cust_phone LIKE '434%';

SELECT prod_desc, prod_price-prod_cost
FROM candy_product
ORDER BY prod_price-prod_cost DESC;

SELECT COUNT(DISTINCT delivery_date)
FROM candy_purchase