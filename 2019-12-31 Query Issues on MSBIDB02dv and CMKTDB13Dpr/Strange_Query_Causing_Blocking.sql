(@P1 date,@P2 date)
SELECT 
"Tbl1005"
."player_id" "Col1008"
,"Tbl1005"."GamingDt" "Col1010"
,"Tbl1005"."PrizeCode" "Col1012"
,"Tbl1005"."PrizeName" "Col1013"
,"Tbl1005"."award_CompsUsed_Hotel_Mktg" "Col1014"
,"Tbl1005"."award_CompsUsed_FB" "Col1015"
,"Tbl1005"."award_CompsUsed_Other" "Col1016"
,"Tbl1005"."award_FPAwarded_NonPts" "Col1017"
,"Tbl1005"."award_PromoChipsAwarded" "Col1018"
,"Tbl1005"."award_CashAwarded_Bingo" "Col1019"
,"Tbl1005"."EmpID" "Col1021" 

FROM "vDW"."player"."tab_award_fact" "Tbl1005" 

WHERE "Tbl1005"."GamingDt">=@P1 
AND "Tbl1005"."GamingDt"<=@P2 
AND "Tbl1005"."IsVoid"=(0) 
AND ("Tbl1005"."award_CompsUsed_Hotel_Mktg"<>(0.0000) 
	OR "Tbl1005"."award_CompsUsed_FB"<>(0.0000) 
	OR "Tbl1005"."award_CompsUsed_Other"<>(0.0000) 
	OR "Tbl1005"."award_FPAwarded_NonPts"<>(0.0000) 
	OR "Tbl1005"."award_PromoChipsAwarded"<>(0.0000) 
	OR "Tbl1005"."award_CashAwarded_Bingo"<>(0.0000))