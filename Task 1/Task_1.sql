SELECT TOP 5 CONCAT(first_name, ' ', last_name) AS name,
		email,
		SUM(quantity * list_price * (1 - discount)) AS order_value,
		COUNT(DISTINCT orders.order_id) AS orders_no
FROM customers
LEFT JOIN orders
	ON orders.customer_id = customers.customer_id
LEFT JOIN order_items
	ON orders.order_id = order_items.order_id
	GROUP BY CONCAT(first_name, ' ', last_name), email
	ORDER BY order_value DESC;

