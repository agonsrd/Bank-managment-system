--Find customers whose total spending is above the average customer spending.

--This demonstrates a temporary table + subquery + aggregation + JOIN.
-- Create temporary table with each customer's total spending

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(r.TotalAmount) AS TotalSpent
INTO #CustomerSpending
FROM Customers AS c
INNER JOIN Rentals AS r
    ON c.CustomerID = r.CustomerID
WHERE r.Status = 'Completed'
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;


-- Find customers spending more than the average

SELECT
    CustomerID,
    CustomerName,
    TotalSpent
FROM #CustomerSpending
WHERE TotalSpent >
(
    SELECT AVG(TotalSpent)
    FROM #CustomerSpending
)
ORDER BY TotalSpent DESC;


-- Remove temporary table

DROP TABLE #CustomerSpending;


--When a customer rents a vehicle, we need to create the rental AND change the vehicle's status to Rented. Both operations should succeed together.

--If something fails, we don't want half of the transaction completed.

--Create the procedure

CREATE PROCEDURE CreateRental
    @CustomerID INT,
    @VehicleID INT,
    @EmployeeID INT,
    @StartDate DATE,
    @EndDate DATE,
    @TotalAmount DECIMAL(10,2)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        -- Create the rental
        INSERT INTO Rentals
        (
            CustomerID,
            VehicleID,
            EmployeeID,
            StartDate,
            EndDate,
            TotalAmount,
            Status
        )
        VALUES
        (
            @CustomerID,
            @VehicleID,
            @EmployeeID,
            @StartDate,
            @EndDate,
            @TotalAmount,
            'Active'
        );


        -- Change vehicle status
        UPDATE Vehicles
        SET Status = 'Rented'
        WHERE VehicleID = @VehicleID;


        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO
--Now you can execute it:

EXEC CreateRental
    @CustomerID = 5,
    @VehicleID = 3,
    @EmployeeID = 2,
    @StartDate = '2026-09-20',
    @EndDate = '2026-09-23',
    @TotalAmount = 180.00;

ROLLBACK
---FUNCTION + View + Trigger + Index

CREATE FUNCTION CalculateRentalDays
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN

    RETURN DATEDIFF(DAY, @StartDate, @EndDate);

END;
GO

SELECT
    RentalID,
    StartDate,
    EndDate,
    dbo.CalculateRentalDays(StartDate, EndDate) AS RentalDays
FROM Rentals;

--VIEW

CREATE VIEW RentalSummary
AS
SELECT
    r.RentalID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    CONCAT(v.Make, ' ', v.Model) AS Vehicle,
    cat.CategoryName,
    l.LocationName,
    r.StartDate,
    r.EndDate,
    dbo.CalculateRentalDays(r.StartDate, r.EndDate) AS RentalDays,
    r.TotalAmount,
    r.Status

FROM Rentals AS r

INNER JOIN Customers AS c
    ON r.CustomerID = c.CustomerID

INNER JOIN Vehicles AS v
    ON r.VehicleID = v.VehicleID

INNER JOIN Categories AS cat
    ON v.CategoryID = cat.CategoryID

INNER JOIN Locations AS l
    ON v.LocationID = l.LocationID;
GO

SELECT *
FROM RentalSummary
WHERE Status = 'Completed'
ORDER BY TotalAmount DESC;

Trigger

CREATE TRIGGER trg_VehicleRented
ON Rentals
AFTER INSERT
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE v
    SET Status = 'Rented'
    FROM Vehicles AS v
    INNER JOIN inserted AS i
        ON v.VehicleID = i.VehicleID;

END;

INSERT INTO Rentals
(
    CustomerID,
    VehicleID,
    EmployeeID,
    StartDate,
    EndDate,
    TotalAmount,
    Status
)
VALUES
(
    3,
    7,
    2,
    '2026-09-20',
    '2026-09-23',
    240,
    'Active'
);

UPDATE Vehicles
SET Status = 'Rented'

--INDEX

--your system frequently searches rentals by customer:
CREATE INDEX IX_Rentals_CustomerID
ON Rentals(CustomerID);

--And if you frequently search rentals by dates:
CREATE INDEX IX_Rentals_StartDate
ON Rentals(StartDate);