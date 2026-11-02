/*
PROJECT: Healthcare Data Analytics
FILE: 01_data_profiling.sql
PURPOSE: Assess the quality of raw hospital admission data.
*/

USE HealthcareAnalyticsProject;
GO

-- 1. Total records
SELECT COUNT(*) AS Total_Records
FROM dbo.raw_healthcare_dataset;


-- 2. Missing values
SELECT
    SUM(CASE WHEN Name IS NULL OR LTRIM(RTRIM(Name)) = '' THEN 1 ELSE 0 END) AS Missing_Name,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Missing_Age,
    SUM(CASE WHEN Gender IS NULL OR LTRIM(RTRIM(Gender)) = '' THEN 1 ELSE 0 END) AS Missing_Gender,
    SUM(CASE WHEN Medical_Condition IS NULL OR LTRIM(RTRIM(Medical_Condition)) = '' THEN 1 ELSE 0 END) AS Missing_Condition,
    SUM(CASE WHEN Hospital IS NULL OR LTRIM(RTRIM(Hospital)) = '' THEN 1 ELSE 0 END) AS Missing_Hospital,
    SUM(CASE WHEN Billing_Amount IS NULL THEN 1 ELSE 0 END) AS Missing_Billing
FROM dbo.raw_healthcare_dataset;


-- 3. Exact duplicate groups
SELECT COUNT(*) AS Duplicate_Groups
FROM
(
    SELECT *
    FROM dbo.raw_healthcare_dataset
    GROUP BY
        Name, Age, Gender, Blood_Type,
        Medical_Condition, Date_of_Admission,
        Doctor, Hospital, Insurance_Provider,
        Billing_Amount, Room_Number, Admission_Type,
        Discharge_Date, Medication, Test_Results
    HAVING COUNT(*) > 1
) AS Duplicates;


-- 4. Invalid dates, ages and billing
SELECT
    SUM(CASE WHEN Discharge_Date < Date_of_Admission THEN 1 ELSE 0 END) AS Invalid_Discharge_Dates,
    SUM(CASE WHEN Age < 0 OR Age > 120 THEN 1 ELSE 0 END) AS Invalid_Age,
    SUM(CASE WHEN Billing_Amount < 0 THEN 1 ELSE 0 END) AS Negative_Billing
FROM dbo.raw_healthcare_dataset;