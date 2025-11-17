SELECT 
 'File 1'
, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_1]

UNION

SELECT 
 'File 2'
, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_2]

UNION

SELECT 
 'File 3'
, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_3]

UNION

SELECT 
 'File 4'
, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_4]

UNION

SELECT 
 'File 5'
, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_5]

--UNION

--SELECT 
-- 'File 6'
--, MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_Start_End_Diff_minutes
--, MAX([Duration]/ 60000) as MAX_duration_minutes
--, MAX([Duration]) as MAX_duration
--FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_6]