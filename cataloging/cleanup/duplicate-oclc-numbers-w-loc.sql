-- Duplicate OCLC Numbers for certain locations
SELECT	pe.index_entry AS "OCLC #",
	COUNT(pe.index_entry) AS "COUNT"
	FROM sierra_view.phrase_entry pe
	JOIN sierra_view.bib_record_location brl ON pe.record_id = brl.bib_record_id
	WHERE brl.location_code IN ('slsj')
	AND index_tag = 'o'
	GROUP BY index_entry
	HAVING (COUNT(index_entry) > 1)
	ORDER BY 2 DESC, 1 ASC;
