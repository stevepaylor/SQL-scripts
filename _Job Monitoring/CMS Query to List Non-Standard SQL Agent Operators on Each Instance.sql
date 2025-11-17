SELECT *
FROM msdb.dbo.sysoperators
WHERE [name] NOT IN (
  'ITappsDBA'
, 'ITappsTeam'
, 'spaylor'
, 'SteveText'
, 'SteveBothEmail'
, 'DWH_Alerts'
, 'DWH_Text_Alerts'
, 'SDSAdmin'
)