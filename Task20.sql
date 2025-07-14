CREATE DATABASE salary_management;
USE salary_management;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE salaries (
    emp_id INT,
    month DATE,
    base DECIMAL(10,2),
    bonus DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

CREATE TABLE deductions (
    emp_id INT,
    month DATE,
    reason VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(id)
);

-- Sample Employees
INSERT INTO employees (name) VALUES
('Alice'), ('Bob'), ('Charlie');

-- Sample Salaries
INSERT INTO salaries (emp_id, month, base, bonus) VALUES
(1, '2025-07-01', 50000, 5000),
(2, '2025-07-01', 60000, 3000),
(3, '2025-07-01', 55000, 7000);

-- Sample Deductions
INSERT INTO deductions (emp_id, month, reason, amount) VALUES
(1, '2025-07-01', 'Late Attendance', 1000),
(2, '2025-07-01', 'Leave Without Pay', 2000),
(3, '2025-07-01', 'Policy Violation', 1500);

-- Query: Net salary per employee for the month
SELECT 
    e.name AS employee_name,
    s.base,
    s.bonus,
    COALESCE(SUM(d.amount), 0) AS total_deductions,
    ROUND(s.base + s.bonus - COALESCE(SUM(d.amount), 0), 2) AS net_salary
FROM salaries s
JOIN employees e ON s.emp_id = e.id
LEFT JOIN deductions d ON s.emp_id = d.emp_id AND s.month = d.month
GROUP BY e.name, s.base, s.bonus, s.month
ORDER BY net_salary DESC;
