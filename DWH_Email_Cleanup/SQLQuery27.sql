/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [PlayerID]
      ,[email_bounce_dttm]
      ,[recipient_domain_nm]
      ,[reason_txt]
  FROM [DBM].[dbo].[Email_HardBounce]

ORDER BY email_bounce_dttm DESC