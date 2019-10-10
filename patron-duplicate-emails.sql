SELECT id2reckey(pv.id) || 'a' AS "Record Number",
       sv.field_content        AS "Email Address",
       n.last_name             AS "Last Name",
       n.first_name            AS "First Name"
FROM sierra_view.patron_view pv
       JOIN
     sierra_view.patron_record_fullname n ON n.patron_record_id = pv.id
       JOIN
     sierra_view.varfield sv ON sv.record_id = pv.id
WHERE sv.field_content IN (
  SELECT sv.field_content
  FROM sierra_view.varfield sv
  WHERE sv.varfield_type_code = 'z'
    AND sv.field_content NOT LIKE '%library%'
  GROUP BY sv.field_content
  HAVING (COUNT(sv.field_content) > 1))
  ORDER BY 2, 3, 4;