SELECT id2reckey(record_id) || 'a' AS record_number,
       location_code,
       price::MONEY                AS price
FROM sierra_view.item_record
WHERE price > '1000'
ORDER BY 2;