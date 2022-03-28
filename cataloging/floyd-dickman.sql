SELECT DISTINCT id2reckey(brp.bib_record_id),
                brp.best_title,
                brp.best_author,
                recs_with_isbns.isbn
FROM sierra_view.bib_record_property brp
         JOIN sierra_view.bib_record_location brl
              ON brl.bib_record_id = brp.bib_record_id
         LEFT JOIN (
    SELECT DISTINCT s.record_id,
                    MAX(regexp_replace(s.content, '[^0-9]+', '', 'g')) as isbn
    FROM sierra_view.subfield s
    WHERE s.field_type_code = 'i'
      AND s.marc_tag = '020'
      AND s.tag = 'a'
      AND (s.content ILIKE '978%' OR s.content ~ '^[0-9]{10,13}')
    GROUP BY 1
) recs_with_isbns
                   ON recs_with_isbns.record_id = brp.bib_record_id
WHERE brl.location_code = 'slcl'
ORDER BY 2;
