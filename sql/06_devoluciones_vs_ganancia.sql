-- ============================================================
-- Paso 6: por qué la ganancia de 1.095 pedidos no cierra
-- Compara la ganancia del dataset con la esperada (ventas netas
-- menos costo), según el pedido haya sido devuelto (1) o no (0).
-- Resultado: en los no devueltos coincide; en los devueltos la
-- ganancia del dataset es el 72% de la esperada (1,50 M contra 2,09 M).
-- ============================================================
USE ProyectoFinal;
GO

SELECT devuelto,
       COUNT(*)                   AS pedidos,
       SUM(ventas_netas)          AS ventas_netas,
       SUM(ventas_netas - costo)  AS ganancia_esperada,
       SUM(ganancia)              AS ganancia_en_dataset
FROM ventas
GROUP BY devuelto;
GO
