# KetrovakDB

**KetrovakDB** is a SQL Server-based employee management database developed for Ketrovak Company. The project demonstrates relational database design, SQL Server, Python database connectivity, and data analysis using Pandas.

---

## 📌 Project Overview

The database manages employee-related information, including:

* Departments
* Job titles
* Employee records
* Employee contact information
* Employment status
* Salaries
* Hiring dates

Python is used to connect to SQL Server through **pyodbc**, while **Pandas** is used to retrieve and work with database data.

### Architecture

```text
SQL Server (KetrovakDB)
          │
          │ ODBC
          ▼
Python + pyodbc
          │
          ▼
Pandas / Data Analysis / Reporting
```

---

## 🛠️ Technology Stack

| Technology           | Purpose                       |
| -------------------- | ----------------------------- |
| Microsoft SQL Server | Database                      |
| T-SQL                | Database creation and queries |
| Python               | Database access               |
| pyodbc               | SQL Server connectivity       |
| Pandas               | Data processing               |
| Visual Studio Code   | Development                   |
| Git                  | Version control               |

---

## 🗄️ Database Structure

The database contains four main tables:

```text
Departments
     │
     ├──────────────┐
     ▼              ▼
Employees       JobTitles
     │
     ▼
EmployeeContacts
```

### Tables

**Departments**

Stores company departments.

**JobTitles**

Stores available job titles.

**Employees**

Stores employee information and references Departments and JobTitles through foreign keys.

**EmployeeContacts**

Stores employee email, phone and emergency contact information.

---

## 📊 Initial Dataset

The database currently contains:

```text
5 Departments
16 Job Titles
20 Employees
20 Employee Contact Records
```

---

# 🚀 Getting Started

## 1. Clone the Repository

```powershell
git clone <repository-url>
cd KetrovakDB
```

---

## 2. Create a Python Virtual Environment

```powershell
python -m venv .venv
```

Activate it:

```powershell
.\.venv\Scripts\Activate.ps1
```

---

## 3. Install Dependencies

```powershell
pip install -r requirements.txt
```

The project requires:

```text
pandas
pyodbc
```

---

## 4. Set Up SQL Server

Make sure the following are installed and running:

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* ODBC Driver 18 for SQL Server

Open the database script:

```text
sql/KetrovakDB.sql
```

Run the script in SSMS.

The script will:

1. Create `KetrovakDB`
2. Create the database tables
3. Add primary and foreign keys
4. Add constraints and indexes
5. Insert sample data
6. Run verification queries

---

# 🐍 Python Database Connection

The Python application uses Windows Authentication.

Example configuration:

```python
server = "YOUR_SQL_SERVER_NAME"
database = "KetrovakDB"

connection_string = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={server};"
    f"DATABASE={database};"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)
```

### Important

The SQL Server name may be different for each developer.

For example:

```python
server = "PETERM"
```

or:

```python
server = r"localhost\SQLEXPRESS"
```

Each developer should configure their own local SQL Server instance.

---

# ▶️ Run the Python Application

After activating the virtual environment:

```powershell
python python\read_database.py
```

A successful connection should display:

```text
Successfully connected to SQL Server!
Server: YOUR_SERVER
Database: KetrovakDB
```

The application will then retrieve employee information from the database using SQL joins and load the results into a Pandas DataFrame.

---

# 📁 Project Structure

Recommended repository structure:

```text
KetrovakDB/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── sql/
│   └── KetrovakDB.sql
│
└── python/
    └── read_database.py
```

---

# 🔐 Security

Do **not** commit the following to Git:

```text
Passwords
API keys
Database credentials
.env files
.venv/
```

The `.gitignore` file should include:

```gitignore
.venv/
__pycache__/
*.pyc
.env
.vscode/
.ipynb_checkpoints/
```

---

# 🌿 Git Workflow

Team members should work using feature branches.

```powershell
git checkout main
git pull origin main

git checkout -b feature/my-feature
```

After making changes:

```powershell
git add .
git commit -m "Add employee analysis"
git push -u origin feature/my-feature
```

Create a Pull Request/Merge Request for review before merging into `main`.

---

# 🧪 Basic Database Verification

After running the SQL script:

```sql
USE KetrovakDB;

SELECT COUNT(*) AS TotalEmployees
FROM dbo.Employees;
```

Expected result:

```text
TotalEmployees
--------------
20
```

Check the tables:

```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
```

Expected:

```text
Departments
JobTitles
Employees
EmployeeContacts
```

---

# 🔧 Troubleshooting

### Python cannot find `pyodbc`

```powershell
pip install pyodbc
```

### Python cannot find Pandas

```powershell
pip install pandas
```

### ODBC Driver error

Verify that **ODBC Driver 18 for SQL Server** is installed.

You can check available drivers with:

```python
import pyodbc
print(pyodbc.drivers())
```

### SQL Server connection error

Check that SQL Server is running:

```powershell
Get-Service MSSQLSERVER
```

Also verify that the `server` value in the Python script matches your SQL Server instance.

---

# 📈 Future Development

Possible future enhancements include:

* Employee performance tracking
* Leave management
* Payroll information
* Attendance tracking
* Employee hierarchy
* Audit logging
* Power BI dashboards
* Automated reporting
* Python analytics and visualizations
* Unit testing

---

# 👥 Team Contribution

Before contributing:

1. Pull the latest `main` branch.
2. Create a feature branch.
3. Make and test your changes.
4. Commit with a clear message.
5. Push your branch.
6. Submit a Pull Request for review.

---

## 📌 Project Status

**Status:** Development

**Database:** `KetrovakDB`

**Platform:** Microsoft SQL Server

**Python Integration:** `pyodbc` + `Pandas`

**Initial Dataset:** 20 employees

**Purpose:** Employee database management, SQL development, Python integration, reporting and future data analytics.

---

