CREATE DATABASE tournament_tracker;
USE tournament_tracker;

CREATE TABLE teams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE matches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    team1_id INT,
    team2_id INT,
    match_date DATE,
    FOREIGN KEY (team1_id) REFERENCES teams(id),
    FOREIGN KEY (team2_id) REFERENCES teams(id)
);

CREATE TABLE scores (
    match_id INT,
    team_id INT,
    score INT,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- Sample teams
INSERT INTO teams (name) VALUES
('Alpha'), ('Beta'), ('Gamma'), ('Delta'), ('Epsilon'),
('Zeta'), ('Eta'), ('Theta'), ('Iota'), ('Kappa');

-- Sample matches
INSERT INTO matches (team1_id, team2_id, match_date) VALUES
(1, 2, '2025-07-01'), (3, 4, '2025-07-02'), (5, 6, '2025-07-03'),
(7, 8, '2025-07-04'), (9, 10, '2025-07-05');

-- Sample scores
INSERT INTO scores (match_id, team_id, score) VALUES
(1, 1, 2), (1, 2, 1),
(2, 3, 3), (2, 4, 3),
(3, 5, 1), (3, 6, 0),
(4, 7, 2), (4, 8, 4),
(5, 9, 3), (5, 10, 2);

-- Query: Leaderboard by wins
SELECT 
    t.name,
    COUNT(*) AS wins
FROM scores s
JOIN matches m ON s.match_id = m.id
JOIN teams t ON s.team_id = t.id
WHERE s.score > (
    SELECT s2.score FROM scores s2
    WHERE s2.match_id = s.match_id AND s2.team_id != s.team_id
)
GROUP BY t.name
ORDER BY wins DESC;
