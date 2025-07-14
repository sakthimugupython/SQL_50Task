CREATE DATABASE hospital_tracker;
USE hospital_tracker;

CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE doctors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE visits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    visit_time DATETIME,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    UNIQUE (doctor_id, visit_time)  -- Prevent overlapping doctor visits
);

-- Sample patients
INSERT INTO patients (name, dob) VALUES
('Alice', '1988-03-21'),
('Bob', '1990-07-16'),
('Charlie', '1985-01-12'),
('David', '1992-05-05'),
('Eva', '1989-11-09'),
('Frank', '1986-12-30'),
('Grace', '1991-04-18'),
('Helen', '1993-06-25'),
('Ivan', '1987-09-14'),
('Julia', '1995-08-03');

-- Sample doctors
INSERT INTO doctors (name, specialization) VALUES
('Dr. Smith', 'Cardiology'),
('Dr. Allen', 'Dermatology'),
('Dr. Kiran', 'Neurology'),
('Dr. Mehta', 'Orthopedics'),
('Dr. Rao', 'Pediatrics');

-- Sample visits
INSERT INTO visits (patient_id, doctor_id, visit_time) VALUES
(1, 1, '2025-07-14 09:00:00'),
(2, 2, '2025-07-14 10:00:00'),
(3, 3, '2025-07-14 11:00:00'),
(4, 1, '2025-07-14 12:00:00'),
(5, 2, '2025-07-14 13:00:00'),
(6, 3, '2025-07-14 14:00:00'),
(7, 4, '2025-07-14 15:00:00'),
(8, 4, '2025-07-14 16:00:00'),
(9, 5, '2025-07-14 17:00:00'),
(10, 5, '2025-07-15 09:00:00');

-- Query: Patients visiting a specific doctor on a given date
SELECT 
    d.name AS doctor_name,
    p.name AS patient_name,
    v.visit_time
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
JOIN patients p ON v.patient_id = p.id
WHERE v.doctor_id = 1 AND DATE(v.visit_time) = '2025-07-14'
ORDER BY v.visit_time;

-- Query: All visits grouped by doctor and day
SELECT 
    d.name AS doctor_name,
    DATE(v.visit_time) AS visit_date,
    COUNT(*) AS total_visits
FROM visits v
JOIN doctors d ON v.doctor_id = d.id
GROUP BY d.name, DATE(v.visit_time)
ORDER BY visit_date, doctor_name;
