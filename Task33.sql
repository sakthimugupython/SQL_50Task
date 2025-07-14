CREATE DATABASE asset_management;
USE asset_management;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE assets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    category VARCHAR(100)
);

CREATE TABLE assignments (
    asset_id INT,
    user_id INT,
    assigned_date DATE,
    returned_date DATE,
    PRIMARY KEY (asset_id, user_id, assigned_date),
    FOREIGN KEY (asset_id) REFERENCES assets(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample assets
INSERT INTO assets (name, category) VALUES
('Laptop A', 'Electronics'),
('Monitor B', 'Electronics'),
('Chair C', 'Furniture'),
('Keyboard D', 'Electronics'),
('Phone E', 'Electronics'),
('Desk F', 'Furniture'),
('Tablet G', 'Electronics'),
('Headphones H', 'Accessories'),
('Camera I', 'Electronics'),
('Mouse J', 'Accessories');

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample assignments
INSERT INTO assignments (asset_id, user_id, assigned_date, returned_date) VALUES
(1, 1, '2025-07-01', NULL),
(2, 2, '2025-07-01', '2025-07-10'),
(3, 3, '2025-07-02', NULL),
(4, 4, '2025-07-03', NULL),
(5, 5, '2025-07-03', '2025-07-09'),
(6, 6, '2025-07-04', NULL),
(7, 7, '2025-07-04', NULL),
(8, 8, '2025-07-05', NULL),
(9, 9, '2025-07-05', '2025-07-08'),
(10, 10, '2025-07-06', NULL);

-- Query: Currently assigned assets
SELECT 
    a.name AS asset,
    a.category,
    u.name AS assigned_to,
    ass.assigned_date
FROM assignments ass
JOIN assets a ON ass.asset_id = a.id
JOIN users u ON ass.user_id = u.id
WHERE ass.returned_date IS NULL;
