CREATE DATABASE bank_transactions;
USE bank_transactions;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    type ENUM('DEPOSIT', 'WITHDRAWAL'),
    amount DECIMAL(10,2),
    timestamp DATETIME,
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

INSERT INTO users (name) VALUES
('Alice'), ('Bob');

INSERT INTO accounts (user_id, balance) VALUES
(1, 5000.00), (2, 7500.00);

INSERT INTO transactions (account_id, type, amount, timestamp) VALUES
(1, 'DEPOSIT', 2000.00, '2025-07-01 09:00:00'),
(1, 'WITHDRAWAL', 1500.00, '2025-07-02 10:00:00'),
(2, 'DEPOSIT', 1000.00, '2025-07-03 11:00:00'),
(2, 'WITHDRAWAL', 1200.00, '2025-07-04 12:00:00');

-- Current balance using CTE
WITH txn_summary AS (
    SELECT 
        account_id,
        SUM(CASE WHEN type = 'DEPOSIT' THEN amount ELSE -amount END) AS txn_net
    FROM transactions
    GROUP BY account_id
)
SELECT 
    u.name AS user_name,
    a.id AS account_id,
    a.balance AS initial_balance,
    t.txn_net,
    a.balance + t.txn_net AS updated_balance
FROM accounts a
JOIN users u ON a.user_id = u.id
JOIN txn_summary t ON a.id = t.account_id;
