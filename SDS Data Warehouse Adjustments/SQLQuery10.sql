--delete from adj_data where gamingdate is null
--select sum(AdjAmount) from adj_data

--select * from adj_data where id not in
--(
--select	a.id
--from	adj_data a, slot_master_sds m, drop_data_load d
--where	'S' + right(('00000' + a.SlotNumber),5) = sltm_slot_number
--and		m.sltm_id = d.sltm_id
--and		a.gamingdate = d.gmdy_acctdt
--)

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

results copied and run against DB2:

--update ACCT_RPT.DROP_DATA set DRPD_BILL1 = DRPD_BILL1 + 10000 where gmdy_acctdt = '3-12-2016' and sltm_id = 51940;
--update ACCT_RPT.DROP_DATA set DRPD_BILL1 = DRPD_BILL1 + 10000 where gmdy_acctdt = '3-17-2016' and sltm_id = 56099;
--update ACCT_RPT.DROP_DATA set DRPD_BILL1 = DRPD_BILL1 + -90800 where gmdy_acctdt = '3-18-2016' and sltm_id = 56862;
--update ACCT_RPT.DROP_DATA set DRPD_BILL1 = DRPD_BILL1 + -149600 where gmdy_acctdt = '3-18-2016' and sltm_id = 56863;
--update ACCT_RPT.DROP_DATA set DRPD_BILL1 = DRPD_BILL1 + -50000 where gmdy_acctdt = '3-23-2016' and sltm_id = 50950;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '2-26-2016' and sltm_id = 47517;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '2-26-2016' and sltm_id = 27615;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 1400 where gmdy_acctdt = '2-28-2016' and sltm_id = 53627;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 1700 where gmdy_acctdt = '2-28-2016' and sltm_id = 54183;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -3100 where gmdy_acctdt = '2-28-2016' and sltm_id = 53033;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '2-29-2016' and sltm_id = 19192;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '2-29-2016' and sltm_id = 51996;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10500 where gmdy_acctdt = '3-7-2016' and sltm_id = 49014;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10500 where gmdy_acctdt = '3-7-2016' and sltm_id = 56425;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -2600 where gmdy_acctdt = '3-8-2016' and sltm_id = 54998;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2600 where gmdy_acctdt = '3-8-2016' and sltm_id = 54996;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '3-10-2016' and sltm_id = 38801;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-10-2016' and sltm_id = 51336;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '3-12-2016' and sltm_id = 49759;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-12-2016' and sltm_id = 45189;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '3-22-2016' and sltm_id = 55740;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-22-2016' and sltm_id = 52353;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2000 where gmdy_acctdt = '3-23-2016' and sltm_id = 55645;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2100 where gmdy_acctdt = '3-23-2016' and sltm_id = 35814;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2500 where gmdy_acctdt = '3-23-2016' and sltm_id = 55699;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2400 where gmdy_acctdt = '3-23-2016' and sltm_id = 51797;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -2600 where gmdy_acctdt = '3-23-2016' and sltm_id = 52123;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 6500 where gmdy_acctdt = '3-23-2016' and sltm_id = 56406;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 8000 where gmdy_acctdt = '3-23-2016' and sltm_id = 56882;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-23-2016' and sltm_id = 56732;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -33500 where gmdy_acctdt = '3-23-2016' and sltm_id = 55557;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -16000 where gmdy_acctdt = '3-23-2016' and sltm_id = 52996;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 18600 where gmdy_acctdt = '3-23-2016' and sltm_id = 56713;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -2500 where gmdy_acctdt = '3-25-2016' and sltm_id = 52354;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2500 where gmdy_acctdt = '3-25-2016' and sltm_id = 50025;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + -10000 where gmdy_acctdt = '3-25-2016' and sltm_id = 49606;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-25-2016' and sltm_id = 56877;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2000 where gmdy_acctdt = '3-29-2016' and sltm_id = 53721;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-29-2016' and sltm_id = 18345;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2700 where gmdy_acctdt = '3-29-2016' and sltm_id = 53034;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 400 where gmdy_acctdt = '3-29-2016' and sltm_id = 51984;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 600 where gmdy_acctdt = '3-29-2016' and sltm_id = 54116;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 1100 where gmdy_acctdt = '3-29-2016' and sltm_id = 53739;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 2000 where gmdy_acctdt = '3-29-2016' and sltm_id = 44673;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 100 where gmdy_acctdt = '3-29-2016' and sltm_id = 43477;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 7300 where gmdy_acctdt = '3-29-2016' and sltm_id = 56093;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 1200 where gmdy_acctdt = '3-29-2016' and sltm_id = 52270;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 200 where gmdy_acctdt = '3-29-2016' and sltm_id = 53730;
--update ACCT_RPT.DROP_DATA set DRPD_SFTCNT_1 = DRPD_SFTCNT_1 + 10000 where gmdy_acctdt = '3-29-2016' and sltm_id = 27616;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 45 where gmdy_acctdt = '1-23-2016' and sltm_id = 55482;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 5029 where gmdy_acctdt = '1-23-2016' and sltm_id = 55065;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 55 where gmdy_acctdt = '1-23-2016' and sltm_id = 55059;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 68 where gmdy_acctdt = '1-24-2016' and sltm_id = 54840;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 13717 where gmdy_acctdt = '1-24-2016' and sltm_id = 55282;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 9100 where gmdy_acctdt = '1-24-2016' and sltm_id = 54831;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 2000 where gmdy_acctdt = '1-24-2016' and sltm_id = 55632;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 30 where gmdy_acctdt = '1-24-2016' and sltm_id = 55484;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 48 where gmdy_acctdt = '1-24-2016' and sltm_id = 55485;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 39 where gmdy_acctdt = '1-24-2016' and sltm_id = 55030;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 32 where gmdy_acctdt = '1-24-2016' and sltm_id = 55485;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 4119 where gmdy_acctdt = '1-24-2016' and sltm_id = 55115;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 10 where gmdy_acctdt = '1-24-2016' and sltm_id = 55382;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 10065 where gmdy_acctdt = '1-24-2016' and sltm_id = 55066;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 5065 where gmdy_acctdt = '1-24-2016' and sltm_id = 55382;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 3300 where gmdy_acctdt = '1-24-2016' and sltm_id = 51331;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 1520 where gmdy_acctdt = '1-24-2016' and sltm_id = 55842;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 2000 where gmdy_acctdt = '1-24-2016' and sltm_id = 55003;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 128 where gmdy_acctdt = '1-24-2016' and sltm_id = 54736;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 960 where gmdy_acctdt = '1-24-2016' and sltm_id = 55425;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 1000 where gmdy_acctdt = '1-24-2016' and sltm_id = 55626;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 4000 where gmdy_acctdt = '1-24-2016' and sltm_id = 55626;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 4000 where gmdy_acctdt = '1-24-2016' and sltm_id = 54831;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 5500 where gmdy_acctdt = '1-24-2016' and sltm_id = 54831;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 5054 where gmdy_acctdt = '1-24-2016' and sltm_id = 55484;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 555 where gmdy_acctdt = '1-24-2016' and sltm_id = 55437;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_CCHP = DRPD_SLIP_CCHP + 9035 where gmdy_acctdt = '3-4-2016' and sltm_id = 55255;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_HPJP = DRPD_SLIP_HPJP + -1100 where gmdy_acctdt = '3-11-2016' and sltm_id = 50782;
--update ACCT_RPT.DROP_DATA set DRPD_SLIP_HPJP = DRPD_SLIP_HPJP + -110 where gmdy_acctdt = '3-14-2016' and sltm_id = 52811;