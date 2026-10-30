```sql
-- PROJECT: Hospital Patient Analysis
-- DATABASE: Microsoft SQL Server

-- STEP 1: Create the database if it does not exist

IF DB_ID('HospitalAnalytics') IS NULL
BEGIN
    CREATE DATABASE HospitalAnalytics;
END;
GO

-- STEP 2: Select the database

USE HospitalAnalytics;
GO

-- STEP 3: Create the patients table

IF OBJECT_ID('dbo.patients', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.patients (
        patient_id INT PRIMARY KEY,
        patient_name VARCHAR(50),
        age INT,
        gender VARCHAR(10),
        department VARCHAR(50),
        bill_amount DECIMAL(10,2),
        satisfaction_score INT
    );
END;
GO

-- STEP 4: Insert sample data only if the table is empty

IF NOT EXISTS (SELECT 1 FROM dbo.patients)
BEGIN
    INSERT INTO dbo.patients
        (patient_id, patient_name, age, gender, department,
         bill_amount, satisfaction_score)
    VALUES
        (1, 'Patient A', 25, 'Male', 'Cardiology', 15000, 4),
        (2, 'Patient B', 42, 'Female', 'Neurology', 22000, 5),
        (3, 'Patient C', 35, 'Male', 'Orthopaedics', 12000, 3),
        (4, 'Patient D', 58, 'Female', 'Cardiology', 28000, 4),
        (5, 'Patient E', 47, 'Male', 'Neurology', 18000, 4),
        (6, 'Patient F', 31, 'Female', 'Cardiology', 14000, 5),
        (7, 'Patient G', 65, 'Male', 'Orthopaedics', 30000, 3),
        (8, 'Patient H', 29, 'Female', 'Neurology', 16000, 5),
        (9, 'Patient I', 52, 'Male', 'Cardiology', 25000, 4),
        (10, 'Patient J', 40, 'Female', 'Orthopaedics', 20000, 4);
END;
GO

-- STEP 5: Display all patients

SELECT *
FROM dbo.patients;
GO

-- STEP 6: Calculate total hospital revenue

SELECT SUM(bill_amount) AS total_revenue
FROM dbo.patients;
GO

-- STEP 7: Calculate average patient age

SELECT AVG(CAST(age AS DECIMAL(10,2))) AS average_patient_age
FROM dbo.patients;
GO

-- STEP 8: Calculate revenue by department

SELECT
    department,
    SUM(bill_amount) AS total_revenue
FROM dbo.patients
GROUP BY department
ORDER BY total_revenue DESC;
GO

-- STEP 9: Calculate average satisfaction by department

SELECT
    department,
    CAST(AVG(CAST(satisfaction_score AS DECIMAL(10,2)))
         AS DECIMAL(4,2)) AS avg_satisfaction
FROM dbo.patients
GROUP BY department
ORDER BY avg_satisfaction DESC;
GO

-- STEP 10: Identify patients with bills above 20000

SELECT
    patient_id,
    department,
    bill_amount
FROM dbo.patients
WHERE bill_amount > 20000
ORDER BY bill_amount DESC;
GO
```
-- ADVANCED HOSPITAL ANALYSIS

-- 1. Patient count by department

SELECT
    department,
    COUNT(*) AS total_patients
FROM dbo.patients
GROUP BY department;


-- 2. Revenue by gender

SELECT
    gender,
    SUM(bill_amount) AS total_revenue
FROM dbo.patients
GROUP BY gender;


-- 3. Identify highest billing patient

SELECT TOP 1
    patient_name,
    department,
    bill_amount
FROM dbo.patients
ORDER BY bill_amount DESC;


-- 4. Department-wise average billing

SELECT
    department,
    AVG(bill_amount) AS average_billing
FROM dbo.patients
GROUP BY department
ORDER BY average_billing DESC;
