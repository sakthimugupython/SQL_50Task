CREATE DATABASE vehicle_rental;
USE vehicle_rental;

CREATE TABLE vehicles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50),
    plate_number VARCHAR(20)
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE rentals (
    id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Sample vehicles
INSERT INTO vehicles (type, plate_number) VALUES
('Sedan', 'TN01A1111'), ('SUV', 'TN02B2222'), ('Hatchback', 'TN03C3333'),
('Bike', 'TN04D4444'), ('Truck', 'TN05E5555');

-- Sample customers
INSERT INTO customers (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Sample rentals (10 entries)
INSERT INTO rentals (vehicle_id, customer_id, start_date, end_date) VALUES
(1, 1, '2025-07-10', '2025-07-12'),
(2, 2, '2025-07-11', '2025-07-13'),
(3, 3, '2025-07-12', '2025-07-14'),
(4, 4, '2025-07-13', '2025-07-15'),
(5, 5, '2025-07-14', '2025-07-16'),
(1, 6, '2025-07-16', '2025-07-18'),
(2, 7, '2025-07-17', '2025-07-19'),
(3, 8, '2025-07-18', '2025-07-20'),
(4, 9, '2025-07-19', '2025-07-21'),
(5, 10, '2025-07-20', '2025-07-22');

-- Query: Available vehicles during a date range
SELECT 
    v.plate_number,
    v.type
FROM vehicles v
WHERE v.id NOT IN (
    SELECT vehicle_id
    FROM rentals
    WHERE start_date <= '2025-07-15' AND end_date >= '2025-07-13'
);

-- Query: Calculate rental duration and charges (₹500/day flat rate)
SELECT 
    c.name AS customer,
    v.plate_number,
    DATEDIFF(r.end_date, r.start_date) AS duration_days,
    DATEDIFF(r.end_date, r.start_date) * 500 AS rental_charge
FROM rentals r
JOIN customers c ON r.customer_id = c.id
JOIN vehicles v ON r.vehicle_id = v.id;
