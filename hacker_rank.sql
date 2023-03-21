--QUESTION 1
--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
--For example, if there are three records in the table with CITY values 'New York', 'New York', 'Bengalaru', there are 2 different city names: 'New York' and 'Bengalaru'. The query returns , because

SELECT
    COUNT(city) - COUNT(distinct city) AS diff
FROM station;

--QUESTION 2
--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

--in SQL Server
SELECT DISTINCT City FROm Station WHERE RIGHT(City,1) IN ('a','e','i','o','u')

--QUESTION 3
-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

SELECT 
    DISTINCT city 
FROm Station 
WHERE 
    RIGHT(City,1) IN ('a','e','i','o','u')
    and LEFT(City,1) IN ('a','e','i','o','u');


--QUESTION 4
--  Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.   

SELECT DISTINCT City FROm Station WHERE LEFT(City,1) NOT IN ('a','e','i','o','u')

