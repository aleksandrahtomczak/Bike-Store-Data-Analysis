WITH order_details AS
	(SELECT YEAR(orders.order_date) AS year,
			MONTH(orders.order_date) AS month,
			SUM(quantity * list_price * (1 - discount)) AS order_value,
			store_name
	FROM order_items
		LEFT JOIN orders
		ON orders.order_id = order_items.order_id
		LEFT JOIN stores
		ON stores.store_id = orders.store_id
	GROUP BY orders.order_id, 
			stores.store_name, 
			YEAR(orders.order_date),
			MONTH(orders.order_date)),
	
	sales AS
	(SELECT store_name,
			year,
			month,
			SUM(order_value) AS total_sales
	FROM order_details
	GROUP BY store_name, year, month),
	
	ranked AS
	(SELECT store_name,
			year,
			month,
			total_sales,
			RANK() OVER(PARTITION BY year, month ORDER BY total_sales DESC) AS rnk
	FROM sales
	GROUP BY store_name, year, month, total_sales)

SELECT store_name,
		year,
		month,
		total_sales
FROM ranked
	WHERE rnk = 1
	GROUP BY store_name, year, month, total_sales, rnk
	ORDER BY year, month, total_sales DESC;