--- TABLE GAMES
SELECT TOP (1000) *
  FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings]
where playerid='261636' and GamingDate='2021-11-12' and GameType<>'S' and AssetNumber=10012181
order by TransactionID asc
Go
select top 100 * from  [CMKTDB13CPR].[cmp13].[dbo].tTableRating tr inner join [CMKTDB13CPR].[cmp13].[dbo].tlocn tl on tr.locnid = tl.locnid
where playerid='261636' and GamingDt = '2021-11-12' and tl.LocnID=10012181---and isVoid=0
order by tranid asc




--- SLOTS  1079246	2021-07-17	60004336
SELECT TOP (1000) *
  FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings]
where playerid='10473557' and GamingDate='2021-11-18' ---and GameType<>'S' and AssetNumber=10012181
order by TransactionID asc


--- SLOTS  1079246	2021-07-17	60004336
SELECT sum(WinLossAmount)
  FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings]
where playerid='10473557' and GamingDate='2021-11-18' ---and GameType<>'S' and AssetNumber=10012181


--176.99

--SELECT TOP (1000) *
--  FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings]
--where TransactionID='10891546333'
--order by TransactionID asc


Go
select top 100 * from  [CMKTDB13CPR].[cmp13].[dbo].tSlotRating tr inner join [CMKTDB13CPR].[cmp13].[dbo].tlocn tl on tr.locnid = tl.locnid
where playerid='10473557' and GamingDt = '2021-11-18' ---and TranID='10891546333'---and tl.LocnID=10012181---and isVoid=0 and 
order by tranid asc

select sum(casinoWin)  from  [CMKTDB13CPR].[cmp13].[dbo].tSlotRating tr inner join [CMKTDB13CPR].[cmp13].[dbo].tlocn tl on tr.locnid = tl.locnid
where playerid='10473557' and GamingDt = '2021-11-18' ---and TranID='10891546333'---and tl.LocnID=10012181---and isVoid=0 and 




10473557	2021-11-18	21117566	-23.3185	0.0000	0.00	15238.0800	0.0000	0.00






--select sum(theoreticalWin)
--  FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings]
--where playerid='261636' and GamingDate='2021-11-12' and GameType<>'S'

---342.0375

--select top 100 * from  [CMKTDB13CPR].[cmp13].[dbo].tTableRating tr inner join [CMKTDB13CPR].[cmp13].[dbo].tlocn tl on tr.locnid = tl.locnid
--where tranid='10925516669'