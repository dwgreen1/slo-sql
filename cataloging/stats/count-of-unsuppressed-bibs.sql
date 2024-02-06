SELECT DISTINCT COUNT(id)
FROM sierra_view.bib_record
WHERE bib_record.bcode3 != 's'
  -- Remove INNReach Recs
AND id2reckey(record_id) NOT LIKE '%@%';
