SELECT bril.item_record_id
FROM
  sierra_view.bib_record_item_record_link bril
LEFT JOIN
  sierra_view.item_view iv ON iv.id = bril.item_record_id
WHERE
  bril.item_record_id IS NULL;