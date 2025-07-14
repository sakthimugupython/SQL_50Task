CREATE DATABASE freelance_management;
USE freelance_management;

-- Freelancers table
CREATE TABLE freelancers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    skill VARCHAR(100)
);

-- Projects table
CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100),
    title VARCHAR(200)
);

-- Proposals table
CREATE TABLE proposals (
    freelancer_id INT,
    project_id INT,
    bid_amount DECIMAL(10,2),
    status ENUM('PENDING', 'ACCEPTED', 'REJECTED'),
    FOREIGN KEY (freelancer_id) REFERENCES freelancers(id),
    FOREIGN KEY (project_id) REFERENCES projects(id),
    PRIMARY KEY (freelancer_id, project_id)
);

-- Insert freelancers
INSERT INTO freelancers (name, skill) VALUES
('Alice', 'Web Design'),
('Bob', 'Backend Development'),
('Charlie', 'Data Analysis'),
('David', 'SEO'),
('Eva', 'Mobile Apps'),
('Frank', 'Graphic Design'),
('Grace', 'Copywriting'),
('Helen', 'UI/UX'),
('Ivan', 'DevOps'),
('Julia', 'QA Testing');

-- Insert projects
INSERT INTO projects (client_name, title) VALUES
('Acme Inc.', 'Website Redesign'),
('Globex Corp.', 'Database Migration'),
('TechNova', 'Mobile App Launch'),
('FinSoft', 'Dashboard Analytics'),
('Marketify', 'SEO Optimization');

-- Insert proposals (10 rows)
INSERT INTO proposals (freelancer_id, project_id, bid_amount, status) VALUES
(1, 1, 1500.00, 'ACCEPTED'),
(2, 2, 2000.00, 'PENDING'),
(3, 4, 1800.00, 'REJECTED'),
(4, 5, 1200.00, 'ACCEPTED'),
(5, 3, 2200.00, 'PENDING'),
(6, 1, 1700.00, 'REJECTED'),
(7, 5, 1000.00, 'ACCEPTED'),
(8, 2, 1600.00, 'PENDING'),
(9, 3, 2500.00, 'ACCEPTED'),
(10, 4, 1100.00, 'REJECTED');

-- Query: Accepted proposals
SELECT 
    f.name AS freelancer,
    p.title AS project,
    pr.bid_amount
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
JOIN projects p ON pr.project_id = p.id
WHERE pr.status = 'ACCEPTED';

-- Query: Number of projects proposed per freelancer
SELECT 
    f.name,
    COUNT(*) AS proposals_submitted
FROM proposals pr
JOIN freelancers f ON pr.freelancer_id = f.id
GROUP BY f.name
ORDER BY proposals_submitted DESC;
