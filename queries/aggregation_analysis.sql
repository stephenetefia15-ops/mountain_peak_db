-- Q6: Total sales amount per store
SELECT st.store_name,
       st.region,
       COALESCE(SUM(s.total_amount), 0) AS total_sales
FROM stores st
LEFT JOIN sales s ON s.store_id = st.store_id
GROUP BY st.store_id, st.store_name, st.region
ORDER BY total_sales DESC;

-- Q7: Monthly sales totals and transaction counts for 2023
SELECT TO_CHAR(DATE_TRUNC('month', sale_date), 'YYYY-MM') AS sale_month,
       COUNT(*)                                           AS transaction_count,
       SUM(total_amount)                                  AS total_sales
FROM sales
WHERE sale_date >= '2023-01-01'
  AND sale_date <  '2024-01-01'
GROUP BY 1
ORDER BY 1;

-- Q8: Categories ranked by total revenue
SELECT RANK() OVER (ORDER BY SUM(si.quantity * si.price_sold) DESC) AS revenue_rank,
       c.category_name,
       SUM(si.quantity * si.price_sold)                             AS total_revenue
FROM categories c
JOIN products p    ON p.category_id = c.category_id
JOIN sale_items si ON si.product_id = p.product_id
GROUP BY c.category_id, c.category_name
ORDER BY revenue_rank;

-- Q9: Top 5 most frequently purchased products
SELECT p.product_name,
       SUM(si.quantity) AS total_quantity_sold
FROM sale_items si
JOIN products p ON p.product_id = si.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC, p.product_name
LIMIT 5;

-- Q10: Purchases per customer with most recent purchase date
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       c.email,
       COUNT(s.sale_id)                   AS purchase_count,
       MAX(s.sale_date)::date             AS most_recent_purchase
FROM customers c
LEFT JOIN sales s ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY purchase_count DESC, customer_name;
