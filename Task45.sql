CREATE DATABASE job_scheduler;
USE job_scheduler;

-- Table: Jobs
CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    frequency VARCHAR(20) -- e.g., 'daily', 'hourly', 'weekly'
);

-- Table: Job Logs
CREATE TABLE job_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_id INT,
    run_time DATETIME,
    status ENUM('SUCCESS', 'FAILED', 'SKIPPED'),
    FOREIGN KEY (job_id) REFERENCES jobs(id)
);

-- Sample Jobs (10 entries)
INSERT INTO jobs (name, frequency) VALUES
('Backup DB', 'daily'),
('Sync Analytics', 'hourly'),
('Clear Temp Files', 'daily'),
('Process Emails', 'hourly'),
('Generate Reports', 'weekly'),
('Sync Inventory', 'daily'),
('Send Reminders', 'hourly'),
('Update Dashboard', 'hourly'),
('Refresh Cache', 'daily'),
('Clean Old Logs', 'weekly');

-- Sample Job Logs (10+ entries)
INSERT INTO job_logs (job_id, run_time, status) VALUES
(1, '2025-07-14 01:00', 'SUCCESS'),
(2, '2025-07-14 02:00', 'FAILED'),
(3, '2025-07-14 03:00', 'SUCCESS'),
(4, '2025-07-14 04:00', 'SUCCESS'),
(5, '2025-07-14 05:00', 'SKIPPED'),
(6, '2025-07-14 06:00', 'SUCCESS'),
(7, '2025-07-14 07:00', 'FAILED'),
(8, '2025-07-14 08:00', 'SUCCESS'),
(9, '2025-07-14 09:00', 'SKIPPED'),
(10, '2025-07-14 10:00', 'SUCCESS'),
(1, '2025-07-15 01:00', 'SUCCESS'),
(2, '2025-07-15 02:00', 'SUCCESS'),
(5, '2025-07-15 05:00', 'SUCCESS');

-- Query: Last run per job
SELECT 
    j.name AS job_name,
    MAX(l.run_time) AS last_run
FROM job_logs l
JOIN jobs j ON l.job_id = j.id
GROUP BY j.name
ORDER BY last_run DESC;

-- Query: Status count per job
SELECT 
    j.name AS job_name,
    l.status,
    COUNT(*) AS status_count
FROM job_logs l
JOIN jobs j ON l.job_id = j.id
GROUP BY j.name, l.status
ORDER BY j.name, l.status;

-- Optional: Next run calculation for daily jobs
-- You can simulate next run using last run + interval
SELECT 
    j.name,
    j.frequency,
    MAX(l.run_time) AS last_run,
    CASE 
        WHEN j.frequency = 'daily' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 DAY)
        WHEN j.frequency = 'hourly' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 HOUR)
        WHEN j.frequency = 'weekly' THEN DATE_ADD(MAX(l.run_time), INTERVAL 1 WEEK)
        ELSE NULL
    END AS next_run
FROM job_logs l
JOIN jobs j ON l.job_id = j.id
GROUP BY j.id, j.name, j.frequency;
