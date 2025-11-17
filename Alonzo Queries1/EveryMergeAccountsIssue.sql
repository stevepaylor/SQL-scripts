
-- 12154656   OLD ACCOUNT    
-- 21154867   NEW ACCOUNT

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 10 *
  FROM [EveriTitle31].[dbo].[T31_TrxPatron]
  where (lastname like 'Chavez' and FirstName='Ronald') or PatronID in ('12154656', '21154867')
  order by GamingDate asc

  GO

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 10 *
  FROM [EveriTitle31].[dbo].[T31_Customer]
  where PatronId in ('12154656', '21154867')

GO

select top 10 * from T31_TrxPatron
 where PatronId in ('12154656', '21154867')

GO 

select top 10 * from T31_TrxPatronDescription
where PatronId in ('12154656', '21154867')


