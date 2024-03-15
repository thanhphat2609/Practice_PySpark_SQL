------------------------------------------------------ CREATE PROCEDURE ---------------------------------------------

-- 1. How many unique product lines does the data have?
CREATE OR ALTER PROCEDURE unique_product
AS
SELECT DISTINCT [Product_line]
FROM WalmartSalesData;

GO
-- 2. What is the most common payment method?
CREATE OR ALTER PROCEDURE common_payment
AS
SELECT Payment, COUNT([Invoice_ID]) as NumberOfUsingPaymentType 
FROM WalmartSalesData
GROUP BY Payment
ORDER BY NumberOfUsingPaymentType DESC;

GO
-- 3. What is the most selling product line?
CREATE OR ALTER PROCEDURE most_sale_product
AS
SELECT [Product_line], COUNT(Quantity) as NumberofSellProduct
FROM WalmartSalesData
GROUP BY [Product_line]
ORDER BY NumberofSellProduct DESC;

GO
-- 4. What is the total revenue by month?
CREATE OR ALTER PROCEDURE total_revenue_month
AS
SELECT MONTH([Date]) as 'Monthly', SUM(Total) as TotalRevenuebyMonth
FROM WalmartSalesData
GROUP BY MONTH([Date])
ORDER BY MONTH([Date]) ASC;

GO
-- 5. What month had the largest COGS?
CREATE OR ALTER PROCEDURE largest_cogs
AS
SELECT MONTH([Date]) as 'Month', SUM(cogs) as Largest_Cogs
FROM WalmartSalesData
GROUP BY MONTH([Date])
ORDER BY Largest_Cogs DESC;

GO
-- 6. What product line had the largest revenue?
CREATE OR ALTER PROCEDURE largest_revenue_product
AS
SELECT Product_line, SUM(Total) as TotalRevenue
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY TotalRevenue DESC;

GO
-- 7. What is the city with the largest revenue?
CREATE OR ALTER PROCEDURE largest_revenue_city
AS
SELECT City, Branch, SUM(Total) as TotalRevenue
FROM WalmartSalesData
GROUP BY City, Branch
ORDER BY TotalRevenue DESC;

GO
-- 8. What product line had the largest VAT?
CREATE OR ALTER PROCEDURE largest_vat
AS
SELECT Product_line, AVG(Tax_5) AS AVG_TAX
FROM WalmartSalesData
GROUP BY Product_line 
ORDER BY AVG_TAX DESC;

GO
-- 9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
CREATE OR ALTER PROCEDURE fetch_prodcut_status
AS

DECLARE @avg_sales FLOAT;
SET @avg_sales = (
					SELECT AVG(Quantity)
					FROM WalmartSalesData
			     );

SELECT Product_line, 
	   'Status_Product' = CASE
						  WHEN AVG(Quantity) > @avg_sales THEN 'Good'
						  ELSE 'Bad'
						  END 
FROM WalmartSalesData
GROUP BY Product_line;
GO
-- 10. Which branch sold more products than average product sold(qantites)?
CREATE OR ALTER PROCEDURE branch_average_product
AS
SELECT Branch, SUM(Quantity) AS NumberOfProductSold
FROM WalmartSalesData
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM WalmartSalesData);

GO
-- 11. What is the most common product line by gender?
CREATE OR ALTER PROCEDURE commnon_product_gender
AS
SELECT Gender, Product_line, COUNT(Product_line) as Most_Used
FROM WalmartSalesData
GROUP BY Gender, Product_line
ORDER BY Most_Used DESC;

GO
-- 12. What is the average rating of each product line?
CREATE OR ALTER PROCEDURE average_rating_product
AS
SELECT Product_line, AVG(Rating) as AVG_RatingProduct
FROM WalmartSalesData
GROUP BY Product_line
ORDER BY AVG_RatingProduct DESC;


------------------------------------------------------ RUN PROCEDURE ---------------------------------------------
EXEC unique_product;
EXEC common_payment;
EXEC most_sale_product;
EXEC total_revenue_month;
EXEC largest_cogs;
EXEC largest_revenue_product;
EXEC largest_revenue_city;
EXEC largest_vat;
EXEC fetch_prodcut_status;
EXEC branch_average_product;
EXEC commnon_product_gender;
EXEC average_rating_product;
