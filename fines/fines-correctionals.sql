SELECT DISTINCT
	id2reckey(svf.patron_record_id)  || 'a' AS "patron_record",
	svprfn.last_name,
	svprfn.first_name,
-- 	svvf.field_content AS "patron_barcode",
    svf.invoice_num,
	to_char(svf.assessed_gmt, 'YYYY-MM-DD') AS "date_assessed",
	to_char(svf.item_charge_amt + svf.processing_fee_amt + svf.billing_fee_amt - svf.paid_amt, 'L9999999990.99') AS "amount",
	CASE
		WHEN svf.charge_code = '1' THEN 'Manual Charge'
		WHEN svf.charge_code = '2' THEN 'Overdue'
		WHEN svf.charge_code = '3' THEN 'Replacement'
		WHEN svf.charge_code = '4' THEN 'Adjustment'
		WHEN svf.charge_code = '5' THEN 'Item Lost'
		WHEN svf.charge_code = '6' THEN 'Overdue (Renewed)'
		ELSE 'Other' END AS "fine_type",
	svf.title
FROM sierra_view.fine AS svf
JOIN sierra_view.patron_record svpr ON svf.patron_record_id = svpr.record_id
JOIN sierra_view.patron_record_fullname svprfn ON svprfn.patron_record_id = svpr.record_id
JOIN sierra_view.varfield svvf ON svvf.record_id = svpr.record_id
WHERE
	svpr.pcode1 = 'c'
	AND svvf.occ_num = 0
ORDER BY 2, 1, 5 DESC;
