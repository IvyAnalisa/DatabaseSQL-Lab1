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
    MoonMissions  -- Ers�tt med namnet p� din ursprungliga tabell
WHERE
    Outcome = 'Successful';  -- Antag att 'Outcome' �r kolumnen som inneh�ller resultatet


GO
--I kolumnen �Operator� har det smugit sig in ett eller flera mellanslag f�re 
--operat�rens namn. Skriv en query som uppdaterar �SuccessfulMissions� och tar 
--bort mellanslagen kring operat�r.
UPDATE SuccessfulMissions
SET Operator = TRIM(Operator)

GO
--Skriv en select query som tar ut, grupperar, samt sorterar p� kolumnerna
--�Operator� och �Mission type� fr�n �SuccessfulMissions�. Som en tredje kolumn
--�Mission count� i resultatet vill vi ha antal uppdrag av varje operat�r och typ. Ta
--bara med de grupper som har fler �n ett (>1) uppdrag av samma typ och operat�r.

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
--Ta ut samtliga rader och kolumner fr�n tabellen �Users�, men sl� ihop �Firstname�
--och �Lastname� till en ny kolumn �Name�, samt l�gg till en extra kolumn �Gender�
--som du ger v�rdet �Female� f�r alla anv�ndare vars n�st sista siffra i personnumret
--�r j�mn, och v�rdet �Male� f�r de anv�ndare d�r siffran �r udda. S�tt in resultatet i
--en ny tabell �NewUsers�.
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

-- Visa inneh�llet i den nya tabellen
GO
-- Skriv en query som returnerar en tabell med alla anv�ndarnamn i �NewUsers�
--som inte �r unika i den f�rsta kolumnen, och antalet g�nger de �r duplicerade i
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
--Skriv en f�ljd av queries som uppdaterar de anv�ndare med dubblerade
--anv�ndarnamn som du fann ovan, s� att alla anv�ndare f�r ett unikt
--anv�ndarnamn. D.v.s du kan hitta p� nya anv�ndarnamn f�r de anv�ndarna, s�
--l�nge du ser till att alla i �NewUsers� har unika v�rden p� �Username�.
-- Skapa en tempor�r tabell med duplicerade anv�ndarnamn och antalet f�rekomster
-- Drop the #Duplicates table if it exists
IF OBJECT_ID('tempdb..#Duplicates') IS NOT NULL
    DROP TABLE #Duplicates;

-- Skapa en tempor�r tabell med duplicerade anv�ndarnamn och antalet f�rekomster
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

-- Uppdatera anv�ndarnamnen i NewUsers f�r att g�ra dem unika
UPDATE U
SET
    U.Name = CONCAT(U.Name, '_', D.RowNum) -- L�gg till en unik identifierare
FROM
    NewUsers U
    INNER JOIN #Duplicates D ON U.Name = D.Name;

-- Visa det uppdaterade inneh�llet i NewUsers

GO
--Skapa en query som tar bort alla kvinnor f�dda f�re 1970 fr�n �NewUsers�
SELECT *
FROM NewUsers
WHERE 
    Gender = 'Female' 
    AND SUBSTRING(ID, 1, 4) < '1970';
	SELECT * FROM NewUsers;

GO

---- L�gg till en ny anv�ndare i NewUsers

-- L�gg till en ny anv�ndare i NewUsers
INSERT INTO NewUsers (Name, Gender, ID)
VALUES ('Andrea Andersson', 'Male', '900101-1234');
SELECT * FROM NewUsers;

GO
--Skriv en query som returnerar tv� kolumner �gender� och �average age�, och tv�
-- Returnera genomsnitts�ldern f�r m�n och kvinnor fr�n NewUsers
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