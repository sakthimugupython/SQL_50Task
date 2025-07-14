CREATE DATABASE complaint_system;
USE complaint_system;

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE complaints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    department_id INT,
    status ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED'),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE responses (
    complaint_id INT,
    responder_id INT,
    message TEXT,
    PRIMARY KEY (complaint_id, responder_id),
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

-- Sample Departments
INSERT INTO departments (name) VALUES
('Water Supply'), ('Sanitation'), ('Electricity'),
('Road Maintenance'), ('Health'), ('Education'),
('Public Safety'), ('Parks & Recreation'), ('Transport'), ('Waste Management');

-- Sample Complaints
INSERT INTO complaints (title, department_id, status) VALUES
('Water leakage', 1, 'OPEN'),
('Street light out', 3, 'IN_PROGRESS'),
('Pothole on Main St', 4, 'RESOLVED'),
('Broken sewer pipe', 2, 'OPEN'),
('Overflowing trash', 10, 'IN_PROGRESS'),
('Noisy generator', 7, 'OPEN'),
('Broken bench', 8, 'RESOLVED'),
('Unhygienic clinic', 5, 'IN_PROGRESS'),
('Unsafe crossing', 9, 'OPEN'),
('School toilet issue', 6, 'RESOLVED');

-- Sample Responses
INSERT INTO responses (complaint_id, responder_id, message) VALUES
(1, 101, 'Inspection scheduled.'),
(2, 102, 'Technician dispatched.'),
(3, 103, 'Resolved on site.'),
(4, 104, 'Maintenance team alerted.'),
(5, 105, 'Cleaning in progress.'),
(6, 106, 'Noise limit under review.'),
(7, 107, 'Replaced furniture.'),
(8, 108, 'Sanitation inspected.'),
(9, 109, 'Barrier installation proposed.'),
(10, 110, 'Restroom fixed.');

-- Status summary per department
SELECT 
    d.name AS department,
    c.status,
    COUNT(*) AS complaint_count
FROM complaints c
JOIN departments d ON c.department_id = d.id
GROUP BY d.name, c.status;

-- Department workload
SELECT 
    d.name AS department,
    COUNT(c.id) AS total_complaints
FROM complaints c
JOIN departments d ON c.department_id = d.id
GROUP BY d.name
ORDER BY total_complaints DESC;
