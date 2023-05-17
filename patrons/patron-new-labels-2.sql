WITH valid_ids AS (
    SELECT DISTINCT record_id
    FROM sierra_view.varfield
    WHERE record_id > 481037415700
      AND varfield_type_code = 's'
      AND field_content IS NOT NULL
      AND field_content != ''
)
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
WHERE record_id > 481037415700
  AND pv.ptype_code <= 3
  AND prat.code = 'a'
  AND pv.id NOT IN (
    SELECT record_id
    FROM valid_ids
)
ORDER BY 3 ASC;