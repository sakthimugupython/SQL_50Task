CREATE DATABASE library_management;
USE library_management;

CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    author VARCHAR(100)
);

CREATE TABLE members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE borrows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

-- Sample books
INSERT INTO books (title, author) VALUES
('1984', 'George Orwell'),
('To Kill a Mockingbird', 'Harper Lee'),
('The Great Gatsby', 'F. Scott Fitzgerald'),
('Sapiens', 'Yuval Noah Harari'),
('The Hobbit', 'J.R.R. Tolkien'),
('The Catcher in the Rye', 'J.D. Salinger'),
('The Alchemist', 'Paulo Coelho'),
('Atomic Habits', 'James Clear'),
('Pride and Prejudice', 'Jane Austen'),
('Thinking, Fast and Slow', 'Daniel Kahneman');

-- Sample members
INSERT INTO members (name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('David'),
('Eva'),
('Frank'),
('Grace'),
('Helen'),
('Ivan'),
('Julia');

-- Sample borrow transactions
INSERT INTO borrows (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2025-07-01', '2025-07-10'),
(2, 2, '2025-07-02', '2025-07-05'),
(3, 3, '2025-07-04', NULL),
(4, 4, '2025-07-05', '2025-07-12'),
(5, 5, '2025-07-06', NULL),
(6, 6, '2025-07-07', '2025-07-11'),
(7, 7, '2025-07-08', NULL),
(8, 8, '2025-07-09', '2025-07-13'),
(9, 9, '2025-07-10', NULL),
(10, 10, '2025-07-11', '2025-07-20');

-- Query: Fine calculation (assuming due in 7 days, fine ₹10/day for overdue)
SELECT 
    m.name AS member_name,
    b.title AS book_title,
    br.borrow_date,
    br.return_date,
    CASE 
        WHEN br.return_date IS NOT NULL AND DATEDIFF(br.return_date, br.borrow_date) > 7 THEN
            (DATEDIFF(br.return_date, br.borrow_date) - 7) * 10
        WHEN br.return_date IS NULL AND DATEDIFF(CURDATE(), br.borrow_date) > 7 THEN
            (DATEDIFF(CURDATE(), br.borrow_date) - 7) * 10
        ELSE 0
    END AS fine
FROM borrows br
JOIN members m ON br.member_id = m.id
JOIN books b ON br.book_id = b.id
ORDER BY br.borrow_date;
