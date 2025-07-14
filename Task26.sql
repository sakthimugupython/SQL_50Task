CREATE DATABASE donation_system;
USE donation_system;

CREATE TABLE donors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE causes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200)
);

CREATE TABLE donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT,
    cause_id INT,
    amount DECIMAL(10,2),
    donated_at DATE,
    FOREIGN KEY (donor_id) REFERENCES donors(id),
    FOREIGN KEY (cause_id) REFERENCES causes(id)
);

INSERT INTO donors (name) VALUES
('Alice'), ('Bob'), ('Charlie');

INSERT INTO causes (title) VALUES
('Clean Water'), ('Education Access'), ('Healthcare Support');

INSERT INTO donations (donor_id, cause_id, amount, donated_at) VALUES
(1, 1, 500, '2025-07-01'),
(2, 1, 300, '2025-07-02'),
(3, 2, 200, '2025-07-03'),
(1, 2, 150, '2025-07-04'),
(2, 3, 400, '2025-07-05'),
(3, 3, 350, '2025-07-06'),
(1, 1, 250, '2025-07-07'),
(2, 2, 100, '2025-07-08'),
(3, 1, 600, '2025-07-09'),
(1, 3, 450, '2025-07-10');

-- Query: Sum and rank causes
SELECT 
    c.title,
    SUM(d.amount) AS total_donated
FROM donations d
JOIN causes c ON d.cause_id = c.id
GROUP BY c.title
ORDER BY total_donated DESC;
