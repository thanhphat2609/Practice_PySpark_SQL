-- Use database
USE Sales_Management;

------------------------------------------- CREATE PROCEDURE FOR SELECT DATA WITHOUT Parameter ---------------------------------------

--- 1. Procedures for select all product
CREATE OR ALTER PROCEDURE select_all_product
AS
SELECT * FROM product;
-- Run procedures
EXEC select_all_product;

--- 2. Procedures for select all customer
CREATE OR ALTER PROCEDURE select_all_customer
AS
SELECT * FROM customer;
-- Run procedures
EXEC select_all_customer;

--- 3. Procedures for select all employee
CREATE OR ALTER PROCEDURE select_all_employee
AS
SELECT * FROM employee;
-- Run procedures
EXEC select_all_employee;

--- 4. Procedures for select receipt
CREATE OR ALTER PROCEDURE select_all_receipt
AS
SELECT * FROM receipt;
-- Run procedures
EXEC select_all_receipt;

--- 5. Procedures for select receiptdetail
CREATE OR ALTER PROCEDURE select_all_receiptdetail
AS
SELECT * FROM receiptdetail;
-- Run procedures
EXEC select_all_receiptdetail;


------------------------------------------- CREATE PROCEDURE FOR SELECT DATA WITHOUT Parameter ---------------------------------------

--- 6. Procedures for Insert into employee with parameter
CREATE OR ALTER PROCEDURE insert_employee @emp_id VARCHAR(4), @emp_name VARCHAR(40), 
										  @emp_phone VARCHAR(20), @dayofwork DATE
AS
INSERT INTO employee(employeeID, employeeName, employeePhone, dayofwork) 
VALUES (@emp_id, @emp_name, @emp_phone, @dayofwork);
-- Run procedures
EXEC select_all_employee;
EXEC insert_employee @emp_id = 'NV06', @emp_name = 'Nguyen Thanh Phat', @emp_phone = '0918590387', @dayofwork = '2002-09-26';
EXEC insert_employee @emp_id = 'NV07', @emp_name = 'Nguyen Ngoc Hien', @emp_phone = '0776695664', @dayofwork = '2002-07-10';
EXEC select_all_employee;

--- 7. Procedures for Insert into product with parameter
CREATE OR ALTER PROCEDURE insert_product @pro_id VARCHAR(4), @pro_name VARCHAR(40), @unit VARCHAR(20),
										 @country VARCHAR(40), @price DECIMAL(10, 2)
AS
INSERT INTO product(productID, productName, unit, country, price)
VALUES (@pro_id, @pro_name, @unit, @country, @price);
-- Run procedures
EXEC select_all_product;
EXEC insert_product @pro_id = 'TV08', @pro_name = 'Tap 100 trang sinh vien', @unit = 'chuc', @country = 'Viet Nam', @price = '600000';
EXEC insert_product @pro_id = 'TV09', @pro_name = 'Tap 200 trang sinh vien', @unit = 'chuc', @country = 'Viet Nam', @price = '650000';
EXEC select_all_product;


--- 8. Procedure for select Group by Country and count number of Product
CREATE OR ALTER PROCEDURE select_groupby_country @country_name VARCHAR(40)
AS
SELECT country, count(productID) AS NumberOfProduct
FROM product
WHERE country = @country_name
GROUP BY country;
-- Run Procedure
EXEC select_groupby_country @country_name = 'Viet Nam';
EXEC select_groupby_country @country_name = 'Thai Lan';
EXEC select_groupby_country @country_name = 'Trung Quoc';


--- 9. Procedure for update price of product in table product
CREATE OR ALTER PROCEDURE update_price_product @pro_id VARCHAR(4), @price DECIMAL(10, 2)
AS
UPDATE product
SET price = @price
WHERE productID = @pro_id;
-- Run Procedure
EXEC select_all_product;
EXEC update_price_product @pro_id = 'TV08', @price = '60000';
EXEC update_price_product @pro_id = 'TV09', @price = '65000';
EXEC select_all_product;

--- 10. Procedure delete product with parameter
CREATE OR ALTER PROCEDURE delete_prodcut @pro_id VARCHAR(4)
AS
DELETE FROM product
WHERE productID = @pro_id;
-- Run procedure
EXEC delete_prodcut @pro_id = 'TV08';
EXEC select_all_product;