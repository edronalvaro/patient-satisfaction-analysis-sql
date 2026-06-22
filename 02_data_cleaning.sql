/*
===========================================================
Patient Survey Data Cleaning & Validation
===========================================================
Purpose:
- Standardize column names (snake_case format)
- Validate data quality (nulls, duplicates, integrity)
- Ensure dataset is analysis-ready
===========================================================
*/


/* =========================================================
1. COLUMN STANDARDIZATION
========================================================= */

-- Standardize column names for consistency and easier querying

ALTER TABLE measures
RENAME COLUMN `Measure ID` TO measure_id;

ALTER TABLE national_results
RENAME COLUMN `Release Period` TO release_period;

ALTER TABLE national_results
RENAME COLUMN `Measure ID` TO measure_id;

ALTER TABLE national_results
RENAME COLUMN `Bottom-box Percentage` TO bottom_box_percentage;

ALTER TABLE national_results
RENAME COLUMN `Middle-box Percentage` TO middle_box_percentage;

ALTER TABLE national_results
RENAME COLUMN `Top-box Percentage` TO top_box_percentage;

ALTER TABLE reports
RENAME COLUMN `Start Date` TO start_date;

ALTER TABLE reports
RENAME COLUMN `End Date` TO end_date;

ALTER TABLE responses
RENAME COLUMN `Release Period` TO release_period;

ALTER TABLE responses
RENAME COLUMN `Facility ID` TO facility_id;

ALTER TABLE responses
RENAME COLUMN `Completed Surveys` TO completed_surveys;

ALTER TABLE responses
RENAME COLUMN `Response Rate (%)` TO response_rate;

ALTER TABLE questions
RENAME COLUMN `Question Num` TO question_num;

ALTER TABLE questions
RENAME COLUMN `Measure ID` TO measure_id;

ALTER TABLE questions
RENAME COLUMN `Bottom-box Answer` TO bottom_box_answer;

ALTER TABLE questions
RENAME COLUMN `Middle-box Answer` TO middle_box_answer;

ALTER TABLE questions
RENAME COLUMN `Top-box Answer` TO top_box_answer;

ALTER TABLE states
RENAME COLUMN `State Name` TO state_name;


/* =========================================================
2. NULL VALUE CHECKS
========================================================= */

-- Check for missing critical values in state_results
SELECT *
FROM state_results
WHERE state IS NULL
   OR measure_id IS NULL
   OR release_period IS NULL
   OR top_box_percentage IS NULL
   OR middle_box_percentage IS NULL
   OR bottom_box_percentage IS NULL;

-- Check for missing values in national_results
SELECT *
FROM national_results
WHERE measure_id IS NULL
   OR release_period IS NULL
   OR top_box_percentage IS NULL;

-- Check for missing values in responses
SELECT *
FROM responses
WHERE state IS NULL
   OR facility_id IS NULL
   OR response_rate IS NULL;


/* =========================================================
3. DUPLICATE DETECTION
========================================================= */

-- State-level duplicates check
SELECT 
    state,
    measure_id,
    release_period,
    COUNT(*) AS duplicate_count
FROM state_results
GROUP BY state, measure_id, release_period
HAVING COUNT(*) > 1;

-- National-level duplicates check
SELECT 
    measure_id,
    release_period,
    COUNT(*) AS duplicate_count
FROM national_results
GROUP BY measure_id, release_period
HAVING COUNT(*) > 1;

-- States table duplicate check
SELECT 
    state,
    COUNT(*) AS duplicate_count
FROM states
GROUP BY state
HAVING COUNT(*) > 1;


/* =========================================================
4. DATA VALIDATION (PERCENTAGE RANGE CHECKS)
========================================================= */

-- Ensure percentages are within valid 0–100 range
SELECT *
FROM state_results
WHERE top_box_percentage NOT BETWEEN 0 AND 100
   OR middle_box_percentage NOT BETWEEN 0 AND 100
   OR bottom_box_percentage NOT BETWEEN 0 AND 100;

SELECT *
FROM national_results
WHERE top_box_percentage NOT BETWEEN 0 AND 100;

SELECT *
FROM responses
WHERE response_rate NOT BETWEEN 0 AND 100;


/* =========================================================
5. REFERENTIAL INTEGRITY CHECKS
========================================================= */

-- Check for state codes that do not exist in states table
SELECT sr.*
FROM state_results sr
LEFT JOIN states s ON sr.state = s.state
WHERE s.state IS NULL;

-- Check for invalid measure IDs
SELECT sr.*
FROM state_results sr
LEFT JOIN measures m ON sr.measure_id = m.measure_id
WHERE m.measure_id IS NULL;
