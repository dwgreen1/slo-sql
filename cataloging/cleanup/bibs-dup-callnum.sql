SELECT id2reckey(record_id), field_content, COUNT(field_content)
FROM sierra_view.varfield
WHERE marc_tag = ('092')
AND varfield_type_code = 'c'
GROUP BY record_id, field_content
HAVING (COUNT(field_content) > 1)
ORDER BY 3 DESC;
