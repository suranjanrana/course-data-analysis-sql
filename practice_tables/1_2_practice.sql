-- We’ll expand our **companydb** database with two schemas: `hr` and `sales`.

-- Create Schemas
CREATE SCHEMA hr;
CREATE SCHEMA sales;

-- Create HR Tables
CREATE TABLE hr.departments (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(50) NOT NULL
);

CREATE TABLE hr.employees (
    empid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    deptid INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (deptid) REFERENCES hr.departments(deptid)
);

-- Create Sales Table
CREATE TABLE sales.orders (
    orderid INT PRIMARY KEY,
    empid INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (empid) REFERENCES hr.employees(empid)
);

-- Insert Sample Data
INSERT INTO hr.departments VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales');

INSERT INTO hr.employees VALUES
(1, 'Alice', 'Taylor', 1, 60000, '2021-01-10'),
(2, 'Bob', 'Nguyen', 2, 75000, '2020-03-15'),
(3, 'Clara', 'Khan', 3, 50000, '2022-07-01');

INSERT INTO sales.orders VALUES
(101, 3, 1200.50, '2023-01-20'),
(102, 2, 800.00, '2023-02-15'),
(103, 3, 600.75, '2023-03-10');
