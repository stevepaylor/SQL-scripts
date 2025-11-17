/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [WsProfileId]
      ,[WsProfileName]
      ,[IsInactive]
      ,[CreatedDtm]
      ,[CreatedBy]
      ,[ModifiedDtm]
      ,[ModifiedBy]
      ,[DataRowVersion]
  FROM [CMP13].[dbo].[tWsProfile]
  where WsProfileName like '%ClubProfile2%'


 --- select * from tWsProfileSetting
 -- where WsProfileId= 5

  Declare @acct as int
  Set @acct=34

 select * FROM [CMP13].[dbo].[tWs]  where WsProfileId= @acct
	Delete [tWsProfile]    where WsProfileId= @acct
	Delete tWsProfileSetting   where WsProfileId= @acct

---		select * from  [tWsProfile]    where WsProfileId= 10000062




 



