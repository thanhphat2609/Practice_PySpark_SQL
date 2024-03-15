---------------------------------------- CREATE PROCEDURE FOR ANALYSIS ----------------------------------------

-- 1. How many unique city in dataset?
CREATE OR ALTER PROCEDURE unique_city
AS
SELECT DISTINCT City
FROM WalmartSalesData

GO
-- 2. How many NumberOfInvoice for each city in each branch?
CREATE OR ALTER PROCEDURE unique_city_branch
AS
SELECT City, Branch, COUNT(Invoice_ID) as NumberofInvoice
FROM WalmartSalesData
GROUP BY City, Branch;

GO

---------------------------------------- RUN PROCEDURE FOR ANALYSIS ----------------------------------------
EXEC unique_city;
EXEC unique_city_branch;




