TRUNCATE TABLE [StayDWH].dbo.outlets
GO
INSERT INTO [StayDWH].dbo.outlets 
SELECT * 
--INTO [StayDWH].dbo.outlets 
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT * FROM public.outlets') ;
GO

TRUNCATE TABLE [StayDWH].dbo.payment_methods
GO
INSERT INTO [StayDWH].dbo.payment_methods
SELECT *
--INTO [StayDWH].dbo.payment_methods
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT * FROM public.payment_methods') ;
GO

TRUNCATE TABLE [StayDWH].dbo.meal_periods
GO
INSERT INTO [StayDWH].dbo.meal_periods
SELECT *
--INTO [StayDWH].dbo.meal_periods
FROM OPENQUERY(Stay_PostgreSQL,
'SELECT * FROM public.meal_periods') ;
GO