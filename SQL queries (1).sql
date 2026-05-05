CREATE DATABASE retail_db;
-- Create new database
CREATE DATABASE retail_db;
USE retail_db;

 CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE,
    region VARCHAR(50)
);

CREATE TABLE products (
    product_id INT,
    name VARCHAR(100),
    category VARCHAR(50),
    price FLOAT
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total FLOAT
);

CREATE TABLE order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO customers VALUES
(1, 'Rohit Sharma', 'rohit@gmail.com', '2023-01-10', 'North'),
(2, 'Amit Verma', 'amit@gmail.com', '2023-02-15', 'West'),
(3, 'Priya Singh', 'priya@gmail.com', '2023-03-20', 'East');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Phone', 'Electronics', 20000),
(103, 'Shoes', 'Fashion', 3000);

INSERT INTO orders VALUES
(1001, 1, '2023-04-01', 50000),
(1002, 2, '2023-04-05', 20000),
(1003, 3, '2023-04-10', 3000);

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1002, 102, 2),
(3, 1003, 103, 3);

SELECT * 
FROM customers
WHERE region = 'North'
ORDER BY join_date DESC;

-- 2. SUM
SELECT SUM(total) AS total_sales
FROM orders;

-- 3. AVG
SELECT AVG(price) AS avg_price
FROM products;

-- 4. COUNT
SELECT COUNT(*) AS total_customers
FROM customers;

-- 5. GROUP BY category
SELECT 
    category,
    COUNT(*) AS total_products,
    AVG(price) AS avg_price
FROM products
GROUP BY category;

-- 6. Monthly revenue
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');

-- 7. JOIN
SELECT 
    c.name,
    p.name AS product,
    oi.quantity,
    p.price
FROM order_items oi
JOIN customers c ON c.customer_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id;

-- 8. Subquery (top customer)
SELECT name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY SUM(total) DESC
    LIMIT 1
);

-- 9. CASE statement
SELECT 
    name,
    total,
    CASE 
        WHEN total > 30000 THEN 'High'
        WHEN total > 10000 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 10. Window function
SELECT 
    customer_id,
    total,
    ROW_NUMBER() OVER (ORDER BY total DESC) AS rank_no
FROM orders;


-- Simple Queries
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

show tables;