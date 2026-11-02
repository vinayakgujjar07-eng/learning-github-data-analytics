/*
PROJECT: Healthcare Data Analytics
FILE: 04_business_analysis.sql
PURPOSE: Analyse insurance, admission types and monthly trends.
*/

USE HealthcareAnalyticsProject;
GO

-- 1. Insurance Provider Analysis

SELECT
    Insurance_Provider,
    COUNT(*) AS Total_Admissions,
    SUM([Billing amount cleaned]) AS Total_Revenue,
    AVG([Billing amount cleaned]) AS Average_Billing,
    COUNT(DISTINCT Hospital) AS Hospitals_Covered

FROM dbo.clean_healthcare_data

GROUP BY Insurance_Provider

ORDER BY Total_Revenue DESC;


-- 2. Admission Type Analysis

SELECT
    Admission_Type,
    COUNT(*) AS Total_Admissions,
    SUM([Billing amount cleaned]) AS Total_Revenue,
    AVG([Billing amount cleaned]) AS Average_Billing,

    AVG(
        CAST(
            DATEDIFF(DAY, Date_of_Admission, Discharge_Date)
            AS FLOAT
        )
    ) AS Average_Length_of_Stay

FROM dbo.clean_healthcare_data

GROUP BY Admission_Type

ORDER BY Total_Admissions DESC;


-- 3. Monthly Admission and Revenue Trends

SELECT
    YEAR(Date_of_Admission) AS Admission_Year,
    MONTH(Date_of_Admission) AS Admission_Month,
    COUNT(*) AS Total_Admissions,
    SUM([Billing amount cleaned]) AS Total_Revenue,
    AVG([Billing amount cleaned]) AS Average_Billing

FROM dbo.clean_healthcare_data

GROUP BY
    YEAR(Date_of_Admission),
    MONTH(Date_of_Admission)

ORDER BY Admission_Year, Admission_Month;


-- 4. Top 10 Months by Patient Admissions

WITH Monthly_Analysis AS
(
    SELECT
        YEAR(Date_of_Admission) AS Admission_Year,
        MONTH(Date_of_Admission) AS Admission_Month,
        COUNT(*) AS Total_Admissions,
        SUM([Billing amount cleaned]) AS Total_Revenue

    FROM dbo.clean_healthcare_data

    GROUP BY
        YEAR(Date_of_Admission),
        MONTH(Date_of_Admission)
)

SELECT TOP 10 *

FROM Monthly_Analysis

ORDER BY Total_Admissions DESC;

