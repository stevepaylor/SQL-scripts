SELECT
  HostName
, COUNT(*)

FROM Hosts

GROUP BY
Hostname
HAVING COUNT(*) > 1

ORDER BY
HostName
