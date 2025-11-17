select a.PARTICIPATION_FEES,b.PARTICIPATION_FEES+b.LEASE_FEES as Total_Fee 
,b.PARTICIPATION_TYPE_CD,b.PARTICIPATION_CD,b.NET_SCALE_WIN_AMT,b.HAND_PAYS_AMT,b.cancel_credits,b.TICKET_OUT_AMT,b.SLOT_NET_WIN_AMT,b.*
from (SELECT AssetNumber, gamingdate,NET_SCALE_WIN_AMT,
HAND_PAYS_AMT as qlx_Hand_PAYS_AMT,TKT_OUT_AMT as qlx_TKT_OUT_AMT,SLOT_NET_WIN_AMT as qlx_slot_net_win_amt,Actual_Drop_AMT as qlx_Actual_Drop_AMT
,PARTICIPATION_FEES,Participation_Type_CD
  FROM [iQ-Gaming].[dbo].[V_IQC_Slot_CoinIn_Summary]
  where --assetnumber = 42026 and
  gamingdate >= '2022-01-01' and gamingdate<getdate()  and DaysOnFloor = 1
 and Manufacturer<>'VGT' 
  )a
inner join(
  SELECT *
  FROM [MSBIDB02DV].[vDW].[slot].[tab_daily_perf_fact]
where gaming_date >= '2022-01-01'  and DAYS_ONLINE = 1
)b
on a.AssetNumber = b.slot_number and round(a.PARTICIPATION_FEES,2)<>round(b.PARTICIPATION_FEES+b.LEASE_FEES,2)
and a.GamingDate = b.gaming_date
