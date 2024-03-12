SELECT id2reckey(record_id)                           AS "Record #",
       field_content                                  AS "Field Content",
       string_agg(varfield_type_code, ',' ORDER BY 1) AS "Tags",
       COUNT(field_content)                           AS "Count"
FROM sierra_view.varfield
-- WHERE (marc_tag = '050' OR marc_tag = '090' OR marc_tag = '099')
WHERE marc_tag = '086'
  AND marc_ind1 = '0'
  AND marc_ind2 = ' '
GROUP BY record_id, field_content
HAVING (COUNT(field_content) > 2)
ORDER BY 3 DESC;