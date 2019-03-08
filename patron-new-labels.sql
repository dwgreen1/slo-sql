SELECT DISTINCT pv.record_num,
                fn.first_name,
                fn.last_name,
                pra.addr1,
                pra.addr2,
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
WHERE pv.record_num > 1077756 -- only records after 2017
  AND (pv.ptype_code = 0 OR pv.ptype_code = 3)
  AND prat.code = 'a'
  AND pv.expiration_date_gmt IS NULL
  AND (
  -- record has a blank unique id field
    (vf.varfield_type_code = 's' AND vf.field_content = '')
    OR
    pv.id NOT IN (
      -- also look for records without a blank unique id field
      SELECT record_id
      FROM sierra_view.varfield
      WHERE record_id > 210454475260
        AND varfield_type_code = 's'
        AND field_content IS NOT NULL
    ))
ORDER BY 3 ASC;