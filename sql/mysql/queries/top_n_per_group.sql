-- name: top-n-per-group
-- purpose: Top 3 products per customer by total spend
WITH spend AS (
  SELECT o.customer_id, oi.product_id, SUM(oi.quantity * oi.unit_price) AS amt
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.id
  GROUP BY o.customer_id, oi.product_id
),
ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amt DESC) AS rn
  FROM spend
)
SELECT customer_id, product_id, amt
FROM ranked
WHERE rn <= 3
ORDER BY customer_id, amt DESC;
