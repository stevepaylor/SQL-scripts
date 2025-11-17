SELECT DISTINCT 
 loginname AS loginnameV
,'Yes' AS 'Verified'

INTO #Login_Verified_In_Use

FROM DBA.dbo.DBActivity

WHERE loginname NOT LIKE '%\%'
  AND loginname NOT IN ('initialize','DBAdmin','ITappsDBA')
  --AND hostname <> @@SERVERNAME
  --AND hostname NOT LIKE '%ITD%'
  --AND hostname NOT IN ('DBAMDB01UT')
  AND DATEDIFF(DD,logintime,CURRENT_TIMESTAMP) < 365  -- Ignore connections older than 180 days
  --AND dbname NOT IN ('master','tempdb','msdb')

ORDER BY
  loginname

--SELECT *
--FROM #Login_Verified_In_Use 

SELECT 
  loginname
  --COALESCE(NULLIF(Address.COUNTRY,''), 'United States')
, COALESCE(NULLIF((SELECT Verified from #Login_Verified_In_Use WHERE loginname = loginnameV),''), 'No') AS 'Verified Used In The Last Year'
 
FROM sys.syslogins

WHERE password IS NOT NULL
  AND loginname NOT LIKE '##%'
  AND loginname NOT IN ('DBAdmin','ITappsDBA')


DROP TABLE
#Login_Verified_In_Use
GO