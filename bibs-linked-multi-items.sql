SELECT DISTINCT
-- brirl.bib_record_id ,
rm.record_num AS bib_record_num,
(
	SELECT
	rm2.record_num
	FROM
	sierra_view.record_metadata AS rm2
	WHERE
	rm2.id = brirl.item_record_id
	LIMIT 1
) AS item_record_num
FROM
sierra_view.bib_record_item_record_link AS brirl
JOIN sierra_view.record_metadata AS rm ON rm.id = brirl.bib_record_id
WHERE
brirl.item_record_id IN (
	SELECT
	item_record_id
	FROM
	sierra_view.bib_record_item_record_link
	GROUP BY
	1
	HAVING
	count(item_record_id) > 1
)
