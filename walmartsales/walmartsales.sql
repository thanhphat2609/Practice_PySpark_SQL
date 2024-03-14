-- CREATE DATABASE
CREATE DATABASE Walmart_Sales;

-- CREATE TABLE
CREATE TABLE WalmartSalesData (
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
	branch VARCHAR(5) NOT NULL,
	city VARCHAR(30) NOT NULL,
	customer_type VARCHAR(30) NOT NULL,
	gender VARCHAR(30) NOT NULL,
	product_line VARCHAR(100) NOT NULL,
	unit_price DECIMAL(10, 2) NOT NULL,
	quantity INT NOT NULL,
	tax_pct FLOAT NOT NULL,
	total DECIMAL(12, 4) NOT NULL,
	[date] DATETIME NOT NULL,
	[time] TIME NOT NULL,
	payment VARCHAR(15) NOT NULL,
	gross_margin_pct FLOAT NOT NULL,
	gross_income DECIMAL(12, 4) NOT NULL,
	rating FLOAT
);

-- INSERT INTO TABLE sales
BULK INSERT [dbo].[WalmartSalesData]
FROM 'C:\Users\Thanh Phat\Downloads\walmartsales\WalmartSalesData.csv'
WITH (
	  FORMAT = 'CSV', 
	  FIRSTROW=2, 
	  FIELDQUOTE = '\', 
	  FIELDTERMINATOR = ';', 
	  ROWTERMINATOR = '0x0a'
);
