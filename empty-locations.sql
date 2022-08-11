SELECT code
FROM sierra_view.location
WHERE code NOT IN (
  SELECT location_code
  FROM sierra_view.bib_record_location
  )
  AND code NOT IN (
  SELECT location_code
  FROM sierra_view.item_record
 )
  AND code NOT IN (
  SELECT location_code
  FROM sierra_view.holding_record_location
 )
AND code NOT LIKE 'y%'
AND code NOT LIKE '9%'
AND code NOT LIKE '%g'
AND code != 'slo'
-- AND code != 'ua4hs'
AND code != 'mail'
ORDER BY 1;
