-- Count of duplicate OCLC nums by location code
SELECT brl.location_code, COUNT(brl.location_code)
FROM sierra_view.phrase_entry pe
JOIN sierra_view.bib_record_location brl ON pe.record_id = brl.bib_record_id
WHERE pe.index_tag = 'o'
AND pe.index_entry IN (
    SELECT pe2.index_entry
	FROM sierra_view.phrase_entry pe2
	WHERE index_tag = 'o'
	GROUP BY index_entry
	HAVING (COUNT(index_entry) > 1)
    )
GROUP BY brl.location_code
ORDER BY 2 DESC;