SELECT 
  PlayerID 
, MAX(TripBeginDate)

FROM [iQ-Gaming].[dbo].[IQC_Player_Trips_GameDay]

where PlayerID IN ('10000216','10000316')

group by  PlayerID

order by PlayerID 



SELECT 
  PlayerID 
, DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(a.TripBeginDate))))
, eomonth(a.TripBeginDate)
, a.TripBeginDate
, a.gamingdateID_TripBegin
, b.DateID
, b.CalendarDate

--, case when b.[CalendarDate] between DATEADD(day, 1, EOMONTH(DATEADD(month,-3,eomonth(TripBeginDate)))) and eomonth(TripBeginDate) then b.[CalendarDate] else null end as PlayDates_3MonthLGD

FROM [iQ-Gaming].[dbo].[IQC_Player_Trips_GameDay] a

full outer join [iQ-Gaming].dbo.IQ_Calendar b
on a.gamingdateID_TripBegin = b.DateID 


--where PlayerID IN ('10000216','10000316')
where PlayerID IN ('10000316')

order by b.CalendarDate desc
