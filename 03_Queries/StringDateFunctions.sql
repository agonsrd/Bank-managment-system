USE CarRentalSystem;

GO


--convert text to lowercase

SELECT
    FirstName,
    LOWER(FirstName) AS UpperName
FROM Customers;

----convert text to uppercase
SELECT
    Email,
    UPPER(Email) AS LowerEmail
FROM Customers;

--combine multiple values
SELECT
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

--count characters
SELECT
    FirstName,
    LEN(FirstName) AS NameLength
FROM Customers;

--get characters from the left
SELECT
    FirstName,
    LEFT(FirstName, 3) AS ShortName
FROM Customers;

--get characters from the right
SELECT
    LastName,
    RIGHT(LastName, 3) AS LastThree
FROM Customers;

--extract part of a string
SELECT
    FirstName,
    SUBSTRING(FirstName, 1, 3) AS FirstThreeLetters
FROM Customers;

--replace text
SELECT
    Email,
    REPLACE(Email, '@', ' [AT] ') AS NewEmail
FROM Customers;

--current date and time
SELECT GETDATE() AS CurrentDateTime;

--get the year
SELECT
    FirstName,
    DateOfBirth,
    YEAR(DateOfBirth) AS BirthYear
FROM Customers;

--get the month from rental start dates
SELECT
    RentalID,
    StartDate,
    DATEPART(MONTH, StartDate) AS RentalMonth
FROM Rentals;

--calculate how many days a vehicle was rented
SELECT
    RentalID,
    StartDate,
    EndDate,
    DATEDIFF(DAY, StartDate, EndDate) AS RentalDays
FROM Rentals;

--Calculate rental cost
SELECT
    r.RentalID,
    r.StartDate,
    r.EndDate,
    DATEDIFF(DAY, r.StartDate, r.EndDate) AS RentalDays,
    v.DailyRate,
    DATEDIFF(DAY, r.StartDate, r.EndDate) * v.DailyRate AS CalculatedAmount
FROM Rentals AS r
INNER JOIN Vehicles AS v
    ON r.VehicleID = v.VehicleID;

 --calculate the date 7 days after a rental starts
    SELECT
    RentalID,
    StartDate,
    DATEADD(DAY, 7, StartDate) AS SevenDaysLater
FROM Rentals;