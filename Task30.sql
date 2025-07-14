CREATE DATABASE hotel_booking;
USE hotel_booking;

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10),
    type VARCHAR(50)
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_id INT,
    guest_id INT,
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    UNIQUE (room_id, from_date, to_date)  -- Prevent exact overlap, optional
);

-- Sample Rooms
INSERT INTO rooms (number, type) VALUES
('101', 'Single'),
('102', 'Double'),
('103', 'Suite');

-- Sample Guests
INSERT INTO guests (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample Bookings (10 Entries)
INSERT INTO bookings (room_id, guest_id, from_date, to_date) VALUES
(1, 1, '2025-07-10', '2025-07-12'),
(2, 2, '2025-07-10', '2025-07-13'),
(3, 3, '2025-07-11', '2025-07-14'),
(1, 4, '2025-07-13', '2025-07-15'),
(2, 5, '2025-07-14', '2025-07-16'),
(3, 6, '2025-07-15', '2025-07-17'),
(1, 7, '2025-07-16', '2025-07-17'),
(2, 8, '2025-07-17', '2025-07-18'),
(3, 9, '2025-07-18', '2025-07-20'),
(1, 10, '2025-07-19', '2025-07-21');

-- Query: Show available rooms for given date range
-- Example range: '2025-07-12' to '2025-07-14'
SELECT 
    r.number,
    r.type
FROM rooms r
WHERE r.id NOT IN (
    SELECT room_id
    FROM bookings
    WHERE from_date <= '2025-07-21'
      AND to_date >= '2025-07-20'
);
