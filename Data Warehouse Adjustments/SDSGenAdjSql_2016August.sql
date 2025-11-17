/*
--
-- export data from rpt database, need to connect as db2rpt
--
db2 "export to acct_rpt.drop_data_Mar20110401 of del modified by coldel~ select * from acct_rpt.drop_data where gmdy_acctdt between '03/27/2011' and '04/01/2011' for read only"

-- SPREADSHEET SENT BY CUSTOMER IS UPLOADED INTO THE FOLLOWING TABLE USING THE IMPORT DATA FUNCTION FOR THE DATABASE
--
-- Import Excel file to CASIVC07PR.SLOT_PARTICIPATION.dbo.ADJ_DATA
--

-- dbo.SLOT_PARTICIPATION/task/import data
-- select destination table [dbo].[ADJ_DATA]
-- edit mapping
--	Check mark "Delete rows in destination table"
--		GamingDate
--		SlotNumber
--		FieldNumber
--		AdjAmount
--	Ignore the 'Adj$' fail
--

--
-- used to insert a record if none exist
-- change the sltm id and 3 date fields dates
--
insert into acct_rpt.drop_data values ('01/25/2011',29671,1,NULL,0,0,0,'N','2011-01-26-09.00.10.000000',0,0,0,'N',NULL,0,0,0,0,0,0,0,0,0,0,0,0,'N','2011-01-25-17.23.53.000000',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'N',NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,0,0)

select *
from SRPTDB01PR.RPT.SYSCAT.TABLES 
where TABSCHEMA not in ('SYSIBM')
order by TABSCHEMA, TABNAME

select * from SRPTDB01PR.RPT.ACCT_RPT.GAMEDAY

select * from 
openquery(SRPTDB01PR, 'select * from ACCT_RPT.GAMEDAY')

*/

--
-- compare the totals to spreadsheet
-- delete null rows
--
--	verify rows transferred
--

delete from adj_data where gamingdate is null
select sum(AdjAmount) from adj_data

--
-- find all adj that does not match drop data
-- change adj_data gaming day to match drop data
--
select * from adj_data where id not in
(
select	a.id
from	adj_data a, slot_master_sds m, drop_data_load d
where	'S' + right(('00000' + a.SlotNumber),5) = sltm_slot_number
and		m.sltm_id = d.sltm_id
and		a.gamingdate = d.gmdy_acctdt
)

--
-- find the missing slot relates to date
-- default bucket to slot S00007 if not within month, replace gamingdate and slotnumber
--
SELECT B.GMDY_ACCTDT, B.DRPD_COIN_IN, B.DRPD_COIN_IN, *
FROM slot_master_sds A
LEFT JOIN drop_data_load B ON A.SLTM_ID = B.SLTM_ID
WHERE A.sltm_slot_number = 'S27705' AND B.GMDY_ACCTDT IS NOT NULL AND B.DRPD_COIN_IN = '0' AND B.DRPD_COIN_OUT = '0'
ORDER BY sltm_start,B.GMDY_ACCTDT DESC

Id	GamingDate	SlotNumber	FieldNumber	AdjAmount
14	11/28/2015	2716	16	55.00
78	12/30/2015	27705	16	2.00

/*
select * from drop_data_load where sltm_id = 2716 order by gmdy_acctdt desc

SLTM_ID
30166
34675

*/

--
-- generate sql for adj that matches drop data
-- run sql statement in SDS RPT server
--
select	'update ACCT_RPT.DROP_DATA set ' +
		db2name + ' = ' +
		db2name + ' + ' + ltrim(str(AdjAmount*100)) +
		' where gmdy_acctdt = ''' + ltrim(str(datepart(month, GamingDate))) 
		+ '-' + ltrim(str(datepart(day, GamingDate))) 
		+ '-' + ltrim(str(datepart(year, GamingDate))) + '''' + 
		' and sltm_id = ' + ltrim(str(d.sltm_id)) + ';'
from	adj_data a, adj_field f, slot_master_sds m, drop_data_load d
where	'S' + right(('00000' + SlotNumber),5) = sltm_slot_number
and		a.fieldnumber = f.fieldnumber
and		m.sltm_id = d.sltm_id
and		a.gamingdate = d.gmdy_acctdt
order by id, slotnumber, sltm_status_code

--
-- Move data over to SLOT_PARTICIPATION
--
-- Run Jobs from CRPTDB01PR.viejas.net "Slot Participation DROP DATA load to CASIVC07PR"

