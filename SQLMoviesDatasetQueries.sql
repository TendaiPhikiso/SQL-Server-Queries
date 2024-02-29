USE Movies -- Using the Movies database 

/*
Show a list of films
*/

SELECT 
	--Adding Alias(temporary name) to fields
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration]
FROM 
	dbo.tblFilm


/*

Sorting in Queries
---
WITH TIES is used to include additional rows that have the same values as the last row. 
If multiple rows share the same values as the last row, they are included in the result set.
*/


-- Basic criterias using numbers
--Show films that are greater than or equal to 120
SELECT TOP 10 WITH TIES
	--Adding Alias(temporary name) to fields
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration]
FROM 
	dbo.tblFilm
WHERE
	FilmRunTimeMinutes >= 120
ORDER BY
	FilmRunTimeMinutes

-- Between operator 
SELECT
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration]
FROM 
	dbo.tblFilm
WHERE
	FilmRunTimeMinutes BETWEEN 120 AND 150
ORDER BY
	FilmRunTimeMinutes

-- Find a list of precise values : Use an IN operator 

SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes
FROM 
	tblFilm
WHERE 
	FilmRunTimeMinutes IN (90, 120, 150,180)
ORDER BY 
	FilmRunTimeMinutes

-- Basic criterias using Text data

SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes

FROM 
	tblFilm
WHERE 
	FilmName = 'die hard'
ORDER BY 
	FilmRunTimeMinutes

-- Using wildcard with Text 
SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes

FROM 
	tblFilm
WHERE 
/* 
	% Wildcard is used with the LIKE operator 
	This query retrieves rows where the the values in FilmName start with die hard 
	and the % allows any characters to follow the specified prefix. So you'll get die hard 2.. instead 
	of just die hard 

*/
	FilmName LIKE '%die hard%'
ORDER BY 
	FilmRunTimeMinutes

--- Dates
--Find dates that were released in the year 2000
SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes	
FROM 
	tblFilm
WHERE 
	FilmReleaseDate BETWEEN '2000-01-01' AND '2000-12-31'
ORDER BY 
	FilmReleaseDate

---OR
SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes	
FROM 
	tblFilm
WHERE 
	 YEAR(FilmReleaseDate) = 2000
ORDER BY 
	FilmReleaseDate


-- Find films released in the Month of May 
SELECT
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes
FROM 
	tblFilm
WHERE
	MONTH(FilmReleaseDate) = 5
ORDER BY 
	FilmReleaseDate

--- Using the AND and Or Operators 

SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes
FROM 
	tblFilm
WHERE 
	FilmName LIKE '%star%' AND YEAR(FilmReleaseDate) < 2000 AND
	FilmRunTimeMinutes > 120
ORDER BY 
	FilmRunTimeMinutes

-- Using OR to Find records that will find any in your conditional list 

--Show films lasting longer than 180 Min and where the title begins with s OR t
SELECT 
	FilmName,
	FilmReleaseDate,
	FilmRunTimeMinutes
FROM 
	tblFilm
WHERE 
	FilmRunTimeMinutes > 180 AND 
	(FilmName LIKE 's%' OR FilmName LIKE 't%')
ORDER BY 
	FilmRunTimeMinutes

/*

CALCULATED COLUMNS 

*/

--Workout the profit loss for the films & use  Calculations to sort Queries

SELECT 
	FilmName,
	FilmBoxOfficeDollars,
	FilmBudgetDollars,
	FilmBoxOfficeDollars-FilmBudgetDollars AS [FilmProfitLoss]
FROM 
	tblFilm
ORDER BY 
	FilmProfitLoss DESC

--- Use calculated column in a WHERE Clause 
SELECT 
	FilmName,
	FilmBoxOfficeDollars,
	FilmBudgetDollars,
	FilmBoxOfficeDollars-FilmBudgetDollars AS [FilmProfitLoss]
FROM 
	tblFilm
WHERE 
	(FilmBoxOfficeDollars-FilmBudgetDollars) < 0 
ORDER BY 
	FilmProfitLoss DESC

--- Calculate hours and Minutes 
SELECT 
	FilmName,
	FilmRunTimeMinutes,
	FilmRunTimeMinutes/60 AS [Hours],
	FilmRunTimeMinutes%60 AS [Minutes]
FROM 
	tblFilm

/*
THE CASE STATEMENT

--Case statement are used to test dif conditions
The CASE expression goes through conditions and returns a value
when the first condition is met (like an if-then-else statement)
*/

SELECT
	FilmName,
	FilmRunTimeMinutes,
	CASE
		WHEN FilmRunTimeMinutes <= 90 THEN 'Short'
		WHEN FilmRunTimeMinutes <= 150 THEN 'Medium'
		WHEN FilmRunTimeMinutes <= 180 THEN 'Long'
		ELSE 'Epic'
	END AS [FilmDuration]

FROM 
	tblFilm

/*
JOINS
*/

-- Inner Join Basic

SELECT 
	*
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.FilmDirectorID = d.DirectorID

--- Adding more tables using Inner Join 

SELECT TOP 5
--Specify fields you want to see 
	f.FilmName,
	d.DirectorName,
	s.StudioName,
	c.CountryName
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.FilmDirectorID = d.DirectorID
	INNER JOIN tblStudio AS s
		ON f.FilmStudioID = s.StudioID
	INNER JOIN tblCountry AS c
		ON f.FilmCountryID = c.CountryID

-- OUTER JOIN 
SELECT
--SHOW Directors who have not directed any films 
	d.DirectorID,
	d.DirectorName,
	f.FilmName,
	f.FilmDirectorID
FROM 
	tblDirector AS d LEFT OUTER JOIN tblFilm AS f ON d.DirectorID=f.FilmDirectorID
WHERE
	f.FilmID IS NULL

-- Other JOINS 

--show people who have been actors and directors 
SELECT 
	* 
FROM 
	tblActor AS a
	INNER JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName

-- Show people who have only been actors and Not Directors 
SELECT 
	* 
FROM 
	tblActor AS a LEFT OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName
WHERE 
	d.DirectorID IS NULL

-- Show people who have only been Directors & not Actors 
SELECT 
	*
FROM 
	tblActor AS a RIGHT OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName
WHERE 
	a.ActorID IS NULL

-- VIEW all the above information from both tables | All actors, All directors and All people who have been both 
SELECT 
	*
FROM 
	tblActor AS a FULL OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName

/*
	USING FUNCTIONS
*/

--simple basic function - UPPER -> turn all the characters to upper case
SELECT
	FilmName,
	UPPER(FilmName),
	FilmReleaseDate
FROM 
	tblFilm

-- Get the Names of each month that a film was released
SELECT
	FilmName,
	UPPER(FilmName), --turn characters into UPPER CASE
	FilmReleaseDate,
	DATENAME(MONTH,FilmReleaseDate) AS [MonthName]
FROM 
	tblFilm

-- Nesting Functions

--Calculate how old the films are in days
SELECT
	FilmName,
	UPPER(FilmName),
	FilmReleaseDate,
	DATENAME(MONTH,FilmReleaseDate) AS [MonthName],
	DATEDIFF(DAY,FilmReleaseDate, GETDATE()) AS [Days] --GETDATE, gets the current system date & time 
FROM 
	tblFilm

/*
	Text Calculation 
*/

-- Concatenating text and numbers 

SELECT 
	FilmName,
	FilmOscarWins,
	FilmName + ' won ' + CONVERT(VARCHAR(2), FilmOscarWins)
FROM 
	tblFilm

-- String Functions 
--Separate actors first name and last name 

SELECT 
	ActorName,
	LEFT(ActorName,CHARINDEX(' ' ,ActorName)-1) AS [ActorsFirstName],
	RIGHT(ActorName, LEN(ActorName)- CHARINDEX(' ', ActorName)) AS [ActorsLastName]
FROM 
	tblActor

/*

Date Calculations 

*/

-- Show date with 2 digit year | Change to standard format
SELECT 
	FilmName,
	FilmReleaseDate,
	CONVERT(CHAR(8), FilmReleaseDate,3)
FROM
	tblFilm

-- Show date with 4 digit year 
SELECT 
	FilmName,
	FilmReleaseDate,
	CONVERT(CHAR(10), FilmReleaseDate,103)
FROM
	tblFilm

-- Custome date format
-- Format that reads the full day of the month
SELECT 
	FilmName,
	FilmReleaseDate,
	CONVERT(CHAR(10), FilmReleaseDate,103),
	FORMAT(FilmReleaseDate, 'dddd dd MMMM yyyy') AS FormattedDate
FROM
	tblFilm

-- Check the dif in years between the film release date and today 

SELECT
	FilmName,
	FilmReleaseDate,
	DATEADD(YY, DATEDIFF(YY,FilmReleaseDate, GETDATE()), FilmReleaseDate),
	CASE 
	-- If birthday of films this year is after todays date
		WHEN DATEADD(YY, DATEDIFF(YY,FilmReleaseDate, GETDATE()), FilmReleaseDate) > GETDATE()
		THEN DATEDIFF(YY,FilmReleaseDate, GETDATE()) -1
		ELSE DATEDIFF(YY,FilmReleaseDate, GETDATE()) 
	END

FROM 
	tblFilm

/*
 GROUP BY and HAVING
*/

-- Aggregate Functions 

SELECT 
	SUM(FilmRunTimeMinutes)  AS [TotalRunTime],
	AVG(FilmRunTimeMinutes)  AS [AverageRunTime],
	MAX(FilmRunTimeMinutes)  AS [HighestRunTime],
	MIN(FilmRunTimeMinutes)  AS [ShortestRunTime],
	COUNT(*)
FROM 
	tblFilm

-- correct data type

SELECT 
	SUM(CONVERT(BIGINT, FilmBoxOfficeDollars)),
	AVG(CONVERT(DECIMAL, FilmRunTimeMinutes))
FROM 
	tblFilm

-- Group by Clause 

SELECT 
	CountryName,
	AVG(FilmRunTimeMinutes)
FROM 
	tblFilm AS f INNER JOIN tblCountry AS c ON c.CountryID=f.FilmCountryID
-- Any field that is not aggregated goes into the group by clause
GROUP BY 
	CountryName
ORDER BY
	CountryName ASC

-- Applying Group Totals

SELECT
	ISNULL(CountryName, 'TOTAL'),
	SUM(FilmRunTimeMinutes)  AS [TotalRunTime],
	AVG(FilmRunTimeMinutes)  AS [AverageRunTime],
	MAX(FilmRunTimeMinutes)  AS [HighestRunTime],
	MIN(FilmRunTimeMinutes)  AS [ShortestRunTime]
FROM 
	tblFilm AS f INNER JOIN tblCountry AS c ON c.CountryID=f.FilmCountryID

GROUP BY 
	CountryName WITH ROLLUP
ORDER BY
	CountryName ASC

-- Criteria in Group Queries
--Look for countries whose name begins with the later U

SELECT
	ISNULL(CountryName, 'TOTAL'),
	SUM(FilmRunTimeMinutes)  AS [TotalRunTime],
	AVG(FilmRunTimeMinutes)  AS [AverageRunTime],
	MAX(FilmRunTimeMinutes)  AS [HighestRunTime],
	MIN(FilmRunTimeMinutes)  AS [ShortestRunTime]
FROM 
	tblFilm AS f INNER JOIN tblCountry AS c ON c.CountryID=f.FilmCountryID
WHERE
	CountryName LIKE 'U%'
GROUP BY 
	CountryName WITH ROLLUP
ORDER BY
	CountryName ASC

---

/*
 HAVING clause is used instead of the WHERE clause because it filters
 the results based on the results of aggregate functions (e.g., MIN, SUM, AVG, etc.) 
*/

SELECT
	ISNULL(CountryName, 'TOTAL'),
	SUM(FilmRunTimeMinutes)  AS [TotalRunTime],
	AVG(FilmRunTimeMinutes)  AS [AverageRunTime],
	MAX(FilmRunTimeMinutes)  AS [HighestRunTime],
	MIN(FilmRunTimeMinutes)  AS [ShortestRunTime]
FROM 
	tblFilm AS f INNER JOIN tblCountry AS c ON c.CountryID=f.FilmCountryID
GROUP BY 
	CountryName WITH ROLLUP
HAVING 
	MIN(FilmRunTimeMinutes) >= 100
ORDER BY
	CountryName ASC

--Multiple columns
/*
Generate a summary report with average film runtimes and film counts, grouped by country and director, including subtotals and a grand total.
*/
SELECT 
	ISNULL(CountryName, 'Grand'),
	ISNULL(DirectorName,'Total'),
	AVG(CONVERT(DECIMAL, FilmRunTimeMinutes)) AS [AverageFilmRunTime],
	COUNT(*) AS [FilmCount] -- count of films 
FROM 
	tblFilm AS f
	INNER JOIN tblCountry AS c ON c.CountryID=f.FilmCountryID
	INNER JOIN tblDirector AS d ON d.DirectorID=f.FilmDirectorID
-- Groups the results by CountryName and DirectorName with the ROLLUP option for subtotals and a grand total.
GROUP BY 
	CountryName,
	DirectorName WITH ROLLUP
-- Orders the result set by CountryName in ascending order.
ORDER BY 
	CountryName

/* 
Subqueries 
*/

-- Find details of a film using subqueries based on filmOscar wins
SELECT 
	FilmName,
	FilmReleaseDate
FROM	
	tblFilm
WHERE 
	FilmOscarWins =
		(SELECT 
			MAX(FilmOscarWins)
		FROM
			tblFilm)

-- Aggregates in Subqueries
-- Find films that are greater than the average 
SELECT 
	FilmName,
	FilmRunTimeMinutes
FROM	
	tblFilm
WHERE 
	 FilmRunTimeMinutes >=
		(SELECT 
			AVG(CONVERT(DECIMAL, FilmRunTimeMinutes))
		FROM
			tblFilm)

-- Using a WHERE Clause in a Subquery
-- Show list of all films whose budget was greater than the most expensive film released in the year 2000
SELECT
	FilmName,
	FilmReleaseDate,
	FilmBudgetDollars
FROM 
	tblFilm
WHERE
	FilmBudgetDollars > 
		(SELECT 
			MAX(FilmBudgetDollars)
		FROM
			tblFilm
		WHERE
			 FilmReleaseDate < '2000-01-01')

--Check films whose release dates are the same as the filmName Casino
SELECT
	FilmName,
	FilmReleaseDate
FROM 
	tblFilm
WHERE
	FilmReleaseDate = 
		(SELECT 
			FilmReleaseDate
		FROM
			tblFilm
		WHERE
			FilmName = 'Casino')


/*

Correlated Subqueries 

*/

-- Show film with the longest running time in a country 
SELECT
	c.CountryName,
	f.FilmName,
	f.FilmRunTimeMinutes
FROM 
	tblFilm AS f INNER JOIN
	tblCountry AS c ON c.CountryID=f.FilmCountryID
WHERE
	f.FilmRunTimeMinutes = 
		(
			SELECT MAX(FilmRunTimeMinutes)
			FROM tblFilm AS g
			WHERE g.FilmCountryID=f.FilmCountryID
		)
-- Show films that are longer than average of all films in a particular year 
SELECT
	YEAR(f.FilmReleaseDate) AS y,
	f.FilmName,
	f.FilmRunTimeMinutes
FROM 
	tblFilm AS f 
WHERE
	f.FilmRunTimeMinutes = 
		(
			SELECT AVG(FilmRunTimeMinutes)
			FROM tblFilm AS g
			WHERE YEAR(g.FilmReleaseDate)=YEAR(f.FilmReleaseDate)
		)
ORDER BY
	y