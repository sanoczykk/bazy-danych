USE AdventureWorks2022;

--z1
CREATE PROCEDURE fibonacci (@n INT)
AS
BEGIN
	DECLARE @pierw INT;
	DECLARE @drug INT;
	DECLARE @sum INT;
	DECLARE @x INT;
	SET @pierw = 0;
	SET @drug = 1;
	SET @x = 1;
	PRINT @pierw;
	PRINT @drug;
	WHILE (@x <= @n)
	BEGIN
		SET @sum = @pierw + @drug;
		PRINT @sum;
		SET @pierw = @drug;
		SET @drug = @sum;
		SET @x = @x +1;
	END;
END;

EXEC fibonacci @n=8;

--z2
CREATE TRIGGER drukowane
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE Person.Person 
	SET LastName = UPPER(LastName) 
	FROM Person.Person
END;

--z3
CREATE TRIGGER TaxRateMonitor
ON Sales.SalesTaxRate
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @taxnew FLOAT;
	DECLARE @taxold FLOAT;
	SELECT @taxnew = TaxRate FROM INSERTED;
	SELECT @taxold =TaxRate FROM DELETED;
	IF (@taxnew > 1.3 * @taxold OR @taxnew < 0.7 * @taxold)
        BEGIN
            PRINT 'Zmiana podatku jest większa niż 30% - niemożna zmienić wartości podatku';
            SET TaxRate = @taxold
        END
END;

UPDATE Sales.SalesTaxRate 
SET TaxRate = 20000
WHERE SalesTaxRateID = 1;
SELECT * FROM Sales.SalesTaxRate WHERE SalesTaxRateID=1;
