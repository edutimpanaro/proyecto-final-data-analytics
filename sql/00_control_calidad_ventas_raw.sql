-- ============================================================
-- Paso 0: control de calidad sobre la tabla original (ventas_raw)
-- Filas, pedidos duplicados, valores vacíos, rango de fechas,
-- cantidades o precios inválidos y coherencia de los importes.
-- Resultado: 15.000 filas y 15.000 pedidos, 0 duplicados, 0 vacíos,
-- fechas 2024-01-01 a 2025-12-31, 0 inválidos, 0 netos incoherentes
-- y 1.095 ganancias incoherentes (son los pedidos devueltos).
-- ============================================================
USE ProyectoFinal;
GO

SELECT
  COUNT(*)                          AS filas,
  COUNT(DISTINCT Order_ID)          AS pedidos_distintos,
  COUNT(*) - COUNT(DISTINCT Order_ID) AS duplicados,
  SUM(CASE WHEN Order_ID IS NULL OR Order_Date IS NULL OR Customer_ID IS NULL
          OR City IS NULL OR Net_Sales_INR IS NULL THEN 1 ELSE 0 END) AS filas_con_nulos,
  MIN(Order_Date) AS fecha_min,  MAX(Order_Date) AS fecha_max,
  SUM(CASE WHEN Quantity <= 0 OR Unit_Price_INR <= 0 THEN 1 ELSE 0 END) AS cantidades_o_precios_invalidos,
  SUM(CASE WHEN ABS(Net_Sales_INR - (Sales_INR - Discount_Amount_INR)) > 0.05
         THEN 1 ELSE 0 END) AS neto_incoherente,
  SUM(CASE WHEN ABS(Profit_INR - (Net_Sales_INR - Cost_INR)) > 0.05
         THEN 1 ELSE 0 END) AS ganancia_incoherente
FROM dbo.ventas_raw;
GO
