CREATE DATABASE food_delivery;
USE food_delivery;

CREATE TABLE restaurants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE delivery_agents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    user_id INT,
    placed_at DATETIME,
    delivered_at DATETIME,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE deliveries (
    order_id INT,
    agent_id INT,
    PRIMARY KEY (order_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(id)
);

-- Sample restaurants
INSERT INTO restaurants (name) VALUES
('Pizza Palace'), ('Burger Hub'), ('Sushi Zone');

-- Sample agents
INSERT INTO delivery_agents (name) VALUES
('John'), ('Mike'), ('Sara');

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample orders
INSERT INTO orders (restaurant_id, user_id, placed_at, delivered_at) VALUES
(1, 1, '2025-07-01 12:00', '2025-07-01 12:35'),
(2, 2, '2025-07-01 13:00', '2025-07-01 13:25'),
(3, 3, '2025-07-01 14:00', '2025-07-01 14:45'),
(1, 4, '2025-07-01 15:00', '2025-07-01 15:30'),
(2, 5, '2025-07-01 16:00', '2025-07-01 16:20'),
(3, 6, '2025-07-01 17:00', '2025-07-01 17:50'),
(1, 7, '2025-07-01 18:00', '2025-07-01 18:40'),
(2, 8, '2025-07-01 19:00', '2025-07-01 19:30'),
(3, 9, '2025-07-01 20:00', '2025-07-01 20:45'),
(1, 10, '2025-07-01 21:00', '2025-07-01 21:35');

INSERT INTO deliveries (order_id, agent_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 1), (5, 2),
(6, 3), (7, 1), (8, 2), (9, 3), (10, 1);

-- Query: Delivery time per order
SELECT 
    o.id AS order_id,
    TIMESTAMPDIFF(MINUTE, o.placed_at, o.delivered_at) AS delivery_minutes
FROM orders o;

-- Query: Agent delivery count
SELECT 
    da.name AS agent,
    COUNT(*) AS deliveries_handled
FROM deliveries d
JOIN delivery_agents da ON d.agent_id = da.id
GROUP BY da.name;
