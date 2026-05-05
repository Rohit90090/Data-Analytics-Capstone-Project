CREATE DATABASE IF NOT EXISTS sales_project;
USE sales_project;

 CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE,
    region VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price FLOAT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total FLOAT
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
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

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;