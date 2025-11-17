
select top 10 * from tprize 
update tprize set IsInactive=1
where prizeid in
(
select tp.PrizeId---, tp.prizecode, tp.prizename
from tprize tp 
where IsInactive = 0
and (prizename like 'Tag promo%'
or prizename like '%2017%'
or prizename like '%2018%'
or prizecode like 'A19%'
or prizecode like 'C19%'
or prizecode like 'S19%'
or prizecode like 'L19%'
or prizecode like 'B19%'
or prizecode like 'A18%'
or prizecode like 'C18%'
or prizecode like 'S18%'
or prizecode like 'L18%'
or prizecode like 'B18%'
or prizecode like 'E19%'
or prizecode like 'N19%'
or prizecode like 'N18%'
or prizecode like 'P18%'
or prizecode like 'E18%'
or (prizecode like 'P19%' and prizename not like '%email' and  prizename not like '%day%' and prizename not like '%Bus%'))
and prizecode <> 'S19BUS10FP'
and prizecode <> 'P19BUSFSNW'
and prizename not like '%bus%'
and PrizeCode not like '%bus%'
)

---order by tp.prizecode, tp.prizename


select top 100 * from tprize where prizecode='0415Wk1Mil'