
Drop Table if Exists #Player
Select PC.Acct, P.FirstName+' '+P.LastName as PlayerName, P.Clubstate, CL.ClubLevelName as Tier, E.FirstName+' '+E.LastName as Host, 
Case When PT.TagID is not null then 1 else 0 end as Offer_Excluded, IsBanned, IsNoMail
INTO #Player
From [CMKTDB13DPR].CMP13.dbo.tplayer P
Join [CMKTDB13DPR].CMP13.dbo.tplayerCard PC on P.PlayerID = PC.PlayerID
LEFT Join [CMKTDB13DPR].CMP13.dbo.tplayerCasinoHost PCH on P.PlayerID = PCH.PlayerID
LEFT JOIN [CMKTDB13DPR].CMP13.dbo.tEMP E on PCH.PrimaryHostEMPID = E.EMPID
Join [CMKTDB13DPR].CMP13.dbo.tclublevels CL on P.Clubstate = CL.Clubstate
Left JOin [CMKTDB13DPR].CMP13.dbo.tplayerTag PT on P.playerID = Pt.PlayerID and Pt.tagID = 10281792 



Drop Table If Exists #Tribal
Select Acct, FirstName, LastName, P.ClubState, CL.ClubLevelName, T.TagName, PT.ModifiedDtm
INTO #Tribal
From [IQ-Gaming].[CMP_13-1].tPlayer P 
Join [IQ-Gaming].[CMP_13-1].tPlayerCard PC on P.PlayerID = PC.PLayerID
Join [IQ-Gaming].[CMP_13-1].tClubLevels CL on P.ClubState = CL.ClubState
LEFT JOin [IQ-Gaming].[CMP_13-1].tPlayerTag PT on P.PlayerID = PT.PlayerID and TagID = 10026890 and PT.IsInactive = 0
Left Join [IQ-Gaming].[CMP_13-1].ttag T on T.TagId = Pt.TagID 
Where IsNULL(TagName,'') = 'Viejas Tribal Group' or P.Clubstate in (58,59) and Acct < 99999000


USE vDW4
Drop Table if Exists #ActPlayers
Select PlayerID,Player_Account_Number as Acct
INTO #ActPlayers
from dbo.coremailers_2507_Test
Union 
Select PlayerID,Player_Account_Number
From dbo.Coremailers_2506_Final


Drop Table if Exists #CompFinal1
Select AP.Acct, 
P.PlayerName, 
--F1.[ACCOUNT UPDATE AS-OF DATE] as Curr_run,
--F2.[ACCOUNT UPDATE AS-OF DATE] as Prev_run,
ISNULL(Case When F1.Host = 'N/A' Then '' Else F1.Host  END,'') as Host,
ISNULL(F1.Tier,'') as Tier,
P.Offer_Excluded, F1.IsBanned, F1.IsNoMail, F1.ISOFFEREXCLUDED, F1.ISHOTELBANNED,
F1.LGD as CurrLGD,
F2.LGD as PrevLGD,
Case when F2.LGD is null then 'New' when F1.LGD = F2.LGD then 'Same' Else 'Change' END as LGD_Change,
--F2.Activity as Prev_Mailer,
ISNULL(NOH.Campaign, 'None')  as Prev_Mailer,
 ISNULL(F2.VISITS_3MONTHLGD,0) as Prev_Visits, 
ISNULL(NOH.Reinvestment,0) as Prev_reinvest_pct,
ISNULL(F2.ADP_3MONTHLGD,0) as Prev_ADP, 
ISNULL(F2.AMP_3MONTHLGD,0) as Prev_AMP, 
ISNULL(F1.NewNEtActual_3monthLGD,0) as Prev_Act, 
F2.Profit_Seg_Type as Prev_Profit_Type,
F1.Activity as Curr_Mailer,
ISNULL(F1.VISITS_3MONTHLGD,0) as Curr_Visits,
ISNULL(F1.AMV_3MONTHLGD,0) as Curr_AMV,
ISNULL(F1.Active_Months,0) as Active_Months,
F1.ReinvestmentPercent as Curr_reinvest_pct, 
F1.ADP_3MONTHLGD as Curr_ADP, 
F1.AMP_3MONTHLGD as Curr_AMP, 
f1.NewNEtActual_3monthLGD as Curr_Act, 
F1.ETG_Theo as Curr_ETG_Theo,
F1.Expenses_L3MoLGD as Curr_Expenses,
F1.Profit_Seg_Type as Curr_Profit_Type,
F1.Worth_Seg_Type as Curr_Worth_Type,
F2.Old_GROSS_Worth_3MONTHLGD as Prev_Worth_Profit, 
F1.Old_GROSS_Worth_3MONTHLGD as Curr_Worth_Profit,
F2.NewNetWorth_3monthLGD as Prev_Worth,
F1.NewNetWorth_3monthLGD as Curr_Worth,
F1.Distance as Geo_Distance,
Case When F1.Distance is null then 'Inner' When F1.Distance <30 Then 'Inner' else 'Outer' End as Geo_Group,
--ISNULL(F2.Offer_amt,0) as Prev_offer, --ISNULL(F2.Segment_Num,0) as Prev_Seg,
ISNULL(NOH2.FPOffer,0) as May_offer,
ISNULL(NOH.FPOffer,0)as Prev_offer,
--ISNULL(F1.Profit_Offer,0) as Curr_offer, --F1.Segment_Num as Curr_Seg,
 F1.Worth_Offer as Curr_Offer,
 Cast(0 as INT) as Step_Offer, 
 --Isnull(F1.Profit_Offer,0) - ISNULL(NOH.FPOffer,0) as Profit_Var,
 F1.Worth_Offer - Isnull(NOH.FPOffer,0) as Worth_Var,
 --F1.Worth_Offer -  Isnull(F1.Profit_Offer,0) as Curr_Worth_v_Profit_Var,
 F1.Worth_Hotel_Seg as Curr_Hotel_Seg, --Isnull(F1.Segment_Num,0) - ISNULL(F2.Segment_Num,0) as Seg_Var, 
 F2.Override_Flg
INTO #CompFinal1
From #ActPlayers AP
---- CHANGE THESE!!!!!!!!!!!!!!!!!!!!!!!!!------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
LEFT JOIN coremailers_2507_Test F1 on AP.Acct = F1.PLAYER_ACCOUNT_NUMBER
LEft Join Coremailers_2506_Final F2 on AP.Acct = F2.PLAYER_ACCOUNT_NUMBER
---------------------------------------------------------------------------------------------------------------------------------
--LEFT JOIN #LGD2 L on AP.PlayerID = L.Player_ID
--LEFT JOIN #LGD L2 on AP.PlayerID = L2.Player_ID
JOin #Player P on AP.Acct = P.Acct
--LEFT JOIN #Curr C on AP.Acct = C.Acct
--LEFT JOIN #PREV Pr on AP.Acct = Pr.Acct
LEFT JOIN Newsletter_Offer_Hist_2025 NOH on NOH.Acct = AP.Acct and OfferMonth = '6/1/2025'
LEFT JOIN NewsLetter_Offer_Hist_2025 NOH2 on NOH.Acct = AP.Acct and NOH2.OfferMonth= '5/1/2025'
Where F1.ISBANNED = 0 and P.Offer_Excluded = 0 and F1.Host not like '%independent%' and AP.Acct <99999000

Select *
From #CompFinal1

Drop Table IF EXISTS #CompFinal2
Select  CF.*,
Case When Curr_offer - IsNull(Prev_Offer,0) = 0 then 'No Change'
--When Curr_offer - IsNull(Prev_Offer,0) > 25 Then 'Significant Increase'
When Curr_offer - IsNull(Prev_Offer,0)>0 Then 'Slight Increase'
When Curr_offer - IsNull(Prev_Offer,0) <-25 Then 'Significant Decrease' 
When Curr_offer - IsNull(Prev_Offer,0) <0 Then 'Slight Decrease' 
Else 'Unknown' End as Var_Group_Worth,
--Case When Worth_Offer - IsNull(Prev_Offer,0) = 0 then 'No Change'
--When Worth_Offer - IsNull(Prev_Offer,0) > 25 Then 'Significant Increase'
--When Worth_Offer - IsNull(Prev_Offer,0)>0 Then 'Slight Increase'
--When Worth_Offer - IsNull(Prev_Offer,0) <-25 Then 'Significant Decrease' 
--When Worth_Offer - IsNull(Prev_Offer,0) <0 Then 'Slight Decrease' 
--Else 'Unknown' End as Var_Group_Worth, 
--Case When Curr_Worth_v_Profit_Var >25 Then 'Increase'
--When Curr_Worth_v_Profit_Var >=-25 Then 'Similar'
--Else 'Decrease' End as Var_Group_ProftvWorth,
Case When Curr_Act >=10000 Then 1 Else 0 end as Net_Loss_Flag, 
Case When  Curr_AMV>= 11 then 1 Else 0 End as 'Avg_Visits>11_Flag', 
Case When T.ClubState is not null then 1 else 0 End as Tribal_Gold_Flag,
Case when ISNULL(Prev_Offer,0) = 0 then 0 when isnull(Prev_Offer,0) > 60 and (Curr_Offer-IsNull(Prev_Offer,0))/Isnull(Prev_Offer,0) <=-.5 THen 1 else 0 end as 'Drop >50%_Flag',
Case when Curr_visits = 1 and Curr_Offer >= 250 Then 1 else 0 end as One_visit_Player_flag,
Case when ISNULL(Prev_Offer,0) = 0 then 0 when isnull(Prev_Offer,0) > 60 and (Curr_Offer-IsNull(Prev_Offer,0))/Isnull(Prev_Offer,0) >=-.3 THen 1 else 0 end as 'Drop <30%_Flag',
Case When Curr_Act <-1000 Then 1 else 0 end as 'Winner_Flag',
------------------Change this date to current month---------------------------------------------------------------
Case When DateDiff(dd,CurrLGD,'2025-05-01')>90 Then 1 else 0 end as 'No_recent_Activity_Flag', 
Case When Prev_Visits = 0 then 1 else 0 end 'New/Reactivation_Flag'
INTO #CompFinal2
from #CompFinal1 CF
LEFT JOIN #Tribal T on CF.Acct = T.Acct

Select *
From #Compfinal2
Where Override_Flg = 1
Order By Worth_Var

Drop Table if Exists #CompFinal3
Select *, 
Case When Net_Loss_Flag+[Avg_Visits>11_Flag]+Tribal_Gold_Flag+[Drop >50%_Flag] >0 Then 'Check' Else '' End as Check_Flag,
Case When Winner_Flag +No_recent_Activity_Flag+[New/Reactivation_Flag]+[Drop <30%_Flag]>= 1 then 'Ignore' else '' End as Ignore_Flag,
Case When Var_Group_Worth in ('No Change', 'Slight Increase', 'Slight Decrease') Then 'Pass' 
		  When Var_Group_Worth = 'Significant Increase' and Curr_Visits = 1 and Curr_Offer >500 Then 'Review'
		  when Var_Group_Worth = 'Significant Increase' Then 'Pass'
		  When Var_Group_Worth = 'Significant Decrease' and Curr_offer = 0 Then 'Pass'
		  when Var_Group_ProftvWorth in ('Similar', 'Increase') Then 'Pass'
		  when No_recent_Activity_Flag = 1 Then 'Pass'
		  When [New/Reactivation_Flag] = 1 Then 'Pass'
		  When Net_Loss_Flag+[Avg_Visits>11_Flag]+Tribal_Gold_Flag+[Drop >50%_Flag] = 0 and Winner_Flag +No_recent_Activity_Flag+[New/Reactivation_Flag]+[Drop <30%_Flag]>= 1 Then 'Pass'
		  Else 'Review' End as Mktg_Evaluation,
Case When Var_Group_Worth in ('No Change') Then 'No Change' 
		 When Var_Group_Worth in ( 'Slight Increase', 'Slight Decrease') Then 'Minimal Change' 
		  When Var_Group_Worth = 'Significant Increase' and Curr_Visits = 1 and Curr_Offer >500 Then '1 Visit Increase Offer'
		  when Var_Group_Worth = 'Significant Increase' Then 'Significant Increase'
		  When Var_Group_Worth = 'Significant Decrease' and Curr_offer = 0 Then 'Reinvestment Suppress'
		  when Var_Group_ProftvWorth in ('Similar', 'Increase') Then 'Worth and Profit Offers Similar'
		  when No_recent_Activity_Flag = 1 Then 'No Recent Activity'
		  When [New/Reactivation_Flag] = 1 Then 'New Player'
		  When Net_Loss_Flag+[Avg_Visits>11_Flag]+Tribal_Gold_Flag+[Drop >50%_Flag] = 0 and Winner_Flag +No_recent_Activity_Flag+[New/Reactivation_Flag]+[Drop <30%_Flag]>= 1 Then 'Ignore Flag - No Check Flag'
		  Else 'Requires Review' End as Eval_Comment
INTO #CompFinal3
From #CompFinal2
Order By Worth_Var 

Drop Table if Exists #CompFinal4
Select *, 
Case When Mktg_Evaluation = 'Pass' Then 0 else (Curr_offer+Worth_offer)/2.0 End as Alt_Offer,
Case  When Mktg_Evaluation = 'Pass' Then 0 When Var_Group_Worth = 'Significant Increase' Then Worth_offer*.75  
When (Curr_offer+Worth_offer)/2 > Prev_Offer 
Then Prev_Offer Else (Curr_offer+Worth_offer)/2 End as Optional_Offer
INTO #CompFinal4
From #CompFinal3


Drop Table IF Exists #CompFinal5
Select CF4.*, ISnull(SM.Step_offer,0) as Step_Offer1, Case when Mktg_Evaluation = 'Pass' then Worth_Offer else Isnull(SM.Step_Offer,0) End as Recommended_Offer,
Cast('No Change' as Varchar(30)) as PD_Review,
Cast(0 as Int) as PD_Offer,
Cast(0 as Int) as Final_Offer,
Cast(0 as Int) as Override_Flg
INTO #CompFinal5
From #CompFinal4 CF4
Left JOin vdw4.dbo.Matrix_NL_Step SM on Geo_Group = Geo_Zone and Optional_Offer Between Min_offer and Max_offer
Where Tier not in ('Inactive', 'GiftCard') --and (Mktg_Evaluation = 'Review' or Tier in ('Gold', 'Platinum' , 'Infinity'))

Update #CompFinal5
Set Step_offer = Step_Offer1
Where Step_Offer1 <> 0


Drop Table IF Exists vDW4.dbo.Coremailers_2506_Mktg_Evaluation
Select *
INTO vDW4.dbo.Coremailers_2506_Mktg_Evaluation
From #CompFInal5


Select *
From vDW4.dbo.Coremailers_2506_Mktg_Evaluation
Where Tier not in ('Gold', 'Platinum' , 'Infinity') and  (check_flag = 'Check' or Mktg_evaluation = 'Review')
and Acct = 20769512



Select Mktg_Evaluation, Eval_Comment, Count(*) as 'Player Count' 
From vDW4.dbo.Coremailers_2506_Mktg_Evaluation
Where Curr_Mailer = 'Active'
Group By Mktg_Evaluation, Eval_Comment
Order By 1, 3 Desc





Select *
From vDW4.dbo.Coremailers_2506_Mktg_Evaluation
Where Eval_Comment like 'OuterMarket%' or Override_Flg = 1

Where Curr_Mailer = 'OuterMarket' and CurrLGD <'2025-03-01' and Tier not in ('Gold', 'Platinum', 'Infinity') and Mktg_Evaluation <> 'Pass'


Update vDW4.dbo.Coremailers_2506_Mktg_Evaluation 
Set Curr_Hotel_Seg = T.Worth_Hotel_Seg
From Coremailers_2506_Mktg_Evaluation ME
JOIN CoreMailers_2506_Test T on ME.Acct = T.PLAYER_ACCOUNT_NUMBER


Select Acct, PlayerName, Host, Tier, Curr_Mailer, Geo_Group, Curr_reinvest_pct, Prev_Worth_Profit, Curr_Worth_Profit, Curr_Worth, Prev_Offer, Curr_Offer, Worth_Offer, Step_Offer, Var_Group_Worth, Check_Flag,Ignore_Flag,
Mktg_Evaluation, Eval_Comment, Recommended_Offer, PD_Review,PD_Offer, Final_Offer, Override_Flg
From vDW4.dbo.Coremailers_2506_Mktg_Evaluation 
Where (Override_Flg = 1 or PD_Review = 'Manual Override' )and Curr_Mailer = 'Active'
Order By PD_Review

Select Eval_Comment, Mktg_Evaluation, Count(*) as Accounts
From vDW4.dbo.Coremailers_2506_Mktg_Evaluation
Where Curr_Mailer = 'Active'
Group By Eval_Comment, Mktg_Evaluation
Order By 2, 3 desc


Select *
From 