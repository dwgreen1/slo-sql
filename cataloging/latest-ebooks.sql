-- OverDrive Ebooks in past 60 days
SELECT id2reckey(rm.id)
FROM sierra_view.record_metadata rm
JOIN sierra_view.bib_record br ON br.id = rm.id
JOIN sierra_view.bib_record_location brl ON brl.bib_record_id = br.record_id
WHERE rm.creation_date_gmt >= CURRENT_DATE - INTERVAL '60 days'
  AND brl.location_code = 'odl'
  AND br.bcode2 = '3'
ORDER BY rm.creation_date_gmt DESC
LIMIT 100;
