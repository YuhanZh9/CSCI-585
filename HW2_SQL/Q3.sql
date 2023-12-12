-- SQLite

WITH PositiveCases AS (
    SELECT T.employee_id
    FROM Test AS T
    WHERE T.test_result = 'positive'
),
SymptomaticIndividuals AS (
    SELECT S.employee_id, E.floor
    FROM Symptom AS S
    JOIN Employee AS E ON S.employee_id = E.ID
),
CombinedData AS (
    SELECT PC.employee_id, SI.floor
    FROM PositiveCases AS PC
    JOIN SymptomaticIndividuals AS SI ON PC.employee_id = SI.employee_id
),
FloorCounts AS (
    SELECT CD.floor AS Sickest_Floor, COUNT(*) AS Floor_Count
    FROM CombinedData AS CD
    GROUP BY CD.floor
)

SELECT Sickest_Floor
FROM FloorCounts
WHERE Floor_Count = (
    SELECT MAX(Floor_Count) FROM FloorCounts
);
