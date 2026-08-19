import pyodbc
import pandas as pd

# SQL Server connection details
server = "PETERM"
database = "KetrovakDB"

# Windows Authentication
connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={server};"
    f"DATABASE={database};"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

try:
    # Connect to SQL Server
    conn = pyodbc.connect(connection_string)

    print("Successfully connected to SQL Server!")
    print(f"Server: {server}")
    print(f"Database: {database}")

    # Test query
    query = """
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
;
    """

    result = pd.read_sql(query, conn)

    print("\nConnection Test:")
    print(result)

    conn.close()

except pyodbc.Error as e:
    print("Database connection failed.")
    print("Error:", e)