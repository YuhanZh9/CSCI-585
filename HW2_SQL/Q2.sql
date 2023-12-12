--SQLite

SELECT symptom_id as Most_Reported_Symptom
FROM Symptom
GROUP BY symptom_id
HAVING COUNT(*) = (
  SELECT MAX(Count)
  FROM (
    SELECT COUNT(*) AS Count
    FROM Symptom
    GROUP BY symptom_id
  ) AS COUNTS
);
