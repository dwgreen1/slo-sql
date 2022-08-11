-- Find a list of unsuppressed bib record numbers where ALL attached items are missing ~suppressed~
-- Order the list by bib_record_last_update
--
WITH bib_item_data AS (
  -- build a set of bib and item data
	-- NOTE that we're including only some bib data along with the item record suppressed status
  --      we count the suppressed items attached, and if if the's same as the total items attached
  --      it will display as a row
	SELECT
	rm.id AS bib_record_id,
	rm.record_num AS bib_record_num,
	date(rm.creation_date_gmt) AS bib_record_create_date,
	date(rm.record_last_updated_gmt) AS bib_record_last_update,
	date(br.cataloging_date_gmt) AS bib_record_cat_date,
	brirl.items_display_order,
	ir.record_id AS item_record_id,
	ir.is_suppressed AS is_item_record_suppressed,
	ir.item_status_code
	FROM
	sierra_view.record_metadata AS rm
	JOIN sierra_view.bib_record AS br ON br.record_id = rm.id
	JOIN sierra_view.bib_record_item_record_link AS brirl ON brirl.bib_record_id = rm.id
	JOIN sierra_view.item_record AS ir ON ir.record_id = brirl.item_record_id
	WHERE
	rm.record_type_code = 'b'
	AND rm.campus_code = ''
	AND br.is_suppressed IS FALSE
)
SELECT
bib_record_num,
bib_record_last_update,
bib_record_create_date,
bib_record_cat_date,
count(item_record_id) AS count_items
FROM
bib_item_data
GROUP BY
bib_record_num,
bib_record_last_update,
bib_record_create_date,
bib_record_cat_date
HAVING
-- all attached items are suppressed ...
--count(item_record_id) = count(CASE WHEN is_item_record_suppressed IS TRUE THEN 1 ELSE NULL END)
--
-- all attached items have a missing status ...
count(item_record_id) = count(CASE WHEN item_status_code = 'm' THEN 1 ELSE NULL END)
ORDER BY bib_record_last_update DESC;
