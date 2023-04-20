CREATE DATABASE productsdb;
GO
USE productsdb;
CREATE TABLE Products
(
 Id INT IDENTITY PRIMARY KEY,
 ProductName NVARCHAR(30) NOT NULL,
 Manufacturer NVARCHAR(20) NOT NULL,
 ProductCount INT DEFAULT 0,
 Price MONEY NOT NULL
)
----INSERT---
INSERT Products VALUES ('iPhone 7', 'Apple', 5, 52000)
----
INSERT INTO Products (ProductName, Price, Manufacturer)
	VALUES ('iPhone 6S', 41000, 'Apple')
-----
INSERT INTO Products
VALUES
	('iPhone 6', 'Apple', 3, 36000),
	('Galaxy S8', 'Samsung', 2, 46000),
	('Galaxy S8 Plus', 'Samsung', 1, 56000)
-----
INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES ('Mi6', 'Xiaomi', DEFAULT, 28000)INSERT INTO Products
DEFAULT VALUES-----DROP TABLE Products;---------������� ������. ������� SELECT----CREATE TABLE Products
(
 Id INT IDENTITY PRIMARY KEY,
 ProductName NVARCHAR(30) NOT NULL,
 Manufacturer NVARCHAR(20) NOT NULL,
 ProductCount INT DEFAULT 0,
 Price MONEY NOT NULL
);

INSERT INTO Products
VALUES
	('iPhone 6', 'Apple', 3, 36000),
	('iPhone 6S', 'Apple', 2, 41000),
	('iPhone 7', 'Apple', 5, 52000),
	('Galaxy S8', 'Samsung', 2, 46000),
	('Galaxy S8 Plus', 'Samsung', 1, 56000),
	('Mi6', 'Xiaomi', 5, 28000),
	('OnePlus 5', 'OnePlus', 6, 38000)
----------
SELECT * FROM Products
--------
SELECT ProductName, Price FROM Products
-----
SELECT ProductName + ' (' + Manufacturer + ')', Price, Price * ProductCount
FROM Products
------------
SELECT
ProductName + ' (' + Manufacturer + ')' AS ModelName, 
	Price,Price * ProductCount AS TotalSum
FROM Products
--------
SELECT DISTINCT Manufacturer
FROM Products
----------
SELECT ProductName + ' (' + Manufacturer + ')' AS ModelName, Price
INTO ProductSummary
FROM Products

SELECT * FROM ProductSummary
-------
INSERT INTO ProductSummary
SELECT ProductName + ' (' + Manufacturer + ')' AS ModelName, 
	Price
FROM Products
-----------

-----C���������-----
------
SELECT *
FROM Products
ORDER BY ProductName----SELECT ProductName, ProductCount * Price AS TotalSum
FROM Products
ORDER BY TotalSum
----
SELECT ProductName
FROM Products
ORDER BY ProductName DESC
------
SELECT ProductName
FROM Products
ORDER BY ProductName ASC------SELECT ProductName, Price, ManufacturerFROM ProductsORDER BY Manufacturer, ProductName-----SELECT ProductName, Price, Manufacturer
FROM Products
ORDER BY Manufacturer ASC, ProductName DESC-----SELECT ProductName, Price, ProductCount
FROM Products
ORDER BY ProductCount * Price-------------���������� ��������� �����----------- �������� ���SELECT TOP 4 ProductName
FROM Products
--------
SELECT TOP 75 PERCENT ProductName
FROM Products
-------- �������� OFFSET
SELECT * FROM Products
ORDER BY Id
 OFFSET 2 ROWS;
-------�������� FETCH
SELECT * FROM Products
ORDER BY Id
 OFFSET 2 ROWS
 FETCH NEXT 3 ROWS ONLY;
-------
----����������. WHERE---------
SELECT * FROM Products
WHERE Manufacturer = 'Samsung'
-----
SELECT * FROM Products
WHERE Price > 45000-----SELECT * FROM Products
WHERE Price * ProductCount > 200000
--------������������� ���������
SELECT * FROM Products
WHERE Manufacturer = 'Samsung' AND Price > 50000------------
SELECT * FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 50000--------SELECT * FROM Products
WHERE NOT Manufacturer = 'Samsung'
---------
SELECT * FROM Products
WHERE Manufacturer <> 'Samsung'---------SELECT * FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 30000 AND ProductCount > 2
------IS NULL
SELECT * FROM Products
WHERE ProductCount IS NULL
---------
SELECT * FROM Products
WHERE ProductCount IS NOT NULL
---------

---��������� ����������-----
--�������� IN
SELECT * FROM Products
WHERE Manufacturer IN ('Samsung', 'Xiaomi', 'Huawei')
-----
SELECT * FROM Products
WHERE Manufacturer NOT IN ('Samsung', 'Xiaomi', 'Huawei')
-------�������� BETWEEN
SELECT * FROM Products
WHERE Price BETWEEN 20000 AND 40000--------SELECT * FROM Products
WHERE Price NOT BETWEEN 20000 AND 40000---------SELECT * FROM Products
WHERE Price * ProductCount BETWEEN 100000 AND 200000
---------������� LIKE
SELECT * FROM Products
WHERE ProductName LIKE 'iPhone [6-8]%'
--------
-------���������� ������. ������� UPDATE---------
UPDATE Products
SET Price = Price + 5000
SELECT * FROM Products
--------
UPDATE Products
SET Manufacturer = 'Samsung Inc.'
WHERE Manufacturer = 'Samsung'------
UPDATE Products
SET Manufacturer = 'Apple Inc.'
FROM
(SELECT TOP 2 FROM Products WHERE Manufacturer='Apple') AS Selected
WHERE Products.Id = Selected.Id
-------
-------�������� ������. ������� DELETE------------
-------
DELETE Products
WHERE Id=9------DELETE Products
WHERE Manufacturer='Xiaomi' AND Price < 15000
-------
DELETE Products FROM
	(SELECT TOP 2 * FROM Products
		WHERE Manufacturer='Apple') AS Selected
WHERE Products.Id = Selected.Id
-----
DELETE Products