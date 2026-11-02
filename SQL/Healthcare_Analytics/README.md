# Healthcare Data Analytics Using SQL Server

## 1. Project Overview

This project focuses on analysing hospital admission data using Microsoft SQL Server. The objective is to understand hospital performance, patient demographics, medical conditions, insurance provider performance and revenue trends through SQL-based analysis.

The project follows a practical data analytics workflow, starting with raw data profiling and cleaning, followed by KPI development, business analysis and advanced SQL techniques.

## 2. Project Objectives

* Analyse hospital admission patterns and patient demographics.
* Identify and handle duplicate records and invalid billing values.
* Evaluate hospital performance using key performance indicators (KPIs).
* Analyse revenue distribution across medical conditions.
* Compare insurance provider performance.
* Understand emergency, urgent and elective admission patterns.
* Track monthly admission trends and revenue growth.
* Apply advanced SQL techniques to extract business insights.

## 3. Tools and Technologies

| Tool                                | Purpose                                    |
| ----------------------------------- | ------------------------------------------ |
| Microsoft SQL Server                | Database management                        |
| SQL Server Management Studio (SSMS) | Writing and executing SQL queries          |
| SQL                                 | Data cleaning, transformation and analysis |
| GitHub                              | Version control and project documentation  |

## 4. Dataset Description

The dataset contains 55,500 hospital admission records and 15 original columns.

| Column             | Description                   |
| ------------------ | ----------------------------- |
| Name               | Patient name                  |
| Age                | Patient age                   |
| Gender             | Patient gender                |
| Blood_Type         | Patient blood group           |
| Medical_Condition  | Medical diagnosis             |
| Date_of_Admission  | Hospital admission date       |
| Doctor             | Treating doctor               |
| Hospital           | Hospital name                 |
| Insurance_Provider | Insurance company             |
| Billing_Amount     | Patient billing amount        |
| Room_Number        | Room allocation               |
| Admission_Type     | Emergency, Urgent or Elective |
| Discharge_Date     | Hospital discharge date       |
| Medication         | Prescribed medication         |
| Test_Results       | Medical test results          |

**Dataset source:** The `healthcare_dataset.csv` file from the Aguss-JPG Healthcare-Analysis public GitHub repository.

## 5. Project Workflow

### Phase 1: Data Profiling

* Checked total records.
* Identified missing and blank values.
* Detected exact duplicate records.
* Checked invalid admission and discharge dates.
* Identified invalid age values.
* Investigated negative billing amounts.

### Phase 2: Data Cleaning

* Removed exact duplicate records using `SELECT DISTINCT`.
* Preserved the original raw dataset.
* Created a separate cleaned dataset.
* Flagged negative billing records.
* Created a cleaned billing column using conditional logic.

Negative billing values were retained in the original dataset but converted to NULL in the cleaned billing field so they would not contribute to standard revenue calculations.

### Phase 3: Healthcare KPI Analysis

Calculated the following indicators:

* Total hospital admissions.
* Number of distinct hospitals and doctors.
* Average patient age.
* Total valid billing revenue.
* Average billing per admission.
* Average length of hospital stay.

### Phase 4: Business Analysis

Performed analysis across:

* Hospital-wise admissions and revenue.
* Medical-condition-wise performance.
* Insurance provider performance.
* Admission type distribution.
* Monthly admission and revenue trends.
* Top 10 months by patient admissions.

### Phase 5: Advanced SQL Analysis

Applied intermediate and advanced SQL concepts:

* Common Table Expressions (CTEs).
* `RANK()` and `DENSE_RANK()`.
* `LAG()`.
* Month-over-Month (MoM) growth calculations.
* Running totals using window functions.
* Revenue contribution percentages.

## 6. Key Project Findings

### Data Quality

| Metric                                       | Finding |
| -------------------------------------------- | ------: |
| Original records                             |  55,500 |
| Missing values                               |       0 |
| Exact duplicate groups                       |     534 |
| Extra duplicate records                      |     534 |
| Invalid discharge dates                      |       0 |
| Invalid age records                          |       0 |
| Negative billing records initially           |     108 |
| Cleaned records                              |  54,966 |
| Negative billing records after deduplication |     106 |

### Overall Healthcare KPIs

| KPI                    |           Result |
| ---------------------- | ---------------: |
| Total admissions       |           54,966 |
| Distinct hospitals     |           39,876 |
| Distinct doctors       |           40,341 |
| Average patient age    |      51.54 years |
| Total valid revenue    | 1,404,121,601.24 |
| Average billing        |        25,594.63 |
| Average length of stay |       15.50 days |

*Revenue and billing figures are reported in the dataset's unspecified currency units.*

### Medical Condition Analysis

* Diabetes generated the highest total revenue.
* Arthritis recorded the highest number of admissions.
* Obesity had the highest average billing per admission.
* Revenue contribution was relatively balanced across the six medical conditions.

### Insurance Provider Analysis

* Cigna recorded the highest admission volume and total revenue.
* Medicare recorded the highest average billing per admission.
* The five insurance providers had relatively similar admission volumes.

### Admission Type Analysis

* Elective admissions recorded the highest patient volume and revenue.
* Emergency admissions had the longest average hospital stay.
* Admission volumes were relatively balanced across the three admission categories.

### Monthly Trends

* August 2020 recorded the highest monthly admission volume, with 1,003 admissions.
* Month-over-Month growth analysis identified periods of increasing and declining patient admissions.
* Cumulative revenue analysis tracked revenue from May 2019 to May 2024.

## 7. SQL Skills Demonstrated

| SQL Concept                | Application                   |
| -------------------------- | ----------------------------- |
| SELECT, WHERE              | Data extraction and filtering |
| GROUP BY                   | Aggregated business analysis  |
| HAVING                     | Duplicate detection           |
| CASE WHEN                  | Conditional data cleaning     |
| DISTINCT                   | Duplicate removal             |
| COUNT, SUM, AVG            | KPI calculations              |
| CTEs                       | Structured analytical queries |
| RANK, DENSE_RANK           | Revenue ranking               |
| LAG                        | Previous-month comparison     |
| SUM() OVER()               | Cumulative calculations       |
| DATEFROMPARTS, YEAR, MONTH | Date-based analysis           |
| DATEDIFF                   | Length-of-stay calculation    |

## 8. Repository Structure

```text
Healthcare_Analytics/
│
├── 01_data_profiling.sql
├── 02_data_cleaning.sql
├── 03_healthcare_kpis.sql
├── 04_business_analysis.sql
├── 05_advanced_sql.sql
└── README.md
```

## 9. Business Applications

The analysis demonstrates how SQL can support healthcare management decisions through:

* Hospital performance monitoring.
* Revenue and billing analysis.
* Patient admission trend monitoring.
* Insurance provider comparisons.
* Resource and bed-capacity planning.
* Identification of data-quality issues.

## 10. Limitations

* Hospital and doctor names are not verified identifiers; distinct counts should not be interpreted as confirmed facility or workforce counts.
* Negative billing records may represent data errors, refunds or adjustments. Their actual meaning cannot be established from the available fields.
* The dataset does not specify the billing currency.
* The findings are descriptive and should not be interpreted as clinical or causal conclusions.
* The analysis is based on the available dataset and its data-quality limitations.

## 11. Future Improvements

* Perform exploratory data analysis using Python.
* Develop an interactive Power BI healthcare dashboard.
* Analyse hospital performance using additional operational indicators.
* Build predictive models for patient admission trends.
* Develop advanced healthcare revenue and resource utilisation analysis.

---

**Project Domain:** Healthcare Analytics
**Database:** Microsoft SQL Server
**Primary Language:** SQL
**Project Type:** Data Analytics Portfolio Project
