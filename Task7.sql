CREATE DATABASE leave_management;
USE leave_management;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE leave_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

CREATE TABLE leave_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    leave_type_id INT,
    from_date DATE,
    to_date DATE,
    status ENUM('PENDING', 'APPROVED', 'REJECTED'),
    FOREIGN KEY (emp_id) REFERENCES employees(id),
    FOREIGN KEY (leave_type_id) REFERENCES leave_types(id)
);

INSERT INTO employees (name) VALUES
('Alice'),
('Bob'),
('Charlie');

INSERT INTO leave_types (type_name) VALUES
('Annual Leave'),
('Sick Leave'),
('Casual Leave');

INSERT INTO leave_requests (emp_id, leave_type_id, from_date, to_date, status) VALUES
(1, 1, '2025-07-10', '2025-07-12', 'APPROVED'),
(1, 2, '2025-07-14', '2025-07-14', 'PENDING'),
(2, 1, '2025-07-08', '2025-07-10', 'APPROVED'),
(3, 3, '2025-07-15', '2025-07-16', 'REJECTED');

-- Query: Aggregate leaves (approved) by employee
SELECT 
    e.name AS employee_name,
    lt.type_name AS leave_type,
    SUM(DATEDIFF(lr.to_date, lr.from_date) + 1) AS total_days
FROM leave_requests lr
JOIN employees e ON lr.emp_id = e.id
JOIN leave_types lt ON lr.leave_type_id = lt.id
WHERE lr.status = 'APPROVED'
GROUP BY e.name, lt.type_name;

-- Optional: Prevent overlapping approved leave requests with a BEFORE INSERT trigger
DELIMITER //

CREATE TRIGGER prevent_overlap_before_insert
BEFORE INSERT ON leave_requests
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    SELECT COUNT(*) INTO overlap_count
    FROM leave_requests
    WHERE emp_id = NEW.emp_id
      AND status = 'APPROVED'
      AND (
          (NEW.from_date BETWEEN from_date AND to_date)
          OR (NEW.to_date BETWEEN from_date AND to_date)
          OR (from_date BETWEEN NEW.from_date AND NEW.to_date)
      );
    
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Overlapping approved leave already exists.';
    END IF;
END;
//

DELIMITER ;
