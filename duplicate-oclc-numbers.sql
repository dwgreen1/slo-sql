-- Duplicate OCLC Numbers
SELECT	pe.index_entry AS "OCLC #",
	COUNT(pe.index_entry) AS "COUNT"
	FROM sierra_view.phrase_entry pe
	WHERE index_tag = 'o'
	GROUP BY index_entry
	HAVING (COUNT(index_entry) > 1)
	ORDER BY 2 DESC, 1 ASC;