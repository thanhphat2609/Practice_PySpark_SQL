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
-- 7. What is the city with the largest revenue?
-- 8. What product line had the largest VAT?
-- 9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
-- 10. Which branch sold more products than average product sold?
-- 11. What is the most common product line by gender?
-- 12. What is the average rating of each product line?


------------------------------------------------------ RUN PROCEDURE ---------------------------------------------
EXEC unique_product;
EXEC common_payment;
EXEC most_sale_product;
EXEC total_revenue_month;
EXEC largest_cogs;
