	select 
		tr.PlayerID,
		tr.IsVoid , 
		tr.GamingDt ,
		tr.DeptID,
		tr.GroupID ,
		case when tpp.BasePts is not NULL then tpp.BasePts else 0 end 'BasePts',

		taw.TranID 'TrMasID', --set to tAwards table tranId
		tr.TranId 'ItemID', --set to tslotrating table tranId . No itemId IN 13.X
 
		from dbo.tslotrating tr (NOLOCK)
			left join tawards taw (NOLOCK) ON taw.RelatedTranId = tr.tranid
			left JOIN tPlayerPoints tpp (nolock) ON tpp.TranId = taw.tranid

WHERE tr.PlayerID = 945715
  AND tr.IsVoid <> 1
  AND tr.GamingDt = '2014-06-09'
  ----AND tr.GroupID <> 1

ORDER BY
		tr.PlayerID,
		tr.IsVoid , 
		tr.GamingDt 