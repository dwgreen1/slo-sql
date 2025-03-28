SELECT
    id2reckey(c1.record_id)
FROM
    sierra_view.subfield c1
JOIN
    sierra_view.subfield c2 ON c1.record_id = c2.record_id
WHERE
    c1.field_type_code = 'c'
    AND c1.marc_tag = '086'
    AND c2.field_type_code = 'c'
    AND c2.marc_tag = '086'
    AND LOWER(c1.content) = LOWER(c2.content) -- Case-insensitive comparison
    AND c1.content <> c2.content -- Case-sensitive difference
    AND c1.varfield_id <> c2.varfield_id -- Different fields
GROUP BY
    c1.record_id
HAVING
    COUNT(DISTINCT c1.varfield_id) = 2; -- Exactly two 'c' fields in each record
