SELECT COUNT(*) AS ventas_ultimos_30_dias
FROM ventas
WHERE order_date >= DATEADD(DAY, -30, (SELECT MAX(order_date) FROM ventas));