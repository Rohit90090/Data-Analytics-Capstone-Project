DROP DATABASE IF EXISTS sales_db;
DROP DATABASE IF EXISTS `AI-Assisted Analysis`;
CREATE DATABASE `AI-Assisted Analysis`;
USE `AI-Assisted Analysis`;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    registration_date DATE,
    region VARCHAR(50),
    customer_segment VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2),
    profit_margin DECIMAL(10,2)
);

CREATE TABLE transactions (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    region VARCHAR(50),
    payment_method VARCHAR(50)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2)
);

show tables;

SELECT
    DATE_FORMAT(t.order_date, '%Y-%m') AS month,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    RANK() OVER (
        PARTITION BY DATE_FORMAT(t.order_date, '%Y-%m')
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS category_rank
FROM transactions t
JOIN order_items oi
    ON t.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY DATE_FORMAT(t.order_date, '%Y-%m'), p.category
ORDER BY month, category_rank;

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(t.order_id) AS total_orders,
    SUM(t.total_amount) AS total_spent,
    AVG(t.total_amount) AS avg_order_value
FROM customers c
JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 5;

SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MAX(order_date), MIN(order_date)) AS customer_lifetime_days,
    CASE
        WHEN COUNT(order_id) = 1 THEN 'One-time Buyer'
        WHEN COUNT(order_id) BETWEEN 2 AND 4 THEN 'Repeat Buyer'
        ELSE 'Loyal Buyer'
    END AS customer_type
FROM transactions
GROUP BY customer_id
ORDER BY total_orders DESC;

WITH product_sales AS (
    SELECT
        p.category,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category, p.product_name
),
ranked_products AS (
    SELECT
        category,
        product_name,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS rn
    FROM product_sales
)
SELECT
    category,
    product_name,
    revenue
FROM ranked_products
WHERE rn = 1;

SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT t.order_id) AS total_orders,
    SUM(t.total_amount) AS total_revenue,
    ROUND(AVG(t.total_amount), 2) AS avg_order_value
FROM customers c
JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;

SELECT * FROM customers;

SELECT * FROM customers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM transactions LIMIT 5;
SELECT * FROM order_items LIMIT 5;

SELECT COUNT(*) FROM custom;

show tables;