sum(basepts) where bucketgroupid<>1  should be tier_points_balance

Case when tier_point_balance < 20000 then ‘Silver’
When tier_point_balance >= 20000 and tier_point_balance < 100000 then ‘Gold’
When tier_point_balance >= 100000 and tier_point_balance < 500000 then ‘Platinum’
When tier_point_balance >= 500000 then ‘Platinum’
Else ‘error’ end ‘Next Tier Status’

Case when tier_point_balance < 20000 then 20,000 – tier_point_balance
When tier_point_balance >= 20000 and tier_point_balance < 100000 then 100,000 – tier_point_balance
When tier_point_balance >= 100000 and tier_point_balance < 500000 then 500,000 – tier_point_balance
When tier_point_balance >= 500000 then ‘0’
Else ‘error’ end ‘Points To Current Requal Upgrade Tier’
