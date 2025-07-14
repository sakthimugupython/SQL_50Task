CREATE DATABASE course_progress;
USE course_progress;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE lessons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    title VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE progress (
    student_id INT,
    lesson_id INT,
    completed_at DATE,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (lesson_id) REFERENCES lessons(id)
);

INSERT INTO courses (name) VALUES ('Advanced SQL');

INSERT INTO lessons (course_id, title) VALUES
(1, 'Intro'), (1, 'Joins'), (1, 'Subqueries'), (1, 'CTEs'),
(1, 'Window Functions'), (1, 'Triggers'), (1, 'Indexes'), (1, 'Stored Procedures'),
(1, 'Transactions'), (1, 'Performance Tuning');

INSERT INTO students (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO progress (student_id, lesson_id, completed_at) VALUES
(1, 1, '2025-07-01'),
(1, 2, '2025-07-02'),
(1, 3, '2025-07-03'),
(1, 4, '2025-07-04'),
(2, 1, '2025-07-01'),
(2, 2, '2025-07-02'),
(2, 3, '2025-07-03'),
(3, 1, '2025-07-01'),
(3, 2, '2025-07-02'),
(3, 3, '2025-07-03');

-- Query: Completion %
SELECT 
    s.name AS student,
    COUNT(p.lesson_id) AS completed_lessons,
    (SELECT COUNT(*) FROM lessons) AS total_lessons,
    ROUND(COUNT(p.lesson_id) * 100 / (SELECT COUNT(*) FROM lessons), 2) AS completion_pct
FROM progress p
JOIN students s ON p.student_id = s.id
GROUP BY s.name;
