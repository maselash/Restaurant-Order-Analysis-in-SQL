--Code to answer questions in Objective 1
--View the orders table
SELECT *
from order_details

--What is the date range of the table
SELECT order_date
FROM order_details
order by order_date DESC

--Another way to answer the question above 
SELECT MIN(order_date), MAX(order_date)
from order_details

--How many orders were made within this date range 
SELECT COUNT (DISTINCT order_id)
from order_details

--How many items were ordered within this date range
SELECT count (item_id)
from order_details

--Another way to answer the question above 
SELECT COUNT (*)
from order_details

-- Which orders had the most number of items?
SELECT order_id, COUNT(item_id) as num_items
from order_details
GROUP by order_id
ORDER by num_items DESC

--How many orders had more than 12 items 
--We have to count our query - so we are going to make it a sub query
SELECT COUNT (*)
from 
(SELECT order_id, COUNT(item_id) as num_items
from order_details
GROUP by order_id
HAVING num_items > 12) as num_orders

--Objective 3 questions 
-- Combine the menu_items and order_details into a single table
--When joining tables you shoul start with the transactions table
select *
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
--Another way to do it by abbr the table names
SELECT*
FROm order_details od LEFT JOIN menu_items mi
on od.item_id = mi.menu_item_id


--What were the least and most ordered items?
SELECT menu_items.item_name, COUNT(order_details.item_id) as num_ordered
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
GROUP by item_name 
order by num_ordered DESC
--Least ordered item is Chicken tacos and Most ordered item is Hamburger

--What categories were they in?
SELECT menu_items.item_name, menu_items.category, COUNT(order_details.item_id) as num_ordered
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
GROUP by item_name 
order by num_ordered DESC
-- Chicken tacos in the Mexican category and Hamburger from American

--What were the top 5 orders that spent the most money 
select order_details.order_id, SUM(menu_items.price) as cost_order
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
group by order_details.order_id 
ORDER by cost_order DESC
LIMIT 5
--Top 5 orders were from Order ID 440, 2075, 1957, 330, 2675

--View the details of the highest spend order
select order_details.order_id, menu_items.item_name, menu_items.category, SUM(menu_items.price) as cost_order
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
group by order_details.order_id 
ORDER by cost_order DESC
-- 440 is Hot dog American, 2075 is cheese burger American, the other two are Hot dogs and the 5th is Hamburger

-- What insights can gather from the results 
-- The American category is the most ordered category - ordering Hot dogs and cheese burgers the most

--Another way of doing it 
SELECT category, COUNT (item_id) as num_items
from order_details od LEFT JOIN menu_items mi
on od.item_id - mi.menu_item_id
WHERE order_id = 440
GROUP by category

--View the details of the top 5 highest spend orders. What insights can you gather from the results 
select order_details.order_id, menu_items.item_name, menu_items.category, SUM(menu_items.price) as cost_order
from menu_items LEFT JOIN order_details
on menu_items.menu_item_id = order_details.item_id
group by order_details.order_id 
ORDER by cost_order DESC
