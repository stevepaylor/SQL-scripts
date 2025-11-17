/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [iQ-Gaming].[dbo].[v_IQB_Transactions] bt

  ---left join CMKTDB13CPR.CMP13.dbo.viewplayersviejas vp on bt.playerID = vp.playerid
  where TxnID=2421563


  select top 100 * from CMKTDB13CPR.CMP13.dbo.viewplayersviejas
  where acct=20189776


Declare @TrxID int
Set @TrxID=2421564

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT acct, lastname, *
  FROM [iQ-Gaming].[dbo].[v_IQB_Transactions] bt
  left join IQB_Player_ID pod on bt.PlayerID = pod.PlayerID
  left join CMKTDB13CPR.CMP13.dbo.viewplayersviejas vp on vp.acct = pod.MembershipNum
  where TxnID=@TrxID

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT  *
  FROM [iQ-Gaming].[dbo].[v_IQB_Transactions] bt
  --left join IQB_Player_ID pod on bt.PlayerID = pod.PlayerID
  --left join CMKTDB13CPR.CMP13.dbo.viewplayersviejas vp on vp.acct = pod.MembershipNum
  where TxnID=@TrxID



SELECT *
FROM [iQ-Gaming].[dbo].v_IQB_Transaction_Detail bt
where TxnID=@TrxID

--select top 10 * from IQB_Player_ID
--where PlayerID=8508
