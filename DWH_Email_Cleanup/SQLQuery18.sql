/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PlayerId]
      ,[ContactTypeId]
      ,[EmailAddress]
      ,[IsEmailSend]
      ,[IsInactive]
      ,[CreatedDtm]
      ,[CreatedBy]
      ,[ModifiedDtm]
      ,[ModifiedBy]
      ,[DataRowVersion]
      ,[DeletedFromCMP13_TS]
      ,[email_bounce_dttm]
      ,[recipient_domain_nm]
      ,[reason_txt]
  FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_HardBounce_Deletes]


SELECT 
  [DeletedFromCMP13_TS]
, COUNT(*)
FROM [Viejas_Custom_Processes].[dbo].[tPlayerEmail_HardBounce_Deletes]

GROUP BY
  [DeletedFromCMP13_TS]