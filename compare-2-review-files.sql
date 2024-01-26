-- Show record overlap between two review files
SELECT id2reckey(record_metadata_id) AS "RECORD #"
FROM sierra_view.bool_set
WHERE bool_info_id = 2
UNION ALL
SELECT id2reckey(record_metadata_id) AS "RECORD #"
FROM sierra_view.bool_set
WHERE bool_info_id = 1;