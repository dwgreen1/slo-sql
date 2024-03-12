SELECT id2reckey(record_id), field_content, COUNT(field_content)
FROM sierra_view.varfield
WHERE (marc_tag = '050' OR marc_tag = '090' OR marc_tag = '099')
GROUP BY record_id, field_content
HAVING (COUNT(field_content) > 2)
ORDER BY 3 DESC;
