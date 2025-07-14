CREATE DATABASE sales_crm;
USE sales_crm;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE leads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    source VARCHAR(100)
);

CREATE TABLE deals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    lead_id INT,
    user_id INT,
    stage ENUM('NEW', 'CONTACTED', 'PROPOSAL', 'WON', 'LOST'),
    amount DECIMAL(10,2),
    created_at DATETIME,
    FOREIGN KEY (lead_id) REFERENCES leads(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample data
INSERT INTO users (name) VALUES
('Alice'),
('Bob');

INSERT INTO leads (name, source) VALUES
('Acme Inc.', 'Website'),
('Globex Corp.', 'Referral');

INSERT INTO deals (lead_id, user_id, stage, amount, created_at) VALUES
(1, 1, 'NEW', 5000.00, '2025-07-01 10:00:00'),
(1, 1, 'CONTACTED', 5000.00, '2025-07-02 12:00:00'),
(1, 1, 'PROPOSAL', 5000.00, '2025-07-03 14:00:00'),
(2, 2, 'NEW', 3000.00, '2025-07-04 09:00:00'),
(2, 2, 'CONTACTED', 3000.00, '2025-07-05 11:00:00'),
(2, 2, 'WON', 3000.00, '2025-07-06 13:00:00');

-- Query: Latest stage per lead using window function
SELECT *
FROM (
    SELECT 
        d.id AS deal_id,
        l.name AS lead_name,
        d.stage,
        d.amount,
        d.created_at,
        ROW_NUMBER() OVER (PARTITION BY d.lead_id ORDER BY d.created_at DESC) AS rn
    FROM deals d
    JOIN leads l ON d.lead_id = l.id
) recent_deals
WHERE rn = 1;

-- Filter deals by stage and date range
SELECT 
    d.id,
    u.name AS user_name,
    l.name AS lead_name,
    d.stage,
    d.amount,
    d.created_at
FROM deals d
JOIN users u ON d.user_id = u.id
JOIN leads l ON d.lead_id = l.id
WHERE d.stage = 'WON'
  AND d.created_at BETWEEN '2025-07-01' AND '2025-07-31'
ORDER BY d.created_at DESC;
