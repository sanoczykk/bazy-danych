USE AdventureWorks2022;
GO

--1
SELECT ListPrice FROM Production.Product WHERE ProductID = 680;

BEGIN TRANSACTION tranzakcja_1;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT;


SELECT ListPrice FROM Production.Product WHERE ProductID = 680;

--2
BEGIN TRANSACTION tranzakcja_2;
DELETE FROM Production.Product
WHERE ProductID = 707;
ROLLBACK;

SELECT * FROM Production.Product WHERE ProductID = 707;

--3
BEGIN TRANSACTION tranzakcja_3;

INSERT INTO Production.Product(
    Name,
    ProductNumber,
    MakeFlag,
    FinishedGoodsFlag,
    Color,
    SafetyStockLevel,
    ReorderPoint,
    StandardCost,
    ListPrice,
    Size,
    SizeUnitMeasureCode,
    WeightUnitMeasureCode,
    Weight,
    DaysToManufacture,
    ProductLine,
    Class,
    Style,
    ProductSubcategoryID,
    ProductModelID,
    SellStartDate,
    SellEndDate,
    DiscontinuedDate,
    rowguid,
    ModifiedDate
)
VALUES(
    'Panzerkampfwagen V'
    'SK-1711',
    1,
    1,
    'Green',
    5000,
    375,
    56.86,
    69.99,
    '887',
    'CM',
    'LB',                        
    98105,                      
    100,                        
    'R', 
    NULL,
    NULL,
    NULL, 
    2,
    '1942-07-05 00:00:00.000',  
    '1945-05-08 22:43:00.000', 
    NULL,                       
    NEWID(),                    
    GETDATE()                   
);
COMMIT;
SELECT * FROM Production.Product
ORDER BY ProductID;

--4
BEGIN TRANSACTION tranzakcja_4;

UPDATE Production.Product
SET StandardCost = StandardCost * 1.1;

IF (SELECT SUM(StandardCost) FROM Production.Product) <= 50000
BEGIN
    PRINT 'Transakcja zaakceptowana';
    COMMIT;
END
ELSE
BEGIN
    PRINT 'Transakcja odrzucona';
    ROLLBACK;
END;

SELECT SUM(StandardCost) AS TotalStandardCost FROM Production.Product;

--5
USE AdventureWorks2022;
GO

--3
BEGIN TRANSACTION tranzakcja_5;

DECLARE @NumerProduktu NVARCHAR(25) = 'SK-1677';

IF EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = @NumerProduktu)
BEGIN
    PRINT 'Odrzucono - Produkt ju¿ istnieje';
    ROLLBACK;

END
ELSE
BEGIN
INSERT INTO Production.Product(
    Name,
    ProductNumber,
    MakeFlag,
    FinishedGoodsFlag,
    Color,
    SafetyStockLevel,
    ReorderPoint,
    StandardCost,
    ListPrice,
    Size,
    SizeUnitMeasureCode,
    WeightUnitMeasureCode,
    Weight,
    DaysToManufacture,
    ProductLine,
    Class,
    Style,
    ProductSubcategoryID,
    ProductModelID,
    SellStartDate,
    SellEndDate,
    DiscontinuedDate,
    rowguid,
    ModifiedDate
)
VALUES(
'Sturmgeschutz IV',         
@NumerProduktu,             
1,                          
1,                          
'Green',                    
11000,                      
375,                        
56.86,                      
69.99,                      
'670',                      
'CM',                       
'LB',                       
50000,                      
100,                        
'R',                        
NULL,                       
NULL,                       
NULL,                       
2,                          
'1943-12-06 12:00:00.000',  
'1945-05-08 22:43:00.000',  
NULL,                       
NEWID(),                    
GETDATE()
);

);
    COMMIT;
    PRINT 'Transakcja zatwierdzona';
END;

SELECT * FROM Production.Product
ORDER BY ProductID;

--6
BEGIN TRANSACTION tranzakcja_6;
IF EXISTS (SELECT * FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
	BEGIN
		PRINT 'Transakcja odrzucona'
		ROLLBACK;
END;
ELSE
	BEGIN
		UPDATE Sales.SalesOrderDetail
		SET OrderQty = OrderQty + 1
		PRINT 'Transakcja zaaceptowana'
		COMMIT;
END;

--7
SELECT StandardCost FROM Production.Product WHERE StandardCost > @AvgStandardCost;

BEGIN TRANSACTION tranzakcja_7;
DECLARE @AvgStandardCost DECIMAL(18, 2);
DECLARE @RowCount INT;
DELETE FROM Production.Product
WHERE StandardCost > @AvgStandardCost;
SET @RowCount = @@ROWCOUNT;

IF @RowCount > 10
BEGIN
    PRINT 'Transakcja odrzucona';
    ROLLBACK;
END
ELSE
BEGIN
    PRINT 'Transakcja wykonana';
    COMMIT;
END;

SELECT StandardCost FROM Production.Product WHERE StandardCost > @AvgStandardCost;