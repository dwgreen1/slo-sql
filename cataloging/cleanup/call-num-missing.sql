--  Items with no barcode varfield but a barcode entry in phrase_entry
SELECT
    id2reckey(iv.id) || 'a' AS "record_number",
    phrase.index_entry AS "indexed_call_no",
    phrase.original_content,
    iv.location_code,
    rm.creation_date_gmt,
    rm.record_last_updated_gmt,
    rm.previous_last_updated_gmt
FROM sierra_view.phrase_entry phrase
JOIN sierra_view.item_view iv ON phrase.record_id = iv.id
JOIN sierra_view.record_metadata rm ON phrase.record_id = rm.id
WHERE phrase.record_id IN ((
    SELECT DISTINCT pe.record_id FROM sierra_view.phrase_entry pe WHERE pe.index_tag IN ('b')
    ) EXCEPT (
    SELECT DISTINCT vf.record_id FROM sierra_view.varfield vf WHERE vf.varfield_type_code = 'b'
    ))
AND phrase.index_tag IN ('b')
ORDER BY iv.location_code;
