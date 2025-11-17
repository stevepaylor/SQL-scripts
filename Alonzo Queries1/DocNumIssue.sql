select top 100 trancode, DocumentNo, * from tVouchers tv inner join ttrancode tc on tv.TrancodeID = tc.trancodeid
---where Trancode='CANFILL'
where Trancode='RQFILL'
order by voucherid desc

GO

select top 1000 DocumentNo, Trancode, 
		DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), ta.PostDtm) 'PostDtm',
* from tAccounting ta inner join tTranCode tt on ta.TranCodeID = tt.TranCodeId
--where TranId=10944010417
where Trancode='RQFILL'
ORDER BY TranID DESC

--select top 100 * from tplayer where

--select top 100 * from tplayercard where acct=99999993

--select top 100 * from tplayer where playerid=1293143


select top 100 * from tWsProfile
where WsProfileName='CMKTProfile'






select  * from tNumberMaster where NumberCode like 'Document_Fl'
