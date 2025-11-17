TRUNCATE TABLE CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail
GO

INSERT INTO CMP13_PLAYER_EMAIL_DEV.dbo.tPlayerEmail
SELECT *
--FROM [CMP13_PROD_live_mount_0722_Noon].[dbo].[tPlayerEmail]
FROM CMKTDB13DPR.[CMP13].[dbo].[tPlayerEmail]

	-- (798451 rows affected)
	-- (799729 rows affected)
	-- (799732 rows affected)
		--(797013 rows affected)