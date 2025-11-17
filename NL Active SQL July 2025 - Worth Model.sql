
--------------------------------------------------------------------------------------------------------------------------
---- Change the Date in Row 238 and beyond!!!!!!!!!!!!!!!!!!!!!!
-------------------------------------------------------------------------------------------------------------------------

USE [iQ-Gaming]
DROP TABLE IF Exists #TempActivity	
SELECT	PD.PLAYER_ID AS PLAYERID,
	PD.PLAYER_ACCOUNT_NUMBER,
	PD.PLAYER_FIRST_NAME AS FIRSTNAME,
	PD.PLAYER_LAST_NAME AS LASTNAME,
	PD.PLAYER_BIRTHDATE AS DOB,
	PD.PLAYER_AGE,
	ISNULL(PD.PLAYER_EMAIL,'') AS EMAIL,
	PD.PLAYER_ADDRESS1 AS ADDRESS1,
	ISNULL(PD.PLAYER_ADDRESS2,'') AS ADDRESS2,
	PD.PLAYER_CITY AS CITY,
	PD.PLAYER_STATE AS [STATE],
	PD.PLAYER_COUNTRY AS COUNTRY,
	PD.PLAYER_ZIP AS ZIPCODE,
	ISNULL(PD.PLAYER_GEO_DISTANCE, 1) AS DISTANCE,
	PD.PLAYER_GEO_DISTANCE_CATEGORY AS DISTCAT,
	PD.PLAYER_ISNOMAIL AS ISNOMAIL,
	PD.PLAYER_ISINACTIVE AS ISINACTIVE,
	PD.PLAYER_ISCLUBHOLD AS ISCLUBHOLD,
	PD.PLAYER_ISBANNED AS ISBANNED,
	Cast(0 as Int) as ISOFFEREXCLUDED,
	Cast(0 as Int) as ISHOTELBANNED,
	PD.PLAYER_CLUB_LEVEL AS TIER,
	PD.PLAYER_HOST AS HOST,
	DateAdd(dd, 1, EOMONTH(dateadd(mm,-3,PD.PLAYERLASTDATE_3MONTHLGD)))as FGD,
	PD.PLAYERLASTDATE_3MONTHLGD AS LGD,
	EOMonth(PD.PLAYERLASTDATE_3MONTHLGD) as LGD_EOM,
	PD.WORTH_GROSS_3MONTHLGD as Old_Gross_Worth_3monthLGD,
	PD.VISITS_3MONTHLGD,
	ISNULL(CompReinvestHistNoHotel, 0) as ReinvestmentPercent,
	PD.AMV_3MONTHLGD,
	PD.ADP_3MONTHLGD,
	PD.AMP_3MONTHLGD,
		PD.FP_3MONTHLGD,
Cast (0.0 as Decimal(10,2)) as Profit_Seg_nbr,
Cast ('' as Varchar(3)) as Profit_Seg_Type,
Cast(0 as Int) as Profit_Offer,
Cast(0.00 as Decimal(10,2)) as Expenses_L3MoLGD,
PD.PLAYERTYPE_3MONTHLGD AS PLAYERTYPE,
Case when PD.NewAMW_3MonthLGD = 0 then 0 else Round(PD.NewNetWorth_3monthLGD/PD.NewAMW_3monthLGD,0)  END as Active_Months,
PD.Total_Theo_3monthLGD,
Cast(0.00 as Decimal(10,2)) as  ETG_Theo,
	PD.NewNetActual_3monthLGD,
	PD.NewNetWorth_3monthLGD,
	PD.NewADW_3monthLGD,
	PD.NewAMW_3monthLGD,
	CASE WHEN PD.TABLE_THEO_6MONTH > 0 THEN 'YES' ELSE 'NO' END  AS 'PLAYSTABLES',
	CONVERT(VARCHAR(10), GETDATE(), 101) AS [ACCOUNT UPDATE AS-OF DATE],
	PD.PLAYER_POINT_BAL,
	ACTIVITY,
	M1.Offer as ADW_Offer, M1.Segment as ADW_Segment, M2.Offer as AMW_Offer, M2.Segment as AMW_Segment
into #TempActivity	
FROM [iQ-Gaming].[Tableau].[player_dim] PD WITH (NOLOCK)
LEFT JOIN VDW4.dbo.Matrix_NL_Worth_Active M1 on M1.Seg_Type = 'ADW' and  	ISNULL(PD.PLAYER_GEO_DISTANCE, 1)  between M1.Distance_Min and M1.Distance_Max
		and NewADW_3monthLGD between M1.Range_Min and M1.Range_Max
LEFT JOIN VDW4.dbo.Matrix_NL_Worth_Active M2 on M2.Seg_Type = 'AMW' and  	ISNULL(PD.PLAYER_GEO_DISTANCE, 1)  between M2.Distance_Min and M2.Distance_Max
		and NewAMW_3monthLGD between M2.Range_Min and M2.Range_Max
WHERE
	(ISNULL(PD.PLAYERLASTDATE_3MONTHLGD, '1/1/1900') >= DATEADD(MONTH, -12, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) OR PD.PLAYER_CLUB_LEVEL IN ('PLATINUM', 'INFINITY'))
	AND PD.PLAYER_ACCOUNT_NUMBER <> 0
	AND PD.PLAYER_FIRST_NAME NOT LIKE '%VJC-%'
	AND PD.PLAYER_TYPE NOT IN ('EXCLUDED')
	AND PD.PLAYER_TYPE NOT LIKE '%GIFT%'
	order by pd.player_id



---  Adding Expenses to #TempActivity
UPDATE #TempActivity
SET Expenses_L3MoLGD = Expenses 
From #TempActivity  CM 
JOIN 	
(SELECT
                PD.PlayerID,
                PD.FirstName + ' ' +PD.LastName AS Guest,
				PD.LGD,
              ISNULL(  CASE WHEN SUM(award_FPUsed) < SUM(award_FPAwarded_PromoWinner + award_FPAwarded_ServiceRecovery) THEN 0 ELSE (SUM(award_FPUsed) - SUM(award_FPAwarded_ServiceRecovery + award_FPAwarded_PromoWinner)) END
                                + (SUM(Award_PromoChipsUsed_Total) - SUM(award_PromoChipUsed_PromoWinner + award_PromoChipUsed_ServiceRecovery))
                                + (SUM(award_Cash_Total) - SUM(award_Cash_Promowinner))
                                + (SUM(Award_Comp_Total) - SUM(award_Merchandise_PromoWinner + award_Comp_ServiceRecovery))
                                + (SUM(award_FB_Total) - SUM(award_FB_PromoWinner + award_FB_ServiceRecovery + award_FB_HostDine + [award_FB_PlatBenefit]))
                                + SUM(Hotel_CompsNoRooms_GrossAmount),0)
AS EXPENSES
FROM #tempActivity PD
LEFT JOIN [iQ-Gaming].[dbo].[v_IQC_Awards] AW ON PD.playerid = AW.playerID AND AW.GamingDate BETWEEN PD.FGD AND LGD_EOM 
GROUP BY         
                PD.playerid,
                PD.FirstName + ' ' +PD.LastName,
				PD.LGD)  EX  	On CM.PlayerID = EX.PlayerID

---------Appending Exclusion Flags
Update #TempActivity 
Set ISOFFEREXCLUDED = 1
From #TempActivity TA
JOIN [iQ-Gaming].[CMP_13-1].[TPLAYERTAG] PT on TA.PlayerID = PT.PlayerID
where TagId = 10281792 AND PT.IsInactive = 0


Update #TempActivity 
Set ISHOTELBANNED = 1
From #TempActivity TA
JOIN [iQ-Gaming].[CMP_13-1].[TPLAYERTAG] PT on TA.PlayerID = PT.PlayerID
where TagId = 10294981 AND PT.IsInactive = 0


Update #TempActivity 
Set ETG_Theo = ET.ETGTheo
From #TempActivity T
JOIN (
Select Acct, Sum(TheorWin) as ETGTheo
FROM [CMKTDB13DPR].[CMP13].[dbo].[tSlotRating] tSR WITH (NOLOCK)
JOIN  [CMKTDB13DPR].[CMP13].[dbo].[tPlayerCard] PC on tSR.PlayerID = PC.PlayerID
Join #TempActivity CM on CM.PLAYER_ACCOUNT_NUMBER = PC.Acct	
Where tSR.GameID = 25 and IsVoid = 0 and GamingDt between CM.FGD and CM.LGD
Group By Acct ) ET on T.player_account_number = ET.Acct


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/** Step Two - Create final variations based on Core Mailer type (Active, Outer Market and Inactive) and remove all other accounts**/



/*Step Three - Find Active NL Offers by ADP (<6 Trips) */

--ADPType 0-5 Trips
Update #TempActivity

Set 
Profit_Seg_nbr = m.Segment_num,
Profit_Seg_Type =  m.Seg_Type,
Profit_offer  = m.Offer 

FROM #TempActivity cm
JOIN [vDW4].[dbo].[Matrix_Newsletter]  m on cm.[ADP_3monthLGD] between m.Range_Min AND m.Range_Max AND cm.AMV_3monthLGD between m.Trip_Min AND m.Trip_Max 
	AND (cm.distance between m.Distance_Min AND m.Distance_Max)

Where 
(cm.[ADP_3monthLGD] >=5)
AND (cm.AMV_3monthLGD < 6)
AND cm.Activity = 'active'


/*Step Four - Find Active NL Offers by AMP (6+ Trips)*/

Update #TempActivity

Set 
Profit_Seg_nbr = m.Segment_num, Profit_Seg_Type =  m.Seg_Type, Profit_offer  = m.Offer 

FROM #TempActivity cm
JOIN [vDW4].[dbo].[Matrix_Newsletter]  m on cm.[AMP_3monthLGD] between m.Range_Min AND m.Range_Max AND cm.AMV_3monthLGD between m.Trip_Min 
	AND m.Trip_Max AND (cm.Distance between m.Distance_Min AND m.Distance_Max)
Where (cm.[AMP_3monthLGD] >=100)  AND (cm.AMV_3monthLGD >= 6) and Activity = 'Active'

----------------------------------------------------        Inactive Offers
---------------------------------------------------  Inactive ADP
Update #TempActivity

Set 
Profit_Seg_nbr = m.Segment_num, Profit_Seg_Type =  m.Seg_Type, Profit_offer  = m.Offer 


FROM #TempActivity cm
JOIN [vdw4].[dbo].[Matrix_InactiveMarket]  m 
on cm.[ADP_3monthLGD] between m.Range_Min AND m.Range_Max AND cm.AMV_3monthLGD between m.Trip_Min AND m.Trip_Max AND (cm.distance between m.Distance_Min AND m.Distance_Max)

Where 
(cm.[ADP_3monthLGD] >=50)
AND (cm.AMV_3monthLGD < 6)
AND cm.Activity = 'inactive'
and cm.playertype in ('Slot', 'table')


-----------------------------------------------------  Inactive AMV
Update #TempActivity

Set 
Profit_Seg_nbr = m.Segment_num, Profit_Seg_Type =  m.Seg_Type, Profit_offer  = m.Offer 
FROM #TempActivity cm
JOIN [vdw4].[dbo].[Matrix_InactiveMarket]  m 
on cm.ADP_3monthLGD between m.Range_Min AND m.Range_Max AND cm.AMV_3monthLGD between m.Trip_Min AND m.Trip_Max AND (cm.Distance between m.Distance_Min AND m.Distance_Max)
Where 
(cm.ADP_3monthLGD >=200)
AND (cm.AMV_3monthLGD >= 6)
and Activity = 'inactive'
and cm.playertype in ('Slot', 'table')

-------------------------------------------    Out Of Marketing Append for Profit Segment
Update #TempActivity
Set 
Profit_Seg_nbr = m.Segment_num, Profit_Seg_Type =  m.Seg_Type, Profit_offer  = m.Offer 
FROM #TempActivity cm
JOIN [vdw4].[dbo].[Matrix_OuterMarketNew]  m on cm.ADP_3monthLGD  between m.Range_Min AND m.Range_Max AND cm.AMV_3monthLGD between m.Trip_Min AND m.Trip_Max AND (cm.Distance between m.Distance_Min AND m.Distance_Max)
Where (cm.ADP_3monthLGD >=15) and Activity = 'OuterMarket'  and cm.playertype in ('Slot', 'table')


---------------------------------------------------------------------------------------------
/*Defining a new setment for players with a 75% reinvestment rate*/

Update #TempActivity
Set Profit_offer = 0, Profit_Seg_nbr = Profit_Seg_nbr +20, Profit_Seg_Type = 'ADP'
Where ReinvestmentPercent >.75

-------------------------------------------------------------------------------------------------------------------------------------------
/*Get Hotel Data for Active Newsletter*/
drop table IF Exists #TempActivity2
Select nl.*, Case When ADW_Segment<=AMW_Segment then ADW_Segment Else AMW_Segment end as Worth_Segment,
Case When ADW_Segment<=AMW_Segment then ADW_Offer Else AMW_Offer end as Worth_Offer,
Case When ADW_Segment<=AMW_Segment then 'ADW' Else 'AMW' end as Worth_Seg_Type,
CASE   WHEN ISHOTELBANNED = 1 then 'I'
		WHEN (NewADW_3monthLGD) >= 1500 OR NewAMW_3monthLGD >= 15000 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AX'
       WHEN NewADW_3monthLGD >= 750 OR NewAMW_3monthLGD >= 11250 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AA'
       WHEN NewADW_3monthLGD >= 450 OR NewAMW_3monthLGD >= 6750 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AB'
       WHEN NewADW_3monthLGD >= 300 OR NewAMW_3monthLGD >= 4500 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AC'
       WHEN NewADW_3monthLGD>= 225 OR NewAMW_3monthLGD >= 3375 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AD'
       WHEN NewADW_3monthLGD>= 175 OR NewAMW_3monthLGD >= 2625 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AE'
       WHEN NewADW_3monthLGD>= 150 OR NewAMW_3monthLGD >= 2250 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AF'
       WHEN NewADW_3monthLGD >= 100 OR NewAMW_3monthLGD >= 2000 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AG'
       WHEN NewADW_3monthLGD >= 75 OR NewAMW_3monthLGD >= 1000 THEN 'HL' + FORMAT(DATEADD(MONTH, 1, GETDATE()), 'yyMM') + 'AH'
ELSE 'I'END 'Worth_Hotel_Seg'
Into #TempActivity2
from #TempActivity nl
--LEFT JOIN [IQ-Gaming].[dbo].[v_IQC_Awards] p on p.playerID = pd.player_id AND p.gamingdate between pd.DateRangeStart_3monthLGD AND pd.DateRangeEnd_3monthLGD


Select *
From #TempActivity2

Drop Table if Exists VDW4.Dbo.Coremailers_2507_Test
Select * 
INTO VDW4.Dbo.Coremailers_2507_Test
From #TempActivity2


---------------------Active Offers

Select *
From VDW4.Dbo.Coremailers_2507_Test
Where Activity = 'Active' 
and ISBANNED = 0 and ISCLUBHOLD = 0 and ISINACTIVE = 0 and ISOFFEREXCLUDED = 0 and Worth_Offer >0 and Host <> 'INDEPENDENT REP, INDEPENDENT'
and (Worth_Offer >5 or (Worth_Offer = 5 and  ISNULL(Email,'No@Viejas.Com') not like '%no@vie%'))
and player_account_number = 21306893

---------------------Inactive Offers
Select *
From VDW4.Dbo.Coremailers_2507_Test
Where Activity = 'Inactive'
and ISBANNED = 0 and ISCLUBHOLD = 0 and ISINACTIVE = 0 and ISOFFEREXCLUDED = 0 and Worth_Offer >0 and Host <> 'INDEPENDENT REP, INDEPENDENT'
and PlayerType in ('Slot', 'Table') and NewADW_3monthLGD >= 50
Order By ADW_Segment

---OuterMarket
Select *
From VDW4.Dbo.Coremailers_2507_Test
Where Activity = 'OuterMarket'
and ISBANNED = 0 and ISCLUBHOLD = 0 and ISINACTIVE = 0 and ISOFFEREXCLUDED = 0 and Worth_Offer >0 and Host <> 'INDEPENDENT REP, INDEPENDENT'
and PlayerType in ('Slot', 'Table') and NewADW_3monthLGD >= 50



Select *
From VDW4.Dbo.Coremailers_2507_Test
Where player_account_number = 994