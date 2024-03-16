------------------------------------------------------ CREATE PROCEDURES ------------------------------------------------------

-- 1. Number of sales made in each time of the day per weekday
SELECT DATENAME(DW, [Date])
FROM WalmartSalesData;
GO

CREATE OR ALTER PROCEDURE dayofweek_number_sales
AS
SELECT DATENAME(DW, [DATE]) AS 'DayOfWeek', COUNT(Invoice_ID) as NumberOfSales 
FROM WalmartSalesData
GROUP BY DATENAME(DW, [DATE])
ORDER BY NumberOfSales ASC;

GO
-- 2. Which of the customer types brings the most revenue?
CREATE OR ALTER PROCEDURE customer_type_revenue
AS
SELECT Customer_type, SUM(Total) as Revenue
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY Revenue DESC;

GO
-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
CREATE OR ALTER PROCEDURE city_largest_vat
AS
SELECT City, AVG(Tax_5) as VAT
FROM WalmartSalesData
GROUP BY City
ORDER BY VAT DESC;

GO
-- 4. Which customer type pays the most in VAT?
CREATE OR ALTER PROCEDURE customer_type_vat
AS
SELECT Customer_type, AVG(Tax_5) AS VAT
FROM WalmartSalesData
GROUP BY Customer_type
ORDER BY VAT DESC;


------------------------------------------------------ EXECUTE PROCEDURES ------------------------------------------------------
EXEC dayofweek_number_sales;
EXEC customer_type_revenue;
EXEC city_largest_vat;
EXEC customer_type_vat;
