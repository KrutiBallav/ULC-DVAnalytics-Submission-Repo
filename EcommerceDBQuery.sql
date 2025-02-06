-- Create a database for the E-commerce system
CREATE DATABASE EcommerceDB;
GO
USE EcommerceDB;
GO

-- Customers Table: Stores customer details
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1000,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15) UNIQUE,
    Address NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Products Table: Stores product details
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(2000,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    Category NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Orders Table: Stores orders placed by customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(3000,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderItems Table: Stores items within an order
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(4000,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments Table: Stores payment details
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(5000,1),
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer')) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Shipments Table: Stores shipment details
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY IDENTITY(6000,1),
    OrderID INT NOT NULL,
    TrackingNumber NVARCHAR(50),
    Carrier NVARCHAR(50),
    ShipmentDate DATETIME,
    EstimatedDelivery DATE,
    Status NVARCHAR(50) CHECK (Status IN ('In Transit', 'Delivered', 'Delayed')) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Sample Data Insertion for Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567891', '123 Main St'),
('Alice', 'Smith', 'alice.smith@example.com', '9876543211', '456 Elm St'),
('Bob', 'Johnson', 'bob.johnson@example.com', '5551234567', '789 Oak Ave'),
('Eva', 'Garcia', 'eva.garcia@example.com', '1112223333', '101 Pine Ln'),
('David', 'Lee', 'david.lee@example.com', '4445556666', '222 Maple Dr'),
('Sarah', 'Brown', 'sarah.brown@example.com', '7778889999', '333 Willow St'),
('Michael', 'Davis', 'michael.davis@example.com', '2223334444', '444 Birch Rd'),
('Emily', 'Wilson', 'emily.wilson@example.com', '5556667777', '555 Cedar Ct');


-- Sample Data Insertion for Products
INSERT INTO Products (Name, Description, Price, StockQuantity, Category)
VALUES 
('Laptop', '15-inch gaming laptop', 1200.00, 10, 'Electronics'),
('Headphones', 'Noise-cancelling over-ear headphones', 200.00, 25, 'Electronics'),
('Mouse', 'Wireless mouse', 25.00, 50, 'Electronics'),
('Keyboard', 'Mechanical keyboard', 75.00, 30, 'Electronics'),
('Monitor', '27-inch monitor', 300.00, 15, 'Electronics'),
('Chair', 'Office chair', 150.00, 20, 'Furniture'),
('Desk', 'Standing desk', 250.00, 10, 'Furniture'),
('Tablet', '10-inch tablet', 400.00, 35, 'Electronics'),
('Smartphone', 'Latest smartphone model', 800.00, 20, 'Electronics'),
('Printer', 'Wireless printer', 150.00, 40, 'Electronics');

-- Sample Data Insertion for Orders
INSERT INTO Orders (CustomerID, TotalAmount, Status)
VALUES 
(1000, 1400.00, 'Pending'),
(1001, 200.00, 'Shipped'),
(1002, 325.00, 'Pending'),
(1003, 75.00, 'Delivered'),
(1000, 550.00, 'Shipped'),
(1001, 400.00, 'Cancelled'),
(1004, 250.00, 'Pending'),
(1005, 1600.00, 'Pending'),
(1006, 100.00, 'Shipped'),
(1007, 900.00, 'Delivered');

-- Sample Data Insertion for OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Subtotal)
VALUES 
(3000, 2000, 1, 1200.00),
(3000, 2001, 1, 200.00),
(3001, 2001, 1, 200.00),
(3002, 2002, 1, 25.00),
(3002, 2003, 1, 75.00),
(3002, 2004, 1, 300.00),
(3003, 2003, 1, 75.00),
(3004, 2000, 1, 1200.00),
(3004, 2002, 1, 25.00),
(3004, 2003, 1, 75.00),
(3004, 2004, 1, 300.00),
(3005, 2004, 1, 300.00),
(3005, 2005, 1, 250.00),
(3006, 2001, 1, 200.00),
(3007, 2000, 1, 1200.00),
(3007, 2008, 1, 400.00);


-- Sample Data Insertion for Payments
INSERT INTO Payments (OrderID, PaymentMethod, Amount)
VALUES 
(3000, 'Credit Card', 1400.00),
(3001, 'PayPal', 200.00),
(3002, 'PayPal', 325.00),
(3003, 'Credit Card', 75.00),
(3004, 'Bank Transfer', 550.00),
(3005, 'Debit Card', 250.00),
(3006, 'Credit Card', 200.00),
(3007, 'PayPal', 1600.00);

-- Sample Data Insertion for Shipments
INSERT INTO Shipments (OrderID, TrackingNumber, Carrier, ShipmentDate, EstimatedDelivery, Status)
VALUES 
(3001, 'ABC123XYZ', 'UPS', '2025-02-01', '2025-02-05', 'In Transit'),
(3002, 'DEF456GHI', 'FedEx', '2025-02-08', '2025-02-12', 'In Transit'),
(3003, 'JKL789MNO', 'USPS', '2025-02-05', '2025-02-07', 'Delivered'),
(3004, 'PQR012STU', 'UPS', '2025-02-10', '2025-02-14', 'In Transit'),
(3005, 'VWX345YZA', 'FedEx', '2025-02-12', '2025-02-16', 'Delayed');

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM Payments;
SELECT * FROM Shipments;