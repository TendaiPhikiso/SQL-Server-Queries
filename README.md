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


###  (6)

