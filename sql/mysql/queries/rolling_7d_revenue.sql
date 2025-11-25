-- name: rolling-7d-revenue
-- purpose: Rolling 7-day revenue by day
WITH daily AS (
  SELECT o.order_date AS dt,
         SUM(oi.quantity * oi.unit_price) AS revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.id
  GROUP BY dt
)
SELECT dt,
       SUM(revenue) OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_7d
FROM daily
ORDER BY dt;
