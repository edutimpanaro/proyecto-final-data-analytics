# Análisis de ventas: qué vende, qué rinde y qué se devuelve

Proyecto integrador final del curso de **Data Analytics de Coderhouse** (noviembre 2026).

**Herramientas:** SQL Server · Power Query · DAX · Power BI

## Pregunta de negocio

¿Cómo evolucionaron las ventas de la empresa en 2024 y 2025, qué categorías las sostienen y qué pasó en diciembre de 2025?

KPIs seguidos: ventas netas, ganancia y margen, cantidad de pedidos, ticket promedio (junto con la mediana) y tasa de devolución.

## Dataset

*Indian Retail Sales Analytics Dataset* (Kaggle, usuario vigneshpgd). Es un dataset **sintético** de comercio minorista: 15.000 pedidos y 22 columnas, del 1/1/2024 al 31/12/2025, con importes en rupias (INR). Está en [`data/sales_data.csv`](data/sales_data.csv).

## Modelo de datos

La tabla original (`ventas_raw`) se separó en un modelo de 4 tablas: `ventas` (una fila por pedido), `clientes`, `geografia` y `productos`.

![Diagrama entidad-relación](img/diagrama_ER.jpg)

## Contenido del repositorio

| Carpeta | Qué hay |
|---|---|
| [`sql/`](sql) | Scripts de SQL Server: creación y carga del modelo, nombres de claves foráneas y consultas de los últimos 30 días |
| [`dashboard/`](dashboard) | Dashboard de Power BI (`.pbix`) |
| [`informe/`](informe) | Informe completo en PDF: preguntas teóricas, EDA, modelo, limpieza, dashboard y conclusiones |
| [`data/`](data) | Dataset original en CSV |
| [`img/`](img) | Diagrama entidad-relación |

## Principales hallazgos

| Indicador | Valor |
|---|---|
| Ventas netas | 72,27 M INR |
| Ganancia | 27,28 M INR (margen 37,7%) |
| Crecimiento de ventas netas 2025 vs 2024 | +2,6% |
| Tasa de devolución | 7,3% de los pedidos |
| Ticket promedio / mediana | 4.818 / 3.463 |

- **Las ventas son estables:** crecieron 2,6%, sobre todo por volumen de pedidos.
- **Tecnología vende más, pero no es la que más gana:** aporta el 28,4% de las ventas con el margen más bajo (31,2%). Office Supplies gana más con menos ventas (margen 42,0%).
- **Online concentra el 57,7% de las ventas.** Los tres canales tienen el mismo margen.
- **Las regiones se diferencian por volumen, no por precio.** El ticket y el margen son casi iguales en las cinco.
- **Las devoluciones son parejas** (6,7% a 7,9%) en todos los canales y categorías.
- **El ticket promedio no representa a un pedido típico:** el 5,8% de los pedidos concentra el 22,5% de las ventas.
- **Diciembre de 2025 cerró 12,5% por debajo de noviembre,** pero es un solo mes y no alcanza para hablar de tendencia.

El detalle y las recomendaciones están en el [informe](informe/Proyecto_Final_Timpanaro_Eduardo.pdf).

## Cómo reproducirlo

1. Importar `data/sales_data.csv` en SQL Server como `dbo.ventas_raw` en una base llamada `ProyectoFinal`.
2. Ejecutar los scripts de `sql/` en orden (01 a 04).
3. Abrir `dashboard/Dashboard_Ventas.pbix` con Power BI Desktop y actualizar el origen de datos si hace falta.

## Autor

Eduardo Timpanaro
