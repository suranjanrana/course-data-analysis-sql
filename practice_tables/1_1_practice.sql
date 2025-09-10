-- We’ll create a small sample database (`companydb`) with a schema: `hr`.
-- This schema will contain two tables: `departments` and `employees`.

-- Create Schemas
CREATE SCHEMA hr;

-- Create HR Tables
CREATE TABLE hr.departments (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(50) NOT NULL
);

-- The `employees` table will reference the `departments` table via a foreign key.
CREATE TABLE hr.employees (
    empid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    deptid INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (deptid) REFERENCES hr.departments(deptid)
);

-- Insert Sample Data
INSERT INTO hr.departments VALUES
(1, 'HR'), (2, 'IT'), (3, 'Sales');

INSERT INTO hr.employees VALUES
(1, 'Alice', 'Taylor', 1, 60000, '2021-01-10'),
(2, 'Bob', 'Nguyen', 2, 75000, '2020-03-15'),
(3, 'Clara', 'Khan', 3, 50000, '2022-07-01');
