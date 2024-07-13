-- Create database
CREATE DATABASE ERPSYSTEM;
GO

 

-- Use the database
USE ERPSYSTEM;
GO

-- Create Roles table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100) NOT NULL,
    UserEmail NVARCHAR(100) NOT NULL UNIQUE,
    UserPassword NVARCHAR(100) NOT NULL,
    RoleID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    ProductDescription NVARCHAR(255),
    CategoryID INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    SupplierEmail NVARCHAR(100),
    SupplierPhone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create PurchaseOrders table
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY IDENTITY(1,1),
    SupplierID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2),
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO

-- Create PurchaseOrderDetails table
CREATE TABLE PurchaseOrderDetails (
    PurchaseOrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    PurchaseOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    CustomerEmail NVARCHAR(100) NOT NULL UNIQUE,
    CustomerPhone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2),
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(18, 2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(100) NOT NULL,
    EmployeeEmail NVARCHAR(100) NOT NULL UNIQUE,
    EmployeePhone NVARCHAR(20),
    HireDate DATETIME DEFAULT GETDATE(),
    DepartmentID INT NOT NULL,
    Salary DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Timesheets table
CREATE TABLE Timesheets (
    TimesheetID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    DateWorked DATE NOT NULL,
    HoursWorked DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO

-- Create FinancialAccounts table
CREATE TABLE FinancialAccounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    AccountName NVARCHAR(100) NOT NULL,
    AccountType NVARCHAR(50) NOT NULL,
    Balance DECIMAL(18, 2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Transactions table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    AccountID INT NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(18, 2) NOT NULL,
    TransactionType NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255),
    FOREIGN KEY (AccountID) REFERENCES FinancialAccounts(AccountID)
);
GO

-- Create CRM_Contacts table
CREATE TABLE CRM_Contacts (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    ContactDate DATETIME DEFAULT GETDATE(),
    ContactMethod NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Create Manufacturing table
CREATE TABLE Manufacturing (
    ManufacturingID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    QuantityProduced INT NOT NULL,
    ProductionDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create BOM (Bill of Materials) table
CREATE TABLE BillOfMaterials (
    BOMID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    ComponentID INT NOT NULL,
    QuantityRequired INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (ComponentID) REFERENCES Products(ProductID)
);
GO

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(100) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    Budget DECIMAL(18, 2),
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create ProjectTasks table
CREATE TABLE ProjectTasks (
    TaskID INT PRIMARY KEY IDENTITY(1,1),
    ProjectID INT NOT NULL,
    TaskName NVARCHAR(100) NOT NULL,
    AssignedTo INT,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID)
);
GO

-- Create Assets table
CREATE TABLE Assets (
    AssetID INT PRIMARY KEY IDENTITY(1,1),
    AssetName NVARCHAR(100) NOT NULL,
    PurchaseDate DATETIME NOT NULL,
    PurchaseCost DECIMAL(18, 2),
    CurrentValue DECIMAL(18, 2),
    Location NVARCHAR(100),
    AssignedTo INT,
    FOREIGN KEY (AssignedTo) REFERENCES Employees(EmployeeID)
);
GO

-- Create QualityChecks table
CREATE TABLE QualityChecks (
    CheckID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    CheckDate DATETIME DEFAULT GETDATE(),
    Result NVARCHAR(50) NOT NULL,
    Notes NVARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create LeaveRequests table
CREATE TABLE LeaveRequests (
    LeaveID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    LeaveType NVARCHAR(50) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    Reason NVARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
GO

-- Create Trainings table
CREATE TABLE Trainings (
    TrainingID INT PRIMARY KEY IDENTITY(1,1),
    TrainingName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    Location NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create EmployeeTrainings table
CREATE TABLE EmployeeTrainings (
    EmployeeTrainingID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    TrainingID INT NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (TrainingID) REFERENCES Trainings(TrainingID)
);
GO











-- Use the database
USE ERPSYSTEM;
GO

-- Create Roles table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100) NOT NULL,
    UserEmail NVARCHAR(100) NOT NULL UNIQUE,
    UserPassword NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create Permissions table
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY IDENTITY(1,1),
    PermissionName NVARCHAR(100) NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create RolePermissions table
CREATE TABLE RolePermissions (
    RolePermissionID INT PRIMARY KEY IDENTITY(1,1),
    RoleID INT NOT NULL,
    PermissionID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);
GO

-- Create UserRoles table
CREATE TABLE UserRoles (
    UserRoleID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

-- Permissions Initialization Script
-- Define some common permissions
INSERT INTO Permissions (PermissionName) VALUES ('Product_Insert'), ('Product_Update'), ('Product_Delete'), ('Product_Select');
INSERT INTO Permissions (PermissionName) VALUES ('Order_Insert'), ('Order_Update'), ('Order_Delete'), ('Order_Select');
INSERT INTO Permissions (PermissionName) VALUES ('User_Insert'), ('User_Update'), ('User_Delete'), ('User_Select');

-- Role Initialization Script
-- Define some common roles
INSERT INTO Roles (RoleName) VALUES ('Admin'), ('Manager'), ('Sales'), ('Inventory');

-- Role-Permissions Assignment Script
-- Assign permissions to Admin role
INSERT INTO RolePermissions (RoleID, PermissionID) 
SELECT RoleID, PermissionID FROM Roles, Permissions WHERE RoleName = 'Admin';

-- Assign permissions to Manager role
INSERT INTO RolePermissions (RoleID, PermissionID) 
SELECT RoleID, PermissionID FROM Roles, Permissions WHERE RoleName = 'Manager' AND PermissionName LIKE 'Product_%';

-- Assign permissions to Sales role
INSERT INTO RolePermissions (RoleID, PermissionID) 
SELECT RoleID, PermissionID FROM Roles, Permissions WHERE RoleName = 'Sales' AND PermissionName LIKE 'Order_%';

-- Assign permissions to Inventory role
INSERT INTO RolePermissions (RoleID, PermissionID) 
SELECT RoleID, PermissionID FROM Roles, Permissions WHERE RoleName = 'Inventory' AND PermissionName IN ('Product_Select', 'Product_Update');

-- Example User Initialization Script
-- Create some example users
INSERT INTO Users (UserName, UserEmail, UserPassword) VALUES ('Alice', 'alice@example.com', 'password123');
INSERT INTO Users (UserName, UserEmail, UserPassword) VALUES ('Bob', 'bob@example.com', 'password123');
INSERT INTO Users (UserName, UserEmail, UserPassword) VALUES ('Charlie', 'charlie@example.com', 'password123');

-- Assign roles to users
INSERT INTO UserRoles (UserID, RoleID)
SELECT UserID, RoleID FROM Users, Roles WHERE UserName = 'Alice' AND RoleName = 'Admin';

INSERT INTO UserRoles (UserID, RoleID)
SELECT UserID, RoleID FROM Users, Roles WHERE UserName = 'Bob' AND RoleName = 'Manager';

INSERT INTO UserRoles (UserID, RoleID)
SELECT UserID, RoleID FROM Users, Roles WHERE UserName = 'Charlie' AND RoleName = 'Sales';

-- Example Tables for ERP System (Simplified for Demonstration)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    ProductDescription NVARCHAR(255),
    Price DECIMAL(18, 2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2),
    Status NVARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NOT NULL,
    CustomerEmail NVARCHAR(100) NOT NULL UNIQUE,
    CustomerPhone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
----------------------------------THIS IS SAMPILE FOR REDO




-- Create backup table for Products
CREATE TABLE Products_Backup (
    BackupID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    ProductName NVARCHAR(100),
    ProductDescription NVARCHAR(255),
    Price DECIMAL(18, 2),
    DeletedAt DATETIME,
    DeletedBy NVARCHAR(100),
    DeleteReason NVARCHAR(255)
);
GO

-- Create backup table for Customers
CREATE TABLE Customers_Backup (
    BackupID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    CustomerName NVARCHAR(100),
    CustomerEmail NVARCHAR(100),
    CustomerPhone NVARCHAR(20),
    DeletedAt DATETIME,
    DeletedBy NVARCHAR(100),
    DeleteReason NVARCHAR(255)
);
GO

-- Create backup table for Orders
CREATE TABLE Orders_Backup (
    BackupID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(18, 2),
    Status NVARCHAR(50),
    DeletedAt DATETIME,
    DeletedBy NVARCHAR(100),
    DeleteReason NVARCHAR(255)
);
GO




-- Trigger for Products table
CREATE TRIGGER trg_Products_Delete
ON Products
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @DeletedAt DATETIME = GETDATE();
    DECLARE @DeletedBy NVARCHAR(100) = SYSTEM_USER;
    DECLARE @DeleteReason NVARCHAR(255) = 'Reason for deletion';

    INSERT INTO Products_Backup (ProductID, ProductName, ProductDescription, Price, DeletedAt, DeletedBy, DeleteReason)
    SELECT ProductID, ProductName, ProductDescription, Price, @DeletedAt, @DeletedBy, @DeleteReason
    FROM DELETED;

    DELETE FROM Products WHERE ProductID IN (SELECT ProductID FROM DELETED);
END;
GO

-- Trigger for Customers table
CREATE TRIGGER trg_Customers_Delete
ON Customers
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @DeletedAt DATETIME = GETDATE();
    DECLARE @DeletedBy NVARCHAR(100) = SYSTEM_USER;
    DECLARE @DeleteReason NVARCHAR(255) = 'Reason for deletion';

    INSERT INTO Customers_Backup (CustomerID, CustomerName, CustomerEmail, CustomerPhone, DeletedAt, DeletedBy, DeleteReason)
    SELECT CustomerID, CustomerName, CustomerEmail, CustomerPhone, @DeletedAt, @DeletedBy, @DeleteReason
    FROM DELETED;

    DELETE FROM Customers WHERE CustomerID IN (SELECT CustomerID FROM DELETED);
END;
GO

-- Trigger for Orders table
CREATE TRIGGER trg_Orders_Delete
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @DeletedAt DATETIME = GETDATE();
    DECLARE @DeletedBy NVARCHAR(100) = SYSTEM_USER;
    DECLARE @DeleteReason NVARCHAR(255) = 'Reason for deletion';

    INSERT INTO Orders_Backup (OrderID, CustomerID, OrderDate, TotalAmount, Status, DeletedAt, DeletedBy, DeleteReason)
    SELECT OrderID, CustomerID, OrderDate, TotalAmount, Status, @DeletedAt, @DeletedBy, @DeleteReason
    FROM DELETED;

    DELETE FROM Orders WHERE OrderID IN (SELECT OrderID FROM DELETED);
END;
GO

-- Continue creating triggers for other entities...









-- Continue creating backup tables for other entities...










-- Undo delete for Products table
CREATE PROCEDURE UndoDelete_Product
    @BackupID INT
AS
BEGIN
    DECLARE @ProductID INT, @ProductName NVARCHAR(100), @ProductDescription NVARCHAR(255), @Price DECIMAL(18, 2);

    SELECT @ProductID = ProductID, @ProductName = ProductName, @ProductDescription = ProductDescription, @Price = Price
    FROM Products_Backup
    WHERE BackupID = @BackupID;

    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        INSERT INTO Products (ProductID, ProductName, ProductDescription, Price)
        VALUES (@ProductID, @ProductName, @ProductDescription, @Price);
    END
END;
GO

-- Redo delete for Products table
CREATE PROCEDURE RedoDelete_Product
    @BackupID INT
AS
BEGIN
    DECLARE @ProductID INT;

    SELECT @ProductID = ProductID
    FROM Products_Backup
    WHERE BackupID = @BackupID;

    DELETE FROM Products WHERE ProductID = @ProductID;
END;
GO

-- Undo delete for Customers table
CREATE PROCEDURE UndoDelete_Customer
    @BackupID INT
AS
BEGIN
    DECLARE @CustomerID INT, @CustomerName NVARCHAR(100), @CustomerEmail NVARCHAR(100), @CustomerPhone NVARCHAR(20);

    SELECT @CustomerID = CustomerID, @CustomerName = CustomerName, @CustomerEmail = CustomerEmail, @CustomerPhone = CustomerPhone
    FROM Customers_Backup
    WHERE BackupID = @BackupID;

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        INSERT INTO Customers (CustomerID, CustomerName, CustomerEmail, CustomerPhone)
        VALUES (@CustomerID, @CustomerName, @CustomerEmail, @CustomerPhone);
    END
END;
GO

-- Redo delete for Customers table
CREATE PROCEDURE RedoDelete_Customer
    @BackupID INT
AS
BEGIN
    DECLARE @CustomerID INT;

    SELECT @CustomerID = CustomerID
    FROM Customers_Backup
    WHERE BackupID = @BackupID;

    DELETE FROM Customers WHERE CustomerID = @CustomerID;
END;
GO

-- Undo delete for Orders table
CREATE PROCEDURE UndoDelete_Order
    @BackupID INT
AS
BEGIN
    DECLARE @OrderID INT, @CustomerID INT, @OrderDate DATETIME, @TotalAmount DECIMAL(18, 2), @Status NVARCHAR(50);

    SELECT @OrderID = OrderID, @CustomerID = CustomerID, @OrderDate = OrderDate, @TotalAmount = TotalAmount, @Status = Status
    FROM Orders_Backup
    WHERE BackupID = @BackupID;

    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status)
        VALUES (@OrderID, @CustomerID, @OrderDate, @TotalAmount, @Status);
    END
END;
GO

-- Redo delete for Orders table
CREATE PROCEDURE RedoDelete_Order
    @BackupID INT
AS
BEGIN
    DECLARE @OrderID INT;

    SELECT @OrderID = OrderID
    FROM Orders_Backup
    WHERE BackupID = @BackupID;

    DELETE FROM Orders WHERE OrderID = @OrderID;
END;
GO

-- Continue creating undo/redo procedures for other entities...
