SET STATEMENT_TIMEOUT TO 0;
SELECT id2reckey(record_id) AS "RECORD #"
FROM sierra_view.varfield_view
WHERE record_type_code = 'b'
  AND varfield_type_code = 'c'
GROUP BY id2reckey(record_id)
HAVING COUNT(id2reckey(record_id)) > 1
-- remove these locations / bibs
EXCEPT
SELECT id2reckey(bib_record_id)
FROM sierra_view.bib_record_location
WHERE location_code IN ('fwp', 'swp', 'odl', 'owp', 'elr', 'sdf', 'slf', 'sld')
-- remove bibs that have item-level c-tag, but keep in mind ONE might have it while another one does NOT
EXCEPT
SELECT id2reckey(sierra_view.bib_record_item_record_link.bib_record_id)
FROM sierra_view.bib_record_item_record_link
         JOIN sierra_view.item_record
              ON sierra_view.bib_record_item_record_link.item_record_id = sierra_view.item_record.id
         JOIN sierra_view.varfield ON sierra_view.item_record.id = sierra_view.varfield.record_id AND
                                      sierra_view.varfield.varfield_type_code = 'c';
