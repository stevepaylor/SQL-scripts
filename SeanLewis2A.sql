USE SteveTest
GO

SELECT 'uses emp_id not auth_empid for awards ask what to use' AS note_one;

-- create query to check if host table has had -lead id added...
/*
Manually Updated Variables
*/

-- dates

DECLARE

       @start_date date = '2019-01-01',
       @apr_start_date date = '2018-01-01'; -- used for #all player ratings table to capture play before using player daily fact

-- FPC Comp Wildcards

DECLARE

       @BCW1 nvarchar(50) = 'BngComp%', -- Bingo Comp wildcard
       @BCW2 nvarchar(50) = 'Evng_Pack', -- Bingo Pack wildcard
       @BCW3 nvarchar(50) = 'ValMatEv%', -- Bingo prizecode 1/2
       @BCP4 nvarchar(50) = 'MatineeC', -- Bingo  prizecode 2/2
       @CCW1 nvarchar(50) = 'SvcRcFP%', -- convenience comp
       @ECP nvarchar(50) = 'ECash-FPC', -- e-cash comp
       @SCW nvarchar(50) = 'FPCComp%', -- slot comps
       @TCW nvarchar(50) = 'NNCComp%'; -- tg comps

/*
Automatically Updated Variables 
*/

DECLARE

       @end_date_cy date = CASE WHEN DATENAME(WEEKDAY, GETDATE()) = 'Monday'
                                         THEN DATEADD(DAY, -1, GETDATE())
                                         WHEN DATENAME(WEEKDAY, GETDATE()) = 'Tuesday'
                                         THEN DATEADD(DAY, -2, GETDATE())
                                         WHEN DATENAME(WEEKDAY, GETDATE()) = 'Wednesday'
                                         THEN DATEADD(DAY, -3, GETDATE())
                                         WHEN DATENAME(WEEKDAY, GETDATE()) = 'Thursday'
                                         THEN DATEADD(DAY, -4, GETDATE())
                                         WHEN DATENAME(WEEKDAY, GETDATE()) = 'Friday'
                                         THEN DATEADD(DAY, -5, GETDATE())
                                         END;

DECLARE

       @end_date date = DATEADD(YEAR, -1, @end_date_cy);

/*
Clears Temp Tables
*/

IF OBJECT_ID(N'Tempdb.dbo.#current_casino_hosts') IS NOT NULL

BEGIN
       DROP TABLE #current_casino_hosts
END;

IF OBJECT_ID(N'Tempdb.dbo.#fpc_comp_prize_codes') IS NOT NULL

BEGIN
       DROP TABLE #fpc_comp_prize_codes
END;

IF OBJECT_ID(N'Tempdb.dbo.#all_player_ratings') IS NOT NULL

BEGIN
       DROP TABLE #all_player_ratings
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_guests') IS NOT NULL

BEGIN
       DROP TABLE #hosted_guests
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_player_ratings') IS NOT NULL

BEGIN
       DROP TABLE #hosted_player_ratings
END;

IF OBJECT_ID(N'Tempdb.dbo.#awards_by_prize_code') IS NOT NULL

BEGIN
       DROP TABLE #awards_by_prize_code
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_guest_award_matrix') IS NOT NULL

BEGIN
       DROP TABLE #hosted_guest_award_matrix
END;

IF OBJECT_ID(N'Tempdb.dbo.#total_daily_fpc_comps') IS NOT NULL

BEGIN
       DROP TABLE #total_daily_fpc_comps
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_daily_fpc_comps') IS NOT NULL

BEGIN
       DROP TABLE #hosted_daily_fpc_comps
END;

IF OBJECT_ID(N'Tempdb.dbo.#total_non_fpc_comps_used') IS NOT NULL

BEGIN
       DROP TABLE #total_non_fpc_comps_used
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_non_fpc_comps_used') IS NOT NULL

BEGIN
       DROP TABLE #hosted_non_fpc_comps_used
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_guests_comp_matrix') IS NOT NULL

BEGIN
       DROP TABLE #hosted_guests_comp_matrix
END;

IF OBJECT_ID(N'Tempdb.dbo.#hosted_player_matrix') IS NOT NULL

BEGIN
       DROP TABLE #hosted_player_matrix
END;

IF OBJECT_ID(N'Tempdb.dbo.#all_hosted_ratings_awards') IS NOT NULL

BEGIN
       DROP TABLE #all_hosted_ratings_awards
END;

/*
Creates Table w/ Current Casino Hosts
*/

CREATE TABLE #current_casino_hosts

       (
       host_order_number int,
       host_emp_id_perm int,
       host_emp_id_lead int NULL,
       host_last_name nvarchar(25),
       host_first_name nvarchar(25),
       host_full_name nvarchar(50),
       host_start_date date,
       days_passed int
       );

/*
Manually Maintained List of Current Casino Hosts
*/

INSERT INTO #current_casino_hosts 

       (host_order_number, host_emp_id_perm, host_last_name, host_first_name, host_full_name, host_start_date)

       VALUES

              (1, 10000314, 'Arcamo', 'Cecilie', 'Arcamo, Cecilie', @start_date),
              (2, 10000771, 'Beale', 'Colton', 'Beale, Colton', '2019-04-01'),
              (3, 10000168, 'Eisner', 'Kimberly', 'Eisner, Kimberly', @start_date),
              (4, 10000777, 'Ferreri', 'Suzanne', 'Ferreri, Suzanne', '2019-04-01'),
              (5, 459, 'Fitzgerald', 'Tina', 'Fitzgerald, Tina', @start_date),
              (6, 10000262, 'Gil', 'Ivonne', 'Gil, Ivonne', @start_date),
              (7, 10000242, 'Gonzales', 'Jenn', 'Gonzales, Jenn', @start_date),
              (8, 502, 'Guzzetta', 'Carmela', 'Guzzetta, Carmela', @start_date),
              (9, 10000729, 'Johnson', 'Richard', 'Johnson, Richard', @start_date),
              (10, 126, 'Johnston', 'Katy', 'Johnston, Katy', @start_date),
              (11, 385, 'Jupin', 'Rae', 'Jupin, Rae', @start_date),
              (12, 10000629, 'Lindsay', 'Laikyn', 'Lindsay, Laikyn', @start_date),
              (13, 10000254, 'Lopez', 'Alfonso', 'Lopez, Alfonso', @start_date),
              (14, 10000707, 'Parsons', 'Alejandra', 'Parsons, Alejandra', @start_date),
              (15, 1444, 'Ramirez', 'Luz', 'Ramirez, Luz', @start_date),
              (16, 10000156, 'Shorees', 'Waleed', 'Shorees, Waleed', @start_date),
              (17, 910, 'Spellman', 'Michael', 'Spellman, Michael', @start_date),
              (18, 1606, 'Stautz', 'Risa', 'Stautz, Risa', @start_date),
              (19, 10000766, 'Vuong', 'Tony', 'Vuong, Tony', '2019-04-01'),
              (20, 861, 'Willan', 'Nathaniel', 'Willan, Nathaniel', @start_date);

/*
Adds lead empi_ds to #current_casino_hosts
for all individual hosts
*/

UPDATE #current_casino_hosts 

SET 

       host_emp_id_lead = e.EmpId

FROM CMKTDB13DPR.CMP13.dbo.tEmp As e

WHERE

       (CASE WHEN host_last_name = 'Fitzgerald' THEN 'Wong-Lead' ELSE CONCAT(host_last_name,'-Lead') END) = e.LastName
       AND host_first_name = e.FirstName
       AND host_emp_id_perm <> 10000777;

UPDATE #current_casino_hosts

SET

       host_emp_id_lead = 10000778

WHERE

       host_emp_id_perm = 10000777;

/*
Creates table w/ FPC comp prize codes
and categories
*/

SELECT

       PrizeCode AS prize_code,
       PrizeName AS prize_name,
       'fpc_comp' AS category

INTO #fpc_comp_prize_codes

FROM CMKTDB13DPR.CMP13.dbo.viewPrizesViejas

WHERE

       PrizeCode LIKE @BCW1
       OR PrizeCode LIKE @BCW2
       OR PrizeCode LIKE @BCW3
       OR PrizeCode = @BCP4
       OR PrizeCode LIKE @CCW1
       OR PrizeCode = @ECP
       OR PrizeCode LIKE @SCW
       OR PrizeCode LIKE @TCW;

/*
creates a YTD ratings table
*/

SELECT

       CONVERT(date, gaming_date) AS gaming_date,
       player_id AS player_id,
       CONVERT(nvarchar(50), player_account_number) AS player_account,
       slot_actual_win + table_actual_win + other_actual_win AS actual_win_total,
       slot_actual_win AS actual_win_slots,
       table_actual_win AS actual_win_table,
       other_actual_win AS actual_win_other,
       slot_theo_win + table_theo_win + other_theo_win AS theo_win_total,
       slot_theo_win AS theo_win_slots,
       table_theo_win AS theo_win_table,
       other_theo_win AS theo_win_other,
       CASE WHEN (slot_theo_win + table_theo_win + other_theo_win) = 0
       THEN 0
       ELSE 1
       END AS theo_trip,
       award_CompsUsed_Hotel_Mktg AS hotel_comp_used,
       award_CompsUsed_FB AS fb_comp_used,
       award_Benefits_FB AS food_vouchers_used,
       award_CompsUsed_Other AS other_comp_used,
       award_CompsUsed_Hotel_Mktg + award_CompsUsed_FB + award_CompsUsed_Other AS total_comps_used,
       award_FPAwarded_NonPts AS slot_fpc_awarded,
       award_PromoChipsAwarded AS tg_fpc_awarded,
       award_CashAwarded_Bingo AS bingo_fpc_awarded,
       award_FPAwarded_NonPts + award_PromoChipsAwarded + award_CashAwarded_Bingo AS total_fpc_awarded

INTO #all_player_ratings

FROM vDW.tableau.player_daily_fact

WHERE

       CONVERT(date, gaming_date) BETWEEN @apr_start_date AND @end_date
       AND ((slot_theo_win + table_theo_win + other_theo_win) <> 0
       OR award_CompsUsed_Hotel_Mktg <> 0
       OR award_CompsUsed_FB <> 0
       OR award_CompsUsed_Other <> 0
       OR award_FPAwarded_NonPts <> 0
       OR award_PromoChipsAwarded <> 0
       OR award_CashAwarded_Bingo <> 0
       OR award_Benefits_FB <> 0);

/*
Checks date range in all player ratings
*/

SELECT MIN(gaming_date) as min_date_apr, MAX(gaming_date) AS max_date_apr FROM #all_player_ratings;

/*
Updates dates_passed field in for current_casino_hosts
*/

-- manual adjustments to hosts who started after 7/1/2018

UPDATE #current_casino_hosts

SET

       days_passed = CASE WHEN host_last_name = 'Eisner'
                             THEN DATEDIFF(DAY, host_start_date, (SELECT MAX(gaming_date) FROM #all_player_ratings)) + 1 + 91
                             ELSE DATEDIFF(DAY, host_start_date, (SELECT MAX(gaming_date) FROM #all_player_ratings)) + 1 + 181
                             END;

/*
Creates a table w/ active hosted guests
*/

WITH

active_players

AS

(

SELECT DISTINCT

       player_id AS player_id

INTO active_players

FROM #all_player_ratings

)

SELECT

       p.HostEmpID AS host_emp_id,
       cch.host_last_name,
       cch.host_first_name,
       cch.host_full_name,
       cch.host_start_date,
       cch.days_passed,
       p.PlayerId AS player_id,
       p.Acct AS player_account,
       p.LastName AS guest_last_name,
       p.FirstName AS guest_first_name,
       CASE WHEN p.ClubStatus IN ('PLATINUM', 'MVP')
       THEN 'PLATINUM'
       WHEN p.ClubStatus IN ('GOLD', 'ELITE')
       THEN 'GOLD'
       WHEN p.ClubStatus IN ('SILVER', 'PREMIER')
       THEN 'SILVER'
       ELSE 'BRONZE'
       END AS club_status

INTO #hosted_guests

FROM active_players AS ap

INNER JOIN CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS p
ON ap.player_id = p.PlayerId

INNER JOIN #current_casino_hosts AS cch
ON (cch.host_emp_id_perm = p.HostEmpID OR cch.host_emp_id_lead = p.HostEmpID)

WHERE

       p.PlayerId NOT IN
(
       SELECT [PlayerId] 
       FROM CMKTDB13DPR.CMP13.dbo.[tPlayerGroup]
       WHERE [GroupId] IN ('3554','3560')
);


SELECT

       apr.gaming_date,
       hg.host_emp_id,
       hg.host_last_name,
       hg.host_first_name,
       hg.host_full_name,
       hg.days_passed,
       hg.player_id,
       hg.player_account,
       hg.guest_last_name,
       hg.guest_first_name,
       hg.club_status,
       apr.actual_win_total,
       apr.actual_win_slots,
       apr.actual_win_table,
       apr.actual_win_other,
       apr.theo_win_total,
       apr.theo_win_slots,
       apr.theo_win_table,
       apr.theo_win_other,
       apr.theo_trip,
       apr.slot_fpc_awarded,
       apr.tg_fpc_awarded,
       apr.bingo_fpc_awarded,
       apr.total_fpc_awarded,
       apr.food_vouchers_used

INTO #hosted_player_ratings

FROM #hosted_guests AS hg

INNER JOIN #all_player_ratings AS apr
ON hg.player_id = apr.player_id

WHERE

       apr.gaming_date BETWEEN hg.host_start_date AND @end_date

ORDER BY

       apr.gaming_date ASC,
       apr.theo_win_total DESC;

/*
Creates a table w awards transaction at prizecode level
*/

SELECT

       GamingDt AS gaming_date,
       EmpId AS emp_id,
       player_id AS player_id,
       PrizeCode AS prize_code,
       PrizeName AS prize_name,
       award_CompsUsed_Hotel_Mktg AS hotel_comp_used,
       award_CompsUsed_FB AS fb_comp_used,
       award_CompsUsed_Other AS other_comp_used,
       award_FPAwarded_NonPts AS slot_fpc_awarded,
       award_PromoChipsAwarded AS tg_fpc_awarded,
       award_CashAwarded_Bingo AS bingo_fpc_awarded

INTO #awards_by_prize_code

FROM vDW.player.tab_award_fact

WHERE

       GamingDt BETWEEN '2019-01-01' AND '2020-01-01'
       AND IsVoid = 0
       AND (award_CompsUsed_Hotel_Mktg <> 0
       OR award_CompsUsed_FB <> 0
       OR award_CompsUsed_Other <> 0
       OR award_FPAwarded_NonPts <> 0
       OR award_PromoChipsAwarded <> 0
       OR award_CashAwarded_Bingo <> 0);

/*
creates an awards table at prize level for hosted guests
*/

SELECT

       abpc.gaming_date,
       hg.host_emp_id,
       hg.host_last_name,
       hg.host_first_name,
       hg.host_full_name,
       hg.host_start_date,
       hg.days_passed,
       hg.player_id,
       hg.player_account,
       hg.guest_last_name,
       hg.guest_first_name,
       hg.club_status,
       abpc.emp_id,
       abpc.prize_Code,
       abpc.prize_name,
       abpc.hotel_comp_used,
       abpc.fb_comp_used,
       abpc.other_comp_used,
       abpc.slot_fpc_awarded,
       abpc.tg_fpc_awarded,
       abpc.bingo_fpc_awarded
       
INTO #hosted_guest_award_matrix

FROM #hosted_guests AS hg

INNER JOIN #awards_by_prize_code AS abpc
ON hg.player_id = abpc.player_id;

/*
Creates a table w/ all daily fpc comps
*/

WITH

all_fpc_comps_by_issuance

AS

(

SELECT

       hgam.gaming_date,
       hgam.host_emp_id,
       hgam.host_last_name,
       hgam.host_first_name,
       hgam.host_full_name,
       hgam.host_start_date,
       hgam.days_passed,
       hgam.player_id,
       hgam.player_account,
       hgam.guest_last_name,
       hgam.guest_first_name,
       hgam.club_status,
       hgam.emp_id,
       hgam.prize_code,
       hgam.prize_name,
       hgam.slot_fpc_awarded,
       hgam.tg_fpc_awarded,
       hgam.bingo_fpc_awarded

FROM #hosted_guest_award_matrix AS hgam

INNER JOIN #fpc_comp_prize_codes AS fcpc
ON hgam.prize_code = fcpc.prize_code

WHERE

       hgam.slot_fpc_awarded <> 0
       OR hgam.tg_fpc_awarded <> 0
       OR hgam.bingo_fpc_awarded <> 0

)

SELECT

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status,
       SUM(slot_fpc_awarded) AS total_slot_fpc_comps,
       SUM(tg_fpc_awarded) AS total_tg_fpc_comps,
       SUM(bingo_fpc_awarded) AS total_bingo_fpc_comps,
       SUM(slot_fpc_awarded) + SUM(tg_fpc_awarded) + SUM(bingo_fpc_awarded) total_fpc_comps

INTO #total_daily_fpc_comps

FROM all_fpc_comps_by_issuance

GROUP BY

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status;

/*
Creates a table w/ hosted daily fpc comps
*/

WITH

hosted_fpc_comps_by_issuance

AS

(

SELECT

       hgam.gaming_date,
       hgam.host_emp_id,
       hgam.host_last_name,
       hgam.host_first_name,
       hgam.host_full_name,
       hgam.host_start_date,
       hgam.days_passed,
       hgam.player_id,
       hgam.player_account,
       hgam.guest_last_name,
       hgam.guest_first_name,
       hgam.club_status,
       hgam.emp_id,
       hgam.prize_code,
       hgam.prize_name,
       hgam.slot_fpc_awarded,
       hgam.tg_fpc_awarded,
       hgam.bingo_fpc_awarded

FROM #hosted_guest_award_matrix AS hgam

INNER JOIN #fpc_comp_prize_codes AS fcpc
ON hgam.prize_code = fcpc.prize_code

INNER JOIN #current_casino_hosts AS cch
ON (hgam.emp_id = cch.host_emp_id_perm OR hgam.emp_id = cch.host_emp_id_lead)

WHERE

       hgam.slot_fpc_awarded <> 0
       OR hgam.tg_fpc_awarded <> 0
       OR hgam.bingo_fpc_awarded <> 0

)

SELECT

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status,
       SUM(slot_fpc_awarded) AS hosted_slot_fpc_comps,
       SUM(tg_fpc_awarded) AS hosted_tg_fpc_comps,
       SUM(bingo_fpc_awarded) AS hosted_bingo_fpc_comps,
       SUM(slot_fpc_awarded) + SUM(tg_fpc_awarded) + SUM(bingo_fpc_awarded) hosted_fpc_comps

INTO #hosted_daily_fpc_comps

FROM hosted_fpc_comps_by_issuance

GROUP BY

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status;

/*
Creates a table w/ all daily non fpc comps
*/

SELECT

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status,
       SUM(hotel_comp_used) AS total_hotel_comps_used,
       SUM(fb_comp_used) AS total_fb_comps_used,
       SUM(other_comp_used) AS total_other_comps_used,
       SUM(hotel_comp_used) + SUM(fb_comp_used) + SUM(other_comp_used) AS total_non_fpc_comps_used

INTO #total_non_fpc_comps_used

FROM #hosted_guest_award_matrix

WHERE

       hotel_comp_used <> 0
       OR fb_comp_used <> 0
       OR other_comp_used <> 0

GROUP BY

       gaming_date,
       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       host_start_date,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status;

/*
Creates a table w/ hosted daily non fpc comps
*/

SELECT

       hgam.gaming_date,
       hgam.host_emp_id,
       hgam.host_last_name,
       hgam.host_first_name,
       hgam.host_full_name,
       hgam.host_start_date,
       hgam.days_passed,
       hgam.player_id,
       hgam.player_account,
       hgam.guest_last_name,
       hgam.guest_first_name,
       hgam.club_status,
       SUM(hgam.hotel_comp_used) AS all_hotel_comps_used,
       SUM(hgam.fb_comp_used) AS all_fb_comps_used,
       SUM(hgam.other_comp_used) AS all_other_comps_used,
       SUM(hgam.hotel_comp_used) + SUM(hgam.fb_comp_used) + SUM(hgam.other_comp_used) AS all_non_fpc_comps_used

INTO #hosted_non_fpc_comps_used

FROM #hosted_guest_award_matrix AS hgam

INNER JOIN #current_casino_hosts AS cch
ON (hgam.emp_id = cch.host_emp_id_perm OR hgam.emp_id = cch.host_emp_id_lead)

WHERE

       hgam.hotel_comp_used <> 0
       OR hgam.fb_comp_used <> 0
       OR hgam.other_comp_used <> 0

GROUP BY

       hgam.gaming_date,
       hgam.host_emp_id,
       hgam.host_last_name,
       hgam.host_first_name,
       hgam.host_full_name,
       hgam.host_start_date,
       hgam.days_passed,
       hgam.player_id,
       hgam.player_account,
       hgam.guest_last_name,
       hgam.guest_first_name,
       hgam.club_status;

/*
Creates a table w/ all comps awarded/used
*/

WITH

all_comp_days

AS

(

SELECT

       fpc.gaming_date,
       fpc.host_emp_id,
       fpc.host_last_name,
       fpc.host_first_name,
       fpc.host_full_name,
       fpc.host_start_date,
       fpc.days_passed,
       fpc.player_id,
       fpc.player_account,
       fpc.guest_last_name,
       fpc.guest_first_name,
       fpc.club_status

FROM #total_daily_fpc_comps AS fpc

UNION

SELECT

       acd.gaming_date,
       acd.host_emp_id,
       acd.host_last_name,
       acd.host_first_name,
       acd.host_full_name,
       acd.host_start_date,
       acd.days_passed,
       acd.player_id,
       acd.player_account,
       acd.guest_last_name,
       acd.guest_first_name,
       acd.club_status

FROM #total_non_fpc_comps_used AS acd

)

SELECT

       acd.gaming_date,
       acd.host_emp_id,
       acd.host_last_name,
       acd.host_first_name,
       acd.host_full_name,
       acd.days_passed,
       acd.player_id,
       acd.player_account,
       acd.guest_last_name,
       acd.guest_first_name,
       acd.club_status,
       COALESCE(hdfc.hosted_slot_fpc_comps, 0) AS hosted_slot_fpc_comps,
       COALESCE(hdfc.hosted_tg_fpc_comps, 0) AS hosted_tg_fpc_comps,
       COALESCE(hdfc.hosted_bingo_fpc_comps, 0) AS hosted_bingo_fpc_comps,
       COALESCE(hdfc.hosted_fpc_comps, 0) AS hosted_fpc_comps,
       COALESCE(tdfc.total_slot_fpc_comps, 0) AS total_slot_fpc_comps,
       COALESCE(tdfc.total_tg_fpc_comps, 0) AS total_tg_fpc_comps,
       COALESCE(tdfc.total_bingo_fpc_comps, 0) AS total_bingo_fpc_comps,
       COALESCE(tdfc.total_fpc_comps, 0) AS total_fpc_comps,
       COALESCE(hnfc.all_hotel_comps_used, 0) AS hosted_hotel_comps,
       COALESCE(hnfc.all_fb_comps_used, 0) AS hosted_fb_comps,
       COALESCE(hnfc.all_other_comps_used, 0) AS hosted_other_comps,
       COALESCE(hnfc.all_non_fpc_comps_used, 0) AS hosted_non_fpc_comps,
       COALESCE(tnfc.total_hotel_comps_used, 0) AS total_hotel_comps,
       COALESCE(tnfc.total_fb_comps_used, 0) AS total_fb_comps,
       COALESCE(tnfc.total_other_comps_used, 0) AS total_other_comps,
       COALESCE(tnfc.total_non_fpc_comps_used, 0) AS total_non_fpc_comps

INTO #hosted_guests_comp_matrix

FROM all_comp_days AS acd

LEFT OUTER JOIN #hosted_daily_fpc_comps AS hdfc
ON acd.gaming_date = hdfc.gaming_date AND acd.player_id = hdfc.player_id

LEFT OUTER JOIN #total_daily_fpc_comps AS tdfc
ON acd.gaming_date = tdfc.gaming_date AND acd.player_id = tdfc.player_id

LEFT OUTER JOIN #hosted_non_fpc_comps_used hnfc
ON acd.gaming_date = hnfc.gaming_date AND acd.player_id = hnfc.player_id

LEFT OUTER JOIN #total_non_fpc_comps_used AS tnfc
ON acd.gaming_date = tnfc.gaming_date AND acd.player_id = tnfc.player_id

WHERE

       (COALESCE(tnfc.total_non_fpc_comps_used, 0) + COALESCE(tdfc.total_fpc_comps, 0)) <> 0
       AND acd.gaming_date BETWEEN acd.host_start_date AND '2020-01-01';

/*
creates ratings/awards table
*/

WITH

ratings_award_days

AS

(

SELECT

       hpr.gaming_date,
       hpr.host_emp_id,
       hpr.host_last_name,
       hpr.host_first_name,
       hpr.host_full_name,
       hpr.days_passed,
       hpr.player_id,
       hpr.player_account,
       hpr.guest_last_name,
       hpr.guest_first_name,
       hpr.club_status

FROM #hosted_player_ratings AS hpr

UNION

SELECT

       hgcm.gaming_date,
       hgcm.host_emp_id,
       hgcm.host_last_name,
       hgcm.host_first_name,
       hgcm.host_full_name,
       hgcm.days_passed,
       hgcm.player_id,
       hgcm.player_account,
       hgcm.guest_last_name,
       hgcm.guest_first_name,
       hgcm.club_status

FROM #hosted_guests_comp_matrix AS hgcm

)

SELECT

       rad.gaming_date,
       rad.host_emp_id,
       rad.host_last_name,
       rad.host_first_name,
       rad.host_full_name,
       rad.days_passed,
       rad.player_id,
       rad.player_account,
       rad.guest_last_name,
       rad.guest_first_name,
       rad.club_status,
       COALESCE(hpr.actual_win_total, 0) AS actual_win_total,
       COALESCE(hpr.actual_win_slots, 0) AS actual_win_slots,
       COALESCE(hpr.actual_win_table, 0) AS actual_win_table,
       COALESCE(hpr.actual_win_other, 0) AS actual_win_bingo,
       COALESCE(hpr.theo_win_total, 0) AS theo_win_total,
       COALESCE(hpr.theo_win_slots, 0) AS theo_win_slots,
       COALESCE(hpr.theo_win_table, 0) AS theo_win_table,
       COALESCE(hpr.theo_win_other, 0) AS theo_win_bingo,
       COALESCE(hpr.total_fpc_awarded, 0) AS total_fpc_awarded,
       CONVERT(money, 0) AS fpc_vouchers,
       COALESCE(hgcm.total_fpc_comps, 0) AS total_fpc_comps,
       COALESCE(hgcm.total_hotel_comps, 0) AS total_hotel_comps,
       COALESCE(hgcm.total_fb_comps, 0) AS total_fb_comps,
       CONVERT(money, 0) AS retail_comps,
       COALESCE(hgcm.total_other_comps, 0) AS total_other_comps,
       COALESCE(hpr.food_vouchers_used, 0) AS food_vouchers,
       CONVERT(money, 0) AS retail_vouchers,
       CONVERT(money, 0) AS other_vouchers,
       COALESCE(hpr.total_fpc_awarded, 0) + COALESCE(hgcm.total_hotel_comps, 0) +
       COALESCE(hgcm.total_fb_comps, 0) + COALESCE(hgcm.total_other_comps, 0) +
       COALESCE(hpr.food_vouchers_used, 0) AS total_awards,
       COALESCE(hpr.theo_trip, 0) AS theo_trip

INTO #hosted_player_matrix

FROM ratings_award_days AS rad

LEFT OUTER JOIN #hosted_player_ratings AS hpr
ON rad.gaming_date = hpr.gaming_date AND rad.player_id = hpr.player_id AND rad.player_account = hpr.player_account

LEFT OUTER JOIN #hosted_guests_comp_matrix AS hgcm
ON rad.gaming_date = hgcm.gaming_date AND rad.player_id = hgcm.player_id AND rad.player_account = hgcm.player_account

ORDER BY

       rad.host_last_name ASC,
       rad.gaming_date ASC,
       rad.player_account ASC; -- used for data checking;

/*
asdasda
*/

WITH

current_ratings

AS

(

SELECT

       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status,
       SUM(actual_win_total) AS actual_win_total,
       SUM(actual_win_slots) AS actual_win_slots,
       SUM(actual_win_table) AS actual_win_table,
       SUM(actual_win_bingo) AS actual_win_bingo,
       SUM(theo_win_total) AS theo_win_total,
       SUM(theo_win_slots) AS theo_win_slots,
       SUM(theo_win_table) AS theo_win_table,
       SUM(theo_win_bingo) AS theo_win_bingo,
       SUM(total_fpc_awarded) AS total_fpc_awarded,
       SUM(fpc_vouchers) AS fpc_vouchers,
       SUM(total_fpc_comps) AS total_fpc_comps,
       SUM(total_hotel_comps) AS total_hotel_comps,
       SUM(total_fb_comps) AS total_fb_comps,
       SUM(retail_comps) AS retail_comps,
       SUM(total_other_comps) AS total_other_comps,
       SUM(food_vouchers) AS food_vouchers,
       SUM(retail_vouchers) AS retail_vouchers,
       SUM(other_vouchers) AS other_vouchers,
       SUM(total_awards) AS total_awards,
       SUM(theo_trip) AS theo_trips

FROM #hosted_player_matrix

GROUP BY

       host_emp_id,
       host_last_name,
       host_first_name,
       host_full_name,
       days_passed,
       player_id,
       player_account,
       guest_last_name,
       guest_first_name,
       club_status

)

SELECT

       '2019-12-31' AS report_date,
       hg.host_emp_id,
       hg.host_last_name,
       hg.host_first_name,
       hg.host_full_name,
       hg.days_passed,
       hg.player_id,
       hg.player_account,
       hg.guest_last_name,
       hg.guest_first_name,
       hg.club_status,
       COALESCE(cr.actual_win_total, 0) + COALESCE(hrcr.actual_win_total, 0) AS actual_win_total,
       COALESCE(cr.actual_win_slots, 0) + COALESCE(hrcr.actual_win_slots, 0) AS actual_win_slots,
       COALESCE(cr.actual_win_table, 0) + COALESCE(hrcr.actual_win_table, 0) AS actual_win_table,
       COALESCE(cr.actual_win_bingo, 0) + COALESCE(hrcr.actual_win_bingo, 0) AS actual_win_bingo,
       COALESCE(cr.theo_win_total, 0) + COALESCE(hrcr.theo_win_total, 0) AS theo_win_total,
       COALESCE(cr.theo_win_slots, 0) + COALESCE(hrcr.theo_win_slots, 0) AS theo_win_slots,
       COALESCE(cr.theo_win_table, 0) + COALESCE(hrcr.theo_win_table, 0) AS theo_win_table,
       COALESCE(cr.theo_win_bingo, 0) + COALESCE(hrcr.theo_win_bingo, 0) AS theo_win_bingo,
       COALESCE(cr.total_fpc_awarded, 0) + COALESCE(hrcr.fpc_awarded_total, 0) AS total_fpc_awarded,
       COALESCE(cr.fpc_vouchers, 0) + COALESCE(hrcr.fpc_vouchers, 0) AS fpc_vouchers,
       COALESCE(cr.total_fpc_comps, 0) + COALESCE(hrcr.fpc_comps, 0) AS total_fpc_comps,
       COALESCE(cr.total_hotel_comps, 0) + COALESCE(hrcr.hotel_comps, 0) AS total_hotel_comps,
       COALESCE(cr.total_fb_comps, 0) + COALESCE(hrcr.fb_comps, 0) AS total_fb_comps,
       COALESCE(cr.retail_comps, 0) + COALESCE(hrcr.retail_comps, 0) AS retail_comps,
       COALESCE(cr.total_other_comps, 0) + COALESCE(hrcr.other_comps, 0) AS total_other_comps,
       COALESCE(cr.food_vouchers, 0) + COALESCE(hrcr.food_vouchers, 0) AS food_vouchers,
       COALESCE(cr.retail_vouchers, 0) + COALESCE(hrcr.retail_vouchers, 0) AS retail_vouchers,
       COALESCE(cr.other_vouchers, 0) + COALESCE(hrcr.other_vouchers, 0) AS other_vouchers,
       COALESCE(cr.total_awards, 0) + COALESCE(hrcr.total_awards, 0) AS total_awards,
       COALESCE(cr.theo_trips, 0) + COALESCE(hrcr.trips, 0) AS trips

INTO #all_hosted_ratings_awards

FROM #hosted_guests AS hg

LEFT OUTER JOIN current_ratings AS cr
ON hg.player_id = cr.player_id AND hg.player_account = cr.player_account

LEFT OUTER JOIN CMKTDB13DPR.Love_Test.dbo.host_report_card_ratings_hist AS hrcr
ON hg.player_id = hrcr.player_id AND hg.player_account = hrcr.player_acct


ORDER BY

       hg.host_last_name ASC,
       COALESCE(cr.theo_win_total, 0) + COALESCE(hrcr.theo_win_total, 0) DESC;

/*
Produces Result Set for Prev Year
*/

SELECT

       '2019-12-31' AS report_date,
       host_full_name,
       COUNT(DISTINCT player_account) AS player_count,
       SUM(actual_win_slots) + SUM(ahra.actual_win_table) AS actual_win,
       SUM(theo_win_slots) + SUM(ahra.theo_win_table) AS theo_win,
       SUM(total_awards) AS total_awards

FROM #all_hosted_ratings_awards AS ahra

GROUP BY

       ahra.host_full_name

ORDER BY
       
       host_full_name ASC;

