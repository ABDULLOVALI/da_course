SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS full_name,
    e.title,
    e.reports_to,
    m.first_name || ' ' || m.last_name AS manager_name,
    m.title AS manager_title
FROM 
    employee e
LEFT JOIN 
    employee m ON e.reports_to = m.employee_id;

 SELECT 
    invoice_id,
    invoice_date,
    EXTRACT(YEAR FROM invoice_date) * 100 + EXTRACT(MONTH FROM invoice_date) AS monthkey,
    customer_id,
    total
FROM 
    invoice 
WHERE 
    EXTRACT(YEAR FROM invoice_date) = 2023
    AND total > (SELECT AVG(total) FROM invoice  WHERE EXTRACT(YEAR FROM invoice_date) = 2023);

   SELECT 
    i.invoice_id,
    i.invoice_date,
    EXTRACT(YEAR FROM i.invoice_date) * 100 + EXTRACT(MONTH FROM i.invoice_date) AS monthkey,
    i.customer_id,
    i.total,
    c.email
FROM 
    invoice i
JOIN 
    customer c ON i.customer_id = c.customer_id
WHERE 
    EXTRACT(YEAR FROM i.invoice_date) = 2023
    AND i.total > (SELECT AVG(total) FROM invoice WHERE EXTRACT(YEAR FROM invoice_date) = 2023);

SELECT 
    i.invoice_id,
    i.invoice_date,
    EXTRACT(YEAR FROM i.invoice_date) * 100 + EXTRACT(MONTH FROM i.invoice_date) AS monthkey,
    i.customer_id,
    i.total,
    c.email
FROM 
    invoice i
JOIN 
    customer c ON i.customer_id = c.customer_id
WHERE 
    EXTRACT(YEAR FROM i.invoice_date) = 2023
    AND i.total > (SELECT AVG(total) FROM invoice WHERE EXTRACT(YEAR FROM invoice_date) = 2023)
    AND c.email NOT LIKE '%@gmail.com';
   
  WITH total_revenue_2024 AS (
    SELECT SUM(total) AS total_2024 FROM invoice  WHERE EXTRACT(YEAR FROM invoice_date) = 2024
)
SELECT 
    i.invoice_id,
    i.invoice_date,
    i.total,
    ROUND((i.total / tr.total_2024) * 100, 2) AS revenue_percentage
FROM 
    invoice i,
    total_revenue_2024 tr
WHERE 
    EXTRACT(YEAR FROM i.invoice_date) = 2024;


WITH total_revenue_2024 AS (
    SELECT SUM(total) AS total_2024 FROM invoice WHERE EXTRACT(YEAR FROM invoice_date) = 2024
),
customer_revenue AS (
    SELECT 
        customer_id,
        SUM(total) AS customer_total
    FROM 
        invoice
    WHERE 
        EXTRACT(YEAR FROM invoice_date) = 2024
    GROUP BY 
        customer_id
)
SELECT 
    c.customer_id,
    c.customer_total,
    ROUND((c.customer_total / tr.total_2024) * 100, 2) AS customer_revenue_percentage
FROM 
    customer_revenue c,
    total_revenue_2024 tr;