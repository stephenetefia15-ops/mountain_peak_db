
-- Q16a: Total sales and transaction count per employee
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS employee_name,
       e.position,
       COALESCE(SUM(s.total_amount), 0)   AS total_sales,
       COUNT(s.sale_id)                   AS transaction_count
FROM employees e
LEFT JOIN sales s ON s.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.position
ORDER BY total_sales DESC;
-- Q16b: Top-performing sales associates only
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       st.store_name,
       SUM(s.total_amount) AS total_sales,
       COUNT(s.sale_id)    AS transaction_count
FROM employees e
JOIN stores st ON st.store_id = e.store_id
JOIN sales s   ON s.employee_id = e.employee_id
WHERE e.position = 'Sales Associate'
GROUP BY e.employee_id, e.first_name, e.last_name, st.store_name
ORDER BY total_sales DESC;

-- Q17: Average transaction value per employee
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       e.position,
       COUNT(s.sale_id)                   AS transaction_count,
       ROUND(AVG(s.total_amount), 2)      AS avg_transaction_value
FROM employees e
JOIN sales s ON s.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.position
ORDER BY avg_transaction_value DESC;

-- Q18: Store name, manager, employee count, total sales
WITH emp_counts AS (
    SELECT store_id, COUNT(*) AS employee_count
    FROM employees
    WHERE store_id IS NOT NULL
    GROUP BY store_id
),
store_sales AS (
    SELECT store_id, SUM(total_amount) AS total_sales
    FROM sales
    GROUP BY store_id
)
SELECT st.store_name,
       COALESCE(m.first_name || ' ' || m.last_name, 'No manager assigned') AS manager_name,
       COALESCE(ec.employee_count, 0) AS employee_count,
       COALESCE(ss.total_sales, 0)    AS total_sales
FROM stores st
LEFT JOIN employees m   ON m.store_id = st.store_id AND m.position = 'Store Manager'
LEFT JOIN emp_counts ec ON ec.store_id = st.store_id
LEFT JOIN store_sales ss ON ss.store_id = st.store_id
ORDER BY total_sales DESC;

-- Q19: Stores whose average employee salary exceeds the company-wide average
SELECT st.store_name,
       ROUND(AVG(e.salary), 2) AS avg_store_salary,
       (SELECT ROUND(AVG(salary), 2) FROM employees) AS company_avg_salary
FROM stores st
JOIN employees e ON e.store_id = st.store_id
GROUP BY st.store_id, st.store_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees)
ORDER BY avg_store_salary DESC;

-- Q20: Product performance matrix (sales volume vs. profit margin)
WITH product_stats AS (
    SELECT p.product_id,
           p.product_name,
           SUM(si.quantity)                      AS units_sold,
           (p.price - p.cost) / p.price * 100    AS margin_pct
    FROM products p
    JOIN sale_items si ON si.product_id = p.product_id
    JOIN sales s       ON s.sale_id = si.sale_id
    GROUP BY p.product_id, p.product_name, p.price, p.cost
),
thresholds AS (
    SELECT AVG(units_sold) AS avg_units,
           AVG(margin_pct) AS avg_margin
    FROM product_stats
),
classified AS (
    SELECT ps.product_name,
           ps.units_sold,
           ps.margin_pct,
           CASE
               WHEN ps.units_sold > t.avg_units AND ps.margin_pct > t.avg_margin THEN 'Stars'
               WHEN ps.units_sold > t.avg_units                                  THEN 'Volume Drivers'
