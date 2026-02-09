SELECT YEAR(orders.order_date) AS year,
		MONTH(orders.order_date) AS month,
		SUM(quantity * list_price * (1 - discount)) AS total_revenue,
		COUNT(DISTINCT orders.order_id) AS orders_placed,
		ROUND(CAST(SUM(quantity) AS float)/CAST(COUNT(DISTINCT orders.order_id) AS float),2) AS avg_quantity
FROM order_items
		LEFT JOIN orders
		ON orders.order_id = order_items.order_id
GROUP BY YEAR(orders.order_date),
			MONTH(orders.order_date)
ORDER BY year, month;

	
	