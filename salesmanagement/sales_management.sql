-- Database
CREATE DATABASE Sales_Management;


-- Create table Customer: Store data of Customer
CREATE TABLE customer (
    customerID VARCHAR(4) PRIMARY KEY NOT NULL, 
    cusName VARCHAR(40) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phoneno VARCHAR(20) NOT NULL,
    dateofbirth DATE,
    sales DECIMAL(10, 2) NOT NULL, 
    registrationdate DATE
);

-- Create table Employee: Store data of Employee
CREATE TABLE employee (
    employeeID VARCHAR(4) PRIMARY KEY NOT NULL,
    employeeName VARCHAR(40) NOT NULL,
    employeePhone VARCHAR(20) NOT NULL,
    dayofwork DATE
);

-- Create table Product: Store data of Product
CREATE TABLE product (
    productID VARCHAR(4) PRIMARY KEY NOT NULL,
    productName VARCHAR(40) NOT NULL,
    unit VARCHAR(20),
    country VARCHAR(40),
    price DECIMAL(10, 2) NOT NULL
);

-- Create table receipt: Store data of receipt
CREATE TABLE receipt (
    receiptID INT PRIMARY KEY NOT NULL,
    receiptDate DATE,
    customerID VARCHAR(4),
    employeeID VARCHAR(4),
    value_receipt DECIMAL(10, 2),
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (employeeID) REFERENCES employee(employeeID)
);

-- Create table receiptdetail: Store data of receiptdetail
CREATE TABLE receiptdetail (
    receiptID INT NOT NULL,
    productID VARCHAR(4),
    quantity INT,
    PRIMARY KEY (receiptID, ProductID),
    FOREIGN KEY (receiptID) REFERENCES receipt(receiptID),
    FOREIGN KEY (productID) REFERENCES product(productID)
);