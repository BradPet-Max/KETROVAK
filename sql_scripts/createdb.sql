
/* =========================================================
   KETROVAK COMPANY DATABASE
   Database: KetrovakDB
   SQL Server
   ========================================================= */

-- 1. Create Database
IF DB_ID('KetrovakDB') IS NULL
BEGIN
    CREATE DATABASE KetrovakDB;
END;
GO

USE KetrovakDB;
GO


/* =========================================================
   2. DROP TABLES IF THEY ALREADY EXIST
   Drop child tables first because of foreign keys
   ========================================================= */

IF OBJECT_ID('dbo.EmployeeContacts', 'U') IS NOT NULL
    DROP TABLE dbo.EmployeeContacts;

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
    DROP TABLE dbo.Employees;

IF OBJECT_ID('dbo.JobTitles', 'U') IS NOT NULL
    DROP TABLE dbo.JobTitles;

IF OBJECT_ID('dbo.Departments', 'U') IS NOT NULL
    DROP TABLE dbo.Departments;
GO


/* =========================================================
   3. DEPARTMENTS TABLE
   ========================================================= */

CREATE TABLE dbo.Departments
(
    DepartmentID INT IDENTITY(1,1) NOT NULL,
    DepartmentCode VARCHAR(10) NOT NULL,
    DepartmentName VARCHAR(50) NOT NULL,
    DepartmentDescription VARCHAR(255) NULL,

    CONSTRAINT PK_Departments
        PRIMARY KEY (DepartmentID),

    CONSTRAINT UQ_Departments_Code
        UNIQUE (DepartmentCode),

    CONSTRAINT UQ_Departments_Name
        UNIQUE (DepartmentName)
);
GO


/* =========================================================
   4. JOB TITLES TABLE
   ========================================================= */

CREATE TABLE dbo.JobTitles
(
    JobTitleID INT IDENTITY(1,1) NOT NULL,
    JobTitleName VARCHAR(100) NOT NULL,

    CONSTRAINT PK_JobTitles
        PRIMARY KEY (JobTitleID),

    CONSTRAINT UQ_JobTitles_Name
        UNIQUE (JobTitleName)
);
GO


/* =========================================================
   5. EMPLOYEES TABLE
   ========================================================= */

CREATE TABLE dbo.Employees
(
    EmployeeID INT IDENTITY(1001,1) NOT NULL,
    EmployeeNumber VARCHAR(20) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NULL,
    Gender VARCHAR(20) NULL,
    DepartmentID INT NOT NULL,
    JobTitleID INT NOT NULL,
    HireDate DATE NOT NULL,
    EmploymentStatus VARCHAR(20) NOT NULL
        CONSTRAINT DF_Employees_Status DEFAULT ('Active'),

    Salary DECIMAL(12,2) NULL,

    CONSTRAINT PK_Employees
        PRIMARY KEY (EmployeeID),

    CONSTRAINT UQ_Employees_EmployeeNumber
        UNIQUE (EmployeeNumber),

    CONSTRAINT CK_Employees_Gender
        CHECK (Gender IN ('Male', 'Female', 'Other')),

    CONSTRAINT CK_Employees_Status
        CHECK (EmploymentStatus IN
              ('Active', 'Inactive', 'Terminated', 'On Leave')),

    CONSTRAINT CK_Employees_Salary
        CHECK (Salary IS NULL OR Salary >= 0),

    CONSTRAINT CK_Employees_Dates
        CHECK (DateOfBirth IS NULL OR DateOfBirth < HireDate),

    CONSTRAINT FK_Employees_Department
        FOREIGN KEY (DepartmentID)
        REFERENCES dbo.Departments(DepartmentID),

    CONSTRAINT FK_Employees_JobTitle
        FOREIGN KEY (JobTitleID)
        REFERENCES dbo.JobTitles(JobTitleID)
);
GO


/* =========================================================
   6. EMPLOYEE CONTACTS TABLE
   One contact record per employee
   ========================================================= */

CREATE TABLE dbo.EmployeeContacts
(
    ContactID INT IDENTITY(1,1) NOT NULL,
    EmployeeID INT NOT NULL,
    EmailAddress VARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(30) NOT NULL,
    EmergencyContactName VARCHAR(100) NULL,
    EmergencyContactPhone VARCHAR(30) NULL,

    CONSTRAINT PK_EmployeeContacts
        PRIMARY KEY (ContactID),

    CONSTRAINT UQ_EmployeeContacts_Employee
        UNIQUE (EmployeeID),

    CONSTRAINT UQ_EmployeeContacts_Email
        UNIQUE (EmailAddress),

    CONSTRAINT UQ_EmployeeContacts_Phone
        UNIQUE (PhoneNumber),

    CONSTRAINT FK_EmployeeContacts_Employee
        FOREIGN KEY (EmployeeID)
        REFERENCES dbo.Employees(EmployeeID)
);
GO


/* =========================================================
   7. INSERT DEPARTMENTS
   ========================================================= */

INSERT INTO dbo.Departments
    (DepartmentCode, DepartmentName, DepartmentDescription)
VALUES
    ('SAL', 'Sales',      'Responsible for revenue generation and customer acquisition'),
    ('MKT', 'Marketing',  'Responsible for branding, campaigns and market research'),
    ('ACC', 'Accounting', 'Responsible for financial reporting and accounting operations'),
    ('IT',  'IT',         'Responsible for technology, systems and technical support'),
    ('HR',  'HR',         'Responsible for employee management and human resources');
GO


/* =========================================================
   8. INSERT JOB TITLES
   ========================================================= */

INSERT INTO dbo.JobTitles (JobTitleName)
VALUES
    ('Sales Manager'),
    ('Sales Representative'),
    ('Account Executive'),
    ('Marketing Manager'),
    ('Marketing Specialist'),
    ('Digital Marketing Specialist'),
    ('Accountant'),
    ('Senior Accountant'),
    ('Financial Analyst'),
    ('IT Manager'),
    ('Systems Administrator'),
    ('IT Support Specialist'),
    ('Database Administrator'),
    ('HR Manager'),
    ('HR Officer'),
    ('Recruitment Specialist');
GO


/* =========================================================
   9. INSERT 20 EMPLOYEES
   ========================================================= */

INSERT INTO dbo.Employees
(
    EmployeeNumber,
    FirstName,
    LastName,
    DateOfBirth,
    Gender,
    DepartmentID,
    JobTitleID,
    HireDate,
    EmploymentStatus,
    Salary
)
VALUES

-- SALES
(
    'KET-0001',
    'Daniel',
    'Moyo',
    '1990-04-15',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'SAL'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Sales Manager'),
    '2021-03-15',
    'Active',
    480000.00
),

(
    'KET-0002',
    'Sarah',
    'Ndlovu',
    '1994-08-22',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'SAL'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Sales Representative'),
    '2022-06-01',
    'Active',
    320000.00
),

(
    'KET-0003',
    'Michael',
    'Dube',
    '1989-11-10',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'SAL'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Account Executive'),
    '2023-01-10',
    'Active',
    350000.00
),

(
    'KET-0004',
    'Linda',
    'Maseko',
    '1995-02-18',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'SAL'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Sales Representative'),
    '2023-08-14',
    'Active',
    310000.00
),


-- MARKETING
(
    'KET-0005',
    'James',
    'Chirwa',
    '1991-07-25',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'MKT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Marketing Manager'),
    '2020-05-18',
    'Active',
    520000.00
),

(
    'KET-0006',
    'Emily',
    'Phiri',
    '1996-03-12',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'MKT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Marketing Specialist'),
    '2022-02-07',
    'Active',
    330000.00
),

(
    'KET-0007',
    'Brian',
    'Mthembu',
    '1993-09-30',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'MKT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Digital Marketing Specialist'),
    '2023-04-03',
    'Active',
    340000.00
),

(
    'KET-0008',
    'Grace',
    'Zwane',
    '1997-12-05',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'MKT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Marketing Specialist'),
    '2024-01-15',
    'Active',
    315000.00
),


-- ACCOUNTING
(
    'KET-0009',
    'Robert',
    'Sibanda',
    '1987-06-17',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'ACC'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Senior Accountant'),
    '2019-09-02',
    'Active',
    560000.00
),

(
    'KET-0010',
    'Patricia',
    'Moyo',
    '1992-10-11',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'ACC'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Accountant'),
    '2021-11-08',
    'Active',
    380000.00
),

(
    'KET-0011',
    'Thomas',
    'Khumalo',
    '1990-01-29',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'ACC'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Financial Analyst'),
    '2022-09-19',
    'Active',
    420000.00
),

(
    'KET-0012',
    'Angela',
    'Tembo',
    '1995-05-20',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'ACC'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Accountant'),
    '2024-03-11',
    'Active',
    350000.00
),


-- IT
(
    'KET-0013',
    'David',
    'Mlambo',
    '1986-02-14',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'IT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'IT Manager'),
    '2018-07-09',
    'Active',
    650000.00
),

(
    'KET-0014',
    'Rachel',
    'Mutasa',
    '1991-11-23',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'IT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Systems Administrator'),
    '2021-04-12',
    'Active',
    470000.00
),

(
    'KET-0015',
    'Kevin',
    'Banda',
    '1994-06-08',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'IT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'IT Support Specialist'),
    '2022-10-03',
    'Active',
    360000.00
),

(
    'KET-0016',
    'Nicole',
    'Sithole',
    '1996-08-27',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'IT'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Database Administrator'),
    '2023-06-19',
    'Active',
    490000.00
),


-- HR
(
    'KET-0017',
    'Peter',
    'Nkomo',
    '1988-03-03',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'HR'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'HR Manager'),
    '2020-02-17',
    'Active',
    540000.00
),

(
    'KET-0018',
    'Melissa',
    'Moyo',
    '1993-12-14',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'HR'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'HR Officer'),
    '2022-05-23',
    'Active',
    370000.00
),

(
    'KET-0019',
    'Andrew',
    'Zimunya',
    '1995-09-09',
    'Male',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'HR'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'Recruitment Specialist'),
    '2023-02-06',
    'Active',
    350000.00
),

(
    'KET-0020',
    'Cynthia',
    'Mabena',
    '1997-01-26',
    'Female',
    (SELECT DepartmentID FROM dbo.Departments WHERE DepartmentCode = 'HR'),
    (SELECT JobTitleID FROM dbo.JobTitles WHERE JobTitleName = 'HR Officer'),
    '2024-06-03',
    'Active',
    345000.00
);
GO


/* =========================================================
   10. INSERT EMPLOYEE CONTACT INFORMATION
   ========================================================= */

INSERT INTO dbo.EmployeeContacts
(
    EmployeeID,
    EmailAddress,
    PhoneNumber,
    EmergencyContactName,
    EmergencyContactPhone
)
SELECT
    EmployeeID,
    CASE EmployeeNumber
        WHEN 'KET-0001' THEN 'daniel.moyo@ketrovak.com'
        WHEN 'KET-0002' THEN 'sarah.ndlovu@ketrovak.com'
        WHEN 'KET-0003' THEN 'michael.dube@ketrovak.com'
        WHEN 'KET-0004' THEN 'linda.maseko@ketrovak.com'
        WHEN 'KET-0005' THEN 'james.chirwa@ketrovak.com'
        WHEN 'KET-0006' THEN 'emily.phiri@ketrovak.com'
        WHEN 'KET-0007' THEN 'brian.mthembu@ketrovak.com'
        WHEN 'KET-0008' THEN 'grace.zwane@ketrovak.com'
        WHEN 'KET-0009' THEN 'robert.sibanda@ketrovak.com'
        WHEN 'KET-0010' THEN 'patricia.moyo@ketrovak.com'
        WHEN 'KET-0011' THEN 'thomas.khumalo@ketrovak.com'
        WHEN 'KET-0012' THEN 'angela.tembo@ketrovak.com'
        WHEN 'KET-0013' THEN 'david.mlambo@ketrovak.com'
        WHEN 'KET-0014' THEN 'rachel.mutasa@ketrovak.com'
        WHEN 'KET-0015' THEN 'kevin.banda@ketrovak.com'
        WHEN 'KET-0016' THEN 'nicole.sithole@ketrovak.com'
        WHEN 'KET-0017' THEN 'peter.nkomo@ketrovak.com'
        WHEN 'KET-0018' THEN 'melissa.moyo@ketrovak.com'
        WHEN 'KET-0019' THEN 'andrew.zimunya@ketrovak.com'
        WHEN 'KET-0020' THEN 'cynthia.mabena@ketrovak.com'
    END,

    CASE EmployeeNumber
        WHEN 'KET-0001' THEN '+27820000001'
        WHEN 'KET-0002' THEN '+27820000002'
        WHEN 'KET-0003' THEN '+27820000003'
        WHEN 'KET-0004' THEN '+27820000004'
        WHEN 'KET-0005' THEN '+27820000005'
        WHEN 'KET-0006' THEN '+27820000006'
        WHEN 'KET-0007' THEN '+27820000007'
        WHEN 'KET-0008' THEN '+27820000008'
        WHEN 'KET-0009' THEN '+27820000009'
        WHEN 'KET-0010' THEN '+27820000010'
        WHEN 'KET-0011' THEN '+27820000011'
        WHEN 'KET-0012' THEN '+27820000012'
        WHEN 'KET-0013' THEN '+27820000013'
        WHEN 'KET-0014' THEN '+27820000014'
        WHEN 'KET-0015' THEN '+27820000015'
        WHEN 'KET-0016' THEN '+27820000016'
        WHEN 'KET-0017' THEN '+27820000017'
        WHEN 'KET-0018' THEN '+27820000018'
        WHEN 'KET-0019' THEN '+27820000019'
        WHEN 'KET-0020' THEN '+27820000020'
    END,

    'Emergency Contact',
    '+27830000000'
FROM dbo.Employees;
GO


/* =========================================================
   11. CREATE USEFUL INDEXES
   ========================================================= */

CREATE INDEX IX_Employees_DepartmentID
ON dbo.Employees(DepartmentID);

CREATE INDEX IX_Employees_JobTitleID
ON dbo.Employees(JobTitleID);

CREATE INDEX IX_Employees_LastName
ON dbo.Employees(LastName);

CREATE INDEX IX_Employees_HireDate
ON dbo.Employees(HireDate);
GO


/* =========================================================
   12. VERIFY EMPLOYEE COUNT
   ========================================================= */

SELECT COUNT(*) AS TotalEmployees
FROM dbo.Employees;
GO


/* =========================================================
   13. VERIFY DEPARTMENT COUNTS
   ========================================================= */

SELECT
    d.DepartmentCode,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM dbo.Departments d
LEFT JOIN dbo.Employees e
    ON d.DepartmentID = e.DepartmentID
GROUP BY
    d.DepartmentCode,
    d.DepartmentName
ORDER BY
    d.DepartmentCode;
GO


/* =========================================================
   14. COMPLETE EMPLOYEE REPORT
   ========================================================= */

SELECT
    e.EmployeeNumber,
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    j.JobTitleName,
    e.HireDate,
    e.EmploymentStatus,
    e.Salary,
    ec.EmailAddress,
    ec.PhoneNumber
FROM dbo.Employees e
INNER JOIN dbo.Departments d
    ON e.DepartmentID = d.DepartmentID
INNER JOIN dbo.JobTitles j
    ON e.JobTitleID = j.JobTitleID
INNER JOIN dbo.EmployeeContacts ec
    ON e.EmployeeID = ec.EmployeeID
ORDER BY
    d.DepartmentName,
    e.LastName;
GO