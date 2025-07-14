CREATE DATABASE restaurant_reservation;
USE restaurant_reservation;

CREATE TABLE tables (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_number VARCHAR(10),
    capacity INT
);

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    table_id INT,
    date DATE,
    time_slot TIME,
    FOREIGN KEY (guest_id) REFERENCES guests(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);

-- Sample tables
INSERT INTO tables (table_number, capacity) VALUES
('T1', 2), ('T2', 4), ('T3', 6), ('T4', 2), ('T5', 4);

-- Sample guests
INSERT INTO guests (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample reservations (10 entries)
INSERT INTO reservations (guest_id, table_id, date, time_slot) VALUES
(1, 1, '2025-07-20', '18:00:00'),
(2, 2, '2025-07-20', '18:30:00'),
(3, 3, '2025-07-20', '19:00:00'),
(4, 4, '2025-07-20', '19:30:00'),
(5, 5, '2025-07-20', '20:00:00'),
(6, 1, '2025-07-20', '20:30:00'),
(7, 2, '2025-07-20', '21:00:00'),
(8, 3, '2025-07-20', '21:30:00'),
(9, 4, '2025-07-20', '22:00:00'),
(10, 5, '2025-07-20', '22:30:00');

-- Query: Detect overlapping reservations on the same table and date
SELECT 
    r1.table_id,
    r1.date,
    r1.time_slot AS slot_1,
    r2.time_slot AS slot_2
FROM reservations r1
JOIN reservations r2 ON r1.table_id = r2.table_id 
   AND r1.date = r2.date
   AND r1.id <> r2.id
   AND ABS(TIMESTAMPDIFF(MINUTE, r1.time_slot, r2.time_slot)) < 60;

-- Query: Daily summary of reservations per table
SELECT 
    t.table_number,
    COUNT(r.id) AS total_reservations
FROM reservations r
JOIN tables t ON r.table_id = t.id
WHERE r.date = '2025-07-20'
GROUP BY t.table_number
ORDER BY total_reservations DESC;
