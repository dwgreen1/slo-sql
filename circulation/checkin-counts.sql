SELECT hrl.location_code,
       COUNT(*)
FROM sierra_view.holding_record_location hrl
GROUP BY 1
ORDER BY 2 DESC;