CREATE DATABASE health_records;
USE health_records;

CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE
);

CREATE TABLE prescriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE medications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE prescription_details (
    prescription_id INT,
    medication_id INT,
    dosage VARCHAR(100),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id),
    FOREIGN KEY (medication_id) REFERENCES medications(id)
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

-- Sample medications
INSERT INTO medications (name) VALUES
('Paracetamol'),
('Ibuprofen'),
('Amoxicillin'),
('Metformin'),
('Lisinopril'),
('Cetirizine'),
('Atorvastatin'),
('Omeprazole'),
('Azithromycin'),
('Amlodipine');

-- Sample prescriptions
INSERT INTO prescriptions (patient_id, date) VALUES
(1, '2025-07-10'),
(2, '2025-07-11'),
(3, '2025-07-12'),
(4, '2025-07-13'),
(5, '2025-07-14'),
(6, '2025-07-15'),
(7, '2025-07-16'),
(8, '2025-07-17'),
(9, '2025-07-18'),
(10, '2025-07-19');

-- Sample prescription details
INSERT INTO prescription_details (prescription_id, medication_id, dosage) VALUES
(1, 1, '500mg twice daily'),
(1, 2, '200mg once daily'),
(2, 3, '250mg three times daily'),
(3, 4, '500mg before meals'),
(4, 5, '10mg once daily'),
(5, 6, '5mg at bedtime'),
(6, 7, '20mg every morning'),
(7, 8, '40mg daily'),
(8, 9, '500mg once daily'),
(9, 10, '10mg twice daily');

-- Query: Get prescriptions for a specific patient
SELECT 
    p.name AS patient_name,
    pr.date AS prescription_date,
    m.name AS medication_name,
    pd.dosage
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE p.id = 1
ORDER BY pr.date;

-- Query: Filter prescriptions by date range
SELECT 
    p.name AS patient_name,
    pr.date AS prescription_date,
    m.name AS medication_name,
    pd.dosage
FROM prescriptions pr
JOIN patients p ON pr.patient_id = p.id
JOIN prescription_details pd ON pr.id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.id
WHERE pr.date BETWEEN '2025-07-10' AND '2025-07-15'
ORDER BY pr.date, p.name;
