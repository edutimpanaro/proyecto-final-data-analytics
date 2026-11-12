USE ProyectoFinal;
GO

SELECT
    c.customer_id  AS cliente,
    v.order_date   AS fecha_compra,
    v.ventas_netas AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.customer_id = c.customer_id
WHERE v.order_date >= DATEADD(DAY, -30, (SELECT MAX(order_date) FROM ventas))
ORDER BY v.order_date DESC;
GO