/*
PROJECT: Healthcare Data Analytics
FILE: 03_healthcare_kpis.sql
PURPOSE: Calculate key hospital performance indicators.
*/

USE HealthcareAnalyticsProject;
GO

-- 1. Overall Healthcare KPIs

SELECT
    COUNT(*) AS Total_Admissions,

    COUNT(DISTINCT Hospital) AS Total_Hospitals,

    COUNT(DISTINCT Doctor) AS Total_Doctors,

    AVG(CAST(Age AS FLOAT)) AS Average_Patient_Age,

    SUM([Billing_amount_cleaned]) AS Total_Revenue,

    AVG([Billing amount cleaned]) AS Average_Billing,

    AVG(
        CAST(
            DATEDIFF(
                DAY,
                Date_of_Admission,
                Discharge_Date
            ) AS FLOAT
        )
    ) AS Average_Length_of_Stay

FROM dbo.clean_healthcare_data;


-- 2. Top 10 Hospitals by Admissions

SELECT TOP 10
    Hospital,

    COUNT(*) AS Total_Admissions,

    SUM([Billing amount cleaned]) AS Total_Revenue,

    AVG([Billing amount cleaned]) AS Average_Billing

FROM dbo.clean_healthcare_data

GROUP BY Hospital

ORDER BY Total_Admissions DESC;


-- 3. Medical Condition Performance

SELECT
    Medical_Condition,

    COUNT(*) AS Total_Admissions,

    SUM([Billing amount cleaned]) AS Total_Revenue,

    AVG([Billing amount cleaned]) AS Average_Billing,

    AVG(CAST(Age AS FLOAT)) AS Average_Patient_Age

FROM dbo.clean_healthcare_data

GROUP BY Medical_Condition

ORDER BY Total_Admissions DESC;