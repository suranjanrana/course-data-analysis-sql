-- Let’s add a `managerid` column to `employees` for this example:

ALTER TABLE hr.employees ADD COLUMN managerid INT;

UPDATE hr.employees SET managerid = NULL WHERE empid = 1; -- Alice = CEO
UPDATE hr.employees SET managerid = 1 WHERE empid IN (2, 3); -- Bob, Clara report to Alice
UPDATE hr.employees SET managerid = 2 WHERE empid = 4; -- Diana reports to Bob
UPDATE hr.employees SET managerid = 3 WHERE empid = 5; -- Eve reports to Clara
