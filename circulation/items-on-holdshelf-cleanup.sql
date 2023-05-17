SELECT i.location_code,
       id2reckey(i.id) || 'a',
       rm.record_last_updated_gmt::DATE,
       ip.call_number_norm,
       ip.barcode
FROM sierra_view.item_record i
         JOIN
     sierra_view.record_metadata rm
     ON
         i.id = rm.id AND rm.campus_code = ''
         LEFT JOIN
     sierra_view.hold h
     ON
         rm.id = h.record_id
         JOIN
     sierra_view.item_record_property ip
     ON
         i.id = ip.item_record_id
WHERE i.item_status_code = '!'
  AND h.record_id IS NULL;