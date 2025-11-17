/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [status]
      ,[source]
      ,[start_time]
      ,[error_message]
  FROM [vDW].[maint].[v_package_fail]

WHERE [start_time] >= '2022-03-25'

ORDER BY [start_time] ASC

--SSIS Error Code DTS_E_OLEDBERROR.  An OLE DB error has occurred. Error code: 0x80004005.
--An OLE DB record is available.  Source: "Microsoft SQL Server Native Client 11.0"  Hresult: 0x80004005  
--Description: "Cannot continue the execution because the session is in the kill state.".

--SSIS Error Code DTS_E_OLEDBERROR.  An OLE DB error has occurred. Error code: 0x80004005.
--An OLE DB record is available.  Source: "Microsoft SQL Server Native Client 11.0"  Hresult: 0x80004005  
--Description: "Cannot continue the execution because the session is in the kill state.".
