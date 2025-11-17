USE TestAAG2
GO

EXEC DBA..FixOrphanedDBusers TestAAG2

--EXEC FixOrphanedDbusersAllDatabases

--ALTER USER RedShirt WITH LOGIN = RedShirt
--ALTER USER Redshirt2 WITH LOGIN = Redshirt2