WITH recs_010a AS (
    SELECT id2reckey(pe.record_id) AS "record_w_010",
           trim(pe.index_entry)    AS "record_010a"
    FROM sierra_view.phrase_entry pe
    WHERE pe.index_tag = 'z'
),
     recs_010z AS (
         SELECT id2reckey(sf.record_id) AS "record_w_z",
                trim(sf.content)        AS "record_010z"
         FROM sierra_view.subfield sf
         WHERE sf.marc_tag = '010'
           AND sf.tag = 'z'
     )
SELECT *
FROM recs_010a
         JOIN recs_010z ON recs_010a.record_010a = recs_010z.record_010z
ORDER BY 1;
