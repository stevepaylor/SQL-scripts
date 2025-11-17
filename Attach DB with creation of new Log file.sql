USE [master]
GO
CREATE DATABASE [CMP13] ON 
( FILENAME = N'K:\UserDBdata\CMP13_data.mdf' ),
--( FILENAME = N'L:\UserDBlog\CMP13_log.ldf' ),
( FILENAME = N'K:\UserDBdata\CMP13_data2.ndf' )
 FOR ATTACH
GO
