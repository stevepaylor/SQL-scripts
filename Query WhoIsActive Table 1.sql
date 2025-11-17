SELECT TOP (1000) [dd hh:mm:ss.mss]
      ,[session_id]
      ,[sql_text]
      ,[login_name]
      ,[wait_info]
      ,[tran_log_writes]
      ,[CPU]
      ,[tempdb_allocations]
      ,[tempdb_current]
      ,[blocking_session_id]
      ,[blocked_session_count]
      ,[reads]
      ,[writes]
      ,[physical_reads]
      ,[query_plan]
      ,[used_memory]
      ,[status]
      ,[tran_start_time]
      ,[open_tran_count]
      ,[percent_complete]
      ,[host_name]
      ,[database_name]
      ,[program_name]
      ,[start_time]
      ,[login_time]
      ,[request_id]
      ,[collection_time]
  FROM [DBA].[dbo].[WhoIsActive]

  where database_name = 'LepideAD Audit_Nov2023'
    --and session_id = 109
	 and status not in ('runnable','suspended')

order by reads desc
