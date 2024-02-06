SELECT id2reckey(h.patron_record_id) AS "Patron",
       id2reckey(h.record_id) AS "Item",
       ir.location_code AS "Item Location",
       h.placed_gmt::date AS "Date Placed",
       h.pickup_location_code
FROM sierra_view.item_record ir
         JOIN sierra_view.hold h
              ON h.record_id = ir.record_id
WHERE ir.item_status_code = 't'
  AND pickup_location_code IN ('slo', 'mail', 'sls', 'bwc')
  AND h.placed_gmt < '2021-09-04'
ORDER BY 5, 4 DESC, 1, 3 DESC;
