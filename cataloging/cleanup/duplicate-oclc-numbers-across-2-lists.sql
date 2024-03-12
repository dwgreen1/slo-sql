-- Duplicate OCLC across two lists
SELECT pe.index_entry
FROM sierra_view.bool_set bs
         JOIN sierra_view.phrase_entry pe ON pe.record_id = bs.record_metadata_id
WHERE index_tag = 'o'
  AND bs.bool_info_id = 2
INTERSECT
SELECT pe.index_entry
 FROM sierra_view.bool_set bs
          JOIN sierra_view.phrase_entry pe ON pe.record_id = bs.record_metadata_id
 WHERE index_tag = 'o'
   AND bs.bool_info_id = 3