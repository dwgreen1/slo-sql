SELECT
r.id AS item_record_id,
r.record_num AS item_record_num,
(
    SELECT
    json_agg(
        jsonb_build_object(
            'display_order', vt.display_order,
            'varfield_type_code', v2.varfield_type_code,
            'field_content', v2.field_content,
            'occ_num', v2.occ_num,
            'short_name', vtn.short_name,
            'name', vtn."name"
        )
        ORDER BY
        vt.display_order ASC,
        v2.occ_num ASC,
        v2.record_id ASC
    )
    FROM
    sierra_view.varfield AS v2
    -- NOTE: make sure you change the record type here, that is being targeting above
    JOIN sierra_view.varfield_type AS vt ON (vt.code = v2.varfield_type_code) AND (vt.record_type_code ='i')
    JOIN sierra_view.varfield_type_name AS vtn ON vtn.varfield_type_id = vt.id
    WHERE
    v2.record_id = r.id
) AS json_item_varfields
FROM
sierra_view.record_metadata AS r
WHERE
r.record_type_code = 'i'
AND r.campus_code = ''
ORDER BY
r.id DESC
LIMIT 1
