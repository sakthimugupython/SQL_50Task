CREATE DATABASE attendance_tracker;
USE attendance_tracker;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE attendance (
    student_id INT,
    course_id INT,
    date DATE,
    status ENUM('PRESENT', 'ABSENT'),
    PRIMARY KEY (student_id, course_id, date),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO students (name) VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO courses (name) VALUES ('Math'), ('History');

INSERT INTO attendance (student_id, course_id, date, status) VALUES
(1, 1, '2025-07-10', 'PRESENT'),
(2, 1, '2025-07-10', 'ABSENT'),
(3, 2, '2025-07-10', 'PRESENT');

-- Attendance summary per student per course
SELECT 
    s.name AS student,
    c.name AS course,
    COUNT(*) AS total_classes,
    SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) AS attended
FROM attendance a
JOIN students s ON a.student_id = s.id
JOIN courses c ON a.course_id = c.id
GROUP BY s.name, c.name;
