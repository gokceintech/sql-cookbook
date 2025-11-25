-- name: top-customers-365d
-- purpose: Top 5 customers by revenue in the last 365 days

WITH revenue AS (
  SELECT
    o.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.id
  WHERE o.order_date >= CURRENT_DATE - INTERVAL 365 DAY
  GROUP BY o.customer_id
)
SELECT c.id, c.name, r.total_revenue
FROM revenue r
JOIN customers c ON c.id = r.customer_id
ORDER BY r.total_revenue DESC
LIMIT 5;
