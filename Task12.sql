CREATE DATABASE online_exam;
USE online_exam;

CREATE TABLE exams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    date DATE
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT,
    text TEXT,
    correct_option CHAR(1),
    FOREIGN KEY (exam_id) REFERENCES exams(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE student_answers (
    student_id INT,
    question_id INT,
    selected_option CHAR(1),
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Sample Data
INSERT INTO exams (course_id, date) VALUES
(101, '2025-07-10'),
(102, '2025-07-11');

INSERT INTO questions (exam_id, text, correct_option) VALUES
(1, 'What is the capital of France?', 'B'),
(1, '2 + 2 equals?', 'A'),
(1, 'Select the correct syntax for a JOIN.', 'C'),
(2, 'Python is a ____ language.', 'A'),
(2, 'HTML stands for?', 'C');

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

INSERT INTO student_answers (student_id, question_id, selected_option) VALUES
(1, 1, 'B'), (1, 2, 'A'), (1, 3, 'C'),
(2, 1, 'A'), (2, 2, 'A'), (2, 3, 'B'),
(3, 1, 'B'), (3, 2, 'C'), (3, 3, 'C'),
(4, 4, 'A'), (4, 5, 'C'),
(5, 4, 'B'), (5, 5, 'C'),
(6, 4, 'A'), (6, 5, 'C'),
(7, 4, 'A'), (7, 5, 'B'),
(8, 4, 'A'), (8, 5, 'C'),
(9, 4, 'A'), (9, 5, 'C'),
(10, 4, 'C'), (10, 5, 'B');

-- Query: Calculate score per student for Exam 1
SELECT 
    s.name AS student_name,
    COUNT(*) AS total_questions,
    SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS correct_answers,
    ROUND(SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS score_percentage
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN students s ON sa.student_id = s.id
WHERE q.exam_id = 1
GROUP BY s.name;

-- Query: Score for Exam 2
SELECT 
    s.name AS student_name,
    COUNT(*) AS total_questions,
    SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) AS correct_answers,
    ROUND(SUM(CASE WHEN sa.selected_option = q.correct_option THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS score_percentage
FROM student_answers sa
JOIN questions q ON sa.question_id = q.id
JOIN students s ON sa.student_id = s.id
WHERE q.exam_id = 2
GROUP BY s.name;
