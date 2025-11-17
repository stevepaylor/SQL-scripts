-- ALTER PROCEDURE	[dbo].[p_open_service_events_template_paginated_by_device_id_sds]
	
DECLARE @DeviceId CHAR(10)=NULL,   /*10/23/2012 | Newgen |ISDS 4.0.2 | Modified DeviceId to contain null values*/
 @EventCode VARCHAR(12) = NULL;


-- 2016-07-28 ADDED FOR TUNING BY S. PAYLOR
DECLARE	@DeviceIdFirstChar CHAR(1)=NULL;
SET @DeviceIdFirstChar = UPPER(LEFT(@DeviceId,1));
		
/*******************************************************************
	[p_open_service_events_template_paginated_by_device_id_sds].sql

	Author: Newgen
	Date:	10/09/2012
	Application:	ISDS
	VSS Location:	
	Description:
		Get open service events for a particluar device(from dbo.DEVICE_ASSOC table). 

	UNIT TEST:
		EXEC p_open_service_events_template_paginated_by_device_id_sds 'C000000200'
	
	CHANGE LOG
	Date		Author	Version		Ticket Number + Description
	-------------------------------------------------------------------------
	10/11/2012	Newgen	ISDS 4.0.0	Implemented changes done by Peter : Commmented some part to get recently assigned events as well 
									and changed to compare only first character of LOCATION_CD.
	10/12/2012	Newgen	ISDS 4.0.0	Implemented changes done by Peter : Commmented last one hour restriction.
	10/16/2012	Newgen	ISDS 4.0.0	Fetch only those assigned events which are assigned using that part. device.
	10/23/2012  Newgen  ISDS 4.0.2  Get all events irrespective of DeviceId(Modified DeviceId to store null value)
	10/29/2012  Newgen  ISDS 4.0.3  No need to check zones if device id is null as it comes from isds manager
	01/24/2013  Newgen  ISDS 4.0.5  Fetch FB Requests as well
	04/04/2013	Newgen	ISDS 5.0.4	Include Event types - Acceptor Malfunction, Acceptor Jammed, Printer Fault (Paper Out)
	04/11/2013  Newgen  ISDS 5.0.5  Add parameter eventCode. Combile Events of types Acceptor Malfunction and Acceptor Jammed
	05/15/2013  Newgen  ISDS 5.0.7  Updated with the sp changes sent by Peter.
	07/03/2013  Newgen  ISDS 5.0.7  Display Jackpots for Managers and Jackpot Amount.
	07/18/2013  Newgen  ISDS 5.0.9  Display all jackpots for all locations and latest for Service Request and FB Request;
									Display Jackpot events other than assigned one for the same location.
	08/29/2013  Newgen  ISDS 5.0.10 Removal of 5 minute check from Dispatch Notification Time and related changes.
	09/09/2013  Newgen  ISDS 5.1.2	Fixed Issue - Different no events are shown on mobile on assignment and unassignment	
	09/17/2013  Newgen  ISDS 5.1.4  Fetch Event codes depending upon TM
	09/19/2013  Newgen  ISDS 5.1.4  Resolved Issue : Extra events are showing up on CSR device.	
	11/13/2013  Newgen  ISDS 5.2.3  Show only events corresponding to assigned zones for Manager device also.
	11/14/2013  Newgen  ISDS 5.2.3  Display jackpot Amounts and Game Description for all type of devices.
	03/07/2014  Newgen  vNTY 5.4.0  Guest Birthday notification in vNotify mobile and web for CSRs & Managers.
	05/21/2014  Newgen  vNTY 5.4.5  Fixed production issue : Events of type “Acceptor Jammed” (code - 092) & “Cassette Jammed” (code - 068) 
									are not displaying under “Acceptor” tab on CSR/CSA device.
	02/27/2015	Newgen	vNTY 5.6.2	vNotify SDS Code: Associate RS Event Code as well with Devices.
									Exception Code, Change Booth, RS Code (last one)
										  176,   107, -1, -1,  064 - Slot Printer Fault
										  176,   155, -1, -1,  066 - Printer Paper Jam
										  176,   211, -1, -1,  063 - Printer Paper Out
										  176,   212, -1, -1,  067 - Printer Paper Low
										  64,				,  001 - Slot Machine Tilt
									- Get events based on IGS_Event_Id & RS_Event_Code.
									- For manager, also get specific events if @EventCode is passed.	
	06/23/2015	Newgen	vNTY 5.6.4	Issue Fixed - If Manager assigns an event to a TM#, then event should be displayed on the assigned 
									TM# device & Manager device only.														
	03/14/2016	Newgen	vNTY 5.6.61	Include "Hot Player" for iPod
***************************************************************************************************************************************/

BEGIN
/*09/17/2013 | Newgen | ISDS 5.1.4 | Fetch Event Codes depending upon device id*/
DECLARE @tblEvents TABLE (IGS_EVENT_ID VARCHAR(12) NOT NULL, RS_EVENT_CODE VARCHAR(3))
--------------
DECLARE @TM_NUM INT
SELECT	@TM_NUM = TEAM_MEMBER_NUM 
FROM	dbo.DEVICE_ASSOC WITH(NOLOCK)
WHERE	DEVICE_ID = @DeviceId

INSERT	@tblEvents
SELECT	tmeca.IGS_EVENT_ID, RS_EVENT_CODE 
FROM	dbo.TEAM_MEMBER_EVENT_CODE_ASSOCIATION tmeca WITH(NOLOCK)
WHERE	tmeca.TEAM_MEMBER_NUM=@TM_NUM 
		AND tmeca.IS_DELETED=0
--------------


DECLARE @tblAssigned TABLE(EVENT_ID INT,EVENT_MASTER_ID INT,--Jul 18, 2013 | NG | Removed ROW INT IDENTITY
		IGS_EVENT_ID VARCHAR(12), EVENT_TS DATETIME, EVENT_DESC VARCHAR(30),DISPATCH_NOTIFICATION_TS DATETIME,
		MACHINE_LOCATION_CD VARCHAR(20)
		,TYPE_DESC CHAR(50),JACKPOT_AMT VARCHAR(50)--07/03/2013 | Newgen | ISDS 5.0.7 | Display Jackpots for Managers and Jackpot Amount.
		,DEVICE_ID CHAR(10)

		,DEVICE_ID_FIRST_CHAR CHAR(1) -- 2016-07-28 ADDED BY S PAYLOR FOR TUNING

		,COMMENTS VARCHAR(500), RS_EVENT_CODE VARCHAR(3), TEAM_MEMBER_NUM INT)--03/10/2014 | Newgen | 5.4.0 | For Bday, comments contain the information.  

/*07/18/2013 | Newgen | ISDS 5.0.9 | temporary table to store jackpot events */		
DECLARE @temptblJackpot TABLE( EVENT_ID INT,EVENT_MASTER_ID INT,
		IGS_EVENT_ID VARCHAR(12), EVENT_TS DATETIME, EVENT_DESC VARCHAR(30),DISPATCH_NOTIFICATION_TS DATETIME,
		MACHINE_LOCATION_CD VARCHAR(20),TYPE_DESC CHAR(50),JACKPOT_AMT VARCHAR(50),
		DEVICE_ID CHAR(10)
		,COMMENTS VARCHAR(500), RS_EVENT_CODE VARCHAR(3), TEAM_MEMBER_NUM INT)--03/10/2014 | Newgen | 5.4.0 | For Bday, comments contain the information.	

--IF (UPPER(LEFT(@DeviceId,1))='M') -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR

IF @DeviceIdFirstChar ='M' -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
BEGIN
INSERT @tblAssigned 
	SELECT DISTINCT	o.EVENT_ID, o.EVENT_MASTER_ID, o.IGS_EVENT_ID, 
			o.EVENT_TS,'Service', o.DISPATCH_NOTIFICATION_TS, vm.STAND_NUMBER 
			,LTRIM(RTRIM(vm.TYPE_DESC)),LTRIM(RTRIM(o.JACKPOT_AMT))--07/04/2013 | Newgen | ISDS 5.0.7 | Display Game Description & Jackpot Amount.
			,oea.DEVICE_ID
			,ISNUll(LTRIM(RTRIM(oea.DEVICE_ID)), -1)
			,o.COMMENTS
			,o.RS_EVENT_CODE
			,oea.TEAM_MEMBER_NUM
	FROM	dbo.OPEN_EVENTS o WITH(NOLOCK)
			INNER JOIN dbo.v_MACHINES_ON_FLOOR vm WITH(NOLOCK) ON vm.STAND_NUMBER = o.LOCATION_CD
			LEFT JOIN dbo.OPEN_EVENT_ACTIVITY oea WITH(NOLOCK) ON o.event_id = oea.event_id
			--LEFT JOIN dbo.TEAM_MEMBER tm ON tm.team_member_num = oea.team_member_num
	WHERE	o.EVENT_CLOSED_TS IS NULL 
	/*01/24/2013 | Newgen | ISDS 4.0.5 | Fetch FB Requests as well*/	
		--AND o.IGS_EVENT_ID IN ('004','065') 
		AND o.IGS_EVENT_ID IN (SELECT t.IGS_EVENT_ID FROM @tblEvents t)
		--('004','065','022','010')--07/04/2013 | Newgen | ISDS 5.0.7 | Added '010'.
	/*10/11/2012 | Newgen | ISDS 4.0.0 | Commented as suggested by Peter to get recently assigned events as well */	
	/*AND
	(
		(
			DATEDIFF(minute,o.DISPATCH_NOTIFICATION_TS,GETDATE()) > 5 And o.DISPATCH_NOTIFICATION_TS IS NOT NULL
		) 
		OR 
		(
			o.DISPATCH_NOTIFICATION_TS is NULL
		) 
	)*/
	AND		o.EVENT_MASTER_ID IS NULL
	--11/13/2013  Newgen  ISDS 5.2.3
 -- AND LEFT(o.LOCATION_CD,1) IN (SELECT LOCATION_CD FROM dbo.TEAM_MEMBER_NOTIFICATION_DEVICE_ASSOC tmnda WITH(NOLOCK)  WHERE ISNUll(tmnda.DEVICE_ID, -1) = ISNUll(@DeviceId, -1) AND SIGN_OUT_TS IS NULL)	/*Get location codes for device id.*/	

	AND o.LocChar1 IN (SELECT LOCATION_CD FROM dbo.TEAM_MEMBER_NOTIFICATION_DEVICE_ASSOC tmnda WITH(NOLOCK) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
	  
		-- WHERE ISNUll(tmnda.DEVICE_ID, -1) = ISNUll(@DeviceId, -1) AND SIGN_OUT_TS IS NULL)	/*Get location codes for device id.*/ -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
	
	   WHERE (tmnda.DEVICE_ID IS NULL AND @DeviceId IS NULL) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
	   OR (tmnda.DEVICE_ID IS NULL AND @DeviceID = -1)
	   OR (tmnda.DEVICE_ID = -1 AND @DeviceId IS NULL)
	   OR (tmnda.DEVICE_ID = -1 AND @DeviceId = -1))

    AND SIGN_OUT_TS IS NULL

	/*10/12/2012 | Newgen | ISDS 4.0.0 | Implemented changes done by Peter : Commmented last one hour restriction.*/
	--AND o.EVENT_TS BETWEEN DATEADD(MINUTE,-60,GETDATE()) AND GETDATE()
	AND
	(
		(@EventCode='087' AND IGS_EVENT_ID IN ('068','087','092') )
		 OR
		--((@EventCode<>'087' OR @EventCode IS NULL) AND IGS_EVENT_ID=ISNULL(@EventCode, IGS_EVENT_ID))
		((@EventCode<>'087' OR @EventCode IS NULL) AND (IGS_EVENT_ID IS NULL OR IGS_EVENT_ID=IGS_EVENT_ID))
	)
END
ELSE
BEGIN
INSERT @tblAssigned 
	SELECT DISTINCT	o.EVENT_ID, o.EVENT_MASTER_ID, o.IGS_EVENT_ID, 
			o.EVENT_TS,'Service', o.DISPATCH_NOTIFICATION_TS, vm.STAND_NUMBER 
			,LTRIM(RTRIM(vm.TYPE_DESC)),LTRIM(RTRIM(o.JACKPOT_AMT))--07/04/2013 | Newgen | ISDS 5.0.7 | Display Game Description & Jackpot Amount.
			,oea.DEVICE_ID
			,ISNUll(LTRIM(RTRIM(oea.DEVICE_ID)), -1)
			,o.COMMENTS
			,o.RS_EVENT_CODE
			,oea.TEAM_MEMBER_NUM
	FROM	dbo.OPEN_EVENTS o WITH(NOLOCK) 
			INNER JOIN dbo.v_MACHINES_ON_FLOOR vm WITH(NOLOCK)  ON vm.STAND_NUMBER = o.LOCATION_CD
			LEFT JOIN dbo.OPEN_EVENT_ACTIVITY oea WITH(NOLOCK)  ON o.event_id = oea.event_id
			--LEFT JOIN dbo.TEAM_MEMBER tm ON tm.team_member_num = oea.team_member_num
	WHERE	o.EVENT_CLOSED_TS IS NULL 
		/*01/24/2013 | Newgen | ISDS 4.0.5 | Fetch FB Requests as well*/	
		--AND o.IGS_EVENT_ID IN ('004','065') 
		--AND o.IGS_EVENT_ID IN ('004','065','022') 
		--04/04/2013 | Newgen |	ISDS | 5.0.4 | Include Event types - Acceptor Malfunction, Acceptor Jammed, Printer Fault (Paper Out)
		AND IGS_EVENT_ID IN (SELECT t.IGS_EVENT_ID FROM @tblEvents t)
		
		------------------------------------------------
		--(
		--( UPPER(LEFT(@DeviceId,1))='T' AND IGS_EVENT_ID IN  ('068','087','092','176'))
		--OR 
		--(UPPER(LEFT(@DeviceId,1))<>'T' AND IGS_EVENT_ID IN ('004','022','065','010'))
		---------------------------------------
		--OR 
		--(UPPER(LEFT(@DeviceId,1))='M' AND IGS_EVENT_ID IN ('010'))--07/03/2013 | Newgen | ISDS 5.0.7 | Display Jackpots for Managers and Jackpot Amount.
		--)
	/*10/11/2012 | Newgen | ISDS 4.0.0 | Commented as suggested by Peter to get recently assigned events as well */	
	/*AND
	(
		(
			DATEDIFF(minute,o.DISPATCH_NOTIFICATION_TS,GETDATE()) > 5 And o.DISPATCH_NOTIFICATION_TS IS NOT NULL
		) 
		OR 
		(
			o.DISPATCH_NOTIFICATION_TS is NULL
		) 
	)*/
	AND		o.EVENT_MASTER_ID IS NULL
	/*10/12/2012 | Newgen | ISDS 4.0.0 | Implemented changes done by Peter : Commmented last one hour restriction.*/
	--AND o.EVENT_TS BETWEEN DATEADD(MINUTE,-60,GETDATE()) AND GETDATE()
	/*10/23/2012 | Newgen |ISDS 4.0.2 | Modified DeviceId to contain null values*/

	--AND LEFT(o.LOCATION_CD,1) IN -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
	-- (SELECT LOCATION_CD FROM dbo.TEAM_MEMBER_NOTIFICATION_DEVICE_ASSOC tmnda WITH (NOLOCK) WHERE ISNUll(tmnda.DEVICE_ID, -1) = ISNUll(@DeviceId, -1) AND SIGN_OUT_TS IS NULL)	/*Get location codes for device id.*/			

	AND o.LocChar1 IN (SELECT LOCATION_CD FROM dbo.TEAM_MEMBER_NOTIFICATION_DEVICE_ASSOC tmnda WITH (NOLOCK) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR

	                    --WHERE ISNUll(tmnda.DEVICE_ID, -1) = ISNUll(@DeviceId, -1) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR

						WHERE (tmnda.DEVICE_ID IS NULL AND @DeviceId IS NULL) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
						   OR (tmnda.DEVICE_ID IS NULL AND @DeviceID = -1)
						   OR (tmnda.DEVICE_ID = -1 AND @DeviceId IS NULL)
						   OR (tmnda.DEVICE_ID = -1 AND @DeviceId = -1))

						  AND SIGN_OUT_TS IS NULL	/*Get location codes for device id.*/			
	/* 09/19/2013 | Newgen | ISDS 5.1.4 | Resolved Issue : Extra events are showing up on CSR device | Commented.
	10/16/2012 | Newgen | ISDS 4.0.0 | Fetch only those assigned events which are assigned using that part. device.
	AND 
	(
		(		
			o.DISPATCH_NOTIFICATION_TS IS NULL		-- unassigned		
		)
		OR
		(
			o.DISPATCH_NOTIFICATION_TS IS NOT NULL		-- assigned
			AND
			/*10/23/2012 | Newgen |ISDS 4.0.2 | Modified DeviceId to contain null values*/
			ISNUll(oea.DEVICE_ID, -1) = ISNUll(@DeviceId, -1)	
		)
	)*/	
	AND
	(
		(@EventCode='087' AND IGS_EVENT_ID IN ('068','087','092') )
		 OR

		--((@EventCode<>'087' OR @EventCode IS NULL) AND IGS_EVENT_ID=ISNULL(@EventCode, IGS_EVENT_ID)) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR 

		((@EventCode<>'087' AND @EventCode IS NOT NULL) AND IGS_EVENT_ID = @EventCode -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR
		 
		 OR
		 
		 (@EventCode<>'087' AND @EventCode IS NULL)) -- 2016-07-28 CHANGED FOR TUNING BY S. PAYLOR  
	)
	--AND IGS_EVENT_ID=ISNULL(@EventCode, IGS_EVENT_ID)
END	



/*	07/18/2013 | Newgen | ISDS 5.0.9 | Jackpot Events. 
	03/10/2014 | Newgen | 5.4.0 | Bday events are similar to Jackpot, so select the same as well.	
*/
INSERT @temptblJackpot 
SELECT EVENT_ID 
	  ,EVENT_MASTER_ID 
	  ,IGS_EVENT_ID
      ,EVENT_TS 
	  ,EVENT_DESC 
	  ,DISPATCH_NOTIFICATION_TS 
	  ,MACHINE_LOCATION_CD	
	  ,TYPE_DESC 
	  ,JACKPOT_AMT
	  ,DEVICE_ID
	  ,COMMENTS
	  ,RS_EVENT_CODE  
	  ,TEAM_MEMBER_NUM
FROM @tblAssigned 
WHERE IGS_EVENT_ID IN ('010', 'BDAY') 
--AND DISPATCH_NOTIFICATION_TS IS NULL /* 08/29/2013 | Newgen | ISDS 5.1.0 */
--OR DATEPART(MINUTE,DISPATCH_NOTIFICATION_TS) > 5 
--GROUP BY MACHINE_LOCATION_CD, IGS_EVENT_ID, EVENT_ID ,EVENT_MASTER_ID ,EVENT_TS ,EVENT_DESC, DISPATCH_NOTIFICATION_TS, TYPE_DESC, JACKPOT_AMT, DEVICE_ID, COMMENTS 

-- 09/09/2013 | Newgen | ISDS 5.1.2 | Fixed Issue - Different no events are shown on mobile on assignment  and unassignment */
DELETE FROM t 
FROM @tblAssigned t
 
CROSS APPLY (SELECT MACHINE_LOCATION_CD,IGS_EVENT_ID, RS_EVENT_CODE 
			FROM @tblAssigned 
			WHERE DISPATCH_NOTIFICATION_TS IS NOT NULL 
			AND MACHINE_LOCATION_CD = t.MACHINE_LOCATION_CD 
			AND IGS_EVENT_ID = t.IGS_EVENT_ID
			AND ISNULL(RS_EVENT_CODE, '') = ISNULL(t.RS_EVENT_CODE, '')) t1
WHERE	DISPATCH_NOTIFICATION_TS IS NULL		

-- 09/09/2013 | Newgen | ISDS 5.1.2 | Fixed Issue - Different no events are shown on mobile on assignment  and unassignment | Commented
--DELETE FROM @tblAssigned 
--WHERE DISPATCH_NOTIFICATION_TS IS NULL
--AND MACHINE_LOCATION_CD IN
--	(
--	SELECT  MACHINE_LOCATION_CD FROM @tblAssigned 
--	WHERE DISPATCH_NOTIFICATION_TS IS NOT NULL /* 08/29/2013 | Newgen | ISDS 5.1.0*/
----WHERE DATEPART(MINUTE,DISPATCH_NOTIFICATION_TS) > 5  /* 08/29/2013 | Newgen */
----AND IGS_EVENT_ID=ISNULL(@EventCode, IGS_EVENT_ID)
--)
--/*07/18/2013 | Newgen | ISDS 5.0.9 */
--AND IGS_EVENT_ID IN
--	(
--	SELECT  IGS_EVENT_ID FROM @tblAssigned 
--	WHERE DISPATCH_NOTIFICATION_TS IS NOT NULL /* 08/29/2013 | Newgen | ISDS 5.1.0*/
----WHERE DATEPART(MINUTE,DISPATCH_NOTIFICATION_TS) > 5/* 08/29/2013 | Newgen */  
----AND IGS_EVENT_ID=ISNULL(@EventCode, IGS_EVENT_ID)
--)

DELETE FROM @tblAssigned 
WHERE EVENT_ID NOT IN
	(
	SELECT  MAX(EVENT_ID) FROM @tblAssigned 
WHERE IGS_EVENT_ID NOT IN ('010', 'BDAY')-- AND (DISPATCH_NOTIFICATION_TS IS NULL /* 08/29/2013 | Newgen | ISDS 5.1.0*/
--OR DATEPART(MINUTE,DISPATCH_NOTIFICATION_TS) > 5
--) 
GROUP BY MACHINE_LOCATION_CD,IGS_EVENT_ID, RS_EVENT_CODE
)

INSERT @tblAssigned 
  SELECT EVENT_ID 
		,EVENT_MASTER_ID 
		,IGS_EVENT_ID
		,EVENT_TS 
		,EVENT_DESC 
		,DISPATCH_NOTIFICATION_TS 
		,MACHINE_LOCATION_CD	
		,TYPE_DESC 
		,JACKPOT_AMT
		,DEVICE_ID
		,ISNUll(LTRIM(RTRIM(DEVICE_ID)), -1)
		,COMMENTS
		,RS_EVENT_CODE
		,TEAM_MEMBER_NUM   
FROM @temptblJackpot

SELECT DISTINCT
		EVENT_ID,
		CASE IGS_EVENT_ID
			WHEN '068' THEN '087'
			WHEN '092' THEN '087'			
			ELSE IGS_EVENT_ID
		END
		AS	
		IGS_EVENT_ID,
		convert(char(8), EVENT_TS, 108) AS EVENT_TS, 
		CASE IGS_EVENT_ID
			WHEN '065' THEN 'Change Request' 
			/*01/24/2013 | Newgen | ISDS 4.0.5 | Fetch FB Requests as well*/
			--ELSE 'Service Request'
			WHEN '004' THEN 'Service Request'
			WHEN '008'	THEN 'Hot Player' 
			WHEN '022' THEN 'FB Request'
			WHEN '068' THEN 'Cassette Jammed'
			WHEN '087' THEN 'Acceptor Malfunction'
			WHEN '092' THEN 'Acceptor Jammed'
			WHEN '176'	THEN --'Printer Fault'
				CASE RS_EVENT_CODE
					WHEN '063' THEN 'Printer Paper Out'
					WHEN '064' THEN 'Slot Printer Fault'
					WHEN '066' THEN 'Printer Paper Jam'
					WHEN '067' THEN 'Printer Paper Low'
					ELSE 'Printer Paper Out' -- Default to make compatible with last version
				END
			WHEN '64'	THEN 
				CASE RS_EVENT_CODE
					WHEN '001' THEN 'Slot Machine Tilt'
				END
			WHEN '010' THEN 'Jackpot'--07/03/2013 | Newgen | ISDS 5.0.7 | Display Jackpots for Managers and Jackpot Amount.
			WHEN 'BDAY' THEN 'Guest Birthday'--03/10/2014 | Newgen | 5.4.0 | For Bday.
		END
		as EVENT_DESC,
		CONVERT(char(8), DISPATCH_NOTIFICATION_TS, 108) AS DISPATCH_NOTIFICATION_TS,
		MACHINE_LOCATION_CD,
		CASE--07/03/2013 | Newgen | ISDS 5.0.8 | Display Game Description for managers and blank in all other cases.
			WHEN  IGS_EVENT_ID='010' --AND UPPER(LEFT(@DeviceId,1))='C' -- 11/14/2013 | Newgen | ISDS 5.2.3 | Display jackpot Amounts and Game Description for all type of devices. 
			THEN ISNULL(LTRIM(RTRIM(TYPE_DESC)),' ')
			ELSE ' '
		END
		AS TYPE_DESC,
		CASE --07/03/2013 | Newgen | ISDS 5.0.7 | Display Jackpot Amount for managers and -1 in all other cases.
			WHEN IGS_EVENT_ID='010' --AND UPPER(LEFT(@DeviceId,1))='C' -- 11/14/2013 | Newgen | ISDS 5.2.3 | Display jackpot Amounts and Game Description for all type of devices. 
			THEN ISNULL(LTRIM(RTRIM(JACKPOT_AMT)),'-1')
			ELSE '-1'
		END
		AS JACKPOT_AMT
		,COMMENTS
	 FROM @tblAssigned
	 /* 09/19/2013 | Newgen | ISDS 5.1.4 | Resolved Issue : Extra events are showing up on CSR device.*/
	 WHERE	(		
				DISPATCH_NOTIFICATION_TS IS NULL		-- unassigned		
			)
			OR
			(
				DISPATCH_NOTIFICATION_TS IS NOT NULL		-- assigned
				AND
				(
				    -- UPPER(LEFT(@DeviceId,1))='M' -- 2016-07-28 changed for tuning by S. Paylor
					@DeviceIdFirstChar = 'M'-- 2016-07-28 changed for tuning by S. Paylor
					OR
					--UPPER(LEFT(DEVICE_ID,1))='M'
					TEAM_MEMBER_NUM = @TM_NUM
					OR
					DEVICE_ID_FIRST_CHAR = @DeviceIdFirstChar
				)
			)
			
	 /* 08/29/2013 | Newgen | ISDS 5.1.0 */
	--WHERE MACHINE_LOCATION_CD NOT IN
	--(SELECT o.LOCATION_CD FROM OPEN_EVENTS o
	--  /*01/24/2013 | Newgen | ISDS 4.0.5 | Fetch FB Requests as well*/
	--  --WHERE  o.IGS_EVENT_ID IN ('004','065')
	--		--WHERE  o.IGS_EVENT_ID IN ('004','065','022') 
	--		--WHERE  o.IGS_EVENT_ID IN ('004','065','022')
	--		--04/04/2013 | Newgen |	ISDS | 5.0.4 | Include Event types - Acceptor Malfunction, Acceptor Jammed, Printer Fault (Paper Out)
	--		WHERE
	--		(
	--	( UPPER(LEFT(@DeviceId,1))='T' AND o.IGS_EVENT_ID IN  ('068','087','092','176'))
	--	OR 
	--	(UPPER(LEFT(@DeviceId,1))<>'T' AND o.IGS_EVENT_ID IN ('004','022','065','010'))
	--	--OR 
	--	--(UPPER(LEFT(@DeviceId,1))='M' AND o.IGS_EVENT_ID IN ('010'))--07/03/2013 | Newgen | ISDS 5.0.7 | Display Jackpots for Managers and Jackpot Amount.
	--	)
		
	--		AND DATEPART(MINUTE,o.DISPATCH_NOTIFICATION_TS) <= 5 
	--		)
			
	GROUP BY EVENT_ID, IGS_EVENT_ID, EVENT_TS, DISPATCH_NOTIFICATION_TS, MACHINE_LOCATION_CD,TYPE_DESC,JACKPOT_AMT,COMMENTS,RS_EVENT_CODE
	ORDER BY DISPATCH_NOTIFICATION_TS DESC,EVENT_TS DESC 
	

END