/*
Имя: Абдулло
Фамилия: Шовалиева
Описание задачи:  Написать SQL-запросы для извлечения различной информации из таблицы track и, возможно, других таблиц базы данных, связанных с музыкальной библиотекой или интернет-магазином музыки.
*/

SELECT name, genre_id 
FROM track;

SELECT name AS song, unit_price AS price, composer AS author
FROM track;

SELECT name, (milliseconds / 60000.0) AS duration_in_minutes
FROM track
ORDER BY duration_in_minutes DESC;

SELECT name, genre_id 
FROM track
LIMIT 15;

SELECT *
FROM track
OFFSET 49;

SELECT name
FROM track
WHERE bytes > 100 * 1024 * 1024;  -- 100 MB в байтах

SELECT name, composer
FROM track
WHERE composer <> 'U2'
LIMIT 11 OFFSET 9;  -- 10 по 20-я строки включительно

SELECT MIN(invoice_date) AS first_purchase, MAX(invoice_date) AS last_purchase
FROM invoice;

SELECT AVG(total) AS average_check
FROM invoice
JOIN customer ON invoice.customer_id = customer.customer_id 
WHERE country = 'USA';

SELECT city
FROM customer
GROUP BY city
HAVING COUNT(customer_id) > 1;

