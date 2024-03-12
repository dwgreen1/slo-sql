-- How many COPIES do we have in the collection?
-- Titles, include electronic, omit BWC, Ohioana, and supressed records.
SELECT DISTINCT COUNT(ir.record_id)
FROM sierra_view.item_record ir
WHERE ir.is_suppressed IS FALSE
  AND ir.location_code  !~ '\d'
  AND NOT (ir.location_code LIKE 'sdj%'
               OR ir.location_code LIKE 'bwc%'
               OR ir.location_code LIKE 'ona%'
               OR ir.location_code LIKE 'sdf%');