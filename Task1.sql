-- Task 1: E-Commerce Product Catalog
CREATE DATABASE ecommerce_catalog;
USE ecommerce_catalog;

-- Create categories table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create brands table
CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create products table with foreign keys and indexes
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    INDEX idx_category (category_id),
    INDEX idx_brand (brand_id),
    INDEX idx_price (price)
);

-- Insert sample data into categories
INSERT INTO categories (name) VALUES
('Electronics'),
('Apparel'),
('Home & Kitchen'),
('Books'),
('Sports & Outdoors');

-- Insert sample data into brands
INSERT INTO brands (name) VALUES
('Apple'),
('Samsung'),
('Nike'),
('Adidas'),
('Amazon Basics'),
('Sony'),
('Dell');

-- Insert sample data into products
INSERT INTO products (name, description, price, stock, image_url, category_id, brand_id) VALUES
('iPhone 13', '128GB, Midnight Black', 799.99, 50, 'iphone13.jpg', 1, 1),
('Galaxy S22', '256GB, Phantom Black', 749.99, 30, 'galaxys22.jpg', 1, 2),
('Air Jordan 1', 'Basketball shoes, size 10', 189.99, 15, 'airjordan1.jpg', 2, 3),
('Ultraboost 22', 'Running shoes, size 9', 179.99, 20, 'ultraboost22.jpg', 2, 4),
('AirPods Pro', 'Wireless earbuds with noise cancellation', 249.99, 40, 'airpodspro.jpg', 1, 1),
('Smart TV 55"', '4K Ultra HD Smart LED TV', 499.99, 10, 'smarttv55.jpg', 1, 6),
('XPS 13 Laptop', '13.4 inch, 16GB RAM, 512GB SSD', 1299.99, 8, 'xps13.jpg', 1, 7),
('Running Shorts', 'Dri-FIT running shorts, size M', 34.99, 25, 'runningshorts.jpg', 2, 3),
('Wireless Mouse', 'Ergonomic wireless mouse', 24.99, 50, 'wirelessmouse.jpg', 1, 5),
('Bluetooth Speaker', 'Portable Bluetooth speaker, 20W', 79.99, 35, 'bluetoothspeaker.jpg', 1, 6);

-- Query 1: Find all products with low stock (less than 15)
SELECT 
    p.id,
    p.name,
    p.price,
    p.stock,
    c.name AS category,
    b.name AS brand
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id
JOIN 
    brands b ON p.brand_id = b.id
WHERE 
    p.stock < 15
ORDER BY 
    p.stock ASC;

-- Query 2: Calculate the total inventory value by category
SELECT 
    c.name AS category,
    COUNT(p.id) AS product_count,
    SUM(p.stock) AS total_items,
    ROUND(SUM(p.price * p.stock), 2) AS inventory_value
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id
GROUP BY 
    c.id, c.name
ORDER BY 
    inventory_value DESC;

-- Query 3: Find the average product price by brand
SELECT 
    b.name AS brand,
    COUNT(p.id) AS product_count,
    ROUND(AVG(p.price), 2) AS average_price,
    MIN(p.price) AS min_price,
    MAX(p.price) AS max_price
FROM 
    products p
JOIN 
    brands b ON p.brand_id = b.id
GROUP BY 
    b.id, b.name
ORDER BY 
    average_price DESC;

-- Query 4: Filter products by price range and category
SELECT 
    p.id,
    p.name,
    p.description,
    p.price,
    p.stock,
    b.name AS brand
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id
JOIN 
    brands b ON p.brand_id = b.id
WHERE 
    c.name = 'Electronics' AND
    p.price BETWEEN 100 AND 500
ORDER BY 
    p.price ASC;

-- Query 5: Find products by brand with stock availability
SELECT 
    p.id,
    p.name,
    p.price,
    p.stock,
    c.name AS category,
    CASE 
        WHEN p.stock > 20 THEN 'High Stock'
        WHEN p.stock > 10 THEN 'Medium Stock'
        ELSE 'Low Stock'
    END AS stock_status
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.id
JOIN 
    brands b ON p.brand_id = b.id
WHERE 
    b.name = 'Apple'
ORDER BY 
    p.stock DESC;