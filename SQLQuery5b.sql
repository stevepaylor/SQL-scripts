SELECT 'EmailCampaign_' + YEAR(GETDATE()) + '_' + MONTH(GETDATE()) + '_' + DAY(GETDATE()) + '_' +  HH(GETDATE()) + '.xlsx'

"EmailCampaign_" + (DT_WSTR,4)YEAR(GETDATE()) + "_" + (DT_WSTR,4)MONTH(GETDATE()) + "_" + (DT_WSTR,4)DAY(GETDATE()) + "_" +  (DT_WSTR,4)HOUR(GETDATE()) + ".xlsx"

(DT_WSTR,19)REPLACE(LEFT(DT_WSTR,29)GETDATE())," ","_")

"EmailCampaign_" + (DT_WSTR,4)YEAR(GETDATE()) + "_" + (DT_WSTR,4)MONTH(GETDATE()) + "_" + (DT_WSTR,4)DAY(GETDATE()) + "_" + ".xlsx"

REPLACE(REPLACE((DT_WSTR, 29)(DT_DBTIMESTAMP)GETDATE()," ","_")),":",".")

Error: Attempt to parse the expression "@[$Project::EMAIL_CAMPAIGN_ARCHIVE_PATH]" failed and returned error code 0xC00470A6. The expression cannot be parsed. 
It might contain invalid elements or it might not be well-formed. There may also be an out-of-memory error.

@[$Project::EMAIL_CAMPAIGN_ARCHIVE_PATH]
