USE SchoolTranscript
GO

INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES ('Dan', 'Gilleland', '19720514 10:34:00 PM', 1),
       ('Jim', 'Smith', '19971115 08:15:00 AM', 1)

	   -- MISSING INFO, PIC ON PHONE

INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES ('Don', 'Welch', '19420804 08:04:00 AM')

SELECT * FROM Students


-- Show all of the columns from the Students table
SELECT * FROM Students -- Using the * to identify all columns is "Quick 'n Dirty"
-- In our SELECT statements for this course, we will AVOID the use of *
-- I will take marks off if you use it where you shouldn't

-- You should specify which columns you want to retrieve data from
SELECT Number, [Name], Credits, [Hours]
FROM   Courses
WHERE [Name] LIKE '%fun%'
ORDER BY [Name]


-- Write a query to get the first/last names of all students
-- whose last name starts with a "H"
SELECT GivenName, Surname
FROM   Students
WHERE Surname LIKE 'H%'
