-- ============================================================
-- Paso 5: validación estadística del ticket promedio
-- Resultado: media 4.818, mediana 3.463, Q1 1.793, Q3 6.230,
-- IQR 4.437, límite superior 12.886. Hay 875 pedidos atípicos
-- (5,8%) que suman 16,23 M, el 22,5% de las ventas netas.
-- ============================================================
USE ProyectoFinal;
GO

-- Media, mediana, cuartiles y límites del IQR
WITH q AS (
  SELECT DISTINCT
    AVG(ventas_netas) OVER () AS media,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY ventas_netas) OVER () AS mediana,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ventas_netas) OVER () AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY ventas_netas) OVER () AS q3
  FROM ventas
)
SELECT media, mediana, q1, q3, q3 - q1 AS iqr,
       q1 - 1.5 * (q3 - q1) AS limite_inferior,
       q3 + 1.5 * (q3 - q1) AS limite_superior
FROM q;

-- Pedidos atípicos, cuánto suman y qué porcentaje del total
WITH q AS (
  SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ventas_netas) OVER () AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY ventas_netas) OVER () AS q3
  FROM ventas
)
SELECT COUNT(*) AS ventas_atipicas,
       SUM(v.ventas_netas) AS monto_atipicas,
       SUM(v.ventas_netas) * 100.0 / (SELECT SUM(ventas_netas) FROM ventas) AS pct_del_total
FROM ventas v CROSS JOIN q
WHERE v.ventas_netas > q.q3 + 1.5 * (q.q3 - q.q1);
GO
