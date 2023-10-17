-- Print Titles in past 120 days
SELECT id2reckey(rm.id)
FROM sierra_view.record_metadata rm
JOIN sierra_view.bib_record br ON br.id = rm.id
JOIN sierra_view.bib_record_location brl ON brl.bib_record_id = br.record_id
WHERE rm.creation_date_gmt >= CURRENT_DATE - INTERVAL '120 days'
  AND brl.location_code IN ('osd', 'slcl', 'slctr', 'slr', 'sls')
  AND br.bcode2 IN ('a', 'k', 'n', 't', 'o', 'e', 's')
ORDER BY rm.creation_date_gmt DESC
LIMIT 100;
