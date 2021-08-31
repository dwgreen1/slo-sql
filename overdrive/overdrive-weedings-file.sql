WITH
-- OCLC NUMS
rec_001s AS (SELECT DISTINCT pe.record_id   AS "record_w_001",
                             pe.index_entry AS "record_001"
             FROM sierra_view.phrase_entry pe
                      JOIN sierra_view.bib_record_location loc ON loc.bib_record_id = pe.record_id
             WHERE pe.index_tag = 'o'
               AND pe.varfield_type_code = 'o'
               AND loc.location_code ILIKE '%elr%'),
-- ISBNS
rec_isbns AS (
    SELECT pe.record_id   AS "record_w_isbn",
           pe.index_entry AS "record_isbn"
    FROM sierra_view.phrase_entry pe
             JOIN sierra_view.bib_record_location loc ON loc.bib_record_id = pe.record_id
    WHERE pe.index_tag = 'i'
      AND pe.varfield_type_code = 'i'
      AND loc.location_code ILIKE '%elr%'
      AND pe.index_entry IN (VALUES {isbns} )),
-- OVERDRIVE IDs
rec_overdrive_ids AS (
    SELECT DISTINCT s.record_id AS "record_w_odid",
                    SUBSTRING(LOWER(content) FROM '[0-9A-Za-z]{{8}}(?:-[0-9A-Za-z]{{4}}){{3}}-[0-9A-Za-z]{{12}}')   AS "record_odid"
    FROM sierra_view.subfield s
    WHERE ((s.marc_tag = '956' AND s.tag = 'u') OR (marc_tag = '037' AND tag = 'a' AND field_type_code = 'i'))
      AND SUBSTRING(LOWER(content) FROM '[0-9A-Za-z]{{8}}(?:-[0-9A-Za-z]{{4}}){{3}}-[0-9A-Za-z]{{12}}') IN (VALUES {oids}))
SELECT rec_001s.record_001           AS "OCLC_NUM",
       rec_overdrive_ids.record_odid AS "RESERVE ID"
    FROM rec_001s
        LEFT JOIN rec_isbns ON rec_isbns.record_w_isbn = rec_001s.record_w_001
        RIGHT JOIN rec_overdrive_ids ON rec_overdrive_ids.record_w_odid = rec_001s.record_w_001
