-- name: deduplicate-keep-latest
-- purpose: Deduplicate customers by name, keep newest created_at
SELECT DISTINCT ON (name) id, name, created_at
FROM customers
ORDER BY name, created_at DESC;
