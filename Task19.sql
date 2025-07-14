CREATE DATABASE loan_tracker;
USE loan_tracker;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE loans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    principal DECIMAL(10,2),
    interest_rate DECIMAL(4,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    amount DECIMAL(10,2),
    paid_on DATE,
    FOREIGN KEY (loan_id) REFERENCES loans(id)
);

-- Sample Users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

-- Sample Loans
INSERT INTO loans (user_id, principal, interest_rate) VALUES
(1, 10000, 5.5),
(2, 15000, 6.2),
(3, 12000, 4.9);

-- Sample Payments
INSERT INTO payments (loan_id, amount, paid_on) VALUES
(1, 2000, '2025-07-01'),
(1, 1500, '2025-07-10'),
(2, 3000, '2025-07-05'),
(3, 1000, '2025-07-06'),
(2, 2500, '2025-07-08'),
(1, 1200, '2025-07-12'),
(3, 2000, '2025-07-09'),
(2, 2000, '2025-07-14'),
(1, 1000, '2025-07-16'),
(3, 1800, '2025-07-18');

-- Query: Loan repayment summary
SELECT 
    u.name AS user_name,
    l.id AS loan_id,
    l.principal,
    ROUND(SUM(p.amount), 2) AS total_paid,
    ROUND(l.principal - SUM(p.amount), 2) AS balance_due
FROM loans l
JOIN users u ON l.user_id = u.id
LEFT JOIN payments p ON l.id = p.loan_id
GROUP BY l.id, u.name, l.principal;
