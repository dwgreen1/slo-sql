SELECT
    id2reckey(bil.bib_record_id)
FROM sierra_view.bib_record_item_record_link bil
JOIN sierra_view.item_view i ON i.id = bil.item_record_id AND i.item_status_code = 'm'
WHERE bil.bib_record_id IN (
    SELECT mb.bib_record_id
    FROM sierra_view.bib_record_item_record_link mb
    JOIN sierra_view.item_view mi ON mb.item_record_id = mi.id
    GROUP BY 1
    HAVING COUNT(mb.item_record_id) = 1
);
