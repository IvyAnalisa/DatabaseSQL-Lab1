# DatabaseSQL-Lab1
Manipulera data i befintlig databas med hjälp av SQL 
Inledning 
Vi vill skapa nya tabeller från befintliga data i databasen ”everyloop”, och sedan 
manipulera och ta ut data från dessa nya tabeller med hjälp av SQL. 
Laborationen redovisas i form av ett (1) SQL-script som steg för steg löser 
uppgifterna i den ordning som de finns beskrivna nedan. Varje steg ska avskiljas 
med en blank rad, följt av ”GO”, följt av ytterligare en blank rad. Alltså: 
Select … GO 
Update … GO 
Etc ... 
MoonMissions 
Använd ”select into” för att ta ut kolumnerna ’Spacecraft’, ’Launch date’, ’Carrier 
rocket’, ’Operator’, samt ’Mission type’ för alla lyckade uppdrag (Successful 
outcome) och sätt in i en ny tabell med namn ”SuccessfulMissions”. 
GO 
I kolumnen ’Operator’ har det smugit sig in ett eller flera mellanslag före 
operatörens namn. Skriv en query som uppdaterar ”SuccessfulMissions” och tar 
bort mellanslagen kring operatör. 
GO 
Lite svårare: 
I ett flertal fall har värden i kolumnen ’Spacecraft’ ett alternativt namn som står 
inom parantes, t.ex: ”Pioneer 0 (Able I)”. Skriv en query som uppdaterar 
”SuccessfulMissions” på ett sådant sätt att alla värden i kolumnen ’Spacecraft’ 
endast innehåller originalnamnet, dvs ta bort alla paranteser och deras innehåll. 
Ex: ”Pioneer 0 (Able I)” → ”Pioneer 0”.
