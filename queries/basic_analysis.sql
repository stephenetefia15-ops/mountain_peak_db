-- Question 1: Find products with less than 20 items in stock
-- Sort by stock quantity from lowest to highest

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity ASC;

-- Question 2: Find products that are currently out of stock

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity = 0;

-- Question 3: Calculate the profit margin percentage for each product
-- Profit Margin % = ((Price - Cost) / Price) * 100

SELECT
    product_id,
    product_name,
    price,
    cost,
    ROUND(((price - cost) / price) * 100, 2) AS profit_margin_percentage
FROM products
ORDER BY profit_margin_percentage DESC;

-- Question 4: Find products with no assigned category or supplier

SELECT
    product_id,
    product_name,
    category_id,
    supplier_id
FROM products
WHERE category_id IS NULL
   OR supplier_id IS NULL;

-- Question 5: List all products with their category and supplier names

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
