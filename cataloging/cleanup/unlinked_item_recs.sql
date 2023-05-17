SELECT id2reckey(id)
FROM sierra_view.item_record ir
WHERE NOT EXISTS(
        SELECT item_record_id
        FROM sierra_view.bib_record_item_record_link bril
        WHERE ir.id = item_record_id
    );
