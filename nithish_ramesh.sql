create procedure t4 as 
begin
select * from product_details
select * from Product_Hierarchy
select * from product_pricing
select * from Product_Sales
end

/*1. Calculate the total revenue for each product category. (7 Marks)
Hint:
--Multiply price by qty and group by category_name.*/
select d.category_name,sum(cast(s.price as int)* cast(s.qty as int)) as tot_revenue
from product_details as d join product_sales as s
on d.product_id=s.prod_id
group by category_name


/*2. Identify the product with the highest discount percentage. (7 Marks)
Hint:
--Compute discount percentage using ((Original Price - Discounted Price) / Original Price) * 100,
--order by discount_percentage DESC LIMIT 1.*/
t4
select top 1 d.product_name,s.discount as discount_percent
from Product_Details as d join Product_Sales as s
on d.product_id=s.prod_id
order by discount_percent desc

/*3. Find the product category with the highest average price. (8 Marks)
Hint:
--Use AVG(price), group by category_name, and order results in descending order.*/
t4

select category_name,avg(cast(price as float)) as avg_price
from product_details
group by category_name
order by avg_price desc

/*4. Determine the product with the lowest price fluctuation (least difference between original and discounted price). (8 Marks)
Hint:
--Compute price fluctuation using ABS(Original Price - Discounted Price),
--order by price_fluctuation ASC LIMIT 1.*/

select top 1 d.product_name,
(cast(s.price as int)*s.discount / 100.0)as price_fluctuation
from product_details as d join product_sales as s 
on d.product_id = s.prod_id
order by price_fluctuation asc

/*6. Find the category with the highest total revenue contribution.
Hint:
--Calculate revenue per category and compare to total revenue using Sub-query.*/
t4

select top 1 d.category_name,sum(cast(s.price as int) * s.qty) as category_revenue
from product_details as d
join product_sales as s on d.product_id = s.prod_id
group by d.category_name
order by category_revenue desc
