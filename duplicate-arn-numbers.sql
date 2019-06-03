-- Duplicate ARN Numbers
SELECT pe.index_entry        AS "ARN #",
       COUNT(pe.index_entry) AS "COUNT"
FROM sierra_view.phrase_entry pe
  WHERE varfield_type_code = 'o'
  AND index_tag = 'z'
  AND parent_record_id IN (
      SELECT v.record_id
        FROM sierra_view.varfield v
        -- Switch between names / subjects
       WHERE v.varfield_type_code = 'q'
  )
GROUP BY index_entry
HAVING (COUNT(index_entry) > 1)
ORDER BY 2 DESC, 1 ASC;