-- We’ll create a small sample database (`companydb`) with two tables: `departments` and `employees`.

-- Create Departments table
CREATE TABLE departments (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(50) NOT NULL
);

-- Create Employees table
CREATE TABLE employees (
    empid INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    deptid INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (deptid) REFERENCES departments(deptid)
);

-- Insert Departments
INSERT INTO departments (deptid, deptname) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales');

-- Insert Employees
INSERT INTO employees (empid, firstname, lastname, deptid, salary) VALUES
(1, 'Alice', 'Taylor', 1, 60000),
(2, 'Bob', 'Nguyen', 2, 75000),
(3, 'Clara', 'Khan', 3, 50000);
