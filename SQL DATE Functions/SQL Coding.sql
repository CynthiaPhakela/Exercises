
-- SQL Date Functions

-- Part 1 — Questions 1–5: Extract Date Parts

-- Question 01 — Day Name from Order Date--

CREATE OR REPLACE TABLE orders (
  order_id INT,
  customer_id INT,
  order_date DATE
);
 
INSERT INTO orders VALUES
  (1001, 101, DATE'2026-05-01'),
  (1002, 102, DATE'2026-05-02'),
  (1003, 103, DATE'2026-05-03'),
  (1004, 104, DATE'2026-05-04'),
  (1005, 105, DATE'2026-05-05');

-- Query — DAYNAME
SELECT order_id, customer_id, order_date,
       dayname(order_date) AS day_name
FROM orders;

-------------
-- Question 02 — Month Name from Signup Date

CREATE OR REPLACE TABLE customer_signups (
  customer_id INT,
  customer_name STRING,
  signup_date DATE
);
 
INSERT INTO customer_signups VALUES
  (201, 'John', DATE'2026-01-15'),
  (202, 'Mary', DATE'2026-02-20'),
  (203, 'Peter', DATE'2026-03-05'),
  (204, 'Sarah', DATE'2026-04-18'),
  (205, 'Thabo', DATE'2026-05-30');

-- query — MONTHNAME (date_format 'MMMM')
SELECT customer_id, customer_name, signup_date,
       date_format(signup_date, 'MMMM') AS signup_month_name
FROM customer_signups;
----------

-- Question 03 — Month Number from Sale Date

CREATE OR REPLACE TABLE sales (
  sale_id STRING,
  product_name STRING,
  sale_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO sales VALUES
  ('S001', 'Laptop', DATE'2026-01-10', 12000),
  ('S002', 'Mouse', DATE'2026-02-15', 250),
  ('S003', 'Keyboard', DATE'2026-03-20', 700),
  ('S004', 'Monitor', DATE'2026-04-25', 3500),
  ('S005', 'Desk', DATE'2026-05-30', 2000);

--query — MONTH
SELECT sale_id, product_name, sale_date,
       month(sale_date) AS sale_month
FROM sales;
-------

-- Question 04 — Year from Transaction Date

CREATE OR REPLACE TABLE transactions (
  transaction_id STRING,
  customer_id INT,
  transaction_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO transactions VALUES
  ('T001', 101, DATE'2024-12-15', 500),
  ('T002', 102, DATE'2025-01-20', 1200),
  ('T003', 103, DATE'2025-06-10', 800),
  ('T004', 104, DATE'2026-02-05', 1500),
  ('T005', 105, DATE'2026-05-25', 2000);

-- query — YEAR
SELECT transaction_id, customer_id, transaction_date,
       year(transaction_date) AS transaction_year
FROM transactions;
------------------

-- Question 05 — Day of Month from Delivery Date

CREATE OR REPLACE TABLE deliveries (
  delivery_id STRING,
  customer_id INT,
  delivery_date DATE
);
 
INSERT INTO deliveries VALUES
  ('D001', 101, DATE'2026-05-01'),
  ('D002', 102, DATE'2026-05-08'),
  ('D003', 103, DATE'2026-05-15'),
  ('D004', 104, DATE'2026-05-22'),
  ('D005', 105, DATE'2026-05-29');
  
-- Query — DAY
SELECT delivery_id, customer_id, delivery_date,
       day(delivery_date) AS day_of_month
FROM deliveries;
------------------------------------------------
--Part 2 — Questions 6–10: Current Date, Convert & Format
-------------------------------------------------
-- Question 06 — Add Today's Date

CREATE OR REPLACE TABLE employees (
  employee_id INT,
  employee_name STRING,
  department STRING
);
 
INSERT INTO employees VALUES
  (301, 'Nandi', 'Sales'),
  (302, 'Brian', 'IT'),
  (303, 'Lerato', 'Finance'),
  (304, 'Sipho', 'HR'),
  (305, 'Aisha', 'Marketing');

--query — CURRENT_DATE()
SELECT employee_id, employee_name, department,
       current_date() AS today_date
FROM employees;
-------------------

-- Question 07 — Convert Text to Date

CREATE OR REPLACE TABLE online_orders (
  order_id INT,
  customer_id INT,
  order_date_text STRING
);
 
INSERT INTO online_orders VALUES
  (4001, 101, '2026-01-15'),
  (4002, 102, '2026-02-20'),
  (4003, 103, '2026-03-25'),
  (4004, 104, '2026-04-10'),
  (4005, 105, '2026-05-05');

-- query — TO_DATE
SELECT order_id, customer_id, order_date_text,
       to_date(order_date_text, 'yyyy-MM-dd') AS order_date
FROM online_orders;
--------------------

-- Question 08 — Format Date as Text

CREATE OR REPLACE TABLE payment_dates (
  payment_id STRING,
  customer_id INT,
  payment_date DATE
);
 
INSERT INTO payment_dates VALUES
  ('P001', 101, DATE'2026-01-05'),
  ('P002', 102, DATE'2026-02-10'),
  ('P003', 103, DATE'2026-03-15'),
  ('P004', 104, DATE'2026-04-20'),
  ('P005', 105, DATE'2026-05-25');

-- query — TO_CHAR 
SELECT payment_id, customer_id, payment_date,
       date_format(payment_date, 'yyyy-MM-dd') AS formatted_payment_date
FROM payment_dates;
--------------------

-- Question 09 — Days Since Last Purchase

CREATE OR REPLACE TABLE customer_purchases (
  customer_id INT,
  customer_name STRING,
  last_purchase_date DATE
);
 
INSERT INTO customer_purchases VALUES
  (501, 'John', DATE'2026-05-01'),
  (502, 'Mary', DATE'2026-05-10'),
  (503, 'Peter', DATE'2026-05-15'),
  (504, 'Sarah', DATE'2026-05-20'),
  (505, 'Thabo', DATE'2026-05-25');

-- query — CURRENT_DATE() + DATEDIFF
SELECT customer_id, customer_name, last_purchase_date,
       datediff(current_date(), last_purchase_date) AS days_since_last_purchase
FROM customer_purchases;
------------------------

-- Question 10 — Expected Delivery Date

CREATE OR REPLACE TABLE shipping_orders (
  order_id INT,
  customer_id INT,
  order_date DATE
);
 
INSERT INTO shipping_orders VALUES
  (6001, 101, DATE'2026-05-01'),
  (6002, 102, DATE'2026-05-03'),
  (6003, 103, DATE'2026-05-05'),
  (6004, 104, DATE'2026-05-07'),
  (6005, 105, DATE'2026-05-09');

--  query — DATEADD 
SELECT order_id, customer_id, order_date,
       date_add(order_date, 7) AS expected_delivery_date
FROM shipping_orders;
---------------------------------------------------------------------------------------
-- Part 3 — Questions 11–15: Multi-Extract & Date Filtering
--------------------------------------------------------------------------------------

-- Question 11 — Year, Month, Day Separately

CREATE OR REPLACE TABLE bookings (
  booking_id STRING,
  customer_id INT,
  booking_date DATE
);
 
INSERT INTO bookings VALUES
  ('B001', 101, DATE'2026-01-12'),
  ('B002', 102, DATE'2026-02-18'),
  ('B003', 103, DATE'2026-03-22'),
  ('B004', 104, DATE'2026-04-09'),
  ('B005', 105, DATE'2026-05-27');

-- Query — YEAR, MONTH, DAY

SELECT booking_id, customer_id, booking_date,
       year(booking_date)  AS booking_year,
       month(booking_date) AS booking_month,
       day(booking_date)   AS booking_day
FROM bookings;

-- Question 12 — Filter Orders from 2026

CREATE OR REPLACE TABLE yearly_orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO yearly_orders VALUES
  (7001, 101, DATE'2024-12-15', 500),
  (7002, 102, DATE'2025-01-20', 1200),
  (7003, 103, DATE'2025-06-10', 800),
  (7004, 104, DATE'2026-02-05', 1500),
  (7005, 105, DATE'2026-05-25', 2000);

-- Query — YEAR + WHERE
SELECT order_id, customer_id, order_date,
       year(order_date) AS order_year, amount
FROM yearly_orders
WHERE year(order_date) = 2026;
------------------------------

-- Question 13 — Filter Orders from March

CREATE OR REPLACE TABLE monthly_orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO monthly_orders VALUES
  (8001, 101, DATE'2026-01-15', 500),
  (8002, 102, DATE'2026-02-20', 1200),
  (8003, 103, DATE'2026-03-10', 800),
  (8004, 104, DATE'2026-03-25', 1500),
  (8005, 105, DATE'2026-05-30', 2000);

-- Query — MONTH + WHERE
SELECT order_id, customer_id, order_date,
       month(order_date) AS order_month, amount
FROM monthly_orders
WHERE month(order_date) = 3;
-----------------------------

-- Question 14 — Last Day of the Month

CREATE OR REPLACE TABLE subscriptions (
  subscription_id STRING,
  customer_id INT,
  start_date DATE
);
 
INSERT INTO subscriptions VALUES
  ('SUB001', 101, DATE'2026-01-10'),
  ('SUB002', 102, DATE'2026-02-15'),
  ('SUB003', 103, DATE'2026-03-20'),
  ('SUB004', 104, DATE'2026-04-25'),
  ('SUB005', 105, DATE'2026-05-30');

-- Query — LAST_DAY
SELECT subscription_id, customer_id, start_date,
       last_day(start_date) AS month_end_date
FROM subscriptions;
-------------------

-- Question 15 — First Day of the Month

CREATE OR REPLACE TABLE campaign_sends (
  send_id STRING,
  customer_id INT,
  send_date DATE
);
 
INSERT INTO campaign_sends VALUES
  ('C001', 101, DATE'2026-01-12'),
  ('C002', 102, DATE'2026-02-18'),
  ('C003', 103, DATE'2026-03-22'),
  ('C004', 104, DATE'2026-04-09'),
  ('C005', 105, DATE'2026-05-27');

-- Query — DATE_TRUNC
SELECT send_id, customer_id, send_date,
       CAST(date_trunc('MONTH', send_date) AS DATE) AS month_start_date
FROM campaign_sends;
----------------------------------------------------------------------------
-- Part 4 — Questions 16–20: Advanced Date Work
---------------------------------------------------------------------------

-- Question 16 — Format as Month and Year

CREATE OR REPLACE TABLE invoice_dates (
  invoice_id STRING,
  customer_id INT,
  invoice_date DATE
);
 
INSERT INTO invoice_dates VALUES
  ('INV001', 101, DATE'2026-01-05'),
  ('INV002', 102, DATE'2026-02-10'),
  ('INV003', 103, DATE'2026-03-15'),
  ('INV004', 104, DATE'2026-04-20'),
  ('INV005', 105, DATE'2026-05-25');

-- Query — TO_CHAR (date_format 'MMMM yyyy')
SELECT invoice_id, customer_id, invoice_date,
       date_format(invoice_date, 'MMMM yyyy') AS invoice_month_year
FROM invoice_dates;
-------------------

-- Question 17 — Customer Age from Date of Birth

CREATE OR REPLACE TABLE customer_birthdays (
  customer_id INT,
  customer_name STRING,
  date_of_birth DATE
);
 
INSERT INTO customer_birthdays VALUES
  (901, 'John', DATE'1998-05-10'),
  (902, 'Mary', DATE'1990-08-20'),
  (903, 'Peter', DATE'2002-03-15'),
  (904, 'Sarah', DATE'1985-12-01'),
  (905, 'Thabo', DATE'2000-07-30');

-- Query-- 

SELECT customer_id, customer_name, date_of_birth,
       FLOOR(months_between(current_date(), date_of_birth) / 12) AS customer_age
FROM customer_birthdays;
------------------------

-- Question 18 — Classify Weekend vs Weekday

CREATE OR REPLACE TABLE weekend_orders (
  order_id INT,
  customer_id INT,
  order_date DATE
);
 
INSERT INTO weekend_orders VALUES
  (9001, 101, DATE'2026-05-01'),
  (9002, 102, DATE'2026-05-02'),
  (9003, 103, DATE'2026-05-03'),
  (9004, 104, DATE'2026-05-04'),
  (9005, 105, DATE'2026-05-05');

-- Query — DAYNAME + CASE

SELECT order_id, customer_id, order_date,
       dayname(order_date) AS day_name,
       CASE
         WHEN dayname(order_date) IN ('Sat', 'Sun') THEN 'Weekend'
         ELSE 'Weekday'
       END AS day_type
FROM weekend_orders;
--------------------

-- Question 19 — Transactions by Quarter

CREATE OR REPLACE TABLE quarterly_transactions (
  transaction_id STRING,
  customer_id INT,
  transaction_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO quarterly_transactions VALUES
  ('Q001', 101, DATE'2026-01-15', 500),
  ('Q002', 102, DATE'2026-03-20', 1200),
  ('Q003', 103, DATE'2026-04-10', 800),
  ('Q004', 104, DATE'2026-07-05', 1500),
  ('Q005', 105, DATE'2026-10-25', 2000);

-- Query — QUARTER
SELECT transaction_id, customer_id, transaction_date,
       quarter(transaction_date) AS transaction_quarter, amount
FROM quarterly_transactions;
----------------------------

-- Question 20 — Orders Older Than 30 Days

CREATE OR REPLACE TABLE recent_orders (
  order_id STRING,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);
 
INSERT INTO recent_orders VALUES
  ('R001', 101, DATE'2026-04-01', 500),
  ('R002', 102, DATE'2026-04-15', 1200),
  ('R003', 103, DATE'2026-05-01', 800),
  ('R004', 104, DATE'2026-05-10', 1500),
  ('R005', 105, DATE'2026-05-25', 2000);

-- Query — CURRENT_DATE() + DATEDIFF + WHERE
SELECT order_id, customer_id, order_date,
       datediff(current_date(), order_date) AS days_since_order, amount
FROM recent_orders
WHERE datediff(current_date(), order_date) > 30:
------------------------------------------------------------------------

-- Bonus Question — Customer Recency Segment

CREATE OR REPLACE TABLE customer_recency (
  customer_id INT,
  customer_name STRING,
  last_purchase_date DATE,
  total_spend DECIMAL(10,2)
);
 
INSERT INTO customer_recency VALUES
  (1001, 'John', DATE'2026-05-25', 5000),
  (1002, 'Mary', DATE'2026-05-10', 2500),
  (1003, 'Peter', DATE'2026-04-01', 700),
  (1004, 'Sarah', DATE'2026-02-15', 15000),
  (1005, 'Thabo', DATE'2025-12-20', 300);

-- Query — CURRENT_DATE() + DATEDIFF + CASE
SELECT customer_id, customer_name, last_purchase_date,
       datediff(current_date(), last_purchase_date) AS days_since_last_purchase,
       CASE
         WHEN datediff(current_date(), last_purchase_date) <= 30 THEN 'Active Customer'
         WHEN datediff(current_date(), last_purchase_date) <= 90 THEN 'At Risk Customer'
         ELSE 'Inactive Customer'
       END AS customer_status
FROM customer_recency;
