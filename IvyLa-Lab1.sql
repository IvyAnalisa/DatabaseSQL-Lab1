/* MoonMissions*/
-- Skapa och fyll en ny tabell med namnet SuccessfulMissions
SELECT
    Spacecraft,
    [Launch date] AS LaunchDate,  
    [Carrier rocket] AS CarrierRocket,
    Operator,
    [Mission type] AS MissionType
INTO SuccessfulMissions
FROM
    MoonMissions  -- Ersätt med namnet på din ursprungliga tabell
WHERE
    Outcome = 'Successful';  -- Antag att 'Outcome' är kolumnen som innehåller resultatet


GO
--I kolumnen ’Operator’ har det smugit sig in ett eller flera mellanslag före 
--operatörens namn. Skriv en query som uppdaterar ”SuccessfulMissions” och tar 
--bort mellanslagen kring operatör.
UPDATE SuccessfulMissions
SET Operator = TRIM(Operator)

GO
--Skriv en select query som tar ut, grupperar, samt sorterar på kolumnerna
--’Operator’ och ’Mission type’ från ”SuccessfulMissions”. Som en tredje kolumn
--’Mission count’ i resultatet vill vi ha antal uppdrag av varje operatör och typ. Ta
--bara med de grupper som har fler än ett (>1) uppdrag av samma typ och operatör.

SELECT
    Operator,
    [MissionType] AS MissionType,
    COUNT(*) AS MissionCount
FROM
    SuccessfulMissions
GROUP BY
    Operator,
    [MissionType]
HAVING
    COUNT(*) > 1
ORDER BY
    Operator,
    MissionType;
GO

	SELECT * FROM SuccessfulMissions;
GO
--Ta ut samtliga rader och kolumner från tabellen ”Users”, men slå ihop ’Firstname’
--och ’Lastname’ till en ny kolumn ’Name’, samt lägg till en extra kolumn ’Gender’
--som du ger värdet ’Female’ för alla användare vars näst sista siffra i personnumret
--är jämn, och värdet ’Male’ för de användare där siffran är udda. Sätt in resultatet i
--en ny tabell ”NewUsers”.
-- Skapa och fyll en ny tabell med namnet NewUsers
-- Skapa och fyll en ny tabell med namnet NewUsers
SELECT
    [ID],
    CONCAT([Firstname], ' ', [Lastname]) AS Name,
    [Gender] = 
        CASE
            WHEN SUBSTRING([ID], LEN([ID])-1, 1) % 2 = 0 THEN 'Female'
            ELSE 'Male'
        END
INTO NewUsers
FROM
    Users;

-- Visa innehållet i den nya tabellen
GO
-- Skriv en query som returnerar en tabell med alla användarnamn i ”NewUsers”
--som inte är unika i den första kolumnen, och antalet gånger de är duplicerade i
--den andra kolumnen.
SELECT
    Name,
    COUNT(*) AS DuplicateCount
FROM
    NewUsers
GROUP BY
    Name
HAVING
    COUNT(*) > 1;

GO
--Skriv en följd av queries som uppdaterar de användare med dubblerade
--användarnamn som du fann ovan, så att alla användare får ett unikt
--användarnamn. D.v.s du kan hitta på nya användarnamn för de användarna, så
--länge du ser till att alla i ”NewUsers” har unika värden på ’Username’.
-- Skapa en temporär tabell med duplicerade användarnamn och antalet förekomster
-- Drop the #Duplicates table if it exists
IF OBJECT_ID('tempdb..#Duplicates') IS NOT NULL
    DROP TABLE #Duplicates;

-- Skapa en temporär tabell med duplicerade användarnamn och antalet förekomster
SELECT
    Name,
    COUNT(*) AS DuplicateCount,
    ROW_NUMBER() OVER (PARTITION BY Name ORDER BY [Name]) AS RowNum
INTO #Duplicates
FROM
    NewUsers
GROUP BY
    Name
HAVING
    COUNT(*) > 1;

-- Uppdatera användarnamnen i NewUsers för att göra dem unika
UPDATE U
SET
    U.Name = CONCAT(U.Name, '_', D.RowNum) -- Lägg till en unik identifierare
FROM
    NewUsers U
    INNER JOIN #Duplicates D ON U.Name = D.Name;

-- Visa det uppdaterade innehållet i NewUsers

GO
--Skapa en query som tar bort alla kvinnor födda före 1970 från ”NewUsers”
SELECT *
FROM NewUsers
WHERE 
    Gender = 'Female' 
    AND SUBSTRING(ID, 1, 4) < '1970';
	SELECT * FROM NewUsers;

GO

---- Lägg till en ny användare i NewUsers

-- Lägg till en ny användare i NewUsers
INSERT INTO NewUsers (Name, Gender, ID)
VALUES ('Andrea Andersson', 'Male', '900101-1234');
SELECT * FROM NewUsers;

GO
--Skriv en query som returnerar två kolumner ’gender’ och ’average age’, och två
-- Returnera genomsnittsåldern för män och kvinnor från NewUsers
SELECT
    Gender,
    AVG(DATEDIFF(YEAR, 
                DATEFROMPARTS('20' + SUBSTRING(ID, 1, 2), SUBSTRING(ID, 3, 2), SUBSTRING(ID, 5, 2)),
                GETDATE()
            )) AS AverageAge
FROM
    NewUsers
GROUP BY
    Gender;


SELECT * FROM NewUsers;