-- My First SQL Practice File
-- Topic: Basic SQL Queries

-- 1. Display all records
SELECT *
FROM patients;

-- 2. Select specific columns
SELECT patient_id, age, gender
FROM patients;

-- 3. Filter records
SELECT *
FROM patients
WHERE age > 40;

-- 4. Sort records
SELECT *
FROM patients
ORDER BY age DESC;

-- 5. Count the total records
SELECT COUNT(*) AS total_patients
FROM patients;