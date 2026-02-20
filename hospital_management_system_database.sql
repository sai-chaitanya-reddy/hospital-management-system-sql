-- Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- Doctors
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name NVARCHAR(100),
    DepartmentID INT,
    Email NVARCHAR(100),
    ExperienceYears INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Patients
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Gender NVARCHAR(10),
    DOB DATE,
    Contact NVARCHAR(15)
);

-- Appointments
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Reason NVARCHAR(200),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Medications
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Type NVARCHAR(50)
);

-- Prescriptions
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT,
    MedicationID INT,
    Dosage NVARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- Bills
CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    AppointmentID INT,
    Amount DECIMAL(10,2),
    Paid BIT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);


INSERT INTO Departments VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Oncology');

INSERT INTO Doctors VALUES
(1, 'Dr. Meena Sharma', 1, 'meena@hospital.com', 10),
(2, 'Dr. Raj Malhotra', 2, 'raj@hospital.com', 15),
(3, 'Dr. Neha Desai', 3, 'neha@hospital.com', 8),
(4, 'Dr. Arjun Rao', 4, 'arjun@hospital.com', 6),
(5, 'Dr. Kavita Nair', 5, 'kavita@hospital.com', 12);

INSERT INTO Patients VALUES
(101, 'Arjun Singh', 'Male', '1990-06-15', '9876543210'),
(102, 'Riya Verma', 'Female', '1985-02-22', '9123456789'),
(103, 'Zaid Khan', 'Male', '1992-11-10', '8899776655'),
(104, 'Suman Das', 'Female', '1978-08-05', '9955441122'),
(105, 'Naveen Reddy', 'Male', '2001-03-30', '7776665554'),
(106, 'Pooja Mehta', 'Female', '1995-12-12', '9345098761');


INSERT INTO Appointments VALUES
(201, 101, 1, '2024-07-15', 'Chest Pain'),
(202, 102, 2, '2024-07-16', 'Migraine'),
(203, 103, 3, '2024-07-17', 'Leg Pain'),
(204, 104, 4, '2024-07-18', 'Fever'),
(205, 105, 5, '2024-07-19', 'Cancer Treatment'),
(206, 106, 1, '2024-07-20', 'Heart Checkup')

INSERT INTO Medications VALUES
(301, 'Paracetamol', 'Tablet'),
(302, 'Aspirin', 'Tablet'),
(303, 'Amoxicillin', 'Capsule'),
(304, 'Ibuprofen', 'Tablet'),
(305, 'Ciprofloxacin', 'Tablet');

INSERT INTO Prescriptions VALUES
(401, 201, 301, '1 tablet daily'),
(402, 202, 302, '2 tablets daily'),
(403, 203, 303, '1 capsule morning'),
(404, 204, 304, '1 tablet after meals'),
(405, 205, 305, '2 tablets daily'),
(406, 206, 301, '1 tablet before bed');

INSERT INTO Bills VALUES
(501, 201, 1500.00, 1),
(502, 202, 800.00, 1),
(503, 203, 1200.00, 0),
(504, 204, 600.00, 1),
(505, 205, 5000.00, 0),
(506, 206, 1000.00, 1);

SELECT a.AppointmentID, p.Name AS Patient, d.Name AS Doctor, a.AppointmentDate, a.Reason
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID


--Total Bills and Unpaid Bills
SELECT 
    SUM(Amount) AS TotalBills, 
    SUM(CASE WHEN Paid = 0 THEN Amount ELSE 0 END) AS UnpaidAmount
FROM Bills;

SELECT dept.Name AS Department, COUNT(*) AS PatientCount
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Departments dept ON d.DepartmentID = dept.DepartmentID
GROUP BY dept.Name;

