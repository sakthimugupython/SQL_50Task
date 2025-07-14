CREATE DATABASE product_reviews;
USE product_reviews;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating DECIMAL(2,1) CHECK (rating BETWEEN 1 AND 5),
    review TEXT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    UNIQUE (user_id, product_id)  -- Prevent duplicate reviews
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO products (name) VALUES
('Laptop'),
('Mouse'),
('Keyboard');

INSERT INTO reviews (user_id, product_id, rating, review, created_at) VALUES
(1, 1, 4.5, 'Great performance, battery could be better.', NOW()),
(2, 1, 5.0, 'Outstanding laptop for daily use.', NOW()),
(3, 2, 3.5, 'Decent mouse, but a bit small.', NOW());

-- Query: Average rating per product
SELECT 
    p.id AS product_id,
    p.name AS product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.id) AS total_reviews
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
ORDER BY average_rating DESC;

-- Query: Get top-rated products (min 2 reviews)
SELECT 
    p.name AS product_name,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
HAVING COUNT(r.id) >= 2
ORDER BY avg_rating DESC;
