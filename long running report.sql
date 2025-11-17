SELECT 			
							guest.GUEST_ID,
							guest.FIRST_NM,
			 				guest.INITIAL_NM,
			 				guest.LAST_NM,
			 				guest.DOB,
			 				CONVERT(VARCHAR(50),dbo.[Decrypt](guest.[SSN])) AS SSN,
			 				guest.VCLUB_NUM,
			 				CASE WHEN guest.GENDER IS NOT NULL
			 					 THEN CASE WHEN guest.GENDER = 1 THEN 'Male' ELSE 'Female' END
			 					 ELSE 'NA' END as GENDER,
			 				guest.RACE,
			 				guest.HAIR,
			 				guest.[TOP],
			 				guest.TOP_COLOR,
			 				guest.BOTTOMS,
			 				guest.BOT_COLOR,
			 				guest.FOOTWEAR,
			 				guest.FOOTWEAR_COLOR,
			 				guest.ID_MARK,
			 				guest.STREET_ADDR,
			 				guest.APARTMENT,
			 				guest.CITY,
			 				guest.STATE_PROVINCE,
			 				guest.ZIP,			 				
			 				guest.MISC_DESC,			 				
			 				gt.GUEST_TYPE_ID, 
			 				gt.GUEST_TYPE_NM
			,(SELECT  HEIGHT_NM FROM HEIGHT_REF h WITH (NOLOCK) WHERE h.HEIGHT_ID  = guest.HEIGHT)AS HEIGHT_NM
			,(SELECT  WEIGHT_NM FROM WEIGHT_REF w WITH (NOLOCK) WHERE w.WEIGHT_ID = guest.WEIGHT) AS WEIGHT_NM
			
			,(
				SELECT ISNULL(SUM(mtl.AMOUNT),0) FROM MTL mtl WITH (NOLOCK) 
				WHERE mtl.CASH_FLOW = 'true'
				AND
				mtl.LOCATION_ID IN 
					(SELECT LOCATION_ID FROM LOCATION WITH (NOLOCK) WHERE LOCATION_TYPE_ID = CASE WHEN @location_type_id = -1 THEN LOCATION_TYPE_ID ELSE @location_type_id END)
				
				AND
				(	mtl.GUEST_ID = guest.GUEST_ID 
					OR mtl.GUEST_ID IN (SELECT AssociatedGuestID FROM #ASS_GUESTS_TBL tempTbl WHERE tempTbl.GuestID = guest.GUEST_ID)
				)
				AND mtl.IS_DELETED = 'false'
			  ) AS CASH_IN_AMT
			
			,(
				SELECT ISNULL(SUM(mtl.AMOUNT),0) FROM MTL mtl WITH (NOLOCK)
				WHERE mtl.CASH_FLOW = 'false' 
				AND 
				mtl.LOCATION_ID IN 
					(SELECT LOCATION_ID FROM LOCATION WITH (NOLOCK) WHERE LOCATION_TYPE_ID = CASE WHEN @location_type_id = -1 THEN LOCATION_TYPE_ID ELSE @location_type_id END)
				AND
			    (  mtl.GUEST_ID = guest.GUEST_ID 
			       OR mtl.GUEST_ID IN (SELECT AssociatedGuestID FROM #ASS_GUESTS_TBL tempTbl WHERE tempTbl.GuestID = guest.GUEST_ID)
			     )
			     AND mtl.IS_DELETED = 'false'
			  ) AS CASH_OUT_AMT 
			
			,(SELECT TOP 1 ICTR_ID FROM ICTR WITH (NOLOCK) WHERE GUEST_ID = guest.GUEST_ID AND IS_DELETED = 'false') AS ICTR_ID
			
			,(
				SELECT TOP 1 ga.COMMON_BANKROLL_ID--ga.LINKED_GUEST_ID 
				FROM GUEST_ASSOCIATION ga  WITH (NOLOCK)
				WHERE ga.GUEST_ID = guest.GUEST_ID  				
			  ) as GUEST_GROUP_ID			
			  
			,(
				SELECT TOP 1 ga.LINKED_GUEST_ID 
				FROM GUEST_ASSOCIATION ga WITH (NOLOCK)
				WHERE ga.GUEST_ID = guest.GUEST_ID  				
			  ) as SAME_GUEST_ID  
			  
			,lock.LOCK_ID
			, lock.LOCK_TIME
			, lock.LOCATION_TYPE_ID
			, lock.IS_MNGR_LOCK
			, lock.IS_AC_LOCK
			, lock.LOCKED_BY_TM
			, lock.IS_AC_SUBMIT
			, lock.SUBMIT_BY_TM
			FROM dbo.GUEST guest WITH (NOLOCK)
			JOIN dbo.GUEST_TYPE_REF gt WITH (NOLOCK) ON gt.GUEST_TYPE_ID = guest.GUEST_TYPE_ID						
			LEFT JOIN dbo.LOCATION_LOCK_STATUS lock WITH (NOLOCK) ON ((lock.LOCATION_TYPE_ID = CASE WHEN @location_type_id = -1 THEN lock.LOCATION_TYPE_ID ELSE @location_type_id END ) AND LOCK_TIME BETWEEN
			DATEADD("s",7200, convert(varchar(10),@gaming_day,111)) and  DATEADD("s",93599,convert(varchar(10), @gaming_day,111 )))	
			WHERE 			
			
			GAMING_DT BETWEEN 
			DATEADD("s",7200, convert(varchar(10),@gaming_day,111)) and  DATEADD("s",93599,convert(varchar(10), @gaming_day,111 ))
			    
			ORDER BY 
			CASE WHEN guest.LAST_NM IS NULL THEN 'zzz' ELSE guest.LAST_NM END ASC,
			CASE WHEN guest.FIRST_NM IS NULL THEN 'zzz' ELSE guest.FIRST_NM END ,
			CASE WHEN guest.INITIAL_NM IS NULL THEN 'zzz' ELSE guest.INITIAL_NM END,
			CASE WHEN guest.GENDER IS NULL THEN '0' ELSE guest.GENDER END DESC,
			CASE WHEN guest.RACE IS NULL THEN 'zzz' ELSE guest.RACE END ASC