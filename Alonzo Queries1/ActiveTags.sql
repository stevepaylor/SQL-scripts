select Tagcode, count(*) from tplayertag tpt inner join ttag tt on tpt.TagId = tt.TagId
where tpt.IsInactive=0 and tt.IsInactive=0
group by Tagcode
order by count(*) desc


---  P2003BowlQual   32583