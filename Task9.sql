CREATE DATABASE appointment_scheduler;
USE appointment_scheduler;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    service_id INT,
    appointment_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id),
    UNIQUE (service_id, appointment_time)  -- Prevent time clashes for same service
);

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO services (name) VALUES
('Haircut'),
('Massage'),
('Dental Checkup');

INSERT INTO appointments (user_id, service_id, appointment_time) VALUES
(1, 1, '2025-07-16 09:00:00'),
(2, 2, '2025-07-16 10:00:00'),
(3, 3, '2025-07-16 11:00:00'),
(1, 2, '2025-07-16 12:00:00'),
(2, 1, '2025-07-16 13:00:00'),
(3, 2, '2025-07-16 14:00:00'),
(1, 3, '2025-07-16 15:00:00'),
(2, 3, '2025-07-16 16:00:00'),
(3, 1, '2025-07-16 17:00:00'),
(1, 1, '2025-07-17 09:00:00');


-- Query: Get appointments for a specific date
SELECT 
    a.id AS appointment_id,
    u.name AS user_name,
    s.name AS service_name,
    a.appointment_time
FROM appointments a
JOIN users u ON a.user_id = u.id
JOIN services s ON a.service_id = s.id
WHERE DATE(a.appointment_time) = '2025-07-15'
ORDER BY a.appointment_time;

-- Query: Get appointments for a specific service
SELECT 
    u.name AS user_name,
    a.appointment_time
FROM appointments a
JOIN users u ON a.user_id = u.id
WHERE a.service_id = 1
ORDER BY a.appointment_time;
