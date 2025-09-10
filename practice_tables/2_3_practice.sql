-- We’ll add more data in department and employees table

INSERT INTO hr.departments (deptid, deptname, location) VALUES
(4, 'Finance', 'Boston');


INSERT INTO hr.employees (empid, firstname, deptid, location, salary) VALUES
(104, 'Diana', 3, 'San Francisco', 80000),
(105, 'Eve', NULL, 'Remote', 55000); -- employee without department
