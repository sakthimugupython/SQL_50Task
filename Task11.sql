CREATE DATABASE course_enrollment;
USE course_enrollment;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    instructor VARCHAR(100)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE enrollments (
    course_id INT,
    student_id INT,
    enroll_date DATE,
    PRIMARY KEY (course_id, student_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Sample courses
INSERT INTO courses (title, instructor) VALUES
('Data Structures', 'Dr. Smith'),
('Web Development', 'Prof. Allen'),
('Database Systems', 'Dr. Kiran'),
('AI & ML', 'Prof. Rao'),
('Cybersecurity', 'Dr. Mehta');

-- Sample students
INSERT INTO students (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com'),
('David', 'david@example.com'),
('Eva', 'eva@example.com'),
('Frank', 'frank@example.com'),
('Grace', 'grace@example.com'),
('Helen', 'helen@example.com'),
('Ivan', 'ivan@example.com'),
('Julia', 'julia@example.com');

-- Sample enrollments
INSERT INTO enrollments (course_id, student_id, enroll_date) VALUES
(1, 1, '2025-07-01'),
(1, 2, '2025-07-02'),
(2, 3, '2025-07-03'),
(2, 4, '2025-07-03'),
(3, 5, '2025-07-04'),
(3, 6, '2025-07-05'),
(4, 7, '2025-07-06'),
(4, 8, '2025-07-06'),
(5, 9, '2025-07-07'),
(5, 10, '2025-07-08');

-- Query: Get students enrolled in each course
SELECT 
    c.title AS course_title,
    s.name AS student_name,
    s.email,
    e.enroll_date
FROM enrollments e
JOIN courses c ON e.course_id = c.id
JOIN students s ON e.student_id = s.id
ORDER BY c.title, e.enroll_date;

-- Query: Count of enrolled students per course
SELECT 
    c.title AS course_title,
    COUNT(e.student_id) AS total_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.title
ORDER BY total_enrolled DESC;
