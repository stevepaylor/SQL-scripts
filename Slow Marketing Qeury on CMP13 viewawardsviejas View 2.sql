select *   -- your original query 
From viewawardsviejas 
where prizecode = 'P18GB4_015'

  -- 224 rows  7 min 38 sec

select *
From viewawardsviejas 
where prizecode = 'P18GB4_015'
  and GamingDt >= '2018-01-01'

  -- 224 rows  47 sec

select *
From viewawardsviejas 
where prizecode = 'P18GB4_015'
  and GamingDt >= '2018-07-24'

 --224 rows 3 sec