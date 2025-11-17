SELECT TOP (1000) [ID]
      ,[ProcessID]
      ,[ProcedureName]
      ,[Start_Dt]
      ,[Finish_Dt]
      ,[IsError]
      ,[Message]
      ,[SQLQuery]
 FROM [iQ-Scheduling].[dbo].[Execution_Log]

 WHERE ProcedureName IN(
  'sp_Extract_Opera_Hotel_Info'
, 'sp_IQ_Marketing_Metrics_Update_EXT'
, 'sp_IQ_Marketing_Metrics_Update'
, 'sp_Update_Player_Daily_Totals_AcctDay'
, 'sp_Update_Player_Daily_Totals_GameDay'
, 'sp_Update_Player_Ratings'
, 'sp_Update_Player_Trips_AcctDay'
, 'sp_Update_Player_Trips_GameDay'
, 'sp_Extract_Offer_Detail_Data'
, 'sp_SDS_Update_IQC_Slot_Accounting'
)
AND Start_Dt >= '2023-09-01'

ORDER BY Start_Dt
