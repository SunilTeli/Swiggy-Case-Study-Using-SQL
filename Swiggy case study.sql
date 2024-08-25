-- Find customers who have never ordered ? 

select name from users where user_id not in (select user_id from orders);

-- Average Price/dish ?

select f.f_name,avg(price) as 'avg price'
 from menu
 m join food f on m.f_id=f.f_id 
 group by f.f_name;
 
--  Find the top restaurant in terms of the number of orders for a given month ?

select r.r_name,count(*) as months                                        
 from orders o 
 join restaurants r on o.r_id=r.r_id
where monthname(o.date) like "may"
group by r.r_name
order by months desc limit 1;

--  restaurants with monthly sales greater than x for ?

select r.r_name,sum(amount) as revenue
from orders o join restaurants r on o.r_id=r.r_id
where monthname(date) like"june"
group by r.r_name
having revenue > 500

--  Show all orders with order details for a particular customer in a particular date range?

select o.order_id,r.r_name,f.f_name
from orders o join restaurants r on r.r_id=o.r_id join order_details 
od on o.order_id=od.order_id join food f on f.f_id=od.f_id where user_id=
(select user_id from users where name like 'ankit') and (date > '2022-06-10' and date < '2022-07-10')

-- Find restaurants with max repeated customers ?

select r.r_name,count(*) as loyal_customers
 from (select r_id,user_id,count(*) as visits
from orders
 group by  
r_id,user_id having count(*)>1) t join restaurants r on r.r_id=t.r_id group by r.r_id,r.r_name
 order by loyal_customers 
desc limit 1;



--  Month over month revenue growth of swiggy?

WITH sales AS (
    SELECT monthname(date) AS month, MONTH(date) AS month_num, SUM(amount) AS revenue
    FROM orders
    GROUP BY monthname(date), MONTH(date)
    ORDER BY MONTH(date)
)
SELECT month, ((revenue - prev) / prev) * 100 AS percent_change
FROM (
    SELECT month, revenue, LAG(revenue, 1) OVER (ORDER BY month_num) AS prev
    FROM sales
) t;


-- Customer - favorite food?








