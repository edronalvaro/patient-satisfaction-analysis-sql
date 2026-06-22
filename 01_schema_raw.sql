/*
===========================================================
Patient Satisfaction Analysis - Raw Schema Documentation
Database: patient_survey
Tools: MySQL
===========================================================

Note:
The raw CSV files were imported into MySQL using the
MySQL Import Wizard.
\
===========================================================
*/

CREATE DATABASE patient_survey;
USE patient_survey;


/* =========================================================
Table: measures
Purpose:
Stores survey measure definitions
Grain:
One row per measure

Raw Columns:
- Measure ID
- Measure
- Type
========================================================= */


/* =========================================================
Table: national_results
Purpose:
National survey results by measure and reporting period
Grain:
One row per measure per release period

Raw Columns:
- Release Period
- Measure ID
- Bottom-box Percentage
- Middle-box Percentage
- Top-box Percentage
========================================================= */


/* =========================================================
Table: questions
Purpose:
Question text and response categories
Grain:
One row per question

Raw Columns:
- Question Num
- Measure ID
- Question
- Bottom-box Answer
- Middle-box Answer
- Top-box Answer
========================================================= */


/* =========================================================
Table: reports
Purpose:
Survey reporting periods
Grain:
One row per release period

Raw Columns:
- Release Period
- Start Date
- End Date
========================================================= */


/* =========================================================
Table: responses
Purpose:
Survey response volume and response rates
Grain:
One row per facility per state per release period

Raw Columns:
- Release Period
- State
- Facility ID
- Completed Surveys
- Response Rate (%)
========================================================= */


/* =========================================================
Table: state_results
Purpose:
State-level patient satisfaction results
Grain:
One row per state per measure per release period

Raw Columns:
- Release Period
- State
- Measure ID
- Bottom-box Percentage
- Middle-box Percentage
- Top-box Percentage
========================================================= */


/* =========================================================
Table: states
Purpose:
State metadata and regional classifications
Grain:
One row per state

Raw Columns:
- State
- State Name
- Region
========================================================= */
