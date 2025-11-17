SELECT 
  u.username
--, c.modifiedbyid
, c.modifieddate
, c.[name] as ReportName
, c.[path] as ReportPath
--, u.userid

FROM ReportServer.dbo.[catalog] c 
JOIN ReportServer.dbo.users u 
ON u.userid= c.modifiedbyid

--Add where condition if you want to see modifieddate and modified by user for a specific report
--where name ='TestReport' 
