-- We’ll reuse employees and orders, plus add a second orders table to simulate multiple sources.

CREATE TABLE sales.orders_2022 (
    orderid INT PRIMARY KEY,
    empid INT,
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO sales.orders_2022 VALUES
(201, 1, 400.00, '2022-06-10'),
(202, 2, 650.00, '2022-07-15'),
(203, 3, 300.00, '2022-09-01');
