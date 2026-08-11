-- E-Commerce Sales & Business Analytics
-- MySQL Analysis Queries

USE ecommerce_analysis;

-- 1. Basic data overview
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_order_items FROM orderitems;

-- 2. Overall sales, cost, profit and margin
SELECT
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS total_sales,
    ROUND(SUM(oi.quantity * p.`UNIT COST`), 2) AS total_cost,
    ROUND(SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`), 2) AS total_profit,
    ROUND(
        (SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`))
        * 100.0 / NULLIF(SUM(oi.`SALES AMOUNT`), 0), 2
    ) AS profit_margin_pct
FROM orderitems oi
JOIN products p ON oi.`PRODUCT ID` = p.`PRODUCT ID`;

-- 3. Monthly sales and profit
SELECT
    DATE_FORMAT(o.`ORDER DATE`, '%Y-%m') AS month,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales,
    ROUND(
        SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`), 2
    ) AS profit
FROM orders o
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
JOIN products p ON oi.`PRODUCT ID` = p.`PRODUCT ID`
GROUP BY DATE_FORMAT(o.`ORDER DATE`, '%Y-%m')
ORDER BY month;

-- 4. Sales and profit by category
SELECT
    p.`CATEGORY`,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales,
    ROUND(
        SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`), 2
    ) AS profit,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN orderitems oi ON p.`PRODUCT ID` = oi.`PRODUCT ID`
GROUP BY p.`CATEGORY`
ORDER BY sales DESC;

-- 5. Top 10 products by sales
SELECT
    p.`PRODUCT NAME`,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales
FROM products p
JOIN orderitems oi ON p.`PRODUCT ID` = oi.`PRODUCT ID`
GROUP BY p.`PRODUCT ID`, p.`PRODUCT NAME`
ORDER BY sales DESC
LIMIT 10;

-- 6. Top 10 products by quantity
SELECT
    p.`PRODUCT NAME`,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN orderitems oi ON p.`PRODUCT ID` = oi.`PRODUCT ID`
GROUP BY p.`PRODUCT ID`, p.`PRODUCT NAME`
ORDER BY quantity_sold DESC
LIMIT 10;

-- 7. Customer sales and order frequency
SELECT
    c.`CUSTOMER ID`,
    c.`CUSTOMER NAME`,
    c.`STATE`,
    COUNT(DISTINCT o.`ORDER ID`) AS order_count,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales
FROM customers c
JOIN orders o ON c.`CUSTOMER ID` = o.`CUSTOMER ID`
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
GROUP BY c.`CUSTOMER ID`, c.`CUSTOMER NAME`, c.`STATE`
ORDER BY sales DESC;

-- 8. Top 10 customers by sales
SELECT
    c.`CUSTOMER NAME`,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales
FROM customers c
JOIN orders o ON c.`CUSTOMER ID` = o.`CUSTOMER ID`
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
GROUP BY c.`CUSTOMER ID`, c.`CUSTOMER NAME`
ORDER BY sales DESC
LIMIT 10;

-- 9. RFM analysis
WITH customer_rfm AS (
    SELECT
        o.`CUSTOMER ID`,
        DATEDIFF(
            (SELECT MAX(`ORDER DATE`) FROM orders),
            MAX(o.`ORDER DATE`)
        ) AS recency,
        COUNT(DISTINCT o.`ORDER ID`) AS frequency,
        ROUND(SUM(oi.`SALES AMOUNT`), 2) AS monetary
    FROM orders o
    JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
    GROUP BY o.`CUSTOMER ID`
)
SELECT
    `CUSTOMER ID`,
    recency,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
    NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
    NTILE(5) OVER (ORDER BY monetary) AS monetary_score
FROM customer_rfm;

-- 10. New vs returning customers
SELECT
    SUM(CASE WHEN order_count = 1 THEN 1 ELSE 0 END) AS one_time_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS returning_customers,
    COUNT(*) AS total_customers
FROM (
    SELECT `CUSTOMER ID`, COUNT(DISTINCT `ORDER ID`) AS order_count
    FROM orders
    GROUP BY `CUSTOMER ID`
) x;

-- 11. State-wise sales and profit
SELECT
    c.`STATE`,
    COUNT(DISTINCT o.`ORDER ID`) AS orders,
    COUNT(DISTINCT c.`CUSTOMER ID`) AS customers,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales,
    ROUND(
        SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`), 2
    ) AS profit
FROM customers c
JOIN orders o ON c.`CUSTOMER ID` = o.`CUSTOMER ID`
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
JOIN products p ON oi.`PRODUCT ID` = p.`PRODUCT ID`
GROUP BY c.`STATE`
ORDER BY sales DESC;

-- 12. Order status distribution and operational rates
SELECT `ORDER STATUS`, COUNT(DISTINCT `ORDER ID`) AS orders
FROM orders
GROUP BY `ORDER STATUS`
ORDER BY orders DESC;

SELECT
    ROUND(SUM(`ORDER STATUS` = 'Delivered') * 100.0 / COUNT(*), 2) AS delivery_rate_pct,
    ROUND(SUM(`ORDER STATUS` = 'Cancelled') * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
    ROUND(SUM(`ORDER STATUS` = 'Returned') * 100.0 / COUNT(*), 2) AS return_rate_pct
FROM orders;

-- 13. Payment method analysis
SELECT
    p.`PAYMENT METHOD`,
    COUNT(DISTINCT p.`ORDER ID`) AS orders,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales
FROM payments p
JOIN orderitems oi ON p.`ORDER ID` = oi.`ORDER ID`
GROUP BY p.`PAYMENT METHOD`
ORDER BY sales DESC;

-- 14. Employee performance
SELECT
    e.`EMPLOYEE NAME`,
    COUNT(DISTINCT o.`ORDER ID`) AS orders_handled,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS sales
FROM employees e
JOIN orders o ON e.`EMPLOYEE ID` = o.`EMPLOYEE ID`
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
GROUP BY e.`EMPLOYEE ID`, e.`EMPLOYEE NAME`
ORDER BY orders_handled DESC;

-- 15. Final executive KPI summary
SELECT
    COUNT(DISTINCT o.`ORDER ID`) AS total_orders,
    COUNT(DISTINCT o.`CUSTOMER ID`) AS total_customers,
    ROUND(SUM(oi.`SALES AMOUNT`), 2) AS total_sales,
    ROUND(SUM(oi.quantity * p.`UNIT COST`), 2) AS total_cost,
    ROUND(SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`), 2) AS estimated_profit,
    ROUND(
        (SUM(oi.`SALES AMOUNT`) - SUM(oi.quantity * p.`UNIT COST`))
        * 100.0 / NULLIF(SUM(oi.`SALES AMOUNT`), 0), 2
    ) AS profit_margin_pct,
    ROUND(
        SUM(oi.`SALES AMOUNT`) /
        NULLIF(COUNT(DISTINCT o.`ORDER ID`), 0), 2
    ) AS average_order_value
FROM orders o
JOIN orderitems oi ON o.`ORDER ID` = oi.`ORDER ID`
JOIN products p ON oi.`PRODUCT ID` = p.`PRODUCT ID`;
