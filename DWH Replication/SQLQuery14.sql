SELECT --TOP 10000
 PlayerID
,LoadDTTM
FROM [iQ-Gaming].dbo.IQC_Player
WHERE LoadDTTM >= (SELECT Last_LoadDTTM FROM [iQ-Gaming].dbo.WK_Player_LoadDTTM)
ORDER BY LoadDTTM DESC
GO

SELECT *
FROM [iQ-Gaming].dbo.WK_Player_LoadDTTM
GO

TRUNCATE TABLE [iQ-Gaming].dbo.WK_Player_LoadDTTM
GO

INSERT INTO [iQ-Gaming].dbo.WK_Player_LoadDTTM
SELECT 
MAX(LoadDTTM) AS Last_LoadDTTM
--INTO [iQ-Gaming].dbo.WK_Player_LoadDTTM 
FROM [iQ-Gaming].dbo.IQC_Player
GO

SELECT *
FROM [iQ-Gaming].dbo.WK_Player_LoadDTTM
GO


