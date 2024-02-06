SELECT
    i.barcode,
    substring(v.field_content from 5 for 11)::date as Transit_Date,
    lname.name as item_location,
    CASE WHEN vv.field_content IS NULL THEN UPPER(replace(cn.call_number,'|a',''))
            ELSE UPPER(replace(cn.call_number,'|a',''))||' '||UPPER(vv.field_content) END
        AS call_number,
        --Title of the item
    b.best_title,
    (SELECT
    CASE WHEN lname2.name IS NULL THEN u.name
        ELSE lname2.name
    END
FROM
    sierra_view.iii_user u
    LEFT JOIN sierra_view.iii_user_location l ON u.id=l.iii_user_id
    LEFT JOIN sierra_view.location_myuser lname2 ON l.location_code=lname2.code
WHERE
    u.name=substring(v.field_content from 42 for position(' to ' in v.field_content)-42))
     as sending_library,
    (SELECT name FROM sierra_view.location_myuser WHERE code=substring(v.field_content from position(' to ' in v.field_content)+4 for 2)) as transit_destination
FROM
    sierra_view.item_view i
    JOIN sierra_view.varfield_view v ON i.id=v.record_id
    JOIN sierra_view.location_myuser lname ON i.location_code=lname.code
    JOIN sierra_view.item_record_property cn ON i.id=cn.item_record_id
    LEFT JOIN (SELECT * FROM sierra_view.varfield WHERE varfield_type_code='v') vv ON i.id=vv.record_id
    JOIN sierra_view.bib_record_item_record_link l ON i.id=l.item_record_id
    JOIN sierra_view.bib_record_property b ON l.bib_record_id=b.bib_record_id
WHERE i.item_status_code='t'
    AND v.varfield_type_code='m'
    AND v.field_content LIKE '%TRANSIT%'
ORDER BY
    Transit_Date
