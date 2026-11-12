-- ============================================================
-- Paso 7: validación contra Power BI
-- La medida Ventas Netas del dashboard tiene que dar lo mismo:
-- 72.271.513,68 INR, con 15.000 pedidos y 2.496 clientes únicos.
-- ============================================================
USE ProyectoFinal;
GO

SELECT SUM(ventas_netas)            AS ventas_netas,
       COUNT(DISTINCT order_id)     AS pedidos,
       COUNT(DISTINCT customer_id)  AS clientes_unicos
FROM ventas;
GO
