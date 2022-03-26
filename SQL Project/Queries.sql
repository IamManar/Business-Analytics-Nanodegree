/* Query 1 */
SELECT STRFTIME('%Y', invoice.invoicedate) year ,SUM(invoiceline.quantity) total_units
FROM invoice
JOIN invoiceline 
ON invoiceline.invoiceid = invoice.invoiceid
GROUP BY 1

/* Query 2 */
SELECT genre.name , SUM(invoiceline.quantity) total_quantity
FROM customer
JOIN invoice 
ON customer.customerid = invoice.customerid 
JOIN invoiceline
ON invoiceline.invoiceid = invoice.invoiceid  
JOIN track 
ON track.trackid = invoiceline.trackid
JOIN genre 
ON genre.genreid = track.genreid
WHERE customer.country = 'USA'
GROUP BY 1 
ORDER BY total_quantity DESC 
LIMIT 5

/* Query 3 */
SELECT employee.firstname ,COUNT(invoice.invoiceid) numuber_of_invoices
FROM employee
LEFT JOIN customer
On employee.employeeid = customer.supportrepid
LEFT JOIN invoice
On invoice.customerid = customer.customerid
GROUP BY 1
ORDER BY 2 DESC

/* Query 4 */
WITH avg_customer_total AS (
  SELECT customer.country AS country , customer.customerid, avg(invoice.total) As avg_total 
  FROM customer
  JOIN invoice
  ON customer.customerid = invoice.customerid 
  JOIN invoiceline 
  ON invoiceline.invoiceid = invoice.invoiceid 
  GROUP BY 1 )
SELECT country , avg(avg_total ) AS avg_country_total
FROM avg_customer_total
GROUP BY country
ORDER BY avg_country_total DESC 
LIMIT 5
