-- Create table for save log error while using Trigger
CREATE TABLE log_error(
	ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	error VARCHAR(1000) NOT NULL,
	date_response DATE
);
SELECT * FROM log_error;

GO

-- 1. Trigger for reject who were under 18
CREATE OR ALTER TRIGGER reject_under_18 ON employee
FOR INSERT
AS
BEGIN
	DECLARE @year_now INT;
	DECLARE @year_employee INT;
	DECLARE @error VARCHAR(1000) = 'Employee can not under 18';
	DECLARE @day_error DATE = (SELECT CAST(GETDATE() AS DATE));

	SET @year_now = (SELECT YEAR(GETDATE()))
	SET @year_employee = (SELECT YEAR(dayofwork) FROM inserted)

	IF (@year_now - @year_employee) < 18
		BEGIN
			PRINT('Employee can not under 18')
			ROLLBACK
			INSERT INTO log_error(error, date_response) VALUES(@error, @day_error)
		END
	ELSE
		BEGIN
			DECLARE @emp_id VARCHAR(4);
			DECLARE @emp_name VARCHAR(40);
			DECLARE @emp_phone VARCHAR(20);
			DECLARE @dayofwork DATE;

			-- Get value for insert
			SELECT TOP 1 @emp_id = employeeID, @emp_name = employeeName, @emp_phone = employeePhone, @dayofwork = dayofwork 
			FROM inserted;

			-- Call procedure insert
			EXEC insert_employee @emp_id = @emp_id, @emp_name = @emp_name, @emp_phone = @emp_phone, @dayofwork = @dayofwork;
		END
END

-- EXAMPLE
EXEC insert_employee @emp_id = 'NV11', @emp_name = 'Nguyen Ngoc Phat', @emp_phone = '0776695664', @dayofwork = '2023-07-10'

GO

-- 2. Trigger for reject update product more than 100 000
CREATE OR ALTER TRIGGER reject_update_product ON product
FOR UPDATE
AS
BEGIN
	DECLARE @error VARCHAR(1000) = 'Can not update product more than 100 000';
	DECLARE @date_res DATE = (SELECT CAST(GETDATE() AS DATE));
	DECLARE @id_update VARCHAR(4);
	DECLARE @price_update DECIMAL(10, 2);

	-- Get id product for update
	SET @id_update = (SELECT TOP 1 productID FROM inserted)

	-- Get price update
	SET @price_update = (SELECT TOP 1 price FROM inserted)

	IF @price_update > 100000
		BEGIN
			PRINT('Can not update product more than 100 000')
			ROLLBACK
			INSERT INTO log_error(error, date_response) VALUES (@error, @date_res)
		END
	
	ELSE
		BEGIN	
			EXEC update_price_product @pro_id = @id_update, @price = @price_update
		END
END

-- EXAMPLE
EXEC update_price_product @pro_id = 'TV09', @price = '120000';


GO
-- 3. Create trigger for reject insert into product if unit not ('cay', 'hop', 'quyen', 'chuc')
CREATE OR ALTER TRIGGER reject_insert_product ON product
FOR INSERT
AS
BEGIN
	DECLARE @error VARCHAR(1000) = 'Can not insert product with unit not in(cay, hop, quyen, chuc)';	
	DECLARE @date_res DATE = (SELECT CAST(GETDATE() AS DATE));
	DECLARE @unit_product VARCHAR(20);

	-- Get unit_product
	SET @unit_product = (SELECT TOP 1 unit FROM inserted)

	-- IF unit not in
	IF @unit_product NOT IN ('cay', 'hop', 'quyen', 'chuc')
		BEGIN
			PRINT('Can not insert product with that unit')
			ROLLBACK
			INSERT INTO log_error(error, date_response) VALUES (@error, @date_res)
		END
	ELSE
		BEGIN
			DECLARE @productID VARCHAR(4);
			DECLARE @productName VARCHAR(40);
			DECLARE @unit VARCHAR(20);
			DECLARE @country VARCHAR(40);
			DECLARE @price DECIMAL(10, 2);

			-- Get data
			SELECT @productID = productID, @productName = productName, @unit = unit, @country = country, @price = price
			FROM inserted

			-- Insert
			EXEC insert_product @pro_id = @productID, @pro_name = @productName, @unit = @unit, @country = @country, @price = @price
		END
END

-- EXAMPLE
EXEC insert_product @pro_id = 'TV10', @pro_name = 'Tap 100 trang sinh vien', @unit = 'phat', @country = 'Viet Nam', @price = '600000';

GO
-- 4. Create trigger for reject delete product if exist on receiptdetail
CREATE OR ALTER TRIGGER reject_delete_product ON product
FOR DELETE
AS
BEGIN
	DECLARE @error VARCHAR(1000) = 'Can not delete product was in ReceiptDetail';
	DECLARE @date_res DATE = (SELECT CAST(GETDATE() AS DATE));
	DECLARE @id_delete VARCHAR(4);
	DECLARE @number_exist INT;

	-- Get id from delete 
	SET @id_delete = (SELECT TOP 1 productID FROM deleted);

	-- Check exist in receiptdetail
	SET @number_exist = (
							SELECT COUNT(*)
							FROM receiptdetail
							WHERE productID = @id_delete
						);

	-- IF
	IF @number_exist > 0
		BEGIN
			PRINT('Can not delete product was in ReceiptDetail')
			ROLLBACK
			INSERT INTO log_error(error, date_response) VALUES(@error, @date_res)
		END
	ELSE
		BEGIN
			PRINT('Delete success')
			EXEC delete_prodcut @pro_id = @id_delete
		END
END

-- EXAMPLE
	-- DROP CONSTRAINT FOREIGN KEY
ALTER TABLE receiptdetail DROP CONSTRAINT FK__receiptde__produ__4222D4EF
	-- DROP
EXEC delete_prodcut @pro_id = 'BC01'