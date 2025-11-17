DECLARE @LASTREC AS VARCHAR(MAX);

SET @LASTREC = (
SELECT TOP 1 
 'INSERTED_TIMESTAMP: ' + LTRIM(CONVERT(CHAR(23),INSERTED_TIMESTAMP,121))
 + '  -  EVENT_ID: ' + LTRIM(CAST(EVENT_ID AS VARCHAR(9))) +
 + '  -  MESSAGE_TYPE: ' + LTRIM(MESSAGE_TYPE)
 + '  -  TRANSACTION_CODE: ' + LTRIM(TRANSACTION_CODE) 
 + '  -  SDS_RECORD_ID: ' + LTRIM(SDS_RECORD_ID)
 + '  -  SDS_EXCEPTION_CODE: ' + LTRIM(SDS_EXCEPTION_CODE)
 + '  -  MACHINE_SERIAL_NUMBER: ' + LTRIM(MACHINE_SERIAL_NUMBER)
 + '  -  STAND ' + LTRIM(STAND)
 + '  -  COIN_IN: ' + LTRIM(COIN_IN)
 + '  -  COIN_OUT: ' + LTRIM(COIN_OUT)
 + '  -  COINS_TO_DROP: ' + LTRIM(COINS_TO_DROP)
 + '  -  HP_JACKPOT_TRANSACTION: ' + LTRIM(HP_JACKPOT_TRANSACTION)
 + '  -  HP_JACKPOT_ACCUMULATED: ' + LTRIM(HP_JACKPOT_ACCUMULATED)
 + '  -  HP_JACKPOT_CASHOUT: ' + LTRIM(HP_JACKPOT_CASHOUT)
 + '  -  GAMES_PLAYED: ' + LTRIM(GAMES_PLAYED)
 + '  -  BILLS_TOTAL: ' + LTRIM(BILLS_TOTAL)
 + '  -  BILLS_1: ' + LTRIM(BILLS_1)
 + '  -  BILLS_5: ' + LTRIM(BILLS_5)
 + '  -  BILLS_10: ' + LTRIM(BILLS_10)
 + '  -  BILLS_20: ' + LTRIM(BILLS_20)
 + '  -  BILLS_50: ' + LTRIM(BILLS_50)
 + '  -  BILLS_100: ' + LTRIM(BILLS_100)
 + '  -  RESERVED: ' + LTRIM(RESERVED)
 + '  -  EVENT_CODE: ' + LTRIM(EVENT_CODE)
 + '  -  EVENT_DATE: ' + LTRIM(EVENT_DATE)
 + '  -  EVENT_TIME: ' + LTRIM(EVENT_TIME)
 + '  -  RS_MESSAGE: ' + LTRIM(RS_MESSAGE)
FROM SLOT_SERVICE..SDS_RS_LOAD
ORDER BY INSERTED_TIMESTAMP DESC
);

DECLARE @CTR AS INT;

SET @CTR = (SELECT COUNT(*) FROM SLOT_SERVICE..SDS_RS_LOAD WHERE DATEDIFF(MINUTE,INSERTED_TIMESTAMP,CURRENT_TIMESTAMP) < 16);

IF @CTR = 0
BEGIN
  DECLARE @HTML NVARCHAR(MAX) ;

  SET @HTML =
  '<table>
      <tr>
	   <th>
	     ALERT: There are no records in database for Slot dispatch in the last 15 minutes.
	   </th>
     </tr>
      
    <tr>
      <td>-------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
    </tr>
     
    <tr>
      <td>Database Server: CASIVC07PR</td>
    </tr>
  
    <tr>
      <td>Database: SLOT_SERVICE</td>
    </tr>

    <tr>
      <td>Table: SDS_RS_LOAD</td>
    </tr>

    <tr>
      <td>Field: INSERTED_TIMESTAMP</td>
    </tr>

	<tr>
      <td>-------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
    </tr>
  </table>
  
  <table>
      <tr>
	   <th>
	     Recommended steps to resolve the issue:
	   </th>
     </tr>
    <tr>
      <td>1. Restart the Pipe #2 on SDS</td>
    </tr>
 
    <tr>
      <td>2. Restart the SDS_RS_POLLING on PAGEAP01PR</td>
    </tr>
          
    <tr>
      <td>3. Check vNotify for incoming messages</td>
    </tr>
          
    <tr>
      <td>Refrence: http://spwkap01pr/tickets/list/single_ticket/25247</td>
    </tr>
          
    <tr>
      <td>-------------------------------------------------------------------------------------------------------------------------------------------------------------</td>
    </tr>
     
    <tr>
      <td>Last Record Stored: </td>
    </tr>

  </table>'
  
  + @LASTREC
  ;

	EXEC msdb.dbo.sp_send_dbmail
	 --@recipients='spaylor@VIEJAS.COM'
	 @recipients='_itdba@VIEJAS.COM'
	,@subject ='ALERT: Slot Dispatch Activity Stopped'
	,@body= @HTML
	,@body_format = 'HTML' 
	,@profile_name = 'CASIVC07pr';
END