use productsdb;DECLARE @name NVARCHAR(20)DECLARE @name NVARCHAR(20), @age INTDECLARE @name NVARCHAR(20), @age INT;
SET @name='Tom';
SET @age = 18;PRINT 'Name: ' + @name;
PRINT 'Age: ' + CONVERT(CHAR, @age);DECLARE @name NVARCHAR(20), @age INT;
SET @name='Tom';
SET @age = 18;
SELECT @name, @age;

------Переменные в запросах
DECLARE @maxPrice MONEY,
 @minPrice MONEY,
 @dif MONEY,
 @count INT
SET @count = (SELECT SUM(ProductCount) FROM Orders);
SELECT @minPrice=MIN(Price), @maxPrice = MAX(Price) FROM Products
SET @dif = @maxPrice - @minPrice;
PRINT 'Всего продано: ' + STR(@count, 5) + ' товарa(ов)';
PRINT 'Разница между максимальной и минимальной ценой: ' + STR(@dif)
DECLARE @sum MONEY, @id INT, @prodid INT, @name NVARCHAR(20);
SET @id=2;
SELECT @sum = SUM(Orders.Price*Orders.ProductCount),
 @name=Products.ProductName, @prodid = Products.Id
FROM Orders
INNER JOIN Products ON ProductId = Products.Id
GROUP BY Products.ProductName, Products.Id
HAVING Products.Id=@id
PRINT 'Товар ' + @name + ' продан на сумму ' + STR(@sum)


DECLARE @lastDate DATE
SELECT @lastDate = MAX(CreatedAt) FROM Orders
IF DATEDIFF(day, @lastDate, GETDATE()) > 10
 PRINT 'За последние десять дней не было заказов'

 DECLARE @lastDate DATE
SELECT @lastDate = MAX(CreatedAt) FROM Orders
IF DATEDIFF(day, @lastDate, GETDATE()) > 10
 PRINT 'За последние десять дней не было заказов'
ELSE
 PRINT 'За последние десять дней были заказы'

DECLARE @lastDate DATE, @count INT, @sum MONEY
SELECT @lastDate = MAX(CreatedAt),
	 @count = SUM(ProductCount) ,
	 @sum = SUM(ProductCount * Price)
FROM Orders
IF @count > 0
	 BEGIN
		 PRINT 'Дата последнего заказа: ' + CONVERT(NVARCHAR, @lastDate)
		 PRINT 'Продано ' + CONVERT(NVARCHAR, @count) + ' единиц(ы)'
		 PRINT 'На общую сумму ' + CONVERT(NVARCHAR, @sum)
	 END;
ELSE
	PRINT 'Заказы в базе данных отсутствуют'

DECLARE @number INT, @factorial INT
SET @factorial = 1;
SET @number = 5;
WHILE @number > 0
	BEGIN
	 SET @factorial = @factorial * @number
	 SET @number = @number - 1
	END;
PRINT @factorial
----
CREATE TABLE #Accounts ( CreatedAt DATE, Balance MONEY)

DECLARE @rate FLOAT, @period INT, @sum MONEY, @date DATE
SET @date = GETDATE()
SET @rate = 0.065;
SET @period = 5;
SET @sum = 10000;
WHILE @period > 0
	BEGIN
		INSERT INTO #Accounts VALUES(@date, @sum)
		SET @period = @period - 1
		SET @date = DATEADD(year, 1, @date)
		SET @sum = @sum + @sum * @rate
	END;
SELECT * FROM #Accounts
-----------------------------
----Операторы BREAK и CONTINUE
DECLARE @number INT
SET @number = 1
WHILE @number < 10
	BEGIN
		 PRINT CONVERT(NVARCHAR, @number)
		 SET @number = @number + 1
		 IF @number = 7
	BREAK;
		IF @number = 4
			CONTINUE;
		PRINT 'Конец итерации'
	END;

-------Обработка ошибок
DROP TABLE #Accounts

CREATE TABLE Accounts (FirstName NVARCHAR NOT NULL, Age INT NOT NULL)
BEGIN TRY
 INSERT INTO Accounts VALUES(NULL, NULL)
 PRINT 'Данные успешно добавлены!'
END TRY
BEGIN CATCH
 PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH