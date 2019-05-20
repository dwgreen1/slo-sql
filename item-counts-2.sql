SELECT l.code, l.name, count(ir.record_id)
FROM sierra_view.item_record ir
JOIN sierra_view.location_myuser l ON ir.location_code = l.code
WHERE ir.itype_code_num < 200
GROUP BY l.code, l.name
ORDER BY l.name;