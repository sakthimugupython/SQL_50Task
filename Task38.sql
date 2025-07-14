CREATE DATABASE qr_entry_log;
USE qr_entry_log;

-- Table: Locations
CREATE TABLE locations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Table: Users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Table: Entry Logs
CREATE TABLE entry_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    location_id INT,
    entry_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (location_id) REFERENCES locations(id)
);

-- Sample Locations
INSERT INTO locations (name) VALUES
('Main Gate'),
('Conference Hall'),
('Cafeteria'),
('Server Room'),
('Reception');

-- Sample Users
INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('David'),
('Eva'),
('Frank'),
('Grace'),
('Helen'),
('Ivan'),
('Julia');

-- Sample Entry Logs (10 entries)
INSERT INTO entry_logs (user_id, location_id, entry_time) VALUES
(1, 1, '2025-07-10 08:55:00'),
(2, 2, '2025-07-10 09:05:00'),
(3, 3, '2025-07-10 09:10:00'),
(4, 1, '2025-07-10 09:15:00'),
(5, 4, '2025-07-10 09:20:00'),
(6, 2, '2025-07-10 09:25:00'),
(7, 3, '2025-07-10 09:30:00'),
(8, 1, '2025-07-10 09:35:00'),
(9, 5, '2025-07-10 09:40:00'),
(10, 2, '2025-07-10 09:45:00');

-- Query: Count entries per location
SELECT 
    l.name AS location_name,
    COUNT(e.id) AS total_entries
FROM entry_logs e
JOIN locations l ON e.location_id = l.id
GROUP BY l.name
ORDER BY total_entries DESC;

-- Query: Filter logs by date/time range
-- Example: Entries between 09:00 and 09:30 on 2025-07-10
SELECT 
    u.name AS user_name,
    l.name AS location_name,
    e.entry_time
FROM entry_logs e
JOIN users u ON e.user_id = u.id
JOIN locations l ON e.location_id = l.id
WHERE e.entry_time BETWEEN '2025-07-10 09:00:00' AND '2025-07-10 09:30:00'
ORDER BY e.entry_time;
