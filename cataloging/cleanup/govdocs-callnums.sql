WITH bad099 AS (SELECT *
                FROM sierra_view.varfield vf
                WHERE vf.marc_ind1 = ''
                  AND vf.marc_tag = '050'
                  AND vf.varfield_type_code = 'c'),
     good086 AS (SELECT *
                 FROM sierra_view.varfield vf
                 WHERE vf.marc_ind1 = ''
                   AND vf.marc_tag = '050'
                   AND vf.varfield_type_code = 'y')
SELECT id2reckey(bad099.record_id)
FROM bad099,
     good086
WHERE bad099.field_content = good086.field_content
  AND bad099.record_id = good086.record_id;
