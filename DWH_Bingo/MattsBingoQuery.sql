Select Cast(ExternalPlayerID as INT) as PlayerID, Count(*) as Wins, Sum(Value) as Awards
From Bingo.HMS_Org_1.dbo.payTxn pt  -- Payout Table
LEFT JOIN Bingo.HMS_Org_1.dbo.paytxntype ptt on pt.TxntypeID = ptt.txnTypeID
JOIN Bingo.HMS_Global.dbo.g_PlcPlayers P on pt.PlayerID = P.PlayerID  -- Player Table
Where BusinessDay >= '2023-01-01'
Group By Cast(ExternalPlayerID as INT)
Order By 3 Desc
