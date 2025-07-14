CREATE DATABASE invoice_generator;

USE invoice_generator;

CREATE TABLE clients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date DATE,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE invoice_items (
    invoice_id INT,
    description VARCHAR(100),
    quantity INT,
    rate DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

INSERT INTO clients (name) VALUES
('Acme Inc.'), ('Globex Corp.');

INSERT INTO invoices (client_id, date) VALUES
(1, '2025-07-01'), (2, '2025-07-02');

INSERT INTO invoice_items (invoice_id, description, quantity, rate) VALUES
(1, 'Consulting Fee', 5, 1000.00),
(1, 'Design Services', 3, 750.00),
(2, 'Hosting', 12, 50.00),
(2, 'Maintenance', 4, 300.00);

-- Invoice totals
SELECT 
    i.id AS invoice_id,
    c.name AS client,
    i.date,
    SUM(ii.quantity * ii.rate) AS total_amount
FROM invoices i
JOIN clients c ON i.client_id = c.id
JOIN invoice_items ii ON i.id = ii.invoice_id
GROUP BY i.id, c.name, i.date;
