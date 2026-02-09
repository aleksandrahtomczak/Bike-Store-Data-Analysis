WITH order_values AS
	(SELECT order_id,
			SUM(quantity * list_price * (1 - discount)) AS order_value
	FROM order_items
	GROUP BY order_id)

SELECT store_name,
		ROUND(SUM(order_value),2) as total_sale
FROM order_values
	LEFT JOIN orders
	ON orders.order_id = order_values.order_id
	LEFT JOIN stores
	ON stores.store_id = orders.store_id
	GROUP BY store_name
	ORDER BY total_sale DESC;