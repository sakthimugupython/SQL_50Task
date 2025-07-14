CREATE DATABASE employee_timesheets;
USE employee_timesheets;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dept VARCHAR(100)
);

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE timesheets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    project_id INT,
    hours DECIMAL(5,2),
    date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

INSERT INTO employees (name, dept) VALUES
('Alice', 'Engineering'),
('Bob', 'Design'),
('Charlie', 'Marketing');

INSERT INTO projects (name) VALUES
('Website Redesign'),
('Mobile App'),
('Social Media Campaign');

INSERT INTO timesheets (emp_id, project_id, hours, date) VALUES
(1, 1, 8.0, '2025-07-07'),
(1, 2, 4.5, '2025-07-08'),
(2, 1, 6.0, '2025-07-07'),
(2, 2, 5.0, '2025-07-09'),
(3, 3, 7.5, '2025-07-07');

-- Total hours per employee per project
SELECT 
    e.name AS employee,
    p.name AS project,
    SUM(t.hours) AS total_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
JOIN projects p ON t.project_id = p.id
GROUP BY e.name, p.name;

-- Weekly hours per employee (assuming current week starts 2025-07-07)
SELECT 
    e.name AS employee,
    SUM(t.hours) AS weekly_hours
FROM timesheets t
JOIN employees e ON t.emp_id = e.id
WHERE YEARWEEK(t.date, 1) = YEARWEEK(CURDATE(), 1)
GROUP BY e.name;

-- Monthly hours per project
SELECT 
    p.name AS project,
    SUM(t.hours) AS monthly_hours
FROM timesheets t
JOIN projects p ON t.project_id = p.id
WHERE MONTH(t.date) = MONTH(CURDATE()) AND YEAR(t.date) = YEAR(CURDATE())
GROUP BY p.name;
