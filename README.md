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
