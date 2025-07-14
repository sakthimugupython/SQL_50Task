CREATE DATABASE support_system;
USE support_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    issue VARCHAR(200),
    category VARCHAR(100),
    status ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED'),
    created_at DATETIME,
    resolved_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE support_staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE assignments (
    ticket_id INT,
    staff_id INT,
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(id),
    FOREIGN KEY (staff_id) REFERENCES support_staff(id)
);

-- Sample data
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

INSERT INTO support_staff (name) VALUES
('Tech1'), ('Tech2'), ('Tech3');

INSERT INTO tickets (user_id, issue, category, status, created_at, resolved_at) VALUES
(1, 'Laptop crash', 'Hardware', 'RESOLVED', '2025-07-01 09:00', '2025-07-01 12:00'),
(2, 'Email not working', 'Software', 'RESOLVED', '2025-07-02 10:00', '2025-07-02 13:00'),
(3, 'Slow internet', 'Network', 'IN_PROGRESS', '2025-07-03 08:30', NULL),
(4, 'Screen flicker', 'Hardware', 'OPEN', '2025-07-04 11:00', NULL),
(5, 'Cannot access VPN', 'Network', 'RESOLVED', '2025-07-05 09:00', '2025-07-05 10:30'),
(6, 'Password reset', 'Software', 'RESOLVED', '2025-07-06 12:00', '2025-07-06 12:20'),
(7, 'Printer offline', 'Hardware', 'RESOLVED', '2025-07-06 13:00', '2025-07-06 14:00'),
(8, 'App crashing', 'Software', 'OPEN', '2025-07-07 08:00', NULL),
(9, 'Connection drops', 'Network', 'IN_PROGRESS', '2025-07-07 09:00', NULL),
(10, 'System freeze', 'Hardware', 'RESOLVED', '2025-07-08 10:00', '2025-07-08 11:30');

INSERT INTO assignments (ticket_id, staff_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 1), (5, 2),
(6, 3), (7, 1), (8, 2), (9, 3), (10, 1);

-- Query: Average resolution time in hours
SELECT 
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, created_at, resolved_at))/60, 2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL;

-- Query: Ticket volume by category
SELECT 
    category,
    COUNT(*) AS ticket_count
FROM tickets
GROUP BY category;
