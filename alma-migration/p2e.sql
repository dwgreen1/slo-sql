SET STATEMENT_TIMEOUT TO 0;

-- Electronic Location Codes
SELECT DISTINCT id2reckey(vf.record_id)
FROM sierra_view.varfield vf
JOIN sierra_view.bib_record br
  ON br.id = vf.record_id
JOIN sierra_view.bib_record_location brl
  ON brl.bib_record_id = vf.record_id
WHERE brl.location_code IN ('swp', 'fwp', 'elr')
  AND vf.marc_tag = '856'
  AND vf.marc_ind1 = '4'
  AND vf.marc_ind2 = '0'

UNION

-- All Ohio Memory URLs
SELECT DISTINCT id2reckey(vf.record_id)
FROM sierra_view.varfield vf
JOIN sierra_view.bib_record br
  ON br.id = vf.record_id
WHERE vf.marc_tag = '856'
  AND vf.marc_ind1 = '4'
  AND vf.marc_ind2 = '0'
  AND vf.field_content ILIKE '%ohiomemory%';
