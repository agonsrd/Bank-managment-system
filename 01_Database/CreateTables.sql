CREATE DATABASE CarRentalSystem;
GO

USE CarRentalSystem;
GO

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    DriverLicenseNo VARCHAR(30) NOT NULL UNIQUE,
    DateOfBirth DATE,
    RegistrationDate DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200),
    DailyRate DECIMAL(10,2) NOT NULL,

    CONSTRAINT CK_Categories_DailyRate
        CHECK (DailyRate > 0)
);

CREATE TABLE Locations (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationName VARCHAR(100) NOT NULL,
    Address VARCHAR(150) NOT NULL,
    City VARCHAR(50) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    LocationID INT NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    VehicleYear INT NOT NULL,
    LicensePlate VARCHAR(20) NOT NULL UNIQUE,
    DailyRate DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Available',

    CONSTRAINT FK_Vehicles_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT FK_Vehicles_Locations
        FOREIGN KEY (LocationID)
        REFERENCES Locations(LocationID),

    CONSTRAINT CK_Vehicles_DailyRate
        CHECK (DailyRate > 0),

    CONSTRAINT CK_Vehicles_Status
        CHECK (Status IN ('Available', 'Rented', 'Maintenance'))
);

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2)
);

CREATE TABLE Rentals (
    RentalID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT FK_Rentals_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Rentals_Vehicles
        FOREIGN KEY (VehicleID)
        REFERENCES Vehicles(VehicleID),

    CONSTRAINT FK_Rentals_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT CK_Rentals_Dates
        CHECK (EndDate >= StartDate),

    CONSTRAINT CK_Rentals_TotalAmount
        CHECK (TotalAmount >= 0),

    CONSTRAINT CK_Rentals_Status
        CHECK (Status IN ('Active', 'Completed', 'Cancelled'))
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    RentalID INT NOT NULL,
    PaymentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Completed',

    CONSTRAINT FK_Payments_Rentals
        FOREIGN KEY (RentalID)
        REFERENCES Rentals(RentalID),

    CONSTRAINT CK_Payments_Amount
        CHECK (Amount > 0),

    CONSTRAINT CK_Payments_Method
        CHECK (PaymentMethod IN ('Cash', 'Card', 'Bank Transfer')),

    CONSTRAINT CK_Payments_Status
        CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed'))
);