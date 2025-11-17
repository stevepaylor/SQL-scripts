SELECT publication_id, agent_id, t.publisher_commit,

       Datediff(s,t.publisher_commit,t.distributor_commit) as 'Time To Dist (sec)',

       Datediff(s,t.distributor_commit,h.subscriber_commit) as 'Time To Sub (sec)'

FROM MStracer_tokens t

JOIN MStracer_history h

ON t.tracer_id = h.parent_tracer_id

 --—Find worst performing subscribers.

SELECT

convert(varchar(10),agent_id) as 'agent id',

max(Datediff(s,distributor_commit,subscriber_commit)) as 'MAXTime To Sub (sec)',

avg(Datediff(s,distributor_commit,subscriber_commit)) as 'AVG Time To Sub (sec)'

FROM MStracer_tokens t

JOIN MStracer_history h

ON t.tracer_id = h.parent_tracer_id

group by agent_id

order by 2 desc