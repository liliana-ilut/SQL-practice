--QUESTION 1
--Show the category_name and description from the categories table sorted by category_name.

SELECT 
     category_name,
     description
FROM categories
ORDER BY category_name
;

--QUESTION 2
--Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'

SELECT 
     contact_name,
     address,
     city
FROM customers
WHERE 
	country not in ('Germany', 'Mexico', 'Spain')
;

--QUESTION 3
--Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26

SELECT 
     order_date,
     shipped_date,
     customer_id,
     freight
from orders
where
	order_date = '2018-02-26'
;

--QUESTION 4
--Show all the even numbered Order_id from the orders table

SELECT 
     order_id
from orders
where
	order_id % 2 = 0
;
