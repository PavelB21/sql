use productsdb;
DROP TABLE ProductSummary
--создаем хранимую процедуру для извлечения данных
CREATE PROCEDURE ProductSummary AS
SELECT ProductName AS Product, Manufacturer, Price
FROM Products

EXEC ProductSummary

DROP PROCEDURE ProductSummary
---------
CREATE PROCEDURE AddProduct
 @name NVARCHAR(20),
 @manufacturer NVARCHAR(20),
 @count INT,
 @price MONEY
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES(@name, @manufacturer, @count, @price)DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20);
DECLARE @prodCount INT, @price MONEY
SET @prodName = 'Galaxy C7'
SET @company = 'Samsung'
SET @price = 22000
SET @prodCount = 5
EXEC AddProduct @prodName, @company, @prodCount, @priceSELECT * FROM Products

EXEC AddProduct 'Galaxy C7', 'Samsung', 5, 22000

DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20);
SET @prodName = 'Honor 9'
SET @company = 'Huawei'
EXEC AddProduct @name = @prodName,
 @manufacturer=@company,
 @count = 3,
 @price = 18000
 SELECT * FROM Products
 -------Необязательные параметры
 CREATE PROCEDURE AddProductWithOptionalCount
 @name NVARCHAR(20),
 @manufacturer NVARCHAR(20),
 @price MONEY,
 @count INT = 1
AS
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES(@name, @manufacturer, @count, @price)
DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20), @price MONEY
SET @prodName = 'Redmi Note 5A'
SET @company = 'Xiaomi'
SET @price = 22000
EXEC AddProductWithOptionalCount @prodName, @company, @price
SELECT * FROM Products

-------Выходные параметры и возвращение результата----
CREATE PROCEDURE GetPriceStats
 @minPrice MONEY OUTPUT,
 @maxPrice MONEY OUTPUT
AS
SELECT @minPrice = MIN(Price), @maxPrice = MAX(Price)
FROM Products

DECLARE @minPrice MONEY, @maxPrice MONEY
EXEC GetPriceStats @minPrice OUTPUT, @maxPrice OUTPUT
PRINT 'Минимальная цена ' + CONVERT(VARCHAR, @minPrice)
PRINT 'Максимальная цена ' + CONVERT(VARCHAR, @maxPrice)
-----
CREATE PROCEDURE CreateProduct
 @name NVARCHAR(20),
 @manufacturer NVARCHAR(20),
 @count INT,
 @price MONEY,
 @id INT OUTPUT
AS
 INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
 VALUES(@name, @manufacturer, @count, @price)
 SET @id = @@IDENTITY

DECLARE @id INT
EXEC CreateProduct 'LG V30', 'LG', 3, 28000, @id OUTPUT
PRINT @id
---------
CREATE PROCEDURE GetAvgPrice AS
DECLARE @avgPrice MONEY
SELECT @avgPrice = AVG(Price)
FROM Products
RETURN @avgPrice;DECLARE @result MONEY
EXEC @result = GetAvgPrice
PRINT @result