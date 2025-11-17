--SELECT name, sid 
--FROM sys.server_principals 
--WHERE name = 'CASI_Link'

--USE [CMP13]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [CMPAPI]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [CMPSDS]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [dbInfogenesis]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [master]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [TV13]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [TVAlert13]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link

--USE [vCMSUpdate]
--GO
--ALTER USER CASI_Link WITH LOGIN = CASI_Link


--SELECT name, sid 
--FROM sys.server_principals 
--WHERE name = 'CMP13_Reader'

--USE [CMP13]
--GO
--ALTER USER CMP13_Reader WITH LOGIN = CMP13_Reader


--SELECT name, sid 
--FROM sys.server_principals 
--WHERE name = 'datareader'

USE [CMP13]
GO
ALTER USER datareader WITH LOGIN = datareader

USE [CMPSDS]
GO
ALTER USER datareader WITH LOGIN = datareader

USE [dbInfogenesis]
GO
ALTER USER datareader WITH LOGIN = datareader

USE [TV13]
GO
ALTER USER datareader WITH LOGIN = datareader

USE [TVAlert13]
GO
ALTER USER datareader WITH LOGIN = datareader




USE [CMP13]
GO
ALTER USER [VIEJAS\datamart] WITH LOGIN = [VIEJAS\datamart]
