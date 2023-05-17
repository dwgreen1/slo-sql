SELECT prfn.first_name, prfn.last_name, COUNT(ct.id)
FROM sierra_view.circ_trans ct
    JOIN sierra_view.patron_record pr on pr.id = ct.patron_record_id
    JOIN sierra_view.patron_record_fullname prfn ON prfn.patron_record_id = pr.record_id
-- WHERE id2reckey(ct.patron_record_id) IN ('p1020495', 'p1016440', 'p1016301',
--                                          'p1065539', 'p1081827', 'p1074481', 'p1085367')
WHERE ct.pcode1 = 'c'
  AND op_code = 'o'
  AND date_part('year', transaction_gmt) = '2022'
GROUP BY prfn.first_name, prfn.last_name
ORDER BY 3 DESC;
