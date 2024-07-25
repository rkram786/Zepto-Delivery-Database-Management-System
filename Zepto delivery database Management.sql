create database zepto_product_delivery;
use zepto_product_delivery;
-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    registration_date DATE
);
INSERT INTO Customers (name, email, phone, address, registration_date) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA', '2024-01-15'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave, Otherville, USA', '2024-02-20'),
('Michael Johnson', 'michael.johnson@example.com', '555-123-4567', '789 Elm Rd, Anycity, USA', '2024-03-10'),
('Emily Brown', 'emily.brown@example.com', '111-222-3333', '321 Pine Ln, Anyplace, USA', '2024-04-05'),
('David Wilson', 'david.wilson@example.com', '777-888-9999', '555 Cedar Dr, Othertown, USA', '2024-05-12'),
('Sarah Lee', 'sarah.lee@example.com', '333-444-5555', '888 Maple Ave, Anothercity, USA', '2024-06-18'),
('Kevin Martinez', 'kevin.martinez@example.com', '666-777-8888', '999 Oak St, Yetanotherplace, USA', '2024-07-01');
select * from customers;
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(50),
    delivery_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


INSERT INTO Orders (customer_id, order_date, total_amount, status, delivery_address) VALUES
(1, '2024-07-10', 150.00, 'Pending', '123 Main St, Anytown, USA'),
(2, '2024-07-12', 200.00, 'Shipped', '456 Oak Ave, Otherville, USA'),
(3, '2024-07-15', 75.50, 'Delivered', '789 Elm Rd, Anycity, USA'),
(4, '2024-07-18', 300.00, 'Pending', '321 Pine Ln, Anyplace, USA'),
(5, '2024-07-20', 100.00, 'Cancelled', '555 Cedar Dr, Othertown, USA'),
(6, '2024-07-22', 50.25, 'Pending', '888 Maple Ave, Anothercity, USA'),
(7, '2024-07-25', 175.75, 'Shipped', '999 Oak St, Yetanotherplace, USA');
select * from orders;
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category VARCHAR(50),
    stock_quantity INT
);


INSERT INTO Products (name, description, price, category, stock_quantity) VALUES
('Laptop', '15" laptop with SSD and 8GB RAM', 799.99, 'Electronics', 10),
('Headphones', 'Noise-cancelling Bluetooth headphones', 149.99, 'Electronics', 5),
('Smartphone', '6.5" Android smartphone with dual cameras', 499.99, 'Electronics', 15),
('Watch', 'Water-resistant digital watch with fitness tracking', 99.99, 'Accessories', 8),
('Backpack', 'Lightweight backpack with laptop compartment', 49.99, 'Accessories', 12),
('Gaming Mouse', 'High-precision gaming mouse with customizable buttons', 79.99, 'Electronics', 3),
('Desk Lamp', 'LED desk lamp with adjustable brightness', 29.99, 'Home & Office', 7);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 799.99),
(2, 2, 2, 299.98),
(3, 3, 1, 499.99),
(4, 4, 3, 299.97),
(5, 1, 1, 799.99),
(6, 5, 2, 99.98),
(7, 6, 1, 79.99);

CREATE TABLE Delivery_Personnel (
    personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    vehicle_type VARCHAR(50)
);


INSERT INTO Delivery_Personnel (name, phone, vehicle_type) VALUES
('Mike Johnson', '111-222-3333', 'Motorcycle'),
('Sarah Lee', '444-555-6666', 'Car'),
('Tom Wilson', '777-888-9999', 'Bicycle'),
('Emily Davis', '333-444-5555', 'Car'),
('Alex Martinez', '666-777-8888', 'Van'),
('Jessica Brown', '999-000-1111', 'Motorcycle'),
('Chris Taylor', '222-333-4444', 'Bicycle');
select * from customers;
SELECT * 
FROM Customers 
WHERE registration_date >= CURDATE() - INTERVAL 1 MONTH;
SELECT o.order_id, c.name AS customer_name, c.email AS customer_email, o.order_date, o.total_amount, o.status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;
SELECT SUM(total_amount) AS total_revenue
FROM Orders
WHERE order_date >= CURDATE() - INTERVAL 3 MONTH;
SELECT *
FROM Products
WHERE product_id = 2;
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 123;
select * from orders;
-- Updating a customer's phone number
UPDATE Customers 
SET phone = '999-888-7777' 
WHERE customer_id = 1;
-- Selecting a delivery person with the least number of deliveries assigned
SELECT personnel_id, name
FROM Delivery_Personnel
LEFT JOIN Orders ON Delivery_Personnel.personnel_id = Orders.customer_id
GROUP BY personnel_id
ORDER BY COUNT(order_id) ASC
LIMIT 2;
-- Adding new stock to an existing product
UPDATE Products 
SET stock_quantity = stock_quantity + 10 
WHERE product_id = 1;
-- Finding products with low stock quantities
SELECT name, stock_quantity
FROM Products
WHERE stock_quantity < 5;
select * from products;
SELECT dp.personnel_id, dp.name, COUNT(o.order_id) AS deliveries_completed
FROM Delivery_Personnel dp
LEFT JOIN Orders o ON dp.personnel_id = o.customer_id
GROUP BY dp.personnel_id, dp.name;
-- Example of generating a report for delivery performance
SELECT dp.personnel_id, dp.name, COUNT(o.order_id) AS deliveries_completed, 
SUM(o.total_amount) AS total_revenue_generated
FROM Delivery_Personnel dp
LEFT JOIN Orders o ON dp.personnel_id = o.customer_id
GROUP BY dp.personnel_id, dp.name;
UPDATE Customers 
SET phone = '999-888-7777' 
WHERE customer_id = 1;
UPDATE Customers
SET email = 'new.email@example.com'
WHERE customer_id = 1;DELETE FROM Orders
WHERE order_id = 123;
SELECT *
FROM Products
ORDER BY price DESC
LIMIT 1;
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END;
CREATE TABLE Customer_Update_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    old_phone VARCHAR(20),
    new_phone VARCHAR(20),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER log_customer_update
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    INSERT INTO Customer_Update_Log (customer_id, old_phone, new_phone)
    VALUES (OLD.customer_id, OLD.phone, NEW.phone);
END;
CREATE VIEW Customer_Orders_Summary AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
CREATE VIEW Product_Stock_Status AS
SELECT product_id, name, stock_quantity, 
    CASE 
        WHEN stock_quantity < 5 THEN 'Low Stock'
        WHEN stock_quantity BETWEEN 5 AND 10 THEN 'Moderate Stock'
        ELSE 'High Stock'
    END AS stock_status
FROM Products;
SELECT o.order_id, c.name AS customer_name, c.email AS customer_email, o.order_date, o.total_amount, o.status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;
SELECT oi.order_item_id, oi.order_id, p.name AS product_name, oi.quantity, oi.unit_price
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;
SELECT o.order_id, dp.name AS delivery_personnel, dp.phone AS delivery_personnel_phone, o.order_date, o.total_amount
FROM Orders o
JOIN Delivery_Personnel dp ON o.customer_id = dp.personnel_id;




























