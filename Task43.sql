CREATE DATABASE return_management;
USE return_management;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE returns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    reason VARCHAR(200),
    status ENUM('PENDING', 'APPROVED', 'REJECTED'),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample products
INSERT INTO products (name) VALUES
('Laptop'), ('Mouse'), ('Keyboard'), ('Monitor'), ('Tablet'),
('Phone'), ('Headphones'), ('Charger'), ('Smartwatch'), ('Speaker');

-- Sample orders
INSERT INTO orders (user_id, product_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Sample returns
INSERT INTO returns (order_id, reason, status) VALUES
(1, 'Damaged product', 'APPROVED'),
(2, 'Wrong item received', 'PENDING'),
(3, 'Changed mind', 'REJECTED'),
(4, 'Late delivery', 'APPROVED'),
(5, 'Not working', 'APPROVED'),
(6, 'Color mismatch', 'REJECTED'),
(7, 'Wrong model', 'PENDING'),
(8, 'Accessory missing', 'APPROVED'),
(9, 'Not compatible', 'REJECTED'),
(10, 'Duplicate order', 'PENDING');

-- Query: Return summary by status
SELECT 
    r.status,
    COUNT(*) AS total_returns
FROM returns r
GROUP BY r.status;

-- Query: Return requests with order and user details
SELECT 
    u.name AS user,
    p.name AS product,
    r.reason,
    r.status
FROM returns r
JOIN orders o ON r.order_id = o.id
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id
ORDER BY r.status;
