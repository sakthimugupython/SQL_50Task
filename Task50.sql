CREATE DATABASE event_management;
USE event_management;

CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    max_capacity INT
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE attendees (
    event_id INT,
    user_id INT,
    registered_at DATETIME,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Events
INSERT INTO events (title, max_capacity) VALUES
('Tech Expo', 100),
('Startup Hackathon', 50),
('Design Bootcamp', 80),
('AI Conference', 60),
('Marketing Meetup', 30);

-- Users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Attendees
INSERT INTO attendees (event_id, user_id, registered_at) VALUES
(2, 1, '2025-07-15 09:00'),
(2, 2, '2025-07-15 09:02'),
(2, 3, '2025-07-15 09:04'),
(2, 4, '2025-07-15 09:06'),
(2, 5, '2025-07-15 09:08'),
(2, 6, '2025-07-15 09:10'),
(2, 7, '2025-07-15 09:12'),
(2, 8, '2025-07-15 09:14'),
(2, 9, '2025-07-15 09:16'),
(2, 10, '2025-07-15 09:18');

-- Query: Event participant count
SELECT 
    e.title,
    COUNT(a.user_id) AS participants,
    e.max_capacity,
    ROUND(COUNT(a.user_id) * 100 / e.max_capacity, 1) AS fill_percent
FROM attendees a
JOIN events e ON a.event_id = e.id
GROUP BY e.id, e.title, e.max_capacity
ORDER BY fill_percent DESC;

-- Query: Events >80% capacity
SELECT 
    e.title,
    COUNT(a.user_id) AS participants,
    e.max_capacity,
    ROUND(COUNT(a.user_id) * 100 / e.max_capacity, 1) AS fill_percent
FROM attendees a
JOIN events e ON a.event_id = e.id
GROUP BY e.id, e.title, e.max_capacity
HAVING COUNT(a.user_id) * 100 / e.max_capacity >= 80
ORDER BY fill_percent DESC;

