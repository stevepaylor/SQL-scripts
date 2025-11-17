/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PayGroup]
      ,[FileNumber]
      ,[EffectiveDate]
      ,[DeductionCode]
      ,[DeductionAmount]
      ,[DeductionRate]
      ,[CreatedDTM]
      ,[TransmittedDTM]
      ,[GUID]
  FROM [LAWSON_EXTRACT].[dbo].[adp_TM_Deduction_Maintenance]

  where TransmittedDTM IS NULL
