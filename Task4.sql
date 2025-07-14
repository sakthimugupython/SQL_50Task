CREATE DATABASE inventory_tracking;
USE inventory_tracking;

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    stock INT
);

CREATE TABLE suppliers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE inventory_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    supplier_id INT,
    action ENUM('IN', 'OUT'),
    qty INT,
    timestamp DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

INSERT INTO products (name, stock) VALUES
('Laptop', 10),
('Mouse', 50),
('Keyboard', 30);

INSERT INTO suppliers (name) VALUES
('TechSupplier'),
('GadgetWorld');

DELIMITER //

CREATE TRIGGER trg_update_stock
AFTER INSERT ON inventory_logs
FOR EACH ROW
BEGIN
    UPDATE products 
    SET stock = CASE 
        WHEN NEW.action = 'IN' THEN stock + NEW.qty
        WHEN NEW.action = 'OUT' THEN stock - NEW.qty
        ELSE stock
    END
    WHERE id = NEW.product_id;
END;
//

DELIMITER ;

INSERT INTO inventory_logs (product_id, supplier_id, action, qty, timestamp) VALUES
(1, 1, 'OUT', 2, NOW()),
(2, 2, 'IN', 10, NOW());

SELECT 
    p.id AS product_id,
    p.name AS product_name,
    p.stock,
    CASE 
        WHEN p.stock = 0 THEN 'OUT OF STOCK'
        WHEN p.stock <= 10 THEN 'REORDER NEEDED'
        ELSE 'SUFFICIENT STOCK'
    END AS stock_status
FROM products AS p;
