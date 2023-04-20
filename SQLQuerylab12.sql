USE productsdb;

CREATE TRIGGER Products_INSERT_UPDATE
ON Products
AFTER INSERT, UPDATE
AS
UPDATE Products
SET Price = Price + Price * 0.38
WHERE Id = (SELECT Id FROM inserted)

INSERT INTO Products(ProductName,ProductCount, Manufacturer,Price)
VALUES ('iPhone X', 2, 'Apple', 68000)
SELECT * FROM Products
------
DROP TRIGGER Products_INSERT_UPDATE
------
DISABLE TRIGGER Products_INSERT_UPDATE ON Products

ENABLE TRIGGER Products_INSERT_UPDATE ON Products
---Триггеры для операций INSERT, UPDATE, DELETE-----
--добавление
USE productsdb;
CREATE TABLE History
(
 Id INT IDENTITY PRIMARY KEY,
 ProductId INT NOT NULL,
 Operation NVARCHAR(200) NOT NULL,
 CreateAt DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TRIGGER Products_INSERT
ON Products
AFTER INSERT
AS
INSERT INTO History (ProductId, Operation)
SELECT Id, 'Добавлен товар ' + ProductName + ' фирма ' + Manufacturer
FROM INSERTED

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES('iPhone X', 'Apple', 2, 79900)
SELECT * FROM History---удалениеCREATE TRIGGER Products_DELETE
ON Products
AFTER DELETE
AS
INSERT INTO History (ProductId, Operation)
SELECT Id, 'Удален товар ' + ProductName + ' фирма ' + Manufacturer
FROM DELETEDDELETE FROM Products
WHERE Id=2
SELECT * FROM History

----Изменение 
CREATE TRIGGER Products_UPDATE
ON Products
AFTER UPDATE
AS
INSERT INTO History (ProductId, Operation)
SELECT Id, 'Обновлен товар ' + ProductName + ' фирма ' + Manufacturer
FROM INSERTED

INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES('C350', 'Motorola',10,2100);
UPDATE Products SET Manufacturer='Moto'
WHERE Manufacturer='Motorola';
SELECT * FROM History

---Триггер INSTEAD OF---
CREATE DATABASE prods;
GO
USE prods;
CREATE TABLE Products
(
 Id INT IDENTITY PRIMARY KEY,
 ProductName NVARCHAR(30) NOT NULL,
 Manufacturer NVARCHAR(20) NOT NULL,
 Price MONEY NOT NULL,
 IsDeleted BIT NULL
);

USE prods
GO
CREATE TRIGGER products_delete
ON Products
INSTEAD OF DELETE
AS
UPDATE Products
SET IsDeleted = 1
WHERE ID =(SELECT Id FROM deleted)INSERT INTO Products(ProductName, Manufacturer, Price)
VALUES ('iPhone X', 'Apple', 79000),
('Pixel 2', 'Google', 60000);
DELETE FROM Products
WHERE ProductName='Pixel 2';
SELECT * FROM Products;