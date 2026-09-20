--Which vehicles are generating the most revenue within each category?
--Uses: CTE, JOINs, GROUP BY, aggregate functions, CONCAT, window function, PARTITION BY, RANK(), CASE


WITH VehiclePerformance AS
(
    SELECT
        v.VehicleID,
        CONCAT(v.Make, ' ', v.Model) AS Vehicle,
        cat.CategoryName,
        v.DailyRate,

        COUNT(r.RentalID) AS TotalRentals,

        SUM(r.TotalAmount) AS TotalRevenue,

        CAST(
            AVG(DATEDIFF(DAY, r.StartDate, r.EndDate) * 1.0)
            AS DECIMAL(10,2)
        ) AS AverageRentalDays,

        RANK() OVER
        (
            PARTITION BY cat.CategoryID
            ORDER BY SUM(r.TotalAmount) DESC
        ) AS CategoryRank
    FROM Vehicles AS v
    INNER JOIN Categories AS cat
        ON v.CategoryID = cat.CategoryID
    LEFT JOIN Rentals AS r
        ON v.VehicleID = r.VehicleID
        AND r.Status = 'Completed'
    GROUP BY
        v.VehicleID,
        v.Make,
        v.Model,
        cat.CategoryID,
        cat.CategoryName,
        v.DailyRate
)
SELECT
    CategoryName,
    Vehicle,
    DailyRate,
    TotalRentals,
    TotalRevenue,
    AverageRentalDays,

    CASE
        WHEN TotalRevenue >= 1000 THEN 'High Performer'
        WHEN TotalRevenue >= 500 THEN 'Medium Performer'
        ELSE 'Low Performer'
    END AS PerformanceLevel
FROM VehiclePerformance
WHERE CategoryRank = 1
ORDER BY TotalRevenue DESC;

--How is the business performing month by month, 
--including revenue, number of rentals, average rental duration, and completion rate?

WITH MonthlyPerformance AS
(
    SELECT
        FORMAT(StartDate, 'yyyy-MM') AS RentalMonth,

        COUNT(*) AS TotalRentals,

        SUM(
            CASE
                WHEN Status = 'Completed'
                THEN 1
                ELSE 0
            END
        ) AS CompletedRentals,

        SUM(
            CASE
                WHEN Status = 'Cancelled'
                THEN 1
                ELSE 0
            END
        ) AS CancelledRentals,

        SUM(
            CASE
                WHEN Status = 'Completed'
                THEN TotalAmount
                ELSE 0
            END
        ) AS Revenue,

        AVG(
            CASE
                WHEN Status = 'Completed'
                THEN DATEDIFF(DAY, StartDate, EndDate) * 1.0
            END
        ) AS AverageRentalDays

    FROM Rentals

    GROUP BY FORMAT(StartDate, 'yyyy-MM')
)

SELECT
    RentalMonth,
    TotalRentals,
    CompletedRentals,
    CancelledRentals,

    CAST(Revenue AS DECIMAL(10,2)) AS Revenue,

    CAST(
        AverageRentalDays
        AS DECIMAL(10,2)
    ) AS AverageRentalDays,

    CAST(
        CompletedRentals * 100.0 /
        NULLIF(TotalRentals, 0)
        AS DECIMAL(10,2)
    ) AS CompletionRate,

    RANK() OVER (
        ORDER BY Revenue DESC
    ) AS RevenueRank

FROM MonthlyPerformance

ORDER BY RentalMonth;


--Which customers have spent the most, how much have they paid, and how much do they still owe?

-- Uses: JOINs, GROUP BY, aggregate functions, string functions, CASE, COALESCE, NULLIF, CAST

SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,

    COUNT(DISTINCT r.RentalID) AS TotalRentals,

    CAST(SUM(r.TotalAmount) AS DECIMAL(10,2)) AS TotalRentalAmount,

    CAST(
        COALESCE(SUM(p.Amount), 0)
        AS DECIMAL(10,2)
    ) AS TotalPaid,

    CAST(
        SUM(r.TotalAmount) - COALESCE(SUM(p.Amount), 0)
        AS DECIMAL(10,2)
    ) AS AmountOwed,

    CASE
        WHEN COALESCE(SUM(p.Amount), 0) >= SUM(r.TotalAmount)
            THEN 'Fully Paid'
        WHEN COALESCE(SUM(p.Amount), 0) > 0
            THEN 'Partially Paid'
        ELSE 'Not Paid'
    END AS PaymentStatus

FROM Customers AS c

INNER JOIN Rentals AS r
    ON c.CustomerID = r.CustomerID

LEFT JOIN Payments AS p
    ON r.RentalID = p.RentalID
    AND p.PaymentStatus = 'Completed'

WHERE r.Status <> 'Cancelled'

GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName

ORDER BY TotalRentalAmount DESC;


--Which customers are active, which customers have completed rentals, and which registered
--customers have never rented a vehicle?


-- 1. Customers with either Active or Completed rentals
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    'Active or Completed Rental' AS CustomerGroup
FROM Customers AS c
INNER JOIN
(
    SELECT CustomerID
    FROM Rentals
    WHERE Status = 'Active'

    UNION

    SELECT CustomerID
    FROM Rentals
    WHERE Status = 'Completed'
) AS CustomerGroups
    ON c.CustomerID = CustomerGroups.CustomerID;


-- 2. Customers who have completed rentals AND completed payments
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    'Completed Rental and Payment' AS CustomerGroup
FROM Customers AS c
INNER JOIN
(
    SELECT CustomerID
    FROM Rentals
    WHERE Status = 'Completed'

    INTERSECT

    SELECT r.CustomerID
    FROM Rentals AS r
    INNER JOIN Payments AS p
        ON r.RentalID = p.RentalID
    WHERE p.PaymentStatus = 'Completed'
) AS CustomerGroups
    ON c.CustomerID = CustomerGroups.CustomerID;


-- 3. Registered customers who have never rented
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    ISNULL(
        CONVERT(VARCHAR(10), c.RegistrationDate, 103),
        'Unknown'
    ) AS RegistrationDate,
    'Never Rented' AS CustomerGroup
FROM Customers AS c
WHERE c.CustomerID IN
(
    SELECT CustomerID
    FROM Customers

    EXCEPT

    SELECT CustomerID
    FROM Rentals
);