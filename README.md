# Patient Satisfaction Analysis: Driving Insights from Healthcare Surveys

## Overview
This project analyzes U.S. healthcare patient satisfaction survey data to identify the key drivers of patient experience, uncover regional disparities, benchmark state performance against national averages, and evaluate response rate bias.

Using SQL, I cleaned and validated data across multiple relational tables, performed analytical queries, and generated actionable business insights related to healthcare quality and patient satisfaction.

This project simulates a real-world healthcare analytics workflow, where survey data is used to monitor operational performance and improve patient experience across facilities and regions.

---

## Business Objective
The goal of this project was to analyze patient satisfaction survey results to answer the following business questions:

- Which healthcare experience measures most strongly influence satisfaction?
- Which states consistently outperform or underperform national benchmarks?
- Are there significant regional disparities in patient satisfaction?
- Does survey response rate introduce bias into satisfaction reporting?
- How has patient satisfaction changed over time?

The ultimate objective is to identify actionable opportunities for improving patient care quality and operational performance.

---

## Dataset
The dataset consists of seven relational tables containing national and state-level healthcare survey data.

### Tables Used
- **measures** – Survey measure definitions  
- **national_results** – National-level survey performance by measure  
- **state_results** – State-level survey performance by measure  
- **responses** – Survey response volume and response rate by facility/state  
- **questions** – Individual survey questions and response categories  
- **reports** – Reporting periods and date ranges  
- **states** – State metadata and regional classifications  

---

## Tools Used
- **MySQL**

---

## SQL Skills Demonstrated
This project showcases:

- Data Cleaning & Validation  
- Joins (INNER / LEFT)  
- Common Table Expressions (CTEs)  
- Window Functions (`RANK`, `LAG`)  
- Aggregate Functions (`AVG`, `STDDEV`, `VAR_SAMP`)  
- Derived KPI Creation  
- Time-Series Analysis  
- Performance Benchmarking  
- Business Insight Generation  

---

## Data Cleaning & Validation
Before analysis, I validated the dataset to ensure data integrity and reliability.

Cleaning steps included:

- Renamed columns for SQL-friendly naming conventions using snake_case
- Performed null value checks across key analytical tables
- Validated duplicate records using the correct table grain  
- Verified percentage-based fields remained within valid ranges (0–100)
- Confirmed survey percentage distributions summed to approximately 100%
- Performed referential integrity checks to identify missing states or measures
- Standardized schema for easier joins and analysis


---

## Key Analytical Questions
The project focused on answering the following questions:

1. How can patient satisfaction be quantified beyond raw survey percentages?
2. Which measures have the lowest satisfaction and highest improvement opportunity?
3. Which survey measures show the greatest performance inconsistency?
4. Which regions show the largest inequality in patient experience?
5. Is there evidence of response rate bias?
6. How has satisfaction changed over time?
7. Which states rank highest and lowest in satisfaction?
8. Which states outperform or underperform national averages?
9. Which specific patient experience questions score lowest?

---

## Key Analysis Performed

### 1. Derived Satisfaction Score
Created a custom KPI:

**Satisfaction Score = Top Box % − Bottom Box %**

This metric provides a more balanced measure of patient experience by considering both highly positive and highly negative responses.

---

### 2. High Impact, Low Performance Measures
Identified healthcare experience measures with low satisfaction and high dissatisfaction to prioritize improvement efforts.

**Insight:**  
Facility-related experience measures (such as cleanliness and environment) showed more improvement opportunity than communication-focused measures.

---

### 3. Measure Consistency Analysis
Measured variance across survey measures using sample variance.

**Insight:**  
Certain measures exhibited significantly higher variability across reporting periods, indicating unstable performance.

---

### 4. Regional Performance & Inequality
Compared average satisfaction and variation by region.

**Insight:**  
All regions showed substantial variation in patient experience, suggesting regional averages alone can hide underperforming states.

---

### 5. Response Rate Bias Analysis
Examined the relationship between survey response rate and satisfaction scores.

**Insight:**  
A mild positive response bias was observed—states with higher response rates tended to report slightly higher satisfaction.

---

### 6. Satisfaction Trend Over Time
Used window functions (`LAG`) to analyze changes between reporting periods.

**Insight:**  
Patient satisfaction improved steadily from 2015 to 2020, plateaued around 2021, and declined afterward, suggesting shifts in care delivery or operational efficiency.

---

### 7. State Satisfaction Rankings
Ranked all states by average patient satisfaction.

**Insight:**  
Top-performing Midwestern states significantly outperformed large, urbanized states, suggesting scalability and system strain may impact satisfaction.

---

### 8. Overperformers vs Underperformers
Benchmarked each state against the national average.

**Insight:**  
Top-performing states exceeded national benchmarks by more than 5 points, while underperformers lagged by nearly 9 points.

---

### 9. Question-Level Deep Dive
Analyzed satisfaction at the individual survey question level.

**Insight:**  
Communication-related questions consistently scored highest, highlighting interpersonal care as a major driver of satisfaction.

---

## Business Insights & Recommendations

Based on the analysis:

- Prioritize operational improvements in underperforming high-population states
- Replicate best practices from top-performing states
- Investigate declining post-2021 satisfaction trends
- Improve survey participation to reduce response bias
- Focus improvement initiatives on facility and environment-related measures

These actions could improve overall patient experience and healthcare quality outcomes.

---

## Conclusion
This project demonstrates how SQL can be used to transform raw healthcare survey data into meaningful business insights.

By combining data validation, advanced SQL analysis, and business interpretation, this analysis identified key drivers of patient satisfaction, highlighted regional disparities, and revealed opportunities for operational improvement.

This project strengthened my ability to work with relational datasets, perform analytical problem-solving, and communicate actionable insights using data.
