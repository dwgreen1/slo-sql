SELECT n.last_name     AS "Last Name",
       n.first_name    AS "First Name",
       v.field_content AS "Email Address"
FROM sierra_view.patron_record_fullname n
         JOIN
     sierra_view.varfield v ON v.record_id = n.patron_record_id
WHERE v.varfield_type_code = 'z';