SELECT b.record_type_code || b.record_num || 'a' AS "Bib Record",
       b.title                                   AS "Title"
FROM sierra_view.bib_view b
WHERE NOT EXISTS(
        SELECT l.id
        FROM sierra_view.bib_record_item_record_link l
                 JOIN sierra_view.item_view i ON l.item_record_id = i.id
             --limit to location
        WHERE b.id = l.bib_record_id
          AND i.item_status_code != 'm'
          AND i.location_code NOT IN ('ona', 'sdf', 'sdj', 'sld', 'slp')
    )
  AND EXISTS(
        SELECT l.id
        FROM sierra_view.bib_record_item_record_link l
                 JOIN sierra_view.item_view i ON l.item_record_id = i.id
             --limit to same location as above
        WHERE b.id = l.bib_record_id
          AND i.item_status_code = 'm'
          AND i.location_code NOT IN ('ona', 'sdf', 'sdj', 'sld', 'slp')
    )
ORDER BY 1;
