-- Q11: Total amount spent by each customer
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       COALESCE(SUM(s.total_amount), 0)   AS total_spend
FROM customers c
LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;

-- Q12: Average rating per loyalty tier
SELECT c.loyalty_tier,
       ROUND(AVG(pr.rating), 2) AS avg_rating,
       COUNT(pr.review_id)      AS review_count
FROM customers c
JOIN product_reviews pr ON pr.customer_id = c.customer_id
GROUP BY c.loyalty_tier
ORDER BY CASE c.loyalty_tier
           WHEN 'Gold'   THEN 1
           WHEN 'Silver' THEN 2
           WHEN 'Bronze' THEN 3
           ELSE 4
         END;

-- Q13: Customers with purchases but no product reviews
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       c.email
FROM customers c
WHERE EXISTS (SELECT 1 FROM sales s
              WHERE s.customer_id = c.customer_id)
  AND NOT EXISTS (SELECT 1 FROM product_reviews pr
                  WHERE pr.customer_id = c.customer_id);

-- Q14: Customers whose Q2 2023 spending exceeded Q1 2023
WITH quarterly AS (
    SELECT c.customer_id,
           c.first_name || ' ' || c.last_name AS customer_name,
           COALESCE(SUM(s.total_amount) FILTER (
               WHERE s.sale_date >= '2023-01-01' AND s.sale_date < '2023-04-01'), 0) AS q1_spend,
           COALESCE(SUM(s.total_amount) FILTER (
               WHERE s.sale_date >= '2023-04-01' AND s.sale_date < '2023-07-01'), 0) AS q2_spend
    FROM customers c
    JOIN sales s ON s.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_name,
       q1_spend,
       q2_spend,
       q2_spend - q1_spend AS increase
FROM quarterly
WHERE q2_spend > q1_spend
ORDER BY increase DESC;

-- Q15: Favorite product categories of Gold tier customers
SELECT cat.category_name,
       SUM(si.quantity)                  AS units_purchased,
       SUM(si.quantity * si.price_sold)  AS revenue
FROM customers c
JOIN sales s       ON s.customer_id = c.customer_id
JOIN sale_items si ON si.sale_id = s.sale_id
JOIN products p    ON p.product_id = si.product_id
JOIN categories cat ON cat.category_id = p.category_id
WHERE c.loyalty_tier = 'Gold'
GROUP BY cat.category_id, cat.category_name
ORDER BY units_purchased DESC, revenue DESC;
