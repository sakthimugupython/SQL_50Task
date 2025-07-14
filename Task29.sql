CREATE DATABASE recruitment_portal;
USE recruitment_portal;

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    company VARCHAR(100)
);

CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE applications (
    job_id INT,
    candidate_id INT,
    status ENUM('APPLIED', 'INTERVIEWED', 'HIRED', 'REJECTED'),
    applied_at DATE,
    PRIMARY KEY (job_id, candidate_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

INSERT INTO jobs (title, company) VALUES
('Backend Developer', 'TechCorp'),
('UI Designer', 'CreativeX'),
('Data Analyst', 'InsightWorks');

INSERT INTO candidates (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

INSERT INTO applications (job_id, candidate_id, status, applied_at) VALUES
(1, 1, 'APPLIED', '2025-07-01'),
(1, 2, 'INTERVIEWED', '2025-07-02'),
(1, 3, 'HIRED', '2025-07-03'),
(2, 4, 'REJECTED', '2025-07-04'),
(2, 5, 'APPLIED', '2025-07-05'),
(2, 6, 'INTERVIEWED', '2025-07-06'),
(3, 7, 'APPLIED', '2025-07-07'),
(3, 8, 'INTERVIEWED', '2025-07-08'),
(3, 9, 'HIRED', '2025-07-09'),
(3, 10, 'REJECTED', '2025-07-10');

-- Query: Job-wise applicant count
SELECT 
    j.title,
    COUNT(a.candidate_id) AS applicant_count
FROM applications a
JOIN jobs j ON a.job_id = j.id
GROUP BY j.title;
