SELECT DISTINCT pv.record_num,
                fn.first_name,
                fn.last_name,
                pra.addr1,
                pra.city,
                pra.region,
                pra.postal_code
FROM sierra_view.patron_view pv
       JOIN sierra_view.patron_record_address pra
            ON pra.patron_record_id = pv.id
       JOIN sierra_view.patron_record_address_type prat
            ON prat.id = pra.patron_record_address_type_id
       JOIN sierra_view.patron_record_fullname fn
            ON fn.patron_record_id = pv.id
       JOIN sierra_view.varfield vf ON vf.record_id = pv.id
WHERE pv.record_num > 1073076 -- only records after 2017
  AND (pv.ptype_code = 0 OR pv.ptype_code = 3)
  AND prat.code = 'a'
  AND pv.expiration_date_gmt IS NULL
  AND (vf.varfield_type_code = 's' AND vf.field_content = '')
ORDER BY 1 ASC;