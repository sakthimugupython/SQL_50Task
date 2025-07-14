CREATE DATABASE subscription_tracker;
USE subscription_tracker;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE subscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan_name VARCHAR(50),
    start_date DATE,
    renewal_cycle INT, -- days
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample subscriptions
INSERT INTO subscriptions (user_id, plan_name, start_date, renewal_cycle) VALUES
(1, 'Basic', '2025-07-01', 30),
(2, 'Premium', '2025-06-10', 30),
(3, 'Standard', '2025-07-12', 15),
(4, 'Basic', '2025-06-25', 30),
(5, 'Premium', '2025-07-03', 30),
(6, 'Standard', '2025-07-04', 15),
(7, 'Basic', '2025-06-20', 30),
(8, 'Premium', '2025-06-30', 30),
(9, 'Standard', '2025-07-07', 15),
(10, 'Basic', '2025-07-05', 30);

-- Query: Expired subscriptions as of 2025-07-15
SELECT 
    u.name,
    s.plan_name,
    s.start_date,
    s.renewal_cycle,
    DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) AS next_renewal
FROM subscriptions s
JOIN users u ON s.user_id = u.id
WHERE DATE_ADD(s.start_date, INTERVAL s.renewal_cycle DAY) < '2025-07-15';

