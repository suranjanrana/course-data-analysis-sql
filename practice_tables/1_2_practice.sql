-- We’ll expand our **companydb** database with a new schema: `sales`.

-- Create Schema
CREATE SCHEMA sales;

-- Create Sales Table
CREATE TABLE sales.orders (
    orderid INT PRIMARY KEY,
    empid INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (empid) REFERENCES hr.employees(empid)
);

-- Insert Sample Data

INSERT INTO sales.orders VALUES
(101, 3, 1200.50, '2023-01-20'),
(102, 2, 800.00, '2023-02-15'),
(103, 3, 600.75, '2023-03-10');
