CREATE DATABASE multi_tenant_app;
USE multi_tenant_app;

CREATE TABLE tenants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    tenant_id INT,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

CREATE TABLE data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_id INT,
    content TEXT,
    FOREIGN KEY (tenant_id) REFERENCES tenants(id)
);

-- Sample tenants
INSERT INTO tenants (name) VALUES
('Tenant A'), ('Tenant B'), ('Tenant C');

-- Sample users
INSERT INTO users (name, tenant_id) VALUES
('Alice', 1), ('Bob', 1), ('Charlie', 2), ('David', 2), ('Eva', 3),
('Frank', 3), ('Grace', 1), ('Helen', 2), ('Ivan', 3), ('Julia', 1);

-- Sample data
INSERT INTO data (tenant_id, content) VALUES
(1, 'A - Invoice record'),
(1, 'A - User activity'),
(2, 'B - Usage metrics'),
(2, 'B - Audit log'),
(3, 'C - Config settings'),
(3, 'C - Notifications'),
(1, 'A - Subscription detail'),
(2, 'B - Plan upgrade'),
(3, 'C - API usage'),
(1, 'A - Billing info');

-- Query: Retrieve data for Tenant A only
SELECT 
    t.name AS tenant,
    d.content
FROM data d
JOIN tenants t ON d.tenant_id = t.id
WHERE t.name = 'Tenant A';

-- Query: Count of users per tenant
SELECT 
    t.name AS tenant,
    COUNT(u.id) AS user_count
FROM users u
JOIN tenants t ON u.tenant_id = t.id
GROUP BY t.name;
