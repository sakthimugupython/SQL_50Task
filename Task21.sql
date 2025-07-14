CREATE DATABASE blog_system;
USE blog_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE posts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(200),
    content TEXT,
    published_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    comment_text TEXT,
    commented_at DATETIME,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO posts (user_id, title, content, published_date) VALUES
(1, 'My Travel Diary', 'Loved my trip to Bali!', '2025-07-01'),
(2, 'Tech Trends', 'Exploring AI in 2025', '2025-07-02');

INSERT INTO comments (post_id, user_id, comment_text, commented_at) VALUES
(1, 2, 'Looks amazing!', '2025-07-01 10:00:00'),
(1, 3, 'Nice post!', '2025-07-01 11:00:00'),
(2, 1, 'Great insights!', '2025-07-02 13:00:00');

-- Query: Comments with post title
SELECT 
    p.title,
    u.name AS commenter,
    c.comment_text,
    c.commented_at
FROM comments c
JOIN posts p ON c.post_id = p.id
JOIN users u ON c.user_id = u.id;

-- Filter posts by user
SELECT 
    p.title,
    p.published_date
FROM posts p
WHERE p.user_id = 1;
