use pizzas;
desc order_details;#check the desc of table
# the total number of orders placed
SELECT 
    COUNT(order_id) AS total_order
FROM
    orders;  
 #21350
 #the total revenue generated from pizza sales
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    #817860.05
    #the highest-priced pizza
   SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
  #The Greek Pizza=35.95
#the most common pizza size ordered.
SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_qty
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_qty DESC;
#List the top 5 most ordered pizza types along with their quantities
select pizza_types.name,sum(order_details.quantity) as qty
from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by qty desc limit 5;
#Join the necessary tables to find the total quantity of each pizza category ordered
select pizza_types.category,sum(order_details.quantity) as tqnty 
from pizza_types join pizzas on
pizza_types.pizza_type_id=pizzas.pizza_type_id join order_details
on pizzas.pizza_id=order_details.pizza_id group by( pizza_types.category) order by tqnty desc;
#Determine the distribution of orders by hour of the day
select hour(order_time),count(order_id) from orders
group by  hour(order_time);
#Join relevant tables to find the category-wise distribution of pizzas
select category,count(name) from pizza_types 
group by category;
#Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(qty) from
(select orders.order_date,sum(order_details.quantity) as qty
from orders join order_details on orders.order_id=order_details.order_id
group by orders.order_date) as or_qty;
#Determine the top 3 most ordered pizza types based on revenue
select pizza_types.name,sum(order_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by  pizza_types.name order by revenue  desc limit 3;

 
 
 


