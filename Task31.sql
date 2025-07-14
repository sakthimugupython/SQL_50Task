CREATE DATABASE movie_db;
USE movie_db;

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    release_year INT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE ratings (
    user_id INT,
    movie_id INT,
    score DECIMAL(2,1),
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

-- Sample genres
INSERT INTO genres (name) VALUES
('Action'), ('Drama'), ('Comedy'), ('Sci-Fi'), ('Thriller');

-- Sample movies
INSERT INTO movies (title, release_year, genre_id) VALUES
('Skyfall', 2012, 1),
('Inception', 2010, 4),
('The Godfather', 1972, 2),
('Forrest Gump', 1994, 2),
('Interstellar', 2014, 4),
('The Dark Knight', 2008, 1),
('Parasite', 2019, 2),
('Avengers: Endgame', 2019, 1),
('The Hangover', 2009, 3),
('Get Out', 2017, 5);

-- Sample ratings
INSERT INTO ratings (user_id, movie_id, score) VALUES
(1, 1, 4.5), (2, 1, 4.7), (3, 2, 4.8), (1, 2, 5.0), (2, 3, 4.9),
(3, 4, 4.2), (1, 5, 5.0), (2, 6, 4.6), (3, 7, 4.3), (1, 8, 4.8);

-- Query: AVG rating per movie with genre
SELECT 
    m.title,
    g.name AS genre,
    ROUND(AVG(r.score), 2) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.id
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.title, g.name
ORDER BY avg_rating DESC;
