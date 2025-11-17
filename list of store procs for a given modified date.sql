SELECT 
  [name]
, type_desc
, modify_date
, create_date

FROM 
    sys.procedures pr

WHERE modify_date >= '2018-01-16'
