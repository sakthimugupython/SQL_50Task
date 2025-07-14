CREATE DATABASE forum_system;
USE forum_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE threads (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    thread_id INT,
    user_id INT,
    content TEXT,
    parent_post_id INT,
    posted_at DATETIME,
    FOREIGN KEY (thread_id) REFERENCES threads(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_post_id) REFERENCES posts(id)
);

-- Sample users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample threads
INSERT INTO threads (title, user_id) VALUES
('SQL Tips & Tricks', 1),
('Frontend Frameworks', 2);

-- Sample posts
INSERT INTO posts (thread_id, user_id, content, parent_post_id, posted_at) VALUES
(1, 1, 'Start with SELECT basics.', NULL, NOW()),
(1, 2, 'JOINs are life-changing!', 1, NOW()),
(1, 3, 'CTEs simplify recursion.', 2, NOW()),
(1, 4, 'GROUP BY gives power.', NULL, NOW()),
(2, 5, 'React is great!', NULL, NOW()),
(2, 6, 'Try Vue for simplicity.', 5, NOW()),
(2, 7, 'Angular has structure.', 6, NOW()),
(1, 8, 'Use indexes for speed.', NULL, NOW()),
(1, 9, 'Avoid SELECT *', 8, NOW()),
(2, 10, 'Svelte is upcoming.', NULL, NOW());

-- Query: Thread view with total posts
SELECT 
    t.title,
    COUNT(p.id) AS total_posts
FROM threads t
LEFT JOIN posts p ON t.id = p.thread_id
GROUP BY t.id, t.title;
