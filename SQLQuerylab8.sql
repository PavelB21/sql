USE productsdb;

SELECT LEN('Apple')

SELECT LTRIM(' Apple')

SELECT LTRIM(' Apple')
SELECT RTRIM(' Apple ')SELECT CHARINDEX('pl', 'Apple')
SELECT PATINDEX('%p_e%', 'Apple') 

SELECT LEFT('Apple', 3)

SELECT RIGHT('Apple', 3)

SELECT SUBSTRING('Galaxy S8 Plus', 8, 2)

SELECT REPLACE('Galaxy S8 Plus', 'S8 Plus', 'Note 8')

SELECT REVERSE('123456789')

SELECT CONCAT('Tom', ' ', 'Smith') 

SELECT LOWER('Apple') 

SELECT UPPER('Apple') 
-----
CREATE TABLE Products
(
 Id INT IDENTITY PRIMARY KEY,
 ProductName NVARCHAR(30) NOT NULL,
 Manufacturer NVARCHAR(20) NOT NULL,
 ProductCount INT DEFAULT 0,
 Price MONEY NOT NULL
);INSERT INTO Products
VALUES ('iPhone 6', 'Apple', 2, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi 5X', 'Xiaomi', 2, 26000),('OnePlus 5', 'OnePlus', 6, 38000)------SELECT CONCAT('Tom', SPACE(2), 'Smith');SELECT UPPER(LEFT(Manufacturer,2)) AS Abbreviation,
 CONCAT(ProductName, ' - ', Manufacturer) AS FullProdName
FROM Products
ORDER BY Abbreviation
------Функции для работы с числами
SELECT ROUND(1342.345, 2) 
SELECT ROUND(1342.345, -2) 

SELECT ISNUMERIC(1342.345) 
SELECT ISNUMERIC('1342.345') 
SELECT ISNUMERIC('SQL') 
SELECT ISNUMERIC('13-04-2017')

SELECT ABS(-123) 

SELECT CEILING(-123.45) 
SELECT CEILING(123.45) 

SELECT FLOOR(-123.45)
SELECT FLOOR(123.45) 

SELECT SQUARE(5)

SELECT SQRT(225)

SELECT RAND() 
SELECT RAND()

SELECT COS(1.0472)

SELECT SIN(1.5708)

SELECT TAN(0.7854)

SELECT ProductName, ROUND(Price * ProductCount, 2)
FROM Products

--------------Функции по работе с датами и временемSELECT GETDATE() SELECT GETUTCDATE()SELECT SYSDATETIME()SELECT SYSUTCDATETIME()SELECT SYSDATETIMEOFFSET() SELECT DAY(GETDATE())SELECT MONTH(GETDATE())SELECT YEAR(GETDATE())SELECT DATENAME(month, GETDATE())SELECT DATEPART(month, GETDATE())SELECT DATEADD(month, 2, '2023-03-30') 
SELECT DATEADD(day, 5, '2023-03-30') 
SELECT DATEADD(day, -5, '2023-03-30')

SELECT DATEDIFF(year, '2017-7-28', '2018-9-28') 
SELECT DATEDIFF(month, '2017-7-28', '2018-9-28')
SELECT DATEDIFF(day, '2017-7-28', '2018-9-28') 

SELECT TODATETIMEOFFSET('2017-7-28 01:10:22', '+03:00')

SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+02:30')

SELECT EOMONTH('2017-02-05')
SELECT EOMONTH('2017-02-05', 3)

SELECT DATEFROMPARTS(2017, 7, 28) 

SELECT ISDATE('2017-07-28') -- 1
SELECT ISDATE('2017-28-07') -- 0
SELECT ISDATE('28-07-2017') -- 0
SELECT ISDATE('SQL')

-----
CREATE TABLE Orders
(
 Id INT IDENTITY PRIMARY KEY,
 ProductId INT NOT NULL,
 CustomerId INT NOT NULL,
 CreatedAt DATE NOT NULL DEFAULT GETDATE(),
 ProductCount INT DEFAULT 1,
 Price MONEY NOT NULL
);

DROP TABLE Customers

CREATE TABLE Customers
(
 Id INT IDENTITY PRIMARY KEY,
 FirstName NVARCHAR(30) NOT NULL
);

INSERT INTO Customers VALUES ('Tom'), ('Bob'),('Sam')

INSERT INTO Orders
VALUES
(
 (SELECT Id FROM Products WHERE ProductName='Galaxy S8'),
 (SELECT Id FROM Customers WHERE FirstName='Tom'),
 '2023-03-11',
 2,
 (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
(
 (SELECT Id FROM Products WHERE ProductName='iPhone 6S'),
 (SELECT Id FROM Customers WHERE FirstName='Tom'),
 '2023-03-13',
 1,
 (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
(
 (SELECT Id FROM Products WHERE ProductName='iPhone 6S'),
 (SELECT Id FROM Customers WHERE FirstName='Bob'),
 '2023-03-14',
 1,
 (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
)-----SELECT * FROM Orders
WHERE DATEDIFF(day, CreatedAt, GETDATE()) = 16

--------------------Преобразование данныхSELECT Id, CAST(CreatedAt AS nvarchar) + '; total: ' + CAST(Price * ProductCount AS nvarchar)
FROM Orders

SELECT CONVERT(nvarchar, CreatedAt, 3),
 CONVERT(nvarchar, Price * ProductCount, 1)
FROM Orders

SELECT TRY_CONVERT(int, 'sql')
SELECT TRY_CONVERT(int, '22')SELECT STR(123.4567, 6,2)SELECT CHAR(219)SELECT ASCII('Ы') SELECT NCHAR(1067) SELECT UNICODE('Ы')--------Функции CASE и IIFSELECT ProductName, Manufacturer,
 CASE ProductCount
 WHEN 1 THEN 'Товар заканчивается'
 WHEN 2 THEN 'Мало товара'
 WHEN 3 THEN 'Есть в наличии'
 ELSE 'Много товара'
 END AS EvaluateCount
FROM Products

SELECT ProductName, Manufacturer,
 CASE
 WHEN Price > 50000 THEN 'Категория A'
 WHEN Price BETWEEN 40000 AND 50000 THEN 'Категория B'
 WHEN Price BETWEEN 30000 AND 40000 THEN 'Категория C'
 ELSE 'Категория D'
 END AS Category
FROM Products

SELECT ProductName, Manufacturer,
 IIF(ProductCount>3, 'Много товара', 'Мало товара')
FROM Products

---Функции NEWID, ISNULL и COALESCE
CREATE TABLE Clients
(
 Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL,
 Phone NVARCHAR(20) NULL,
 Email NVARCHAR(20) NULL
)
INSERT INTO Clients (FirstName, LastName, Phone, Email)
VALUES ('Tom', 'Smith', '+36436734', NULL),
('Bob', 'Simpson', NULL, NULL)

SELECT FirstName, LastName,
 ISNULL(Phone, 'не определено') AS Phone,
 ISNULL(Email, 'неизвестно') AS Email
FROM Clients

SELECT FirstName, LastName,
 COALESCE(Phone, Email, 'не определено') AS Contacts
FROM Clients