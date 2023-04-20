USE productsdb;
DROP TABLE Products;
DROP TABLE Customers;
DROP TABLE Orders;

CREATE TABLE Products
(
 Id INT IDENTITY PRIMARY KEY,
 ProductName NVARCHAR(30) NOT NULL,
 Manufacturer NVARCHAR(20) NOT NULL,
 ProductCount INT DEFAULT 0,
 Price MONEY NOT NULL
);
CREATE TABLE Customers
(
 Id INT IDENTITY PRIMARY KEY,
 FirstName NVARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
 Id INT IDENTITY PRIMARY KEY,
 ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
 CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
 CreatedAt DATE NOT NULL,
 ProductCount INT DEFAULT 1,
 Price MONEY NOT NULL
);

INSERT INTO Products
VALUES 
	('iPhone 6', 'Apple', 2, 36000),
	('iPhone 6S', 'Apple', 2, 41000),
	('iPhone 7', 'Apple', 5, 52000),
	('Galaxy S8', 'Samsung', 2, 46000),
	('Galaxy S8 Plus', 'Samsung', 1, 56000),
	('Mi 5X', 'Xiaomi', 2, 26000),
	('OnePlus 5', 'OnePlus', 6, 38000)
INSERT INTO Customers VALUES ('Tom'), ('Bob'),('Sam')

INSERT INTO Orders
VALUES
(
	 (SELECT Id FROM Products WHERE ProductName='Galaxy S8'),
	 (SELECT Id FROM Customers WHERE FirstName='Tom'),
	 '2017-07-11',
	 2,
	 (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
(
	 (SELECT Id FROM Products WHERE ProductName='iPhone 6S'),
	 (SELECT Id FROM Customers WHERE FirstName='Tom'),
	 '2017-07-13',
	 1,
	 (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
(
	 (SELECT Id FROM Products WHERE ProductName='iPhone 6S'),
	 (SELECT Id FROM Customers WHERE FirstName='Bob'),
	 '2017-07-11',
	 1,
	 (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
)--Соединение двух таблицSELECT * FROM Orders, Customers-----SELECT * FROM Orders, CustomersWHERE Orders.Id = Customers.Id--Соединение по трем таблицамSELECT Customers.FirstName, Products.ProductName, Orders.CreatedAtFROM Orders, Customers, ProductsWHERE Orders.CustomerId = Customers.Id AND Orders.ProductId = Products.Id-----SELECT C.FirstName, P.ProductName, O.CreatedAt
FROM Orders AS O, Customers AS C, Products AS P
WHERE O.CustomerId = C.Id AND O.ProductId=P.Id----SELECT C.FirstName, P.ProductName, O.*
FROM Orders AS O, Customers AS C, Products AS P
WHERE O.CustomerId = C.Id AND O.ProductId=P.Id

----INNER JOIN
SELECT Orders.CreatedAt, Orders.ProductCount, Products.ProductName
FROM Orders
JOIN Products
	ON Products.Id = Orders.ProductId
-----
SELECT O.CreatedAt, O.ProductCount, P.ProductName
FROM Orders AS O
JOIN Products AS P
	ON P.Id = O.ProductId-----SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName
FROM Orders
JOIN Products
	ON Products.Id = Orders.ProductId
JOIN Customers
	ON Customers.Id = Orders.CustomerId
---- фильтрация выборки и сортировки
SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName
FROM Orders
JOIN Products 
	ON Products.Id = Orders.ProductId
JOIN Customers 
	ON Customers.Id=Orders.CustomerId
WHERE Products.Price < 45000
ORDER BY Customers.FirstName
-----
SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName
FROM Orders
JOIN Products 
	ON Products.Id = Orders.ProductId AND Products.Manufacturer='Apple'
JOIN Customers 
	ON Customers.Id=Orders.CustomerId
ORDER BY Customers.FirstName

----OUTER JOIN
SELECT FirstName, CreatedAt, ProductCount, Price, ProductId
FROM Orders LEFT JOIN Customers
	ON Orders.CustomerId = Customers.Id
----
SELECT FirstName, CreatedAt, ProductCount, Price, ProductId
FROM Orders RIGHT JOIN Customers
	ON Orders.CustomerId = Customers.Id
----
SELECT Customers.FirstName, Orders.CreatedAt,
		Products.ProductName, Products.Manufacturer
FROM Orders
LEFT JOIN Customers 
	ON Orders.CustomerId = Customers.Id
LEFT JOIN Products 	ON Orders.ProductId = Products.Id-----SELECT Customers.FirstName, Orders.CreatedAt,
	Products.ProductName, Products.Manufacturer
FROM Orders
LEFT JOIN Customers 
	ON Orders.CustomerId = Customers.Id
LEFT JOIN Products 
	ON Orders.ProductId = Products.Id
WHERE Products.Price < 45000
ORDER BY Orders.CreatedAt---SELECT FirstName FROM Customers
LEFT JOIN Orders ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL----SELECT Customers.FirstName, Orders.CreatedAt,
 Products.ProductName, Products.Manufacturer
FROM Orders
JOIN Products 
	ON Orders.ProductId = Products.Id AND Products.Price < 45000
LEFT JOIN Customers 
	ON Orders.CustomerId = Customers.Id
ORDER BY Orders.CreatedAt------Cross JoinSELECT *FROM OrdersCROSS JOIN Customers----Группировка в соединенияхSELECT FirstName, COUNT(Orders.Id)
FROM Customers JOIN Orders
	ON Orders.CustomerId = Customers.Id
GROUP BY Customers.Id, Customers.FirstName;----SELECT FirstName, COUNT(Orders.Id)
FROM Customers LEFT JOIN Orders
	ON Orders.CustomerId = Customers.Id
GROUP BY Customers.Id, Customers.FirstName;---SELECT Products.ProductName, Products.Manufacturer,
 SUM(Orders.ProductCount * Orders.Price) AS Units
FROM Products LEFT JOIN Orders
	ON Orders.ProductId = Products.Id
GROUP BY Products.Id, Products.ProductName, Products.Manufacturer-----UNIONDROP TABLE Products;
DROP TABLE Customers;
DROP TABLE Orders;CREATE TABLE Customers
(
	 Id INT IDENTITY PRIMARY KEY,
	 FirstName NVARCHAR(20) NOT NULL,
	 LastName NVARCHAR(20) NOT NULL,
	 AccountSum MONEY
);
CREATE TABLE Employees
(
	 Id INT IDENTITY PRIMARY KEY,
	 FirstName NVARCHAR(20) NOT NULL,
	 LastName NVARCHAR(20) NOT NULL,
);

INSERT INTO Customers VALUES
	('Tom', 'Smith', 2000),
	('Sam', 'Brown', 3000),
	('Mark', 'Adams', 2500),
	('Paul', 'Ins', 4200),
	('John', 'Smith', 2800),
	('Tim', 'Cook', 2800)

INSERT INTO Employees VALUES
	('Homer', 'Simpson'),
	('Tom', 'Smith'),
	('Mark', 'Adams'),
	('Nick', 'Svensson')
------
SELECT FirstName, LastName
FROM Customers
UNION SELECT FirstName, LastName FROM Employees
----
SELECT FirstName + ' ' +LastName AS FullName
FROM Customers
UNION SELECT FirstName + ' ' + LastName AS EmployeeName
FROM Employees
ORDER BY FullName DESC
----
SELECT FirstName, LastName, AccountSum
FROM Customers
UNION SELECT FirstName, LastName
FROM Employees----SELECT FirstName, LastName
FROM Customers
UNION SELECT Id, LastName
FROM Employees
----
SELECT FirstName, LastName
FROM Customers
UNION ALL SELECT FirstName, LastName
FROM Employees
----
SELECT FirstName, LastName, AccountSum + AccountSum * 0.1 AS TotalSum
FROM Customers WHERE AccountSum < 3000
UNION SELECT FirstName, LastName, AccountSum + AccountSum * 0.3 AS TotalSum
FROM Customers WHERE AccountSum >= 3000

-----EXCEPT
SELECT FirstName, LastName
FROM Customers
EXCEPT SELECT FirstName, LastName
FROM Employees
----
SELECT FirstName, LastName
FROM Employees
EXCEPT SELECT FirstName, LastName
FROM Customers

-----INTERSECT
SELECT FirstName, LastName
FROM Employees
INTERSECT SELECT FirstName, LastName
FROM Customers