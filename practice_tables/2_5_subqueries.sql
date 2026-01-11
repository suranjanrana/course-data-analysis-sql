-- We'll be creating a new table called `customers`.

CREATE TABLE sales.customers (
    customerid INT PRIMARY KEY,
    customername VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO sales.customers VALUES
(1, 'Alice Corp', 'USA'),
(2, 'Bob Stores', 'USA'),
(3, 'Charlie Ltd', 'UK'),
(4, 'Delta Inc', 'Canada');
