
USE CarRentalSystem;
GO

INSERT INTO Categories (CategoryName, Description, DailyRate)
VALUES
('Economy', 'Small and fuel-efficient cars', 25.00),
('Compact', 'Comfortable cars for everyday use', 35.00),
('SUV', 'Larger vehicles suitable for families and longer trips', 55.00),
('Luxury', 'Premium vehicles with higher comfort and performance', 90.00),
('Van', 'Large vehicles suitable for groups and cargo', 75.00);

INSERT INTO Locations (LocationName, Address, City)
VALUES
('Prishtina Airport', 'Rruga e Aeroportit', 'Prishtina'),
('Prishtina Downtown', 'Bulevardi Bill Klinton', 'Prishtina'),
('Prizren Branch', 'Rruga Tirana', 'Prizren'),
('Peja Branch', 'Rruga Mbretëresha Teutë', 'Peja'),
('Ferizaj Branch', 'Rruga Dëshmorët e Kombit', 'Ferizaj');

INSERT INTO Customers
(FirstName, LastName, Phone, Email, DriverLicenseNo, DateOfBirth, RegistrationDate)
VALUES
('Arben', 'Krasniqi', '044111222', 'arben.krasniqi@email.com', 'KS100001', '1995-03-15', '2026-01-10'),
('Lira', 'Berisha', '045222333', 'lira.berisha@email.com', 'KS100002', '1998-07-22', '2026-01-15'),
('Dren', 'Gashi', '049333444', 'dren.gashi@email.com', 'KS100003', '1992-11-05', '2026-01-20'),
('Era', 'Hoxha', '044444555', 'era.hoxha@email.com', 'KS100004', '2000-02-18', '2026-02-01'),
('Blerim', 'Shala', '045555666', 'blerim.shala@email.com', 'KS100005', '1988-09-30', '2026-02-05'),
('Elira', 'Rexhepi', '049666777', 'elira.rexhepi@email.com', 'KS100006', '1997-06-12', '2026-02-10'),
('Leon', 'Morina', '044777888', 'leon.morina@email.com', 'KS100007', '1994-12-01', '2026-02-15'),
('Sara', 'Kelmendi', '045888999', 'sara.kelmendi@email.com', 'KS100008', '1999-04-25', '2026-02-20'),
('Valon', 'Bajrami', '049999111', 'valon.bajrami@email.com', 'KS100009', '1990-08-14', '2026-02-25'),
('Arta', 'Osmani', '044123456', 'arta.osmani@email.com', 'KS100010', '1996-01-19', '2026-03-01'),
('Gent', 'Bytyqi', '045234567', 'gent.bytyqi@email.com', 'KS100011', '1993-05-11', '2026-03-05'),
('Rina', 'Selimi', '049345678', 'rina.selimi@email.com', 'KS100012', '2001-10-09', '2026-03-10'),
('Fisnik', 'Tahiri', '044456789', 'fisnik.tahiri@email.com', 'KS100013', '1987-03-27', '2026-03-15'),
('Dafina', 'Mustafa', '045567890', 'dafina.mustafa@email.com', 'KS100014', '1995-07-03', '2026-03-20'),
('Luan', 'Ibrahimi', '049678901', 'luan.ibrahimi@email.com', 'KS100015', '1991-09-17', '2026-03-25'),
('Nora', 'Zeka', '044789012', 'nora.zeka@email.com', 'KS100016', '1998-12-22', '2026-04-01'),
('Alban', 'Mehmeti', '045890123', 'alban.mehmeti@email.com', 'KS100017', '1989-06-06', '2026-04-05'),
('Jona', 'Koci', '049901234', 'jona.koci@email.com', 'KS100018', '2000-11-28', '2026-04-10'),
('Kreshnik', 'Dervishi', '044012345', 'kreshnik.dervishi@email.com', 'KS100019', '1993-02-10', '2026-04-15'),
('Vesa', 'Rama', '045012346', 'vesa.rama@email.com', 'KS100020', '1997-08-21', '2026-04-20');

INSERT INTO Employees
(FirstName, LastName, Position, HireDate, Salary)
VALUES
('Besnik', 'Krasniqi', 'Manager', '2022-03-01', 1200.00),
('Mira', 'Berisha', 'Rental Agent', '2023-05-15', 850.00),
('Ilir', 'Gashi', 'Rental Agent', '2023-08-10', 850.00),
('Arta', 'Hoxha', 'Rental Agent', '2024-01-20', 900.00),
('Drin', 'Shala', 'Rental Agent', '2024-04-05', 850.00),
('Blerta', 'Rexhepi', 'Accountant', '2022-11-01', 1000.00),
('Luan', 'Morina', 'Fleet Manager', '2021-06-15', 1100.00),
('Sara', 'Kelmendi', 'Rental Agent', '2025-02-10', 800.00),
('Valon', 'Bajrami', 'Customer Service', '2024-09-01', 850.00),
('Drita', 'Osmani', 'Branch Manager', '2020-07-01', 1300.00);

INSERT INTO Vehicles
(CategoryID, LocationID, Make, Model, VehicleYear, LicensePlate, DailyRate, Status)
VALUES
(1, 1, 'Toyota', 'Yaris', 2023, '01-101-AA', 25.00, 'Available'),
(1, 2, 'Volkswagen', 'Polo', 2022, '01-102-AA', 27.00, 'Available'),
(1, 3, 'Hyundai', 'i20', 2023, '04-103-AA', 26.00, 'Rented'),
(2, 1, 'Volkswagen', 'Golf', 2024, '01-201-BB', 35.00, 'Available'),
(2, 2, 'Toyota', 'Corolla', 2023, '01-202-BB', 38.00, 'Rented'),
(2, 4, 'Skoda', 'Octavia', 2022, '03-203-BB', 40.00, 'Available'),
(3, 1, 'Toyota', 'RAV4', 2024, '01-301-CC', 55.00, 'Available'),
(3, 2, 'Hyundai', 'Tucson', 2023, '01-302-CC', 52.00, 'Rented'),
(3, 3, 'Kia', 'Sportage', 2024, '04-303-CC', 55.00, 'Available'),
(3, 5, 'Nissan', 'Qashqai', 2022, '05-304-CC', 50.00, 'Maintenance'),
(4, 1, 'BMW', '320i', 2023, '01-401-DD', 90.00, 'Available'),
(4, 2, 'Mercedes-Benz', 'C200', 2024, '01-402-DD', 100.00, 'Available'),
(4, 3, 'Audi', 'A4', 2023, '04-403-DD', 95.00, 'Rented'),
(5, 1, 'Volkswagen', 'Transporter', 2022, '01-501-EE', 75.00, 'Available'),
(5, 4, 'Ford', 'Transit', 2023, '03-502-EE', 80.00, 'Available'),
(2, 5, 'Honda', 'Civic', 2023, '05-204-BB', 37.00, 'Available'),
(1, 4, 'Renault', 'Clio', 2022, '03-104-AA', 25.00, 'Available'),
(3, 2, 'Mazda', 'CX-5', 2024, '01-305-CC', 58.00, 'Available'),
(4, 5, 'Volvo', 'S60', 2023, '05-404-DD', 92.00, 'Available'),
(1, 3, 'Fiat', '500', 2022, '04-105-AA', 24.00, 'Available');

INSERT INTO Rentals
(CustomerID, VehicleID, EmployeeID, StartDate, EndDate, TotalAmount, Status)
VALUES
(1, 1, 2, '2026-05-01', '2026-05-04', 75.00, 'Completed'),
(2, 4, 3, '2026-05-03', '2026-05-08', 175.00, 'Completed'),
(3, 7, 4, '2026-05-05', '2026-05-10', 275.00, 'Completed'),
(4, 5, 5, '2026-05-07', '2026-05-09', 76.00, 'Completed'),
(5, 11, 2, '2026-05-10', '2026-05-13', 270.00, 'Completed'),
(6, 2, 3, '2026-05-12', '2026-05-15', 81.00, 'Completed'),
(7, 8, 4, '2026-05-15', '2026-05-20', 260.00, 'Completed'),
(8, 14, 5, '2026-05-18', '2026-05-22', 300.00, 'Completed'),
(9, 13, 2, '2026-05-20', '2026-05-25', 475.00, 'Completed'),
(10, 6, 3, '2026-05-22', '2026-05-25', 120.00, 'Completed'),

(1, 3, 4, '2026-06-01', '2026-06-05', 104.00, 'Completed'),
(3, 9, 5, '2026-06-03', '2026-06-08', 275.00, 'Completed'),
(5, 12, 2, '2026-06-05', '2026-06-08', 300.00, 'Completed'),
(11, 17, 3, '2026-06-07', '2026-06-10', 75.00, 'Completed'),
(12, 18, 4, '2026-06-10', '2026-06-15', 290.00, 'Completed'),
(13, 16, 5, '2026-06-12', '2026-06-16', 148.00, 'Completed'),
(14, 7, 2, '2026-06-15', '2026-06-20', 275.00, 'Completed'),
(15, 15, 3, '2026-06-18', '2026-06-22', 320.00, 'Completed'),
(16, 19, 4, '2026-06-20', '2026-06-23', 276.00, 'Completed'),
(17, 1, 5, '2026-06-22', '2026-06-25', 75.00, 'Completed'),

(2, 5, 2, '2026-07-01', '2026-07-05', 152.00, 'Completed'),
(4, 10, 3, '2026-07-03', '2026-07-08', 250.00, 'Completed'),
(6, 11, 4, '2026-07-05', '2026-07-10', 450.00, 'Completed'),
(8, 4, 5, '2026-07-08', '2026-07-12', 140.00, 'Completed'),
(10, 8, 2, '2026-07-10', '2026-07-15', 260.00, 'Completed'),
(12, 14, 3, '2026-07-12', '2026-07-17', 375.00, 'Completed'),
(14, 20, 4, '2026-07-15', '2026-07-18', 72.00, 'Completed'),
(18, 13, 5, '2026-07-18', '2026-07-23', 475.00, 'Completed'),
(19, 6, 2, '2026-07-20', '2026-07-25', 200.00, 'Completed'),
(20, 7, 3, '2026-07-22', '2026-07-27', 275.00, 'Completed'),

(1, 12, 4, '2026-08-01', '2026-08-05', 400.00, 'Completed'),
(5, 18, 5, '2026-08-03', '2026-08-08', 290.00, 'Completed'),
(7, 9, 2, '2026-08-05', '2026-08-09', 220.00, 'Completed'),
(9, 11, 3, '2026-08-07', '2026-08-12', 450.00, 'Completed'),
(11, 4, 4, '2026-08-10', '2026-08-14', 140.00, 'Completed'),
(13, 15, 5, '2026-08-12', '2026-08-18', 480.00, 'Completed'),
(16, 2, 2, '2026-08-15', '2026-08-20', 135.00, 'Completed'),
(18, 7, 3, '2026-08-18', '2026-08-24', 330.00, 'Completed'),
(20, 19, 4, '2026-08-20', '2026-08-25', 460.00, 'Completed'),
(3, 3, 5, '2026-08-25', '2026-08-30', 130.00, 'Active'),
(6, 8, 2, '2026-08-27', '2026-09-02', 312.00, 'Active'),
(15, 13, 3, '2026-08-28', '2026-09-03', 570.00, 'Active'),
(4, 10, 4, '2026-08-29', '2026-09-01', 150.00, 'Cancelled'),
(17, 16, 5, '2026-08-30', '2026-09-03', 148.00, 'Cancelled');

INSERT INTO Payments
(RentalID, PaymentDate, Amount, PaymentMethod, PaymentStatus)
VALUES
(1, '2026-05-01', 75.00, 'Card', 'Completed'),
(2, '2026-05-03', 100.00, 'Card', 'Completed'),
(2, '2026-05-07', 75.00, 'Cash', 'Completed'),
(3, '2026-05-05', 150.00, 'Card', 'Completed'),
(3, '2026-05-10', 125.00, 'Card', 'Completed'),
(4, '2026-05-07', 76.00, 'Cash', 'Completed'),
(5, '2026-05-10', 270.00, 'Bank Transfer', 'Completed'),
(6, '2026-05-12', 81.00, 'Card', 'Completed'),
(7, '2026-05-15', 260.00, 'Card', 'Completed'),
(8, '2026-05-18', 300.00, 'Cash', 'Completed'),
(9, '2026-05-20', 250.00, 'Card', 'Completed'),
(9, '2026-05-24', 225.00, 'Card', 'Completed'),
(10, '2026-05-22', 120.00, 'Cash', 'Completed'),

(11, '2026-06-01', 104.00, 'Card', 'Completed'),
(12, '2026-06-03', 275.00, 'Card', 'Completed'),
(13, '2026-06-05', 300.00, 'Bank Transfer', 'Completed'),
(14, '2026-06-07', 75.00, 'Cash', 'Completed'),
(15, '2026-06-10', 150.00, 'Card', 'Completed'),
(15, '2026-06-14', 140.00, 'Card', 'Completed'),
(16, '2026-06-12', 148.00, 'Cash', 'Completed'),
(17, '2026-06-15', 275.00, 'Card', 'Completed'),
(18, '2026-06-18', 320.00, 'Bank Transfer', 'Completed'),
(19, '2026-06-20', 276.00, 'Card', 'Completed'),
(20, '2026-06-22', 75.00, 'Cash', 'Completed'),

(21, '2026-07-01', 152.00, 'Card', 'Completed'),
(22, '2026-07-03', 250.00, 'Cash', 'Completed'),
(23, '2026-07-05', 450.00, 'Card', 'Completed'),
(24, '2026-07-08', 140.00, 'Card', 'Completed'),
(25, '2026-07-10', 260.00, 'Bank Transfer', 'Completed'),
(26, '2026-07-12', 200.00, 'Card', 'Completed'),
(26, '2026-07-16', 175.00, 'Card', 'Completed'),
(27, '2026-07-15', 72.00, 'Cash', 'Completed'),
(28, '2026-07-18', 475.00, 'Card', 'Completed'),
(29, '2026-07-20', 200.00, 'Bank Transfer', 'Completed'),
(30, '2026-07-22', 275.00, 'Card', 'Completed'),

(31, '2026-08-01', 200.00, 'Card', 'Completed'),
(31, '2026-08-04', 200.00, 'Card', 'Completed'),
(32, '2026-08-03', 290.00, 'Bank Transfer', 'Completed'),
(33, '2026-08-05', 220.00, 'Card', 'Completed'),
(34, '2026-08-07', 450.00, 'Card', 'Completed'),
(35, '2026-08-10', 140.00, 'Cash', 'Completed'),
(36, '2026-08-12', 300.00, 'Card', 'Completed'),
(36, '2026-08-16', 180.00, 'Card', 'Completed'),
(37, '2026-08-15', 135.00, 'Cash', 'Completed'),
(38, '2026-08-18', 330.00, 'Card', 'Completed'),
(39, '2026-08-20', 460.00, 'Bank Transfer', 'Completed'),
(40, '2026-08-25', 50.00, 'Card', 'Completed'),
(41, '2026-08-27', 150.00, 'Card', 'Completed'),
(42, '2026-08-28', 300.00, 'Card', 'Completed');