-- SQLite

CREATE TABLE "Employee" (
	"ID"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"office"	INTEGER NOT NULL,
	"floor"	INTEGER NOT NULL CHECK((1 <= "floor") & ("floor" <= 10)),
	"phone"	TEXT NOT NULL,
	"email"	TEXT,
	UNIQUE("ID"),
	PRIMARY KEY("ID")
) WITHOUT ROWID;


CREATE TABLE "Meeting" (
	"meeting_id"	INTEGER NOT NULL,
	"employee_id"	INTEGER NOT NULL,
	"room_number"	INTEGER NOT NULL,
	"floor_number"	INTEGER NOT NULL CHECK((1 <= "floor_number") & ("floor_number" <= 10)),
	"meeting_start_time"	INTEGER NOT NULL CHECK((8 <= "meeting_start_time") & ("meeting_start_time" <= 18)),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("meeting_id","employee_id")
);


CREATE TABLE "Notification" (
	"notification_id"	INTEGER NOT NULL UNIQUE,
	"employee_id"	INTEGER NOT NULL,
	"notification_date"	TEXT NOT NULL,
	"notification_type"	TEXT NOT NULL CHECK(notification_type in ('mandatory', 'optional')),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("notification_id")
) WITHOUT ROWID;


CREATE TABLE "Symptom" (
	"row_id"	INTEGER NOT NULL,
	"employee_id"	INTEGER NOT NULL,
	"date_reported"	TEXT NOT NULL,
	"symptom_id"	TEXT NOT NULL CHECK(1 <= "symptom_id" & "symptom_id" <= 5),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("row_id")
);

CREATE TABLE "Scan" (
	"scan_id"	INTEGER NOT NULL UNIQUE,
	"scan_date"	TEXT NOT NULL,
	"scan_time"	INTEGER NOT NULL CHECK(0 <= "scan_time" & "scan_time" <= 23),
	"employee_id"	INTEGER NOT NULL,
	"temperature"	NUMERIC NOT NULL,
	PRIMARY KEY("scan_id"),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID")
) WITHOUT ROWID;


CREATE TABLE "Test" (
	"test_id"	INTEGER NOT NULL UNIQUE,
	"location"	TEXT NOT NULL CHECK("location" IN ('company', 'hospital', 'clinic')),
	"test_date"	TEXT NOT NULL,
	"test_time"	INTEGER NOT NULL CHECK(("test_time" <= 23) & ("test_time" >= 0)),
	"employee_id"	INTEGER NOT NULL,
	"test_result"	TEXT NOT NULL CHECK("test_result" IN ('positive', 'negative')),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("test_id")
) WITHOUT ROWID;


CREATE TABLE "Case" (
	"case_id"	INTEGER NOT NULL UNIQUE,
	"employee_id"	INTEGER NOT NULL,
	"date"	TEXT NOT NULL,
	"resolution"	TEXT NOT NULL CHECK("resolution" IN ('left the company', 'deceased', 'back to work')),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("case_id")
) WITHOUT ROWID;

CREATE TABLE "Health Status" (
	"row_id"	INTEGER NOT NULL,
	"employee_id"	INTEGER NOT NULL,
	"date"	TEXT NOT NULL,
	"status"	TEXT NOT NULL CHECK("status" IN ('sick', 'hospitalized', 'well')),
	FOREIGN KEY("employee_id") REFERENCES "Employee"("ID"),
	PRIMARY KEY("row_id")
);


-- INSERT INTO "Employee" ("ID", "name", "office", "floor", "phone", "email") VALUES
-- (1, 'John Doe', 101, 5, '555-1234', 'john.doe@email.com'),
-- (2, 'Jane Smith', 102, 5, '555-5678', 'jane.smith@email.com'),
-- (3, 'Bob Johnson', 103, 5, '555-9876', 'bob.johnson@email.com'),
-- (4, 'Alice Brown', 104, 6, '555-4321', 'alice.brown@email.com'),
-- (5, 'Charlie Wilson', 105, 6, '555-8765', 'charlie.wilson@email.com'),
-- (6, 'David Davis', 106, 6, '555-2345', 'david.davis@email.com'),
-- (7, 'Eva White', 107, 7, '555-6789', 'eva.white@email.com'),
-- (8, 'Frank Miller', 108, 7, '555-3456', 'frank.miller@email.com'),
-- (9, 'Grace Lee', 109, 7, '555-7890', 'grace.lee@email.com'),
-- (10, 'Henry Thomas', 110, 8, '555-4567', 'henry.thomas@email.com'),
-- (11, 'Ivy Green', 111, 8, '555-8901', 'ivy.green@email.com'),
-- (12, 'Jack Black', 112, 8, '555-6543', 'jack.black@email.com'),
-- (13, 'Kelly Johnson', 113, 9, '555-2109', 'kelly.johnson@email.com'),
-- (14, 'Liam Harris', 114, 9, '555-5432', 'liam.harris@email.com'),
-- (15, 'Mia Robinson', 115, 9, '555-8765', 'mia.robinson@email.com'),
-- (16, 'Noah Taylor', 116, 10, '555-4321', 'noah.taylor@email.com'),
-- (17, 'Olivia White', 117, 10, '555-7654', 'olivia.white@email.com'),
-- (18, 'Peter Smith', 118, 10, '555-1098', 'peter.smith@email.com'),
-- (19, 'Quinn Davis', 119, 10, '555-4321', 'quinn.davis@email.com'),
-- (20, 'Rachel Brown', 120, 10, '555-7654', 'rachel.brown@email.com');
--
-- INSERT INTO "Meeting" ("meeting_id", "employee_id", "room_number", "floor_number", "meeting_start_time")
-- VALUES
--     (1, 1, 101, 1, 9),
--     (1, 2, 101, 1, 9),
--     (1, 10, 101, 1, 9),
--     (2, 4, 301, 3, 13),
--     (2, 5, 301, 3, 13),
--     (2, 6, 301, 3, 13),
--     (2, 7, 301, 3, 13),
--     (3, 1, 102, 1, 10),
--     (3, 18, 102, 1, 10),
--     (3, 9, 102, 1, 10);
--
-- INSERT INTO "Notification" ("notification_id", "employee_id", "notification_date", "notification_type")
-- VALUES
--     (1, 1, '2023-10-06', 'mandatory'),
--     (2, 10, '2023-10-06', 'mandatory'),
--     (3, 3, '2023-10-06', 'optional'),
--     (4, 4, '2023-10-09', 'mandatory'),
--     (5, 6, '2023-10-09', 'mandatory'),
--     (6, 7, '2023-10-09', 'mandatory');
--
-- INSERT INTO "Symptom" ("employee_id", "date_reported", "symptom_id")
-- VALUES
--     (1, '2023-10-05', 1),
--     (2, '2023-10-06', 4),
--     (15, '2023-10-06', 5),
--     (3, '2023-10-08', 1),
--     (4, '2023-10-08', 4),
--     (13, '2023-10-09', 4),
--     (6, '2023-10-09', 2),
--     (9, '2023-10-10', 3);
--
-- INSERT INTO "Scan" ("scan_id", "scan_date", "scan_time", "employee_id", "temperature")
-- VALUES
-- (1, '2023-10-05', 9, 14, 98.6),
-- (2, '2023-10-05', 10, 3, 98.4),
-- (3, '2023-10-05', 11, 9, 98.8),
-- (4, '2023-10-05', 12, 20, 99.0),
-- (5, '2023-10-05', 13, 4, 98.7),
-- (6, '2023-10-06', 9, 1, 98.5),
-- (7, '2023-10-06', 10, 10, 98.9),
-- (8, '2023-10-06', 11, 8, 98.3),
-- (9, '2023-10-06', 12, 9, 98.2),
-- (10, '2023-10-06', 13, 10, 98.4),
-- (11, '2023-10-07', 9, 11, 98.7),
-- (12, '2023-10-07', 10, 12, 98.6),
-- (13, '2023-10-07', 11, 13, 98.8),
-- (14, '2023-10-07', 12, 14, 98.9),
-- (15, '2023-10-07', 13, 15, 98.5),
-- (16, '2023-10-08', 9, 16, 98.4),
-- (17, '2023-10-08', 10, 17, 98.3),
-- (18, '2023-10-08', 11, 18, 98.7),
-- (19, '2023-10-09', 12, 7, 98.6),
-- (20, '2023-10-09', 14, 5, 100.4);
--
-- INSERT INTO "Test" ("test_id", "location", "test_date", "test_time", "employee_id", "test_result")
-- VALUES
-- (1, 'company', '2023-10-06', 12, 1, 'positive'),
-- (2, 'clinic', '2023-10-06', 11, 2, 'positive'),
-- (3, 'company', '2023-10-06', 13, 10, 'negative'),
-- (4, 'hospital', '2023-10-06', 16, 15, 'negative'),
-- (5, 'company', '2023-10-07', 14, 14, 'negative'),
-- (6, 'company', '2023-10-07', 17, 12, 'positive'),
-- (7, 'clinic', '2023-10-08', 13, 18, 'negative'),
-- (8, 'company', '2023-10-08', 10, 3, 'positive'),
-- (9, 'hospital', '2023-10-08', 12, 4, 'negative'),
-- (10, 'company', '2023-10-09', 11, 4, 'negative'),
-- (11, 'clinic', '2023-10-09', 16, 6, 'positive'),
-- (12, 'hospital', '2023-10-09', 17, 5, 'positive'),
-- (13, 'clinic', '2023-10-09', 17, 7, 'negative'),
-- (14, 'company', '2023-10-10', 10, 9, 'negative');
--
-- INSERT INTO "Case" ("case_id", "employee_id", "date", "resolution")
-- VALUES
--     (1, 1, '2023-10-06', 'left the company'),
--     (2, 2, '2023-10-06', 'left the company'),
--     (3, 12, '2023-10-08', 'back to work'),
--     (4, 3, '2023-10-08', 'left the company'),
--     (5, 6, '2023-10-09', 'left the company'),
--     (6, 5, '2023-10-09', 'left the company');
--
-- INSERT INTO "Health Status" ("employee_id", "date", "status")
-- VALUES
--     (1, '2023-10-06', 'sick'),
--     (2, '2023-10-06', 'hospitalized'),
--     (12, '2023-10-07', 'hospitalized'),
--     (1, '2023-10-07', 'sick'),
--     (2, '2023-10-07', 'hospitalized'),
--     (1, '2023-10-08', 'sick'),
--     (1, '2023-10-08', 'sick'),
--     (2, '2023-10-08', 'hospitalized'),
--     (3, '2023-10-08', 'sick'),
--     (1, '2023-10-09', 'sick'),
--     (2, '2023-10-09', 'sick'),
--     (3, '2023-10-09', 'sick'),
--     (6, '2023-10-09', 'sick'),
--     (5, '2023-10-09', 'hospitalized');
