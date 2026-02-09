SELECT  CONCAT(s.first_name, ' ', s.last_name) AS employee,
		s.manager_id,
		ISNULL(ROUND(SUM(quantity * list_price * (1 - discount)),2), 0) AS total_revenue,
		COUNT(DISTINCT o.order_id) AS orders_placed
FROM order_items AS oi
		LEFT JOIN orders AS o
		ON o.order_id = oi.order_id
		RIGHT JOIN staffs AS s
		ON s.staff_id=o.staff_id
GROUP BY CONCAT(s.first_name, ' ', s.last_name), s.manager_id
ORDER BY total_revenue DESC;

	
	