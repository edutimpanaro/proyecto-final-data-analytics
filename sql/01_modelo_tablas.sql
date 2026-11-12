-- ============================================================
-- PROYECTO FINAL: separar ventas_raw en un modelo de 4 tablas
-- Origen: dbo.ventas_raw (sales_data.csv importado desde Kaggle)
--
-- Por qué estas tablas:
--  * geografia : cada ciudad pertenece a una sola region (se verificó)
--  * categorias: cada subcategoria pertenece a una sola categoria (se verificó)
--  * clientes  : solo Customer_ID, porque region/segmento/ciudad cambian
--                de un pedido a otro del mismo cliente en este dataset
--  * ventas    : una fila por pedido (Order_ID es unico)
-- Product_ID no se usa como tabla: cada codigo aparece con varios
-- precios y categorias, asi que no identifica a un producto real.
-- ============================================================
USE ProyectoFinal;
GO

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS geografia;
DROP TABLE IF EXISTS categorias;
GO

CREATE TABLE geografia (
    ciudad VARCHAR(50) PRIMARY KEY,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE categorias (
    subcategoria VARCHAR(50) PRIMARY KEY,
    categoria    VARCHAR(50) NOT NULL
);

CREATE TABLE clientes (
    customer_id      VARCHAR(20) PRIMARY KEY,
    primera_compra   DATE NOT NULL,
    cantidad_pedidos INT  NOT NULL
);
GO

INSERT INTO geografia (ciudad, region)
SELECT DISTINCT City, Region FROM dbo.ventas_raw;

INSERT INTO categorias (subcategoria, categoria)
SELECT DISTINCT Subcategory, Category FROM dbo.ventas_raw;

INSERT INTO clientes (customer_id, primera_compra, cantidad_pedidos)
SELECT Customer_ID, MIN(Order_Date), COUNT(*)
FROM dbo.ventas_raw
GROUP BY Customer_ID;
GO

CREATE TABLE ventas (
    order_id        VARCHAR(20)   PRIMARY KEY,
    order_date      DATE          NOT NULL,
    customer_id     VARCHAR(20)   NOT NULL REFERENCES clientes(customer_id),
    ciudad          VARCHAR(50)   NOT NULL REFERENCES geografia(ciudad),
    subcategoria    VARCHAR(50)   NOT NULL REFERENCES categorias(subcategoria),
    segmento        VARCHAR(30)   NOT NULL,
    canal           VARCHAR(30)   NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    descuento       DECIMAL(5,4)  NOT NULL,
    ventas_brutas   DECIMAL(12,2) NOT NULL,
    descuento_monto DECIMAL(12,2) NOT NULL,
    ventas_netas    DECIMAL(12,2) NOT NULL,
    costo           DECIMAL(12,2) NOT NULL,
    ganancia        DECIMAL(12,2) NOT NULL,
    dias_envio      INT           NOT NULL,
    devuelto        VARCHAR(3)    NOT NULL,
    satisfaccion    INT           NOT NULL,
    metodo_pago     VARCHAR(30)   NOT NULL
);
GO

INSERT INTO ventas
SELECT
    Order_ID, Order_Date, Customer_ID, City, Subcategory, Segment, Channel,
    Quantity,
    CAST(Unit_Price_INR      AS DECIMAL(12,2)),
    CAST(Discount            AS DECIMAL(5,4)),
    CAST(Sales_INR           AS DECIMAL(12,2)),
    CAST(Discount_Amount_INR AS DECIMAL(12,2)),
    CAST(Net_Sales_INR       AS DECIMAL(12,2)),
    CAST(Cost_INR            AS DECIMAL(12,2)),
    CAST(Profit_INR          AS DECIMAL(12,2)),
    Shipping_Days, Returned, Customer_Satisfaction, Payment_Method
FROM dbo.ventas_raw;
GO

-- Controles: ventas tiene que dar 15000 filas y suma bruta ~80951484,
-- clientes 2496, geografia 20, categorias 20
SELECT
    (SELECT COUNT(*)           FROM ventas)     AS filas_ventas,
    (SELECT SUM(ventas_brutas) FROM ventas)     AS ventas_brutas,
    (SELECT COUNT(*)           FROM clientes)   AS filas_clientes,
    (SELECT COUNT(*)           FROM geografia)  AS filas_geografia,
    (SELECT COUNT(*)           FROM categorias) AS filas_categorias;
GO