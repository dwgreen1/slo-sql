-- Show record overlap between two review files
SELECT id2reckey(record_metadata_id) AS "RECORD #"
FROM sierra_view.bool_set
WHERE bool_info_id = 3
INTERSECT
SELECT id2reckey(record_metadata_id) AS "RECORD #"
FROM sierra_view.bool_set
WHERE bool_info_id = 4;
