/*
===========================================================
Patient Survey Analysis - Insights Layer
===========================================================
Objective:
Transform cleaned healthcare survey data into actionable
insights on patient satisfaction, regional disparities,
performance drivers, and time trends.
===========================================================
*/


/* =========================================================
1. CORE SATISFACTION KPI
========================================================= */

-- Derived Satisfaction Score (Top vs Bottom Box)
SELECT 
    measure_id,
    release_period,
    (top_box_percentage - bottom_box_percentage) AS satisfaction_score
FROM national_results
ORDER BY satisfaction_score DESC;


/* =========================================================
2. MEASURE PERFORMANCE ANALYSIS
========================================================= */

-- Identify high-impact but underperforming measures
SELECT 
    m.measure,
    ROUND(AVG(n.top_box_percentage), 2) AS avg_top,
    ROUND(AVG(n.bottom_box_percentage), 2) AS avg_bottom,
    ROUND(AVG(n.top_box_percentage) - AVG(n.bottom_box_percentage), 2) AS net_score
FROM national_results n
JOIN measures m 
    ON n.measure_id = m.measure_id 
GROUP BY m.measure
HAVING AVG(n.top_box_percentage) < 70
ORDER BY net_score;


/* =========================================================
3. CONSISTENCY / VARIABILITY ANALYSIS
========================================================= */

-- Measure stability across time (variance analysis)
SELECT 
    m.measure,
    ROUND(VAR_SAMP(n.top_box_percentage), 2) AS variance_top,
    ROUND(VAR_SAMP(n.middle_box_percentage), 2) AS variance_middle,
    ROUND(VAR_SAMP(n.bottom_box_percentage), 2) AS variance_bottom
FROM national_results n
JOIN measures m 
    ON n.measure_id = m.measure_id
GROUP BY m.measure
ORDER BY variance_top DESC;


/* =========================================================
4. REGIONAL PERFORMANCE & INEQUALITY
========================================================= */

SELECT
    s.region,
    ROUND(AVG(sr.top_box_percentage), 2) AS avg_satisfaction,
    ROUND(STDDEV(sr.top_box_percentage), 2) AS variation
FROM state_results sr
JOIN states s 
    ON sr.state = s.state
GROUP BY s.region
ORDER BY variation DESC;


/* =========================================================
5. RESPONSE RATE BIAS ANALYSIS
========================================================= */

SELECT 
    s.state_name,
    ROUND(AVG(r.response_rate), 2) AS response_rate,
    ROUND(AVG(sr.top_box_percentage), 2) AS satisfaction
FROM responses r
JOIN state_results sr 
    ON r.state = sr.state 
    AND r.release_period = sr.release_period
JOIN states s 
    ON r.state = s.state
GROUP BY s.state_name
ORDER BY response_rate DESC;


/* =========================================================
6. SATISFACTION TREND OVER TIME
========================================================= */

SELECT 
    r.release_period, 
    ROUND(AVG(n.top_box_percentage), 2) AS satisfaction,
    LAG(ROUND(AVG(n.top_box_percentage), 2)) 
        OVER (ORDER BY r.release_period) AS prev_period,
    ROUND(
        AVG(n.top_box_percentage) -
        LAG(AVG(n.top_box_percentage)) OVER (ORDER BY r.release_period),
        2
    ) AS change_value
FROM national_results n 
JOIN reports r 
    ON n.release_period = r.release_period 
GROUP BY r.release_period
ORDER BY r.release_period;


/* =========================================================
7. STATE PERFORMANCE RANKING
========================================================= */

SELECT    
    s.state_name,
    ROUND(AVG(sr.top_box_percentage), 2) AS satisfaction,
    RANK() OVER (
        ORDER BY AVG(sr.top_box_percentage) DESC
    ) AS rank_num
FROM state_results sr
JOIN states s 
    ON sr.state = s.state
GROUP BY s.state_name;


/* =========================================================
8. NATIONAL BENCHMARKING (OVER vs UNDER PERFORMERS)
========================================================= */

WITH national_avg AS (
    SELECT AVG(top_box_percentage) AS avg_score
    FROM national_results
)

SELECT 
    n.avg_score,
    s.state_name,
    ROUND(AVG(sr.top_box_percentage), 2) AS state_score,
    ROUND(AVG(sr.top_box_percentage) - n.avg_score, 2) AS performance_gap
FROM state_results sr 
JOIN states s 
    ON sr.state = s.state
JOIN national_avg n
GROUP BY n.avg_score, s.state_name
ORDER BY performance_gap DESC;


/* =========================================================
9. QUESTION-LEVEL SATISFACTION DRIVERS
========================================================= */

SELECT 
    q.question,
    ROUND(AVG(sr.top_box_percentage), 2) AS satisfaction
FROM state_results sr
JOIN questions q 
    ON sr.measure_id = q.measure_id
GROUP BY q.question
ORDER BY satisfaction DESC;
