CREATE DATABASE survey_collection;
USE survey_collection;

CREATE TABLE surveys (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200)
);

CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    survey_id INT,
    question_text VARCHAR(300),
    FOREIGN KEY (survey_id) REFERENCES surveys(id)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE responses (
    user_id INT,
    question_id INT,
    answer_text VARCHAR(100),
    PRIMARY KEY (user_id, question_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Sample data
INSERT INTO surveys (title) VALUES ('Tech Usage Survey');

INSERT INTO questions (survey_id, question_text) VALUES
(1, 'What is your primary device?'),
(1, 'How many hours do you use technology daily?'),
(1, 'Preferred programming language?'),
(1, 'Do you use cloud services?'),
(1, 'Favorite OS?');

INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

INSERT INTO responses (user_id, question_id, answer_text) VALUES
(1, 1, 'Laptop'), (1, 2, '8'), (1, 3, 'Python'), (1, 4, 'Yes'), (1, 5, 'Windows'),
(2, 1, 'Smartphone'), (2, 2, '5'), (2, 3, 'Java'), (2, 4, 'Yes'), (2, 5, 'Android');

-- Response count by question
SELECT 
    q.question_text,
    COUNT(r.answer_text) AS response_count
FROM questions q
JOIN responses r ON q.id = r.question_id
GROUP BY q.question_text;
