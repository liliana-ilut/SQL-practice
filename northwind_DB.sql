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

--QUESTION 5
-- Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date

SELECT 
     employee_id,
     order_id,
     customer_id,
     required_date,
     shipped_date
from orders
where shipped_date > required_date
;

--QESTION 6
--Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name

SELECT 
     city,
     company_name,
     contact_name
from customers
where
	city like '%L%'
order by contact_name
;

--QUESTION 7
--Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)

SELECT 
     company_name,
     contact_name,
     fax
from customers
where
	fax is not null
;

--QUESTION 8
--Show the first_name, last_name of the most recently hired employee.

SELECT 
     first_name,
     last_name,
     max(hire_date) as hire_day
from employees
;

--QESTION 9
--Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.

SELECT 
     round(avg(unit_price),2) as avg_unit_price,
     sum(units_in_stock) as total_unit_stock,
     sum(discontinued) as discounted_products
from products;


------------------------------------------------------------------------------------------------
--MEDIUM SECTION----MEDIUM SECTION----MEDIUM SECTION----MEDIUM SECTION----MEDIUM SECTION--

--QUESTION 1
--Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table



