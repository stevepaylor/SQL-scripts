/****************************************************************************************************************************************
Viejas: Re-run for Failed ETL job

This document explains the steps on how to troubleshoot a failed job (stored procedure) for SQL Agent Server job “QLX – Run Daily Batch”. 
This job is scheduled to run daily at 6 AM PT and finish within 90 minutes.  Users receives email notification when daily job finishes. 
When one or more daily ETL jobs failed, and the email highlights failed jobs and attaches error messages.  
If there’s no data structure or data type changes in source system or destination data warehouse, by following this guide should resolve 
most of the failed jobs.  If there’s any changes done at the source system or destination data warehouse, necessary modifications and 
testing need to be done first.

1.	Locate failed job

[iQ-Shcheduling].[dbo].[Execution_log] contains history of executed stored procedures.

Below query returns the most recent error logs. 
******************************************************************************************************************************************/

Select *
FROM [iQ-Scheduling].[dbo].[Execution_Log]
Where isError = 1
Order by Finish_dt desc

/****************************************************************************************************************************************
2.	Reset parameters

Once locate the failed ProcedureName from step 1, Submitted, Completed, and isError need to be reset in 
table [iQ-Shcheduling].[dbo].[Job_Dependencies] and [iQ-Shcheduling].[dbo].[Job_Flows]

Run below query to reset the parameters on [iQ-Shcheduling].[dbo].[Job_ Flows]
******************************************************************************************************************************************/

Update [iQ-Scheduling].[dbo].[Job_Flows]
Set Submitted=0, Completed=0, isError=0
Where [Enabled]=1 
     and Frequency='D'    
     and Submitted = 1
    and isError = 1 
     and FlowName in (
			Select distinct FlowName
			From [iQ-Scheduling].[dbo].[Job_Dependencies]
			Where [Enabled]=1 
				--and ProcedureName='<from step 1>'
				--and FlowName not like '%[_]H'
				and isError = 1)

--  Run below query to reset the parameters on [iQ-Shcheduling].[dbo].[Job_Dependencies]

Update [iQ-Scheduling].[dbo].[Job_Dependencies]
Set Submitted=0, Completed=0, isError=0
Where [Enabled]=1 
     --and ProcedureName='<from step 1>'
     --and FlowName not like '%[_]H'
     and isError = 1
     and Submitted = 1

/****************************************************************************************************************************************
3.	Execute job

Locate job “QLX – Run_Daily_Batch”, and right click, and then select “Run from Step”. And then select step 2, and click OK.

The Daily batch job will pick up from it was failed and continue to finish

******************************************************************************************************************************************/
