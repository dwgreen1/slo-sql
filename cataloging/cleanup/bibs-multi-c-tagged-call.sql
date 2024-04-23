SELECT 'b' || record_num || 'a' AS "RECORD #"
FROM sierra_view.varfield_view
WHERE record_type_code = 'b'
  AND varfield_type_code = 'c'
  AND varfield_view.record_id NOT IN (
      SELECT bib_record_id
      FROM sierra_view.bib_record_location
      WHERE location_code IN ('fwp', 'swp', 'odl', 'owp', 'elr')
    )
GROUP BY record_num
HAVING COUNT(record_num) > 1;
