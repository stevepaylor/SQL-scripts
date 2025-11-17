USE [master]
GO

CREATE LOGIN [cmktuser] WITH PASSWORD=N'JkGI2Ns1cY8QMqYs1LJQm06G2EbTBPlbfN5o4w1DuGI=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [cmktuser]
GO

ALTER SERVER ROLE [serveradmin] ADD MEMBER [cmktuser]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [cmktuser]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [cmpapi] WITH PASSWORD=N'vTkJevVkDT0jCX36ftqyjUHAUnlyTW04sE+RU4R+VkY=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [cmsupgrade] WITH PASSWORD=N'Uf9QkOWz/4HjLmkHv+jF9A+BL+RULq7fVLFswX7AOIQ=', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\APPSWB21DV$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\APPSWB22DV$] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\cmsupgrade] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [VIEJAS\cmsupgrade]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\dmehta] FROM WINDOWS WITH DEFAULT_DATABASE=[CMP13_TEMP_used_to_copy_logins], DEFAULT_LANGUAGE=[us_english]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\ewallace] FROM WINDOWS WITH DEFAULT_DATABASE=[CMP13_TEMP_used_to_copy_logins], DEFAULT_LANGUAGE=[us_english]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\JGiolitto] FROM WINDOWS WITH DEFAULT_DATABASE=[CMP13_TEMP_used_to_copy_logins], DEFAULT_LANGUAGE=[us_english]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\Outsource_Developers] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [VIEJAS\Outsource_Developers]
GO

--------------------------------------------------------------------------------------------------------------

CREATE LOGIN [VIEJAS\sbauer] FROM WINDOWS WITH DEFAULT_DATABASE=[CMP13_TEMP_used_to_copy_logins], DEFAULT_LANGUAGE=[us_english]
GO










