-- How many titles do we have in the collection?
-- Titles, include electronic, omit BWC, Ohioana, and supressed records.
SELECT DISTINCT COUNT(br.record_id)
FROM sierra_view.bib_record br
JOIN sierra_view.bib_record_location brl ON br.id = brl.bib_record_id
WHERE br.bcode3 != 's'
    AND brl.location_code NOT IN ('ona', 'sdf', 'sdj', 'multi')
    AND brl.location_code !~ '\d';