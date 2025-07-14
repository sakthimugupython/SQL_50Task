CREATE DATABASE wishlist_system;
USE wishlist_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE wishlist (
    user_id INT,
    product_id INT,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO products (name) VALUES ('Laptop'), ('Smartphone'), ('Headphones');

INSERT INTO wishlist (user_id, product_id) VALUES
(1, 1), (2, 1), (3, 2), (1, 3);

-- Query: Popular wishlist items
SELECT 
    p.name AS product_name,
    COUNT(w.user_id) AS wishlisted_by
FROM wishlist w
JOIN products p ON w.product_id = p.id
GROUP BY p.name
ORDER BY wishlisted_by DESC;
