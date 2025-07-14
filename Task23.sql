CREATE DATABASE messaging_system;
USE messaging_system;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE conversations (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    conversation_id INT,
    sender_id INT,
    message_text TEXT,
    sent_at DATETIME,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);

INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO conversations VALUES (1), (2);

INSERT INTO messages (conversation_id, sender_id, message_text, sent_at) VALUES
(1, 1, 'Hey Bob!', '2025-07-10 09:00:00'),
(1, 2, 'Hi Alice!', '2025-07-10 09:01:00'),
(2, 3, 'Anyone free?', '2025-07-10 10:00:00');

-- Latest message per conversation
SELECT *
FROM (
    SELECT 
        m.conversation_id,
        m.sender_id,
        m.message_text,
        m.sent_at,
        ROW_NUMBER() OVER (PARTITION BY m.conversation_id ORDER BY m.sent_at DESC) AS rn
    FROM messages m
) latest
WHERE rn = 1;

-- Full message thread
SELECT 
    c.id AS conversation_id,
    u.name AS sender,
    m.message_text,
    m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.id
JOIN conversations c ON m.conversation_id = c.id
ORDER BY c.id, m.sent_at;
