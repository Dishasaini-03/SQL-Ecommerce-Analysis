- Query 1: Orders by Status
SELECT status, COUNT(*) AS total_orders
FROM orders
GROUP BY status;

-- Query 2: Total Revenue
SELECT SUM(quantity * unit_price) AS total_revenue
FROM order_items;

-- Query 3: Top 5 Customers by Spending
SELECT c.customer_name,
       SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Query 4: Best Selling Products
SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Query 5: Monthly Sales Trend
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS month,
       SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;

-- Query 6: Average Order Value
SELECT ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT o.order_id,
           SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS order_summary;

-- Query 7: Revenue by Category
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Query 8: Pending & Cancelled Orders
SELECT customer_id, order_id, status, order_date
FROM orders
WHERE status IN ('Pending', 'Cancelled')
ORDER BY order_date;

-- Query 9: Customer with Most Orders
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 5;