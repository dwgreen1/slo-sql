-- Authority records with a |z in the 010
-- Limited to NAME and SERIES
SET SEARCH_PATH TO sierra_view;
SELECT subfield.content
FROM varfield_view vv
       JOIN authority_view a
            ON a.id = vv.record_id
       JOIN subfield ON subfield.record_id = vv.record_id
WHERE (a.code1 = 'a' OR a.code1 = 'q')
  AND a.suppress_code = 'z'
  AND vv.marc_tag = '010'
  AND subfield.marc_tag = '010'
  AND subfield.tag = 'a';

-- Authority records with a |z in the 010
-- Limited to SUBJECTS
SET SEARCH_PATH TO sierra_view;
SELECT subfield.content
FROM varfield_view vv
       JOIN authority_view a
            ON a.id = vv.record_id
       JOIN subfield ON subfield.record_id = vv.record_id
WHERE a.code1 = 'd'
  AND a.suppress_code = 'z'
  AND vv.marc_tag = '010'
  AND subfield.marc_tag = '010'
  AND subfield.tag = 'a';