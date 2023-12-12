-- SQLite

WITH MeetingAttendance AS (
  SELECT employee_id
  FROM Meeting
  GROUP BY employee_id
  HAVING COUNT(*) >= 3
),
EmployeeAllMeeting AS (
  SELECT e1.ID
  FROM Employee e1
  WHERE NOT EXISTS (
    SELECT ma.employee_id
    FROM MeetingAttendance ma
    WHERE ma.employee_id NOT IN (
      SELECT e2.ID
      FROM Employee e2
      WHERE e2.ID=e1.ID
    )
  )
)

SELECT e.ID, e.name, COUNT(*) AS "Symptom Report Count"
FROM Symptom s
JOIN Employee e ON e.ID = s.employee_id
WHERE s.employee_id IN (
  SELECT ID
  FROM EmployeeAllMeeting
)
GROUP BY s.employee_id;
