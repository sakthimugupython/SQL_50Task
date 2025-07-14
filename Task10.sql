CREATE DATABASE project_management;
USE project_management;

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    name VARCHAR(100),
    status ENUM('TODO', 'IN_PROGRESS', 'COMPLETED', 'BLOCKED'),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE task_assignments (
    task_id INT,
    user_id INT,
    PRIMARY KEY (task_id, user_id),
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample Data
INSERT INTO projects (name) VALUES
('Website Redesign'),
('App Launch');

INSERT INTO tasks (project_id, name, status) VALUES
(1, 'Design Homepage', 'IN_PROGRESS'),
(1, 'Write Content', 'TODO'),
(1, 'Setup Hosting', 'BLOCKED'),
(2, 'Create Screenshots', 'COMPLETED'),
(2, 'Build App Store Listing', 'TODO'),
(2, 'QA Testing', 'IN_PROGRESS'),
(2, 'Marketing Plan', 'TODO'),
(1, 'Feedback Round 1', 'TODO'),
(2, 'Bug Fixing Sprint', 'BLOCKED'),
(1, 'Finalize Layout', 'COMPLETED');

INSERT INTO users (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO task_assignments (task_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 2),
(5, 1),
(6, 3),
(7, 1),
(8, 2),
(9, 3),
(10, 1);

-- Query 1: Task counts per project by status
SELECT 
    p.name AS project_name,
    t.status,
    COUNT(*) AS task_count
FROM tasks t
JOIN projects p ON t.project_id = p.id
GROUP BY p.name, t.status
ORDER BY p.name, FIELD(t.status, 'TODO', 'IN_PROGRESS', 'COMPLETED', 'BLOCKED');

-- Query 2: Tasks assigned to each user
SELECT 
    u.name AS user_name,
    t.name AS task_name,
    t.status,
    p.name AS project_name
FROM task_assignments ta
JOIN users u ON ta.user_id = u.id
JOIN tasks t ON ta.task_id = t.id
JOIN projects p ON t.project_id = p.id
ORDER BY u.name, t.status;

-- Query 3: Count of tasks per user
SELECT 
    u.name AS user_name,
    COUNT(*) AS total_tasks
FROM task_assignments ta
JOIN users u ON ta.user_id = u.id
GROUP BY u.name;
