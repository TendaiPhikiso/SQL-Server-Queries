<div align="center">
	<h1>
		SQL Queries | Movies Dataset 
	</h1>

![image](https://img.freepik.com/free-vector/realistic-horizontal-cinema-movie-time-poster-with-3d-glasses-snacks-tickets-clapper-reel-blue-background-with-bokeh-vector-illustration_1284-77013.jpg?t=st=1708960090~exp=1708963690~hmac=a43c67c034b365a61c378b5a2c308899ba06016c7e9f00e37eb8cd549661569b&w=1380)
 </div>


### (1) Show a list of films 

Showing a list of films with release date and duration.

**SQL Query:**

```sql
USE Movies -- Using the Movies database 

SELECT 
	--Adding Alias(temporary name) to fields
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration]
FROM 
	dbo.tblFilm
```

###  (2) Sorting in Queries

**SQL Query: Using ORDER BY Clause**

```sql
SELECT 
	--Adding Alias(temporary name) to fields
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration]
FROM 
	dbo.tblFilm
ORDER BY
	Duration DESC,
	FilmName ASC
```
**SQL Query: TOP 10 Films**

```sql
/*
WITH TIES is used to include additional rows that have the same values as the last row. 
If multiple rows share the same values as the last row, they are included in the result set.
*/

SELECT TOP 10 WITH TIES
	--Adding Alias(temporary name) to fields
	FilmName AS [Title],
	FilmReleaseDate AS [Relseased on],
	FilmRunTimeMinutes AS [Duration],
	FilmOscarWins
FROM 
	dbo.tblFilm
ORDER BY
	FilmOscarWins DESC
```
**Result Set:**

| Title                                     | Released on                 | Duration | Film Oscar Wins |
|-------------------------------------------|-----------------------------|----------|------------------|
| Titanic                                   | 1998-01-23 00:00:00.000   | 194      | 11               |
| The Lord of the Rings: Return of the King | 2003-12-17 00:00:00.000   | 201      | 11               |
| Gandhi                                    | 1982-12-08 00:00:00.000   | 188      | 8                |
| Schindler's List                          | 1994-02-18 00:00:00.000   | 195      | 7                |
| Dances With Wolves                        | 1991-02-08 00:00:00.000   | 180      | 7                |
| Star Wars: Episode IV - A New Hope        | 1977-12-27 00:00:00.000   | 121      | 6                |
| Terminator 2: Judgement Day               | 1991-08-16 00:00:00.000   | 137      | 6                |
| The Aviator                               | 2005-01-06 00:00:00.000   | 170      | 5                |
| Gladiator                                 | 2000-05-12 00:00:00.000   | 155      | 5                |
| Braveheart                                | 1995-09-08 00:00:00.000   | 177      | 5                |
| Saving Private Ryan                       | 1998-09-11 00:00:00.000   | 170      | 5                |
| Around the World in 80 Days               | 1956-10-17 00:00:00.000   | 167      | 5                |
| American Beauty                           | 2000-02-04 00:00:00.000   | 122      | 5                |


###  (3) Criteria in Queries

**SQL Query:Using Text**

```sql

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
	FilmName LIKE 'die hard%'
ORDER BY 
	FilmRunTimeMinutes
```

**Result Set:**

| FilmName                    | FilmReleaseDate            | FilmRunTimeMinutes |
|-----------------------------|----------------------------|--------------------|
| Die Hard 2                  | 1990-08-17 00:00:00.000    | 124                |
| Live Free or Die Hard       | 2007-07-04 00:00:00.000    | 130                |
| Die Hard: With A Vengeance  | 1995-08-18 00:00:00.000    | 131                |
| Die Hard                    | 1989-02-03 00:00:00.000    | 131                |


**SQL Query: Using Date**

```sql
-- Find films released in the year 2000
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
```


###  (4) Calculated Columns 

```sql

```


###  (5) CASE Statement

```sql
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
```


###  (6) INNER & OUTER JOINS 
```sql
--- Inner joins 
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

```
**Result Set:**
| FilmName          | DirectorName        | StudioName                  | CountryName   |
|-------------------|---------------------|-----------------------------|---------------|
| Jurassic Park     | Steven Spielberg    | Universal Pictures          | United States |
| Spider-Man        | Sam Raimi           | Columbia Pictures           | United States |
| King Kong         | Peter Jackson       | Universal Pictures          | United States |
| Superman Returns  | Bryan Singer        | Warner Bros. Pictures       | United States |
| Titanic           | James Cameron       | 20th Century Fox            | United States |


#### Other JOINS
```sql

--show people who have been actors and directors 
SELECT 
	* 
FROM 
	tblActor AS a
	INNER JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName
-------------------------------------------------------------
-- Show people who have only been actors and Not Directors 
SELECT 
	* 
FROM 
	tblActor AS a LEFT OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName
WHERE 
	d.DirectorID IS NULL

-------------------------------------------------------------
-- Show people who have only been Directors & not Actors 
SELECT 
	*
FROM 
	tblActor AS a RIGHT OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName
WHERE 
	a.ActorID IS NULL

-------------------------------------------------------------

-- VIEW all the above information from both tables | All actors, All directors and All people who have been both 
SELECT 
	*
FROM 
	tblActor AS a FULL OUTER JOIN tblDirector AS d ON a.ActorName=d.DirectorName

```

###  (7) Using Functions

```sql

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
```
###  (8) Text Calculations

```sql

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

```


###  (9) Date Calculations

```sql

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
```

###  (10) GROUP BY and HAVING

```sql
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

```


###  (11) 

```sql

```

###  (12) 

```sql

```



