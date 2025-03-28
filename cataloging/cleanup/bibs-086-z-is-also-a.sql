SELECT DISTINCT
    id2reckey(a.record_id)
FROM
    sierra_view.subfield a
JOIN
    sierra_view.subfield z ON a.record_id = z.record_id
                           AND a.content = z.content
WHERE
    a.tag = 'a'
    AND z.tag = 'z'
    AND a.field_type_code = 'c'
    AND a.marc_tag = '086'
    AND z.field_type_code = 'c'
    AND z.marc_tag = '086';
