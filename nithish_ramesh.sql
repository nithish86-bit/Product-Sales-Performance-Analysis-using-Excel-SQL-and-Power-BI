-- ====================================================================
-- TASK 2: SQL ANALYTICAL QUERIES - SOLUTIONS
-- ====================================================================

-- 1. Total revenue for each product category
SELECT 
    category_name,
    ROUND(SUM(price * qty), 2) AS total_revenue
FROM product_sales
GROUP BY category_name
ORDER BY total_revenue DESC;


-- 2. Product with the highest discount percentage
SELECT 
    product_name,
    original_price,
    discounted_price,
    ROUND(((original_price - discounted_price) / original_price) * 100, 2) AS discount_percentage
FROM product_pricing
WHERE original_price > 0
ORDER BY discount_percentage DESC
LIMIT 1;


-- 3. Product category with the highest average price
SELECT 
    category_name,
    ROUND(AVG(price), 2) AS average_price
FROM product_sales
GROUP BY category_name
ORDER BY average_price DESC;


-- 4. Product with the lowest price fluctuation (least difference)
SELECT 
    product_name,
    original_price,
    discounted_price,
    ABS(original_price - discounted_price) AS price_fluctuation
FROM product_pricing
ORDER BY price_fluctuation ASC
LIMIT 1;


-- 5. Choice-Based Question: 3rd and 4th highest-selling product categories
WITH RankedCategories AS (
    SELECT 
        category_name,
        SUM(price * qty) AS total_sales,
        DENSE_RANK() OVER (ORDER BY SUM(price * qty) DESC) AS sales_rank
    FROM product_sales
    GROUP BY category_name
)
SELECT 
    sales_rank,
    category_name,
    ROUND(total_sales, 2) AS total_sales
FROM RankedCategories
WHERE sales_rank IN (3, 4);

