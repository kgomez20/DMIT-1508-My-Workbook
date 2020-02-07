/* ******************
* File: SchoolTranscript.sql
* Author: Dan Gilleland
*
* CREATE DATABASE SchoolTranscript
********************** */
USE SchoolTranscript
GO

/* ---- Drop Tables ----*/
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'StudentCourses')
    DROP TABLE StudentCourses
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Courses')
    DROP TABLE Courses
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Students')
    DROP TABLE Students


/* ---- Create Tables ----- */
CREATE TABLE Students
(
    -- Comma-separated list of:
    -- Column-level and table-level definitions
    StudentID       int
        CONSTRAINT PK_Students_StudentID
            PRIMARY KEY
        IDENTITY(20200001, 1)       NOT NULL,
    GivenName       varchar(50)     NOT NULL,

-- % is a wildcard for zero or more characters (letter, digit, or other character)
-- _ is a wildcard for a single character (letter, digit, or other character)
    Surname         varchar(50)
		CONSTRAINT CK_Students_Surname
--			CHECK (Surname LIKE '_%')				-- LIKE allows us to do a "pattern-match"
			CHECK (Surname LIKE '[a-z][a-z]%')		-- two letters plus any other chars
		 --						 \ 1 /\ 1 /
		 -- Positive match for 'Fred'
		 -- Positive match for 'Wu'
		 -- Negative match for 'F'
		 -- Negative match for '2udor'
								    NOT NULL,
    DateOfBirth     datetime
		CONSTRAINT CK_Students_DateOfBirth
			CHECK (DateOfBirth < GETDATE())				-- GETDATE gets real time dates (todays date)
							        NOT NULL,
    Enrolled        bit
        CONSTRAINT DF_Students_Enrolled
            DEFAULT (1)             NOT NULL
)

CREATE TABLE Courses
(
    Number          varChar(10)
        CONSTRAINT      PK_Courses_Number
            PRIMARY KEY             NOT NULL,
    Name            varChar(50)     NOT NULL,
    Credits         decimal(3,1)
		CONSTRAINT CK_Courses_Credits
			CHECK (Credits > 0 AND Credits <= 12)
			--     \         /     \           /
			--       boolean         boolean
			--		 \                     /
			--                boolean
								    NOT NULL,
    Hours           tinyint
		CONSTRAINT CK_Courses_Hours
--			CHECK (Hours >= 15 AND HOURS <= 180)
			CHECK (Hours BETWEEN 15 AND 180) -- BETWEEN operator is inclusive
							        NOT NULL,
    Active          bit
        CONSTRAINT DF_Courses_Active
            DEFAULT (1)             NOT NULL,
    Cost            money           NOT NULL
)

CREATE TABLE StudentCourses
(
    StudentID       int
        CONSTRAINT FK_StudentCourses_StudentID_Students_StudentID
            FOREIGN KEY REFERENCES Students(StudentID)
                                    NOT NULL,
    CourseNumber    varchar(10)
        CONSTRAINT FK_StudentCourses_CourseNumber_Courses_Number
            FOREIGN KEY REFERENCES Courses(Number)
                                    NOT NULL,
    Year            tinyint         NOT NULL,
    Term            char(3)         NOT NULL,
    FinalMark       tinyint             NULL,
    Status          char(1)         NOT NULL,
    -- Table-level definition for Composite Primary Keys
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)