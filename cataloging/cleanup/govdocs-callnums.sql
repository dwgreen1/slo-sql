WITH bad086 AS (SELECT vf.record_id, vf.field_content
                FROM sierra_view.varfield vf
                WHERE vf.marc_ind1 = ''
                  AND vf.marc_tag = '086'
                  AND vf.varfield_type_code = 'c'
                ),
     good086 AS (SELECT vf.record_id, vf.field_content
                 FROM sierra_view.varfield vf
                 WHERE vf.marc_ind1 = '0'
                   AND vf.marc_tag = '086'
                   AND vf.varfield_type_code = 'c'
                 ),
    only2nums AS (SELECT vf.record_id, COUNT(vf.record_id)
                  FROM sierra_view.varfield vf
                  WHERE vf.marc_tag = '086'
                  AND vf.varfield_type_code = 'c'
                  GROUP BY 1
                  HAVING COUNT(1) = 2
                  )
SELECT id2reckey(bad086.record_id)
FROM bad086,
     good086
WHERE bad086.field_content = good086.field_content
  AND bad086.record_id = good086.record_id
  AND bad086.record_id IN (
      SELECT bad086.record_id
      FROM only2nums
    );