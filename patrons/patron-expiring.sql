SELECT record_num,
       expiration_date_gmt,
       activity_gmt
FROM sierra_view.patron_view
WHERE ptype_code = '3'
  AND expiration_date_gmt >= current_date
  AND expiration_date_gmt <= (current_date + integer '22')
  AND activity_gmt >= current_date - integer '1095'
ORDER BY 2, 3 DESC;