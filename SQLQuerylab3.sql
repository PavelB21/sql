--—Œ«ƒ¿Õ»≈ ¡¿«€ ƒ¿ÕÕ€’
CREATE DATABASE userdb
USE userdb

----”‰‡ÎÂÌËÂ ·‡Á˚ ‰‡ÌÌ˚ı
DROP DATABASE contactsdb
--—Œ«ƒ¿Õ»≈ “¿¡À»÷€
CREATE TABLE Customers
(
	Id INT,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20)
);

--”ƒ¿À≈Õ»≈ “¿¡À»÷€
DROP TABLE Customers

--PRIMARY KEY. 
CREATE TABLE Customers
(
	Id INT PRIMARY KEY,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20)
)
DROP TABLE Customers;
--------------------

--ÔÂ‚Ë˜Ì˚È ÍÎ˛˜ Ì‡ ÛÓ‚ÌÂ Ú‡·ÎËˆ˚
CREATE TABLE Customers
(
	Id INT,
	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
	PRIMARY KEY(Id)
)
--------------------------

--ÒÓÒÚ‡‚ÌÓÈ ÔÂ‚Ë˜Ì˚È ÍÎ˛˜
CREATE TABLE OrderLines
(
	OrderId INT,
	ProductId INT,
	Quantity INT,
	Price MONEY,
	PRIMARY KEY(OrderId, ProductId)
)
---------------

--IDENTITYCREATE TABLE Customers(	Id INT PRIMARY KEY IDENTITY(2,2),	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20)
)
DROP TABLE Customers;
--------------------

--UNIQUE
CREATE TABLE Customers(	Id INT PRIMARY KEY IDENTITY,	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30) UNIQUE,
	Phone VARCHAR(20) UNIQUE
)
DROP TABLE Customers;

CREATE TABLE Customers(	Id INT PRIMARY KEY IDENTITY,	Age INT,
	FirstName NVARCHAR(20),
	LastName NVARCHAR(20),
	Email VARCHAR(30),
	Phone VARCHAR(20),
	UNIQUE(Email, Phone)
)
------------------

--NULL Ë NOT NULL
CREATE TABLE Customers
(
 Id INT PRIMARY KEY IDENTITY,
 Age INT,
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL,
 Email VARCHAR(30) UNIQUE,
 Phone VARCHAR(20) UNIQUE
)-----------DEFAULTCREATE TABLE Customers
(
 Id INT PRIMARY KEY IDENTITY,
 Age INT DEFAULT 18,
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL,
 Email VARCHAR(30) UNIQUE,
 Phone VARCHAR(20) UNIQUE
);DROP TABLE Customers;-----------CHECKCREATE TABLE Customers
(
 Id INT PRIMARY KEY IDENTITY,
 Age INT DEFAULT 18 CHECK(Age >0 AND Age < 100),
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL, Email VARCHAR(30) UNIQUE CHECK(Email !=''),
 Phone VARCHAR(20) UNIQUE CHECK(Phone !=''))-----------------CONSTRAINTCREATE TABLE Customers
(
 Id INT CONSTRAINT PK_Customer_Id PRIMARY KEY IDENTITY,
 Age INT
 CONSTRAINT DF_Customer_Age DEFAULT 18
 CONSTRAINT CK_Customer_Age CHECK(Age >0 AND Age < 100),
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL,
 Email VARCHAR(30) CONSTRAINT UQ_Customer_Email UNIQUE,
 Phone VARCHAR(20) CONSTRAINT UQ_Customer_Phone UNIQUE
)
----------

-----¬Õ≈ÿÕ»≈  Àﬁ◊»----
CREATE TABLE Customers
(
Id INT PRIMARY KEY IDENTITY,
Age INT DEFAULT 18,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Email VARCHAR(30) UNIQUE,
Phone VARCHAR(20) UNIQUE
);
-----
CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
CustomerId INT,
CreatedAt Date,
FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);
-----
drop table Orders

CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
CustomerId INT,
CreatedAt Date,
CONSTRAINT FK_Orders_To_Customers FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);

----ON DELETE Ë ON UPDATE---------Í‡ÒÍ‡‰ÌÓÂ Û‰‡ÎÂÌËÂCREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
CustomerId INT,
CreatedAt Date,
FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
)
DROP TABLE Orders;

-- ”ÒÚ‡ÌÓ‚Í‡ null
CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
CustomerId INT,
CreatedAt Date,
FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE SET NULL
);--”ÒÚ‡ÌÓ‚Í‡ ÁÌ‡˜ÂÌËˇ ÔÓ ÛÏÓÎ˜‡ÌË˛CREATE TABLE Orders
(
Id INT PRIMARY KEY IDENTITY,
CustomerId INT,
CreatedAt Date,
FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE SET DEFAULT
)
DROP TABLE Orders;
----------------

--»«Ã≈Õ≈Õ»≈ “¿¡À»÷€------
---ƒŒ¡¿¬À≈Õ»≈ ÕŒ¬Œ√Œ —“ŒÀ¡÷¿
ALTER TABLE Customers
ADD Address NVARCHAR(50) NULL;

ALTER TABLE Customers
ADD Address NVARCHAR(50) NOT NULL;-------”ƒ¿À≈Õ»≈ —“ŒÀ¡÷¿ALTER TABLE Customers
DROP COLUMN Address;---»ÁÏÂÌÂÌËÂ ÚËÔ‡ ÒÚÓÎ·ˆ‡ALTER TABLE Customers
ALTER COLUMN FirstName NVARCHAR(200)--ƒÓ·‡‚ÎÂÌËÂ Ó„‡ÌË˜ÂÌËÈALTER TABLE Customers
ADD CHECK (Age > 21);ALTER TABLE Customers WITH NOCHECK
ADD CHECK (Age > 21);-----------ƒŒ¡¿¬À≈Õ»≈ ¬Õ≈ÿÕ≈√Œ  Àﬁ◊¿DROP TABLE Orders;DROP TABLE Customers;CREATE TABLE Customers
(
 Id INT PRIMARY KEY IDENTITY,
 Age INT DEFAULT 18,
 FirstName NVARCHAR(20) NOT NULL,
 LastName NVARCHAR(20) NOT NULL,
 Email VARCHAR(30) UNIQUE,
 Phone VARCHAR(20) UNIQUE
);
CREATE TABLE Orders
(
 Id INT IDENTITY,
 CustomerId INT,
 CreatedAt Date
);ALTER TABLE Orders
ADD FOREIGN KEY(CustomerId) REFERENCES Customers(Id);----------ƒŒ¡¿¬À≈Õ»≈ œ≈–¬»◊ÕŒ√Œ  Àﬁ◊¿ALTER TABLE Orders
ADD PRIMARY KEY (Id);--------ƒŒ¡¿¬À≈Õ»≈ Œ√–¿Õ»◊≈Õ»…ALTER TABLE Orders
ADD CONSTRAINT PK_Orders_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Orders_To_Customers FOREIGN KEY(CustomerId) REFERENCES Customers(Id);
ALTER TABLE Customers
ADD CONSTRAINT CK_Age_Greater_Than_Zero CHECK (Age > 0);
-----------------

--”ƒ¿À≈Õ»≈ Œ√–¿Õ»◊≈Õ»…
ALTER TABLE Orders
DROP FK_Orders_To_Customers;

--- ŒÃ¿ÕƒŒ GO-----
DROP TABLE Orders;
DROP TABLE Customers;

CREATE DATABASE internetstore;
GO
USE internetstore;
CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	Age INT DEFAULT 18,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	Email VARCHAR(30) UNIQUE,
	Phone VARCHAR(20) UNIQUE
);
CREATE TABLE Orders
(
	Id INT PRIMARY KEY IDENTITY,
	CustomerId INT,
	CreatedAt DATE,
	FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
); 