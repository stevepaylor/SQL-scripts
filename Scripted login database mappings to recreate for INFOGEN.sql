Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoUser')
CREATE USER [InfoUser] FOR LOGIN [InfoUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoUser]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoUser')
CREATE USER [InfoUser] FOR LOGIN [InfoUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoUser]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nbrown')
CREATE USER [VIEJAS\nbrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nbrown]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWUser')
CREATE USER [DWUser] FOR LOGIN [DWUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DWUser]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoRead')
CREATE USER [InfoRead] FOR LOGIN [InfoRead] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoRead]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_app;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser1')
CREATE USER [dashboardUser1] FOR LOGIN [dashboardUser1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser1]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sbauer')
CREATE USER [VIEJAS\sbauer] FOR LOGIN [VIEJAS\sbauer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sbauer]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser')
CREATE USER [dashboardUser] FOR LOGIN [dashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ewallace')
CREATE USER [VIEJAS\ewallace] FOR LOGIN [VIEJAS\ewallace] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ewallace]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kerazo')
CREATE USER [VIEJAS\kerazo] FOR LOGIN [VIEJAS\kerazo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kerazo]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\apham')
CREATE USER [VIEJAS\apham] FOR LOGIN [VIEJAS\apham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\apham]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Datamart')
CREATE USER [VIEJAS\Datamart] FOR LOGIN [VIEJAS\Datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Datamart]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\llofstrom')
CREATE USER [VIEJAS\llofstrom] FOR LOGIN [VIEJAS\llofstrom] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\llofstrom]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DMehta')
CREATE USER [VIEJAS\DMehta] FOR LOGIN [VIEJAS\DMehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DMehta]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports')
CREATE USER [pos_reports] FOR LOGIN [pos_reports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports1')
CREATE USER [pos_reports1] FOR LOGIN [pos_reports1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports1]'; 
Go
Use ig_business;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sbauer')
CREATE USER [VIEJAS\sbauer] FOR LOGIN [VIEJAS\sbauer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sbauer]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\datamart')
CREATE USER [VIEJAS\datamart] FOR LOGIN [VIEJAS\datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\datamart]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ewallace')
CREATE USER [VIEJAS\ewallace] FOR LOGIN [VIEJAS\ewallace] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ewallace]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'viejas\dclarke')
CREATE USER [viejas\dclarke] FOR LOGIN [viejas\dclarke] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[viejas\dclarke]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ztoma')
CREATE USER [VIEJAS\ztoma] FOR LOGIN [VIEJAS\ztoma] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ztoma]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWUser')
CREATE USER [DWUser] FOR LOGIN [DWUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DWUser]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser1')
CREATE USER [dashboardUser1] FOR LOGIN [dashboardUser1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser1]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kerazo')
CREATE USER [VIEJAS\kerazo] FOR LOGIN [VIEJAS\kerazo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kerazo]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\apham')
CREATE USER [VIEJAS\apham] FOR LOGIN [VIEJAS\apham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\apham]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser')
CREATE USER [dashboardUser] FOR LOGIN [dashboardUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\llofstrom')
CREATE USER [VIEJAS\llofstrom] FOR LOGIN [VIEJAS\llofstrom] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\llofstrom]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DMehta')
CREATE USER [VIEJAS\DMehta] FOR LOGIN [VIEJAS\DMehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DMehta]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'cmpDW')
CREATE USER [cmpDW] FOR LOGIN [cmpDW] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[cmpDW]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports')
CREATE USER [pos_reports] FOR LOGIN [pos_reports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports1')
CREATE USER [pos_reports1] FOR LOGIN [pos_reports1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports1]'; 
Go
Use ig_dimension;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\BIWEB')
CREATE USER [VIEJAS\BIWEB] FOR LOGIN [VIEJAS\BIWEB] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\BIWEB]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_log;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_revconfig;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_revconfig_EXP;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWUser')
CREATE USER [DWUser] FOR LOGIN [DWUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DWUser]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\AJohnson]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\SLewis]'; 
Go
Use ig_task;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\oreva')
CREATE USER [VIEJAS\oreva] FOR LOGIN [VIEJAS\oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\oreva]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[VIEJAS\GDiVincent]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use ig_transaction;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoUser')
CREATE USER [InfoUser] FOR LOGIN [InfoUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[InfoUser]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ewallace')
CREATE USER [VIEJAS\ewallace] FOR LOGIN [VIEJAS\ewallace] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ewallace]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sbauer')
CREATE USER [VIEJAS\sbauer] FOR LOGIN [VIEJAS\sbauer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sbauer]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbadmin')
CREATE USER [dbadmin] FOR LOGIN [dbadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbadmin]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[jjones]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[jjones]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'gagent')
CREATE USER [gagent] FOR LOGIN [gagent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[gagent]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[avizcarra]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[avizcarra]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nbrown')
CREATE USER [VIEJAS\nbrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\nbrown]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\squagmire')
CREATE USER [VIEJAS\squagmire] FOR LOGIN [VIEJAS\squagmire] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\squagmire]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\squagmire')
CREATE USER [VIEJAS\squagmire] FOR LOGIN [VIEJAS\squagmire] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\squagmire]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'viejas\cmkt')
CREATE USER [viejas\cmkt] FOR LOGIN [viejas\cmkt] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[viejas\cmkt]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kerazo')
CREATE USER [VIEJAS\kerazo] FOR LOGIN [VIEJAS\kerazo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kerazo]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ztoma')
CREATE USER [VIEJAS\ztoma] FOR LOGIN [VIEJAS\ztoma] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ztoma]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\gcole')
CREATE USER [VIEJAS\gcole] FOR LOGIN [VIEJAS\gcole] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\gcole]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\lpetsch')
CREATE USER [VIEJAS\lpetsch] FOR LOGIN [VIEJAS\lpetsch] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\lpetsch]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\rperalta')
CREATE USER [VIEJAS\rperalta] FOR LOGIN [VIEJAS\rperalta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\rperalta]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'datamart')
CREATE USER [datamart] FOR LOGIN [datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[datamart]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'viejas\datamart')
CREATE USER [viejas\datamart] FOR LOGIN [viejas\datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[viejas\datamart]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'POSReports')
CREATE USER [POSReports] FOR LOGIN [POSReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[POSReports]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\biweb')
CREATE USER [VIEJAS\biweb] FOR LOGIN [VIEJAS\biweb] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\biweb]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\VBI_Pos')
CREATE USER [VIEJAS\VBI_Pos] FOR LOGIN [VIEJAS\VBI_Pos] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\VBI_Pos]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DWUser')
CREATE USER [DWUser] FOR LOGIN [DWUser] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[DWUser]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\apham')
CREATE USER [VIEJAS\apham] FOR LOGIN [VIEJAS\apham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\apham]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoRead')
CREATE USER [InfoRead] FOR LOGIN [InfoRead] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoRead]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\erevak')
CREATE USER [VIEJAS\erevak] FOR LOGIN [VIEJAS\erevak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\erevak]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\vmena')
CREATE USER [VIEJAS\vmena] FOR LOGIN [VIEJAS\vmena] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\vmena]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\llofstrom')
CREATE USER [VIEJAS\llofstrom] FOR LOGIN [VIEJAS\llofstrom] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\llofstrom]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DMehta')
CREATE USER [VIEJAS\DMehta] FOR LOGIN [VIEJAS\DMehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DMehta]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TDeleon')
CREATE USER [VIEJAS\TDeleon] FOR LOGIN [VIEJAS\TDeleon] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TDeleon]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports')
CREATE USER [pos_reports] FOR LOGIN [pos_reports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports1')
CREATE USER [pos_reports1] FOR LOGIN [pos_reports1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports1]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'YellowDog')
CREATE USER [YellowDog] FOR LOGIN [YellowDog] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[YellowDog]'; 
Go
Use it_cfg;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbadmin')
CREATE USER [dbadmin] FOR LOGIN [dbadmin] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbadmin]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[jjones]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[jjones]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[avizcarra]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[avizcarra]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nbrown')
CREATE USER [VIEJAS\nbrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\nbrown]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_ga;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_perms;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'splunk_user')
CREATE USER [splunk_user] FOR LOGIN [splunk_user] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[splunk_user]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nsilverthorn')
CREATE USER [VIEJAS\nsilverthorn] FOR LOGIN [VIEJAS\nsilverthorn] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\nsilverthorn]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[jjones]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jjones')
CREATE USER [jjones] FOR LOGIN [jjones] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[jjones]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[avizcarra]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'avizcarra')
CREATE USER [avizcarra] FOR LOGIN [avizcarra] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[avizcarra]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nbrown')
CREATE USER [VIEJAS\nbrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\nbrown]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_rlt;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
Use it_sysweb;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dbo')
CREATE USER [dbo] FOR LOGIN [dbo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[dbo]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\sbauer')
CREATE USER [VIEJAS\sbauer] FOR LOGIN [VIEJAS\sbauer] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\sbauer]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\ewallace')
CREATE USER [VIEJAS\ewallace] FOR LOGIN [VIEJAS\ewallace] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\ewallace]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\jgiolitto')
CREATE USER [VIEJAS\jgiolitto] FOR LOGIN [VIEJAS\jgiolitto] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\jgiolitto]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\kerazo')
CREATE USER [VIEJAS\kerazo] FOR LOGIN [VIEJAS\kerazo] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\kerazo]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\lpetsch')
CREATE USER [VIEJAS\lpetsch] FOR LOGIN [VIEJAS\lpetsch] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\lpetsch]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\BIWEB')
CREATE USER [VIEJAS\BIWEB] FOR LOGIN [VIEJAS\BIWEB] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\BIWEB]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SQuagmire')
CREATE USER [VIEJAS\SQuagmire] FOR LOGIN [VIEJAS\SQuagmire] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[VIEJAS\SQuagmire]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SQuagmire')
CREATE USER [VIEJAS\SQuagmire] FOR LOGIN [VIEJAS\SQuagmire] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SQuagmire]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'POSReports')
CREATE USER [POSReports] FOR LOGIN [POSReports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[POSReports]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\cmkt')
CREATE USER [VIEJAS\cmkt] FOR LOGIN [VIEJAS\cmkt] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\cmkt]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\Datamart')
CREATE USER [VIEJAS\Datamart] FOR LOGIN [VIEJAS\Datamart] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\Datamart]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\apham')
CREATE USER [VIEJAS\apham] FOR LOGIN [VIEJAS\apham] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\apham]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[InfoETLreader]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'InfoETLreader')
CREATE USER [InfoETLreader] FOR LOGIN [InfoETLreader] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[InfoETLreader]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'dashboardUser2')
CREATE USER [dashboardUser2] FOR LOGIN [dashboardUser2] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[dashboardUser2]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'michael')
CREATE USER [michael] FOR LOGIN [michael] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_owner', N'[michael]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\erevak')
CREATE USER [VIEJAS\erevak] FOR LOGIN [VIEJAS\erevak] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\erevak]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\vmena')
CREATE USER [VIEJAS\vmena] FOR LOGIN [VIEJAS\vmena] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\vmena]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\llofstrom')
CREATE USER [VIEJAS\llofstrom] FOR LOGIN [VIEJAS\llofstrom] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\llofstrom]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[oreva]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'oreva')
CREATE USER [oreva] FOR LOGIN [oreva] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datawriter', N'[oreva]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\DMehta')
CREATE USER [VIEJAS\DMehta] FOR LOGIN [VIEJAS\DMehta] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\DMehta]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SWright')
CREATE USER [VIEJAS\SWright] FOR LOGIN [VIEJAS\SWright] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SWright]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\agoldberg')
CREATE USER [VIEJAS\agoldberg] FOR LOGIN [VIEJAS\agoldberg] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\agoldberg]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'python01')
CREATE USER [python01] FOR LOGIN [python01] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[python01]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\GDiVincent')
CREATE USER [VIEJAS\GDiVincent] FOR LOGIN [VIEJAS\GDiVincent] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\GDiVincent]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SDraper')
CREATE USER [VIEJAS\SDraper] FOR LOGIN [VIEJAS\SDraper] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SDraper]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\TDeleon')
CREATE USER [VIEJAS\TDeleon] FOR LOGIN [VIEJAS\TDeleon] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\TDeleon]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\AJohnson')
CREATE USER [VIEJAS\AJohnson] FOR LOGIN [VIEJAS\AJohnson] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\AJohnson]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports')
CREATE USER [pos_reports] FOR LOGIN [pos_reports] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\SLewis')
CREATE USER [VIEJAS\SLewis] FOR LOGIN [VIEJAS\SLewis] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[VIEJAS\SLewis]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'pos_reports1')
CREATE USER [pos_reports1] FOR LOGIN [pos_reports1] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[pos_reports1]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'YellowDog')
CREATE USER [YellowDog] FOR LOGIN [YellowDog] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[YellowDog]'; 
Go
Use it_trn;
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'OptXusr')
CREATE USER [OptXusr] FOR LOGIN [OptXusr] WITH DEFAULT_SCHEMA=[dbo]; 
GO
EXEC sp_addrolemember N'db_datareader', N'[OptXusr]'; 
Go
