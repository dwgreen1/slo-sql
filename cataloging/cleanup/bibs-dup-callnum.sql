SELECT id2reckey(record_id), field_content, COUNT(field_content)
FROM sierra_view.varfield
WHERE marc_tag = '050'
GROUP BY record_id, replace(field_content, ' ', '')
HAVING (COUNT(replace(field_content, ' ', '')) > 2)
ORDER BY 3 DESC;
