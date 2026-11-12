-- ============================================================
-- Paso 2: nombres finales del modelo
--  * la tabla categorias pasa a llamarse productos, y su clave
--    subcategoria pasa a ser tipo_producto (cada fila es un tipo
--    de producto, por ejemplo Laptops, Chairs o Makeup)
--  * en ventas, la columna subcategoria pasa a ser tipo_producto
--  * las claves foráneas toman nombres legibles para el diagrama ER
-- ============================================================
USE ProyectoFinal;
GO

EXEC sp_rename 'categorias', 'productos';
EXEC sp_rename 'productos.subcategoria', 'tipo_producto', 'COLUMN';
EXEC sp_rename 'ventas.subcategoria', 'tipo_producto', 'COLUMN';
GO

DECLARE @n NVARCHAR(200);

SELECT @n = name FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('ventas') AND referenced_object_id = OBJECT_ID('clientes');
EXEC sp_rename @n, 'FK_ventas_clientes', 'OBJECT';

SELECT @n = name FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('ventas') AND referenced_object_id = OBJECT_ID('geografia');
EXEC sp_rename @n, 'FK_ventas_geografia', 'OBJECT';

SELECT @n = name FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('ventas') AND referenced_object_id = OBJECT_ID('productos');
EXEC sp_rename @n, 'FK_ventas_productos', 'OBJECT';
GO
