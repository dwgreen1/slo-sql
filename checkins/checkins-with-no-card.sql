-- Holdings records with no card
SELECT id2reckey(hr.id)
FROM sierra_view.holding_record hr
FULL JOIN sierra_view.holding_record_card card ON card.holding_record_id = hr.id
WHERE card.holding_record_id IS NULL
ORDER BY 1;
