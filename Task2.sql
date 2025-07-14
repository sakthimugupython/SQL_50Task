-- Task 2: Shopping Cart System
CREATE DATABASE shopping_cart;
USE shopping_cart;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255)
);

CREATE TABLE carts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE cart_items (
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO users (name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Robert Johnson', 'robert.johnson@example.com'),
('Emily Davis', 'emily.davis@example.com'),
('Michael Wilson', 'michael.wilson@example.com');

INSERT INTO products (name, description, price, stock, image_url) VALUES
('Smartphone X', '128GB, Black', 799.99, 50, 'smartphone_x.jpg'),
('Laptop Pro', '16GB RAM, 512GB SSD', 1299.99, 30, 'laptop_pro.jpg'),
('Wireless Headphones', 'Noise cancellation, 20hr battery', 199.99, 45, 'headphones.jpg'),
('Smart Watch', 'Fitness tracking, heart rate monitor', 249.99, 25, 'smartwatch.jpg'),
('Bluetooth Speaker', 'Waterproof, 12hr battery life', 89.99, 60, 'speaker.jpg'),
('Tablet Ultra', '10-inch display, 64GB', 399.99, 20, 'tablet.jpg'),
('Gaming Mouse', 'RGB lighting, programmable buttons', 59.99, 40, 'mouse.jpg'),
('Mechanical Keyboard', 'RGB backlit, tactile switches', 129.99, 35, 'keyboard.jpg'),
('External SSD', '1TB, USB-C', 149.99, 55, 'ssd.jpg'),
('Wireless Charger', '15W fast charging', 29.99, 70, 'charger.jpg');

INSERT INTO carts (user_id) VALUES
(1),
(2),
(3),
(4),
(5);

INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(1, 5, 1),

(2, 2, 1),
(2, 4, 1),
(2, 7, 2),

(3, 6, 1),
(3, 9, 1),

(4, 8, 1),
(4, 10, 3),
(4, 3, 1),

(5, 5, 2),
(5, 7, 1);

SELECT 
    u.id AS user_id,
    u.name AS user_name,
    c.id AS cart_id,
    COUNT(ci.product_id) AS total_items,
    SUM(ci.quantity) AS total_quantity,
    ROUND(SUM(p.price * ci.quantity), 2) AS total_cart_value
FROM 
    users u
JOIN 
    carts c ON u.id = c.user_id
LEFT JOIN 
    cart_items ci ON c.id = ci.cart_id
LEFT JOIN 
    products p ON ci.product_id = p.id
GROUP BY 
    u.id, u.name, c.id
ORDER BY 
    total_cart_value DESC;

SELECT 
    p.id AS product_id,
    p.name AS product_name,
    p.price AS unit_price,
    ci.quantity,
    ROUND(p.price * ci.quantity, 2) AS subtotal
FROM 
    users u
JOIN 
    carts c ON u.id = c.user_id
JOIN 
    cart_items ci ON c.id = ci.cart_id
JOIN 
    products p ON ci.product_id = p.id
WHERE 
    u.id = 1
ORDER BY 
    p.name;

SELECT 
    p.id AS product_id,
    p.name AS product_name,
    COUNT(DISTINCT ci.cart_id) AS cart_count,
    SUM(ci.quantity) AS total_quantity
FROM 
    products p
JOIN 
    cart_items ci ON p.id = ci.product_id
GROUP BY 
    p.id, p.name
ORDER BY 
    total_quantity DESC, cart_count DESC;

SELECT 
    u.name AS user_name,
    p.name AS product_name,
    ci.quantity AS cart_quantity,
    p.stock AS available_stock,
    (ci.quantity > p.stock) AS exceeds_stock
FROM 
    cart_items ci
JOIN 
    carts c ON ci.cart_id = c.id
JOIN 
    users u ON c.user_id = u.id
JOIN 
    products p ON ci.product_id = p.id
WHERE 
    ci.quantity > p.stock
ORDER BY 
    u.name;

DELIMITER //
CREATE PROCEDURE add_to_cart(IN user_id_param INT, IN product_id_param INT, IN quantity_param INT)
BEGIN
    DECLARE cart_id_var INT;
    
    SELECT id INTO cart_id_var FROM carts WHERE user_id = user_id_param LIMIT 1;
    
    IF cart_id_var IS NULL THEN
        INSERT INTO carts (user_id) VALUES (user_id_param);
        SET cart_id_var = LAST_INSERT_ID();
    END IF;
    
    IF EXISTS (SELECT 1 FROM cart_items WHERE cart_id = cart_id_var AND product_id = product_id_param) THEN
        UPDATE cart_items 
        SET quantity = quantity + quantity_param,
            added_at = CURRENT_TIMESTAMP
        WHERE cart_id = cart_id_var AND product_id = product_id_param;
    ELSE
        INSERT INTO cart_items (cart_id, product_id, quantity) 
        VALUES (cart_id_var, product_id_param, quantity_param);
    END IF;
    
    SELECT 
        p.id AS product_id,
        p.name AS product_name,
        p.price AS unit_price,
        ci.quantity,
        ROUND(p.price * ci.quantity, 2) AS subtotal
    FROM 
        cart_items ci
    JOIN 
        products p ON ci.product_id = p.id
    WHERE 
        ci.cart_id = cart_id_var
    ORDER BY 
        p.name;
    
END //
DELIMITER ;

CALL add_to_cart(1, 6, 2);
CALL remove_from_cart(2, 7);

DELIMITER //
CREATE PROCEDURE remove_from_cart(IN user_id_param INT, IN product_id_param INT)
BEGIN
    DECLARE cart_id_var INT;
    
    SELECT id INTO cart_id_var FROM carts WHERE user_id = user_id_param LIMIT 1;
    
    IF cart_id_var IS NOT NULL THEN
        DELETE FROM cart_items 
        WHERE cart_id = cart_id_var AND product_id = product_id_param;
    END IF;
    
    SELECT 
        p.id AS product_id,
        p.name AS product_name,
        p.price AS unit_price,
        ci.quantity,
        ROUND(p.price * ci.quantity, 2) AS subtotal
    FROM 
        cart_items ci
    JOIN 
        products p ON ci.product_id = p.id
    WHERE 
        ci.cart_id = cart_id_var
    ORDER BY 
        p.name;
    
END //
DELIMITER ;