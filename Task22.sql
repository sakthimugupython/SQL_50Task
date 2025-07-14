CREATE DATABASE voting_system;
USE voting_system;

CREATE TABLE polls (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question VARCHAR(200)
);

CREATE TABLE options (
    id INT PRIMARY KEY AUTO_INCREMENT,
    poll_id INT,
    option_text VARCHAR(100),
    FOREIGN KEY (poll_id) REFERENCES polls(id)
);

CREATE TABLE votes (
    user_id INT,
    option_id INT,
    voted_at DATETIME,
    PRIMARY KEY (user_id, option_id),
    FOREIGN KEY (option_id) REFERENCES options(id)
);

INSERT INTO polls (question) VALUES ('Favorite programming language?');

INSERT INTO options (poll_id, option_text) VALUES
(1, 'Python'), (1, 'Java'), (1, 'C++');

INSERT INTO votes (user_id, option_id, voted_at) VALUES
(1, 1, '2025-07-10 09:00:00'),
(2, 2, '2025-07-10 09:05:00'),
(3, 1, '2025-07-10 09:10:00');

-- Count votes per option
SELECT 
    o.option_text,
    COUNT(v.user_id) AS total_votes
FROM options o
LEFT JOIN votes v ON o.id = v.option_id
GROUP BY o.option_text;
