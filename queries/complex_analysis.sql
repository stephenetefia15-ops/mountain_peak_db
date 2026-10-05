-- Q21: Management hierarchy per store, from store managers down
WITH RECURSIVE hierarchy AS (
    SELECT e.employee_id,
           e.store_id,
           e.first_name || ' ' || e.last_name AS employee_name,
           e.position,
           NULL::text AS reports_to,
           0 AS level,
           ARRAY[e.employee_id] AS path
    FROM employees e
    WHERE e.position = 'Store Manager'

    UNION ALL

    SELECT e.employee_id,
           e.store_id,
           e.first_name || ' ' || e.last_name,
           e.position,
           h.employee_name,
           h.level + 1,
           h.path || e.employee_id
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.employee_id
)
SELECT st.store_name,
       REPEAT('    ', h.level) || h.employee_name AS org_chart,
       h.position,
       COALESCE(h.reports_to, '(top of store)') AS reports_to,
       h.level
FROM hierarchy h
JOIN stores st ON st.store_id = h.store_id
ORDER BY st.store_id, h.path;

-- Q22: Customer analysis by loyalty tier
WITH tier_customers AS (
    SELECT loyalty_tier, COUNT(*) AS customers
    FROM customers
    GROUP BY loyalty_tier
),
tier_sales AS (
    SELECT c.loyalty_tier,
           COUNT(DISTINCT c.customer_id)    AS purchasing_customers,
           COUNT(s.sale_id)                 AS transactions,
           SUM(s.total_amount)              AS total_spend,
           ROUND(AVG(s.total_amount), 2)    AS avg_transaction_value
    FROM customers c
    JOIN sales s ON s.customer_id = c.customer_id
    GROUP BY c.loyalty_tier
),
category_units AS (
    SELECT c.loyalty_tier,
           cat.category_name,
           SUM(si.quantity)                 AS units,
           SUM(si.quantity * si.price_sold) AS revenue
    FROM customers c
    JOIN sales s        ON s.customer_id = c.customer_id
    JOIN sale_items si  ON si.sale_id = s.sale_id
    JOIN products p     ON p.product_id = si.product_id
    JOIN categories cat ON cat.category_id = p.category_id
    GROUP BY c.loyalty_tier, cat.category_id, cat.category_name
),
top_category AS (
    SELECT DISTINCT ON (loyalty_tier)
           loyalty_tier, category_name, units
    FROM category_units
    ORDER BY loyalty_tier, units DESC, revenue DESC
),
tier_reviews AS (
    SELECT c.loyalty_tier,
           COUNT(DISTINCT pr.product_id) AS products_reviewed
    FROM customers c
    JOIN product_reviews pr ON pr.customer_id = c.customer_id
    GROUP BY c.loyalty_tier
)
SELECT tc.loyalty_tier,
       tc.customers,
       ts.purchasing_customers,
       ts.transactions,
       ts.total_spend,
       ts.avg_transaction_value,
       tcat.category_name AS most_purchased_category,
       tcat.units         AS units_in_that_category,
       tr.products_reviewed
FROM tier_customers tc
LEFT JOIN tier_sales ts    ON ts.loyalty_tier = tc.loyalty_tier
LEFT JOIN top_category tcat ON tcat.loyalty_tier = tc.loyalty_tier
LEFT JOIN tier_reviews tr  ON tr.loyalty_tier = tc.loyalty_tier
ORDER BY CASE tc.loyalty_tier
             WHEN 'Gold'   THEN 1
             WHEN 'Silver' THEN 2
             WHEN 'Bronze' THEN 3
             ELSE 4
         END;
