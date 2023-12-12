-- SQLite

SELECT '2023-10-06' AS Start_Date,
    '2023-10-09' AS End_Date,
    (SELECT COUNT(*)
    FROM Scan
    WHERE scan_date
    BETWEEN '2023-10-06'
    AND '2023-10-09')
    AS Number_of_Scans,
    (SELECT COUNT(*)
    FROM Test
    WHERE test_date
    BETWEEN '2023-10-06'
    AND '2023-10-09')
    AS Number_of_Tests,
    (SELECT COUNT(DISTINCT employee_id)
    FROM Symptom
    WHERE date_reported
    BETWEEN '2023-10-06'
    AND '2023-10-09')
    AS Number_of_Employees_With_Symptoms,
    (SELECT COUNT(*)
    FROM Test
    WHERE test_date
    BETWEEN '2023-10-06'
    AND '2023-10-09'
    AND test_result = 'positive')
    AS Number_of_Positive_Cases;
