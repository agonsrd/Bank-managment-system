-- Select specific columns

SELECT
    FirstName,
    LastName,
    Phone,
    Email
FROM Customers;


--Select specific vehicle information

SELECT
    Make,
    Model,
    VehicleYear,
    LicensePlate,
    DailyRate
FROM Vehicles;

--Find available cars

SELECT
    VehicleID,
    Make,
    Model,
    VehicleYear,
    DailyRate
FROM Vehicles
WHERE Status = 'Available';

--Find rented cars 

SELECT
    VehicleID,
    Make,
    Model,
    LicensePlate
FROM Vehicles
WHERE Status = 'Rented';


--Cars that cost more than 50 EUR a day

SELECT
    Make,
    Model,
    DailyRate
FROM Vehicles
WHERE DailyRate > 50;


-- Cars that cost between 30 and 60 EUR a day
SELECT
    Make,
    Model,
    DailyRate
FROM Vehicles
WHERE DailyRate BETWEEN 30 AND 60;


-- Customers from a specific registration period
SELECT
    FirstName,
    LastName,
    RegistrationDate
FROM Customers
WHERE RegistrationDate >= '2026-03-01';

--Rentals costing more than €300

SELECT 
    RentalID,
    CustomerID,
    VehicleID,
    StartDate,
    EndDate,
    TotalAmount
FROM Rentals
WHERE TotalAmount > 300;

--Rentals above €300 that are completed
SELECT *
FROM Rentals
WHERE TotalAmount > 300
  AND Status = 'Completed';


--Find vehicles that are either rented or under maintenance ( USING IN)
 
SELECT
    Make,
    Model,
    Status
FROM Vehicles
WHERE Status IN ('Rented', 'Maintenance');

--Find Customer with Specific IDS
SELECT
    CustomerID,
    FirstName,
    LastName
FROM Customers
WHERE CustomerID IN (1, 5, 10, 15);

--Sort by most expensive daily rate vehicles
SELECT
    Make,
    Model,
    DailyRate
FROM Vehicles
ORDER BY DailyRate DESC;

--Searching for a particular name
SELECT
    FirstName,
    LastName,
    Email
FROM Customers
WHERE FirstName LIKE 'A%';

--Retrieve completed rentals from August
SELECT
    RentalID,
    CustomerID,
    VehicleID,
    StartDate,
    EndDate,
    TotalAmount
FROM Rentals
WHERE Status = 'Completed'
  AND StartDate >= '2026-08-01'
  AND StartDate < '2026-09-01';

  --Retrieve payments made by card

  SELECT
    PaymentID,
    RentalID,
    PaymentDate,
    Amount
FROM Payments
WHERE PaymentMethod = 'Card';


--Find the 5 most expensive available cars

SELECT TOP 5
    Make,
    Model,
    VehicleYear,
    DailyRate
FROM Vehicles
WHERE Status = 'Available'
ORDER BY DailyRate DESC;