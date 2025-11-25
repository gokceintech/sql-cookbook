-- name: deduplicate-keep-latest
-- purpose: Deduplicate customers by name, keep newest created_at
WITH ranked AS (
  SELECT id, name, created_at,
         ROW_NUMBER() OVER (PARTITION BY name ORDER BY created_at DESC) AS rn
  FROM customers
)
SELECT id, name, created_at
FROM ranked
WHERE rn = 1;
