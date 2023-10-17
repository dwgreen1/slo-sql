-- Check for items with status '(' (OHIOLINK PAGED)

SELECT
irp.barcode,
i.item_status_code,
h.placed_gmt as hold_placed,
h.status as hold_status,
h.is_ir,
h.is_ill

FROM
sierra_view.hold as h

LEFT OUTER JOIN
sierra_view.item_record as i
ON h.record_id = i.record_id

LEFT OUTER JOIN
sierra_view.item_record_property as irp
ON i.record_id = irp.item_record_id

WHERE
--INSERT PATRON BARCODE
--p.barcode = '' AND
i.item_status_code = '(' AND
h.status IS NOT NULL AND
h.is_ir = 'true'

ORDER BY
1