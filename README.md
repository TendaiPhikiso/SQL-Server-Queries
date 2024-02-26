# SQL Queries | Movies Dataset 

### Show a list of films 

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

### Sorting in Queries

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


