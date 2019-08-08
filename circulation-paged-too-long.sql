SELECT *
FROM sierra_view.item_record ir
         JOIN sierra_view.hold h ON ir.record_id = h.record_id
WHERE ir.item_status_code = '('
  AND h.placed_gmt < now() - INTERVAL '4 days';