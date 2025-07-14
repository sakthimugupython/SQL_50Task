CREATE DATABASE inventory_expiry;
USE inventory_expiry;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE batches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    expiry_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Sample Products
INSERT INTO products (name) VALUES
('Milk'), ('Bread'), ('Yogurt'), ('Cheese'), ('Juice'),
('Butter'), ('Eggs'), ('Spinach'), ('Chicken'), ('Rice');

-- Sample Batches (10 rows)
INSERT INTO batches (product_id, quantity, expiry_date) VALUES
(1, 50, '2025-07-15'),
(2, 100, '2025-07-14'),
(3, 70, '2025-07-13'),
(4, 40, '2025-07-20'),
(5, 30, '2025-07-18'),
(6, 60, '2025-07-12'),
(7, 90, '2025-07-16'),
(8, 20, '2025-07-11'),
(9, 55, '2025-07-13'),
(10, 80, '2025-07-17');

-- Query: Expired stock (as of '2025-07-15')
SELECT 
    p.name AS product,
    b.quantity,
    b.expiry_date
FROM batches b
JOIN products p ON b.product_id = p.id
WHERE b.expiry_date < '2025-07-15'
ORDER BY b.expiry_date;

-- Query: Total remaining stock by product
SELECT 
    p.name,
    SUM(b.quantity) AS total_quantity
FROM batches b
JOIN products p ON b.product_id = p.id
WHERE b.expiry_date >= CURDATE()
GROUP BY p.name
ORDER BY total_quantity DESC;
