/*******************************************************************************************************************************************
Viejas: Re-run for Failed ETL job

This document explains the steps on how to troubleshoot a failed job (stored procedure) for SQL Agent Server job “QLX – Run Daily Batch”.
This job is scheduled to run daily at 6 AM PT and finish within 90 minutes.

Users receives email notification when daily job finishes. When one or more daily ETL jobs failed, and the email highlights failed jobs and
attaches error messages.

If there’s no data structure or data type changes in source system or destination data warehouse, by following this guide should resolve most
of the failed jobs.

If there’s any changes done at the source system or destination data warehouse, necessary modifications and testing need to be done first.

********************************************************************************************************************************************
1.	Locate failed job

	[iQ-Shcheduling].[dbo].[Execution_log] contains history of executed stored procedures. 
	Below query returns the most recent error logs. 
*******************************************************************************************************************************************/

SELECT *
FROM [iQ-Scheduling].dbo.Execution_log
WHERE isError = 1
ORDER BY Finish_dt DESC

/*******************************************************************************************************************************************
2.	Reset parameters

Once locate the failed ProcedureName from step 1, Submitted, Completed, and isError need to be reset in table 
[iQ-Shcheduling].[dbo].[Job_Dependencies] and [iQ-Shcheduling].[dbo].[Job_Flows]

Run below query to reset the parameters on [iQ-Shcheduling].[dbo].[Job_ Flows]
*******************************************************************************************************************************************/

-- this query shows you all of the potential job_flows that could be updated in the UPDATE command

------SELECT
------  jf.Submitted
------, jf.Completed
------, jf.isError
------, jf.[Enabled]
------, jf.Frequency
------, jf.Submitted
------, jf.FlowName
------, jd.FlowName AS jd_FlowName
------, jd.[Enabled] AS jd_Enabled
------, jd.ProcedureName AS jd_ProcedureName

------FROM [iQ-Scheduling].dbo.Job_Flows jf
------LEFT OUTER JOIN [iQ-Scheduling].dbo.Job_Dependencies jd
------ON jf.FlowName = jd.FlowName

------WHERE jf.[Enabled] = 1 
------  AND jf.Frequency = 'D'    
------  AND jf.Submitted = 1
------  AND jf.isError = 1 
------  AND jd.[Enabled] = 1 
------  AND jd.ProcedureName ='<from step 1>'
------  AND jd.FlowName NOT LIKE '%[_]H'
------  AND jd.isError = 1

-- this is the actual UPDATE command that is used to reset the job_flows that need to be re-run

UPDATE [iQ-Scheduling].dbo.Job_Flows
SET Submitted=0, Completed=0, isError=0
WHERE [Enabled] = 1 
  AND Frequency= 'D'    
  AND Submitted = 1
  AND isError = 1 
  AND FlowName IN 
    (SELECT DISTINCT FlowName
     FROM [iQ-Scheduling].dbo.Job_Dependencies
     WHERE [Enabled] = 1 
       AND ProcedureName ='sp_CMP_Update_IQC_Comp_Dimensions'
       AND FlowName NOT LIKE '%[_]H'
       AND isError = 1)

-- this is to set the values back to original if a mistake is made - Update is done specified FlowName

------UPDATE [iQ-Scheduling].dbo.Job_Flows
------SET Submitted=1, Completed=1, isError=0
------WHERE[Enabled]= 1
------  AND FlowName = 'CMP_iQC'
