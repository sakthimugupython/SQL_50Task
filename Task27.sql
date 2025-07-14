CREATE DATABASE notification_system;
USE notification_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE notifications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT,
    status ENUM('UNREAD', 'READ'),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO notifications (user_id, message, status, created_at) VALUES
(1, 'Welcome!', 'UNREAD', NOW()),
(2, 'New Feature!', 'UNREAD', NOW()),
(3, 'Scheduled Maintenance', 'READ', NOW()),
(1, 'Profile Updated', 'READ', NOW()),
(2, 'Reminder', 'UNREAD', NOW()),
(3, 'Verification Email', 'UNREAD', NOW()),
(1, 'Feedback Request', 'UNREAD', NOW()),
(2, 'Message from Admin', 'READ', NOW()),
(3, 'Promotion Alert', 'UNREAD', NOW()),
(1, 'System Update Notice', 'UNREAD', NOW());

-- Query: Unread count per user
SELECT 
    u.name,
    COUNT(n.id) AS unread_count
FROM notifications n
JOIN users u ON n.user_id = u.id
WHERE n.status = 'UNREAD'
GROUP BY u.name;
