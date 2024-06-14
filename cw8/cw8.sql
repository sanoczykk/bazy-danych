USE AdventureWorks2022;
GO
USE AdventureWorksLT2022;
GO

--1
IF OBJECT_ID('tempdb..#TempInfo') IS NOT NULL
    DROP TABLE #TempInfo;

CREATE TABLE #TempInfo (
    id INT,
    imie NVARCHAR(50),
    nazwisko NVARCHAR(50),
    stawka DECIMAL(10, 2)
);

WITH CTE (id, imie, nazwisko, stawka) 
AS
(
    SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.Rate
    FROM AdventureWorks2022.Person.Person p
    INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory e
    ON p.BusinessEntityID = e.BusinessEntityID
)
INSERT INTO #TempInfo (id, imie, nazwisko, stawka) 
SELECT id, imie, nazwisko, stawka
FROM CTE;

SELECT * FROM #TempInfo;

--2
WITH CTE2 (CompanyContact, Revenue)
AS 
(
	SELECT CONCAT(c.CompanyName, ' (', c.FirstName, ' ', c.LastName, ')') AS CompanyContact, s.TotalDue AS Revenue
	FROM SalesLT.Customer c
	INNER JOIN SalesLT.SalesOrderHeader s
	ON c.CustomerID = s.CustomerID
)
SELECT * FROM CTE2
ORDER BY CompanyContact;

--3 
WITH CTE3 (Category, SalesValue)
AS
(
    SELECT 
        c.Name AS Category,
        o.UnitPrice * o.OrderQty AS SalesValue
    FROM 
        SalesLT.Product p
    INNER JOIN 
        SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID
    INNER JOIN 
        SalesLT.SalesOrderDetail o ON p.ProductID = o.ProductID
)

SELECT 
    Category, 
    SUM(SalesValue) AS TotalSalesValue
FROM 
    CTE3 
GROUP BY 
    Category;
