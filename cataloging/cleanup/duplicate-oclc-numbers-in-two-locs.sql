-- Duplicate OCLC Numbers in a Location
SELECT	pe.index_entry AS "OCLC #"
	FROM sierra_view.phrase_entry pe
	WHERE index_tag = 'o'
	AND index_entry is not null
	AND index_entry != ''
	AND parent_record_id IN (
	    SELECT bib_record_id
	    FROM sierra_view.bib_record_location
	    WHERE location_code = 'sls'
        )
UNION
SELECT	pe.index_entry AS "OCLC #"
	FROM sierra_view.phrase_entry pe
	WHERE index_tag = 'o'
	AND index_entry is not null
	AND index_entry != ''
	AND parent_record_id IN (
	    SELECT bib_record_id
	    FROM sierra_view.bib_record_location
	    WHERE location_code = 'sld'
        )
	GROUP BY index_entry
	HAVING (COUNT(index_entry) > 1)
	ORDER BY 1::numeric
