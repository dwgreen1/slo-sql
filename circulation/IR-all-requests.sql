-- Check INN-REACH requests for local patrons

SELECT DISTINCT
(
	SELECT
	v.field_content
	FROM
	sierra_view.varfield v

	WHERE
	v.varfield_type_code = 'z' AND p.id = v.record_id

	ORDER BY v.field_content

	LIMIT 1
	)
 AS email,
n.last_name as last_name,
n.first_name as first_name,
p.ptype_code as ptype_code,
(
	SELECT
    u.field_content
	FROM
	sierra_view.varfield as u

	WHERE
	u.varfield_type_code = 'b' AND i.id = u.record_id

	ORDER BY u.field_content

	LIMIT 1
	)
as item_barcode,
i.item_status_code,
h.placed_gmt as hold_placed,
h.status as hold_status,
h.is_ir,
h.is_ill

FROM
sierra_view.patron_view as p

JOIN
sierra_view.patron_record_fullname n
ON p.id = n.patron_record_id

LEFT OUTER JOIN
sierra_view.hold as h
ON n.patron_record_id = h.patron_record_id

LEFT OUTER JOIN
sierra_view.bib_record as b
ON h.record_id = b.record_id

LEFT OUTER JOIN
sierra_view.item_record as i
ON h.record_id = i.record_id

LEFT OUTER JOIN
sierra_view.bib_record_item_record_link as l
ON l.item_record_id = i.record_id

LEFT OUTER JOIN
sierra_view.bib_record_property as brp
ON (h.record_id = brp.bib_record_id) OR (l.bib_record_id = brp.bib_record_id)

LEFT OUTER JOIN
sierra_view.checkout as cko
ON l.item_record_id = cko.item_record_id

WHERE
--INSERT PATRON BARCODE
--p.barcode = '' AND
h.status IS NOT NULL AND
h.is_ir = 'true'

ORDER BY
1