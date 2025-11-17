SELECT 
    [Extent1].[ID] AS [ID], 
    [Extent1].[Account] AS [Account], 
    [Extent1].[TagCode] AS [TagCode], 
    [Extent1].[Attempts] AS [Attempts], 
    [Extent1].[FileGuid] AS [FileGuid]
    FROM [dbo].[AccountsTags] AS [Extent1]
    WHERE (0 = [Extent1].[IsCMPTagged]) AND (0 = [Extent1].[Attempts])



	SELECT 
    [Project1].[ID] AS [ID], 
    [Project1].[Account] AS [Account], 
    [Project1].[TagCode] AS [TagCode], 
    [Project1].[Attempts] AS [Attempts], 
    [Project1].[FileGuid] AS [FileGuid]
    FROM ( SELECT 
        [Extent1].[ID] AS [ID], 
        [Extent1].[Account] AS [Account], 
        [Extent1].[TagCode] AS [TagCode], 
        [Extent1].[Attempts] AS [Attempts], 
        [Extent1].[FileGuid] AS [FileGuid]
        FROM [dbo].[AccountsTags] AS [Extent1]
        WHERE (0 = [Extent1].[IsCMPTagged]) AND ([Extent1].[Attempts] <= @p__linq__0)
    )  AS [Project1]
    ORDER BY [Project1].[Attempts] ASC