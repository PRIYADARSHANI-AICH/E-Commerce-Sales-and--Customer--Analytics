CREATE DATABASE oilst_ecommerce;

USE oilst_ecommerce;

SHOW DATABASES;


DROP TABLE CUSTOMERS;

SELECT COUNT(*)
FROM  olist_customers_dataset;
SELECT COUNT(*) FROM olist_order_payments_dataset;

SHOW TABLES;

select* from olist_order_reviews_dataset;
select* from olist_sellers_dataset;

SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;


SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;

SELECT COUNT(*) AS total_orders_items
FROM olist_order_items_dataset;

SELECT COUNT(*) AS total_payments
FROM olist_order_payments_dataset; 


SELECT COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset;


SELECT COUNT(*) AS total_products
FROM olist_products_dataset;


SELECT COUNT(*) AS total_sellers
FROM olist_sellers_dataset;


/* How many orders belongs to each status */
SELECT  order_status,
COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

/* Calculate the order-status percentage */
SELECT order_status, 
COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2)
AS percentage FROM olist_orders_dataset
GROUP BY  order_status
ORDER BY total_orders DESC;
 
/* HOW MANY UNIQUE CUSTOMERS PALCED ORDERS? */
SELECT COUNT(distinct customer_id) 
AS unique_customers
FROM olist_orders_dataset;

/*HOW MANY ORDERS WERE PLACED EACH MONTH */
SELECT date_format(order_purchase_timestamp, '%Y-%m') AS order_month,
COUNT(*) AS total_orders FROM olist_orders_dataset
WHERE order_purchase_timestamp IS NOT NULL
group by date_format(order_purchase_timestamp,'%Y-%m')
ORDER BY order_month;


/* HOW MANY ORDERS WERE CANCELLED */

SELECT COUNT(*) AS canceled_orders
FROM olist_orders_dataset
WHERE order_status = 'delivered';

/* WHAT is the total items sales vale */
SELECT ROUND(SUM(price), 2) AS total_item_sales
FROM olist_order_items_dataset;

/* WHAT is the total freight */

SELECT ROUND(SUM(freight_value), 2) AS total_freight
FROM olist_order_items_dataset;


/* WHAT is the total payment value */
SELECT ROUND(SUM(payment_value), 2) AS total_payments_value
FROM olist_order_payments_dataset;

/* Which payment methods are most popular */

SELECT payment_type, COUNT(*) AS payment_records,
ROUND(SUM(payment_value), 2) AS payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type
order by  payment_records DESC;

/* WHAT is the average payment per payment record */
SELECT ROUND(AVG(payment_value), 2) AS average_payment
FROM olist_order_payments_dataset;

/* HOW many installments are used */
SELECT payment_installments, COUNT(*) AS payment_records
FROM olist_order_payments_dataset
GROUP BY payment_installments
ORDER BY payment_installments;

/* WHICH products have the highest sales value */
SELECT product_id, COUNT(*) AS units_sold,
ROUND(SUM(price), 2) AS sales_value
FROM olist_order_items_dataset
GROUP BY product_id
ORDER BY sales_value DESC
LIMIT 10;

/* Which sellers have the highest sales value */
SELECT seller_id, COUNT(*) AS items_sold,
ROUND(SUM(price), 2) AS sales_value 
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY sales_value DESC
LIMIT 10;


/* Which product categories sell the most */
SELECT p.product_category_name, COUNT(*) AS items_sold,
ROUND(SUM(oi.price), 2) AS sales_value
FROM olist_order_items_dataset oi JOIN olist_products_dataset p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY sales_value DESC
LIMIT 10;

/* Which sellers sell the most items */
SELECT seller_id, COUNT(*) AS items_sold
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY items_sold DESC
LIMIT 10;

/* HOW many customers are in each state */
SELECT customer_state,
COUNT(distinct customer_unique_id) AS unique_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY unique_customers DESC;

/*Which cities have the most customers ?*/
SELECT customer_city, COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY unique_customers DESC
LIMIT 10;


/* Which customers have placed the most orders */
SELECT customer_id, COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

/* What is the average delivery time in days */
SELECT ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_delivered_customer_date)), 2)
AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_purchase_timestamp IS NOT NULL;

/* HOW many delivered orders arrived later than estimated */

SELECT COUNT(*) AS late_deliveries
FROM olist_orders_dataset 
WHERE order_status= 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date ;


/* WHAT is the average review score */
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM olist_order_reviews_dataset;

/* How many reviews were given for each score */
SELECT review_score, COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score
ORDER BY review_score DESC;

/* WHICH order ststuses have the lowest review scores */
SELECT o.order_status, ROUND(AVG(r.review_score), 2) AS avg_review_score,
COUNT(*) AS review_records
FROM olist_orders_dataset o JOIN olist_order_reviews_dataset r 
ON o.order_id= r.order_id
GROUP BY o.order_status
ORDER BY avg_review_score ASC;





































