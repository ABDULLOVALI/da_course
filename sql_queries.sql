SELECT phone
FROM customer
WHERE phone NOT LIKE '%(%' AND phone NOT LIKE '%)%';

SELECT INITCAP('lorem ipsum') AS formatted_text;

SELECT name
FROM track
WHERE name ILIKE '%run%';

SELECT *
FROM customer
WHERE email LIKE '%@gmail.com';

SELECT name
FROM track
ORDER BY LENGTH(name) DESC
LIMIT 1;

SELECT EXTRACT(MONTH FROM invoice_date) AS Month_id, 
       SUM(total) AS Sales_sum
FROM invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2021
GROUP BY Month_id
ORDER BY Month_id;

SELECT EXTRACT(MONTH FROM invoice_date) AS Month_id,
       TO_CHAR(invoice_date, 'Month') AS Month_Name,
       SUM(total) AS Sales_sum
FROM invoice
WHERE EXTRACT(YEAR FROM invoice_date) = 2021
GROUP BY Month_id, Month_Name
ORDER BY Month_id;

SELECT CONCAT(first_name, ' ', last_name) AS полное_имя,
       birth_date,
       EXTRACT(YEAR FROM AGE(birth_date)) AS возраст_сейчас
FROM employee 
ORDER BY birth_date
LIMIT 3;

SELECT AVG(EXTRACT(YEAR FROM AGE(birth_date)) + 3 + (4/12.0)) AS средний_возраст_через_3_года_и_4_месяца
FROM employee;

SELECT EXTRACT(YEAR FROM invoice_date) AS year,
       billing_country AS country,
       SUM(total) AS total_sales
FROM invoice
WHERE total > 20
GROUP BY year, country
ORDER BY year ASC, total_sales DESC;