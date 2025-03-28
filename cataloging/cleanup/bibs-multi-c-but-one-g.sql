SELECT
    id2reckey(g.record_id)
FROM
    sierra_view.subfield g
JOIN
    sierra_view.subfield c ON g.record_id = c.record_id
WHERE
    g.field_type_code = 'g' -- Filter for g-type fields
    AND c.field_type_code = 'c' -- Filter for c-type fields
--     AND c.marc_tag = '086' -- Filter for c-type fields with marc_tag 086
GROUP BY
    id2reckey(g.record_id)
HAVING
    COUNT(DISTINCT g.varfield_id) = 1 -- Only one 'g' record
    AND COUNT(DISTINCT c.varfield_id) > 1; -- Multiple 'c' records
