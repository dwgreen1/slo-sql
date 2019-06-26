-- Duplicate ARN Numbers
SELECT id2reckey(pe.record_id), pe.index_entry
FROM sierra_view.phrase_entry pe
WHERE pe.index_entry IN (
    SELECT pe.index_entry AS "ARN #"
    FROM sierra_view.phrase_entry pe
    WHERE varfield_type_code = 'o'
      AND index_tag = 'z'
      AND parent_record_id IN (
        SELECT v.record_id
        FROM sierra_view.varfield v
             -- Switch between names / subjects
        WHERE v.varfield_type_code = 'd'
    )
    GROUP BY index_entry
    HAVING (COUNT(index_entry) > 1)
)
ORDER BY 2;

-- Duplicate ARN Numbers Pt. II
WITH dup_name
         AS (SELECT a.code1,
                    e.index_tag,
                    e.index_entry
             FROM sierra_view.phrase_entry AS e
                      JOIN sierra_view.record_metadata AS r
                           ON r.id = e.record_id
                               AND r.record_type_code = 'a'
                      JOIN sierra_view.authority_record a
                           ON a.record_id = e.record_id
             WHERE e.index_tag = 'z'
               AND e.varfield_type_code = 'o'
              -- AND a.code1 = 'q'
             GROUP BY a.code1,
                      e.index_tag,
                      e.index_entry
             HAVING COUNT(*) > 1)
SELECT d.*,
       r.record_type_code
           || r.record_num
           || 'a' AS record_num
FROM dup_name AS d
         JOIN sierra_view.phrase_entry AS e
              ON e.index_tag
                     || e.index_entry = d.index_tag
                     || d.index_entry
         JOIN sierra_view.record_metadata AS r
              ON r.id = e.record_id
                  AND r.record_type_code = 'a'
ORDER BY 1, 3, 4;

-- Duplicate ARN Numbers Pt. III
WITH dup_name
     AS (SELECT a.code1,
                e.index_tag,
                e.index_entry
         FROM   sierra_view.phrase_entry AS e
                JOIN sierra_view.record_metadata AS r
                  ON r.id = e.parent_record_id
                     AND r.record_type_code = 'a'
                JOIN sierra_view.authority_record a
                  ON a.record_id = e.parent_record_id
         WHERE  e.index_tag = 'z'
                AND e.varfield_type_code = 'o'
                -- CHANGE FOR NAME / SUBJECT / SERIES
                AND a.code1 = 'a'
         GROUP  BY a.code1,
                   e.index_tag,
                   e.index_entry
         HAVING Count(*) > 1)
SELECT d.*,
       r.record_type_code
       || r.record_num
       || 'a' AS record_num
FROM   dup_name AS d
       JOIN sierra_view.phrase_entry AS e
         ON e.index_tag
            || e.index_entry = d.index_tag
                               || d.index_entry
       JOIN sierra_view.record_metadata AS r
         ON r.id = e.parent_record_id
            AND r.record_type_code = 'a'
       JOIN sierra_view.authority_record a
         ON a.record_id = e.parent_record_id
-- CHANGE FOR NAME / SUBJECT / SERIES
WHERE  a.code1 = 'a'
ORDER  BY 1,3,4;