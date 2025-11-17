--(1) Using 4-part way, like you are doing:
--SELECT * FROM ``[MyLinkedServerHere].[Country_DB].[dbo].[Location_View]
--It is a most inefficient way. ☹

--(2) Using OPENQUERY():
--SELECT * FROM OPENQUERY (linkedServer, ‘Query’)
--Much more performant than #1 above, but still not the best.

--(3) Using EXECUTE ... AT [LinkedServerName]. For example:
--EXECUTE (N'SELECT * FROM [Country_DB].[dbo].[Location_View]') AT [LinkedServerName]
--It is a most performant way!!! Highly recommended to try. 😊