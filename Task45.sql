CREATE DATABASE course_feedback;
USE course_feedback;

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    user_id INT,
    rating DECIMAL(2,1), -- scale of 1.0 to 5.0
    comments TEXT,
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Sample courses
INSERT INTO courses (title) VALUES
('SQL Fundamentals'), ('Data Visualization'), ('Web Development');

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample feedback (10 entries)
INSERT INTO feedback (course_id, user_id, rating, comments) VALUES
(1, 1, 4.5, 'Great intro to SQL'),
(1, 2, 4.0, 'Helpful exercises'),
(1, 3, 3.8, 'Well structured'),
(2, 4, 5.0, 'Loved the visual tools'),
(2, 5, 4.2, 'Clear explanations'),
(2, 6, 4.7, 'Very engaging'),
(3, 7, 3.9, 'Good for beginners'),
(3, 8, 4.1, 'Practical content'),
(3, 9, 4.4, 'Covered latest trends'),
(1, 10, 4.6, 'Easy to follow');

-- Query: Average rating per course
SELECT 
    c.title AS course,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(f.id) AS total_feedbacks
FROM feedback f
JOIN courses c ON f.course_id = c.id
GROUP BY c.title
ORDER BY avg_rating DESC;
