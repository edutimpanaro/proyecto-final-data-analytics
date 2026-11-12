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