CREATE DATABASE fitness_tracker;
USE fitness_tracker;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Workouts table
CREATE TABLE workouts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    type VARCHAR(50)
);

-- Workout Logs table
CREATE TABLE workout_logs (
    user_id INT,
    workout_id INT,
    duration INT, -- duration in minutes
    log_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (workout_id) REFERENCES workouts(id)
);

-- Insert users
INSERT INTO users (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eva'),
('Frank'), ('Grace'), ('Helen'), ('Ivan'), ('Julia');

-- Insert workouts
INSERT INTO workouts (name, type) VALUES
('Push-ups', 'Strength'),
('Running', 'Cardio'),
('Yoga', 'Flexibility'),
('Cycling', 'Cardio'),
('Plank', 'Core'),
('Squats', 'Strength'),
('Jump Rope', 'Cardio'),
('Stretching', 'Flexibility'),
('Swimming', 'Cardio'),
('Deadlift', 'Strength');

-- Insert workout logs (10 entries)
INSERT INTO workout_logs (user_id, workout_id, duration, log_date) VALUES
(1, 2, 30, '2025-07-14'),
(1, 1, 15, '2025-07-15'),
(2, 3, 40, '2025-07-14'),
(2, 4, 25, '2025-07-15'),
(3, 5, 10, '2025-07-16'),
(4, 6, 20, '2025-07-14'),
(5, 7, 35, '2025-07-16'),
(6, 8, 30, '2025-07-15'),
(7, 9, 45, '2025-07-13'),
(8, 10, 50, '2025-07-13');

-- Weekly summary: total duration per user (week of 2025-07-14)
SELECT 
    u.name AS user,
    SUM(wl.duration) AS total_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
WHERE YEARWEEK(wl.log_date, 1) = YEARWEEK('2025-07-14', 1)
GROUP BY u.name;

-- Workout type summary per user
SELECT 
    u.name AS user,
    w.type,
    SUM(wl.duration) AS total_minutes
FROM workout_logs wl
JOIN users u ON wl.user_id = u.id
JOIN workouts w ON wl.workout_id = w.id
GROUP BY u.name, w.type
ORDER BY u.name, total_minutes DESC;
