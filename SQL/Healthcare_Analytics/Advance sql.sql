/*
PROJECT: Healthcare Data Analytics
FILE: 05_advanced_sql.sql
PURPOSE: Advanced SQL analysis using CTEs and window functions.
*/

USE HealthcareAnalyticsProject;
GO

-- 1. Rank Medical Conditions by Revenue

WITH Condition_Revenue AS
(
    SELECT
        Medical_Condition,
        COUNT(*) AS Total_Admissions,
        SUM([Billing amount cleaned]) AS Total_Revenue

    FROM dbo.clean_healthcare_data
    GROUP BY Medical_Condition
)

SELECT
    Medical_Condition,
    Total_Admissions,
    Total_Revenue,

    RANK() OVER(
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank,

    DENSE_RANK() OVER(
        ORDER BY Total_Revenue DESC
    ) AS Dense_Revenue_Rank

FROM Condition_Revenue;


-- 2. Month-over-Month Admission Comparison

WITH Monthly_Admissions AS
(
    SELECT
        DATEFROMPARTS(
            YEAR(Date_of_Admission),
            MONTH(Date_of_Admission),
            1
        ) AS Admission_Month,

        COUNT(*) AS Total_Admissions

    FROM dbo.clean_healthcare_data

    GROUP BY
        YEAR(Date_of_Admission),
        MONTH(Date_of_Admission)
)

SELECT
    Admission_Month,
    Total_Admissions,

    LAG(Total_Admissions) OVER(
        ORDER BY Admission_Month
    ) AS Previous_Month_Admissions,

    Total_Admissions -
    LAG(Total_Admissions) OVER(
        ORDER BY Admission_Month
    ) AS Admission_Difference

FROM Monthly_Admissions
ORDER BY Admission_Month;


-- 3. Month-over-Month Growth Percentage

WITH Monthly_Admissions AS
(
    SELECT
        DATEFROMPARTS(
            YEAR(Date_of_Admission),
            MONTH(Date_of_Admission),
            1
        ) AS Admission_Month,

        COUNT(*) AS Total_Admissions

    FROM dbo.clean_healthcare_data

    GROUP BY
        YEAR(Date_of_Admission),
        MONTH(Date_of_Admission)
),

Monthly_Comparison AS
(
    SELECT
        Admission_Month,
        Total_Admissions,

        LAG(Total_Admissions) OVER(
            ORDER BY Admission_Month
        ) AS Previous_Month_Admissions

    FROM Monthly_Admissions
)

SELECT
    Admission_Month,
    Total_Admissions,
    Previous_Month_Admissions,

    CAST(
        (Total_Admissions - Previous_Month_Admissions)
        * 100.0 /
        NULLIF(Previous_Month_Admissions, 0)
        AS DECIMAL(10,2)
    ) AS Growth_Percentage

FROM Monthly_Comparison
ORDER BY Admission_Month;


-- 4. Cumulative Monthly Revenue

WITH Monthly_Revenue AS
(
    SELECT
        DATEFROMPARTS(
            YEAR(Date_of_Admission),
            MONTH(Date_of_Admission),
            1
        ) AS Admission_Month,

        SUM([Billing amount cleaned]) AS Monthly_Revenue

    FROM dbo.clean_healthcare_data

    GROUP BY
        YEAR(Date_of_Admission),
        MONTH(Date_of_Admission)
)

SELECT
    Admission_Month,
    Monthly_Revenue,

    SUM(Monthly_Revenue) OVER(
        ORDER BY Admission_Month
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS Cumulative_Revenue

FROM Monthly_Revenue
ORDER BY Admission_Month;


-- 5. Revenue Contribution by Medical Condition

SELECT
    Medical_Condition,

    SUM([Billing amount cleaned]) AS Total_Revenue,

    CAST(
        SUM([Billing amount cleaned]) * 100.0 /
        SUM(SUM([Billing amount cleaned])) OVER()
        AS DECIMAL(10,2)
    ) AS Revenue_Contribution_Percentage

FROM dbo.clean_healthcare_data

GROUP BY Medical_Condition
ORDER BY Total_Revenue DESC;