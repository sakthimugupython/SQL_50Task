CREATE DATABASE expense_tracker;
USE expense_tracker;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE expenses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO categories (name) VALUES
('Food'), ('Transport'), ('Utilities'), ('Entertainment'), ('Shopping');

INSERT INTO expenses (user_id, category_id, amount, date) VALUES
(1, 1, 300.50, '2025-07-01'),
(1, 2, 100.00, '2025-07-03'),
(2, 3, 550.00, '2025-07-04'),
(2, 1, 150.75, '2025-07-05'),
(3, 4, 200.00, '2025-07-06'),
(3, 5, 120.00, '2025-07-07'),
(1, 3, 250.00, '2025-07-08'),
(2, 5, 180.50, '2025-07-08'),
(3, 2, 95.00, '2025-07-09'),
(1, 4, 60.00, '2025-07-10');

-- Aggregated spend per category
SELECT 
    c.name AS category,
    ROUND(SUM(e.amount), 2) AS total_spent
FROM expenses e
JOIN categories c ON e.category_id = c.id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Monthly expenses filtered by amount
SELECT 
    u.name AS user_name,
    e.amount,
    e.date,
    c.name AS category
FROM expenses e
JOIN users u ON e.user_id = u.id
JOIN categories c ON e.category_id = c.id
WHERE MONTH(e.date) = 7 AND YEAR(e.date) = 2025 AND e.amount BETWEEN 100 AND 300
ORDER BY e.date;
