SELECT 	CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
		c.email,
		ROUND(SUM(oi.list_price * (1 -  oi.discount) * oi.quantity),2) AS Total_Spend,
		CAST(MIN(o.order_date) AS date) AS First_order,
		CAST(MAX(o.order_date) AS date) AS Recent_order
		FROM order_items AS oi
		LEFT JOIN orders AS o
		ON oi.order_id=o.order_id
		LEFT JOIN customers AS c
		ON c.customer_id=o.customer_id
		GROUP BY CONCAT(c.first_name, ' ', c.last_name), c.email
		HAVING COUNT(DISTINCT oi.order_id) > 2;