/*
PROJECT: Healthcare Data Analytics
FILE: 02_data_cleaning.sql
PURPOSE: Remove exact duplicates and validate billing data.
*/

USE HealthcareAnalyticsProject;
GO

-- 1. Remove the previous cleaned table if it exists
-- The original raw table remains untouched.

DROP TABLE IF EXISTS dbo.clean_healthcare_data;
GO

-- 2. Create cleaned dataset
-- DISTINCT removes exact duplicate records.

SELECT DISTINCT
    *,

    CASE
        WHEN Billing_Amount < 0 THEN NULL
        ELSE Billing_Amount
    END AS Billing_Amount_Cleaned,

    CASE
        WHEN Billing_Amount < 0 THEN 'Invalid Billing'
        ELSE 'Valid Billing'
    END AS Billing_Status

INTO dbo.clean_healthcare_data

FROM dbo.raw_healthcare_dataset;
GO

-- 3. Validate cleaned records

SELECT
    COUNT(*) AS Cleaned_Records,

    SUM(CASE
        WHEN Billing_Status = 'Invalid Billing'
        THEN 1 ELSE 0
    END) AS Invalid_Billing_Records,

    SUM(CASE
        WHEN Billing_Amount_Cleaned IS NULL
        THEN 1 ELSE 0
    END) AS Null_Cleaned_Billing

FROM dbo.clean_healthcare_data;
GO