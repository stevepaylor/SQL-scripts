USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [LNW_SA]    Script Date: 10/1/2024 3:18:34 PM ******/
CREATE LOGIN [LNW_SA] WITH PASSWORD=N'LNWadmin123456!', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO


ALTER SERVER ROLE [sysadmin] ADD MEMBER [LNW_SA]
GO

