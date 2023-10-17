SELECT prfn.first_name, prfn.last_name, COUNT(ct.id)
FROM sierra_view.circ_trans ct
    JOIN sierra_view.patron_record pr on pr.id = ct.patron_record_id
    JOIN sierra_view.patron_record_fullname prfn ON prfn.patron_record_id = pr.record_id
WHERE op_code = 'o'
AND stat_group_code_num = 825
GROUP BY prfn.first_name, prfn.last_name
ORDER BY 3 DESC;