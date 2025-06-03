CREATE DATABASE retail_sail_insight;
USE retail_sail_insight;

-- customer table
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(50),
region VARCHAR(50));

-- product table
CREATE TABLE products(
product_id INT PRIMARY KEY,
name VARCHAR(50),
category VARCHAR (50),
price INT);


-- order table
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

-- orders item table
CREATE TABLE order_items(
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id));

-- add data


-- customers
INSERT INTO customers VALUES
(1, 'Alice', 'alice@email.com', 'West'),
(2, 'Bob', 'bob@email.com', 'East'),
(3, 'Charlie', 'charlie@email.com', 'North'),
(4, 'Diana', 'diana@email.com', 'South');

-- products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 800),
(102, 'Phone', 'Electronics', 500),
(103, 'Desk', 'Furniture', 150),
(104, 'Chair', 'Furniture', 85);

-- orders
INSERT INTO orders VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-15'),
(1003, 3, '2024-02-01'),
(1004, 1, '2024-03-10');

-- orders item
INSERT INTO order_Items VALUES
(1, 1001, 101, 1),
(2, 1001, 104, 2),
(3, 1002, 102, 1),
(4, 1003, 103, 1),
(5, 1004, 101, 1),
(6, 1004, 102, 1);


-- Total revenue per customer
SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_Items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;

-- Top 3 products by revenue
SELECT p.name, SUM(p.price * oi.quantity) AS revenue
FROM products p
JOIN order_Items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 3;

-- Orders per region
SELECT region, COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY region;

-- Monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, 
       SUM(p.price * oi.quantity) AS monthly_sales
FROM orders o
JOIN order_Items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Products never ordered
SELECT p.name
FROM products p
LEFT JOIN order_Items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;






