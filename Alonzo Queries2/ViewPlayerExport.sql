USE CMP3

select top 1000 playerid, acct, FirstName, MiddleInitial, LastName, ClubStatus, HomeEmail, IsEmailSend, HomeAddr1, HomeAddr2, 
HomeCity, HomeCountryCode, HomeCountryName, HomePostalCode, HomeStateCode, HomeStateName, PtsBal from viewPlayersViejas
where LastTripStartTranCodeGamingDt>='02/01/2020'