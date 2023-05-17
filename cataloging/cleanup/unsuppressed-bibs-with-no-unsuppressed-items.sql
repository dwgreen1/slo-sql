WITH bad_bibs AS (
	(( 	-- Bibs must satisfy the following conditions:
		-- 1.  Not suppressed
		SELECT bv.id AS "bib_id"
		FROM sierra_view.bib_view bv
		WHERE bv.bcode3 NOT IN ('s','m')
	) INTERSECT ( -- 2. Have linked items
		SELECT bil.bib_record_id AS "bib_id"
		FROM sierra_view.bib_record_item_record_link bil
	) INTERSECT ( -- 3. Have 245
		SELECT bv.id AS "bib_id"
		FROM sierra_view.bib_view bv
		JOIN sierra_view.varfield vf ON bv.id = vf.record_id AND vf.marc_tag = '245'
	)) EXCEPT ( -- Bibs must NOT meet the following criteria:
		(	-- 1. No owp or elr or odl bibs
			SELECT brl.bib_record_id AS "bib_id"
			FROM sierra_view.bib_record_location brl
			WHERE ( brl.location_code LIKE '%wp' OR brl.location_code = 'elr' OR brl.location_code = 'odl')
		) UNION ( -- 2. No bibs with unsuppressed items
			SELECT bv.id AS "bib_id"
			FROM sierra_view.bib_view bv
			JOIN sierra_view.bib_record_item_record_link brirl ON bv.id = brirl.bib_record_id
			JOIN sierra_view.item_view iv ON brirl.item_record_id = iv.id
			WHERE iv.icode2 != 's'
		) UNION ( -- 3. No bibs with holdings records
			SELECT bhl.bib_record_id AS "bib_id"
			FROM sierra_view.bib_record_holding_record_link bhl
		) UNION ( -- 4. No bibs with order records
			SELECT bol.bib_record_id AS "bib_id"
			FROM sierra_view.bib_record_order_record_link bol
		)
	)
)
SELECT id2reckey(bad_bibs.bib_id) || 'a' AS "bib record",
	bib.record_creation_date_gmt::DATE AS "created date",
	bib.cataloging_date_gmt::DATE AS "cat date",
	md.record_last_updated_gmt::DATE AS "updated date",
	left(bib.title, 150) AS "title",
	array_to_string(
		ARRAY(
			SELECT loc.location_code
			FROM sierra_view.bib_record_location AS loc
			WHERE bad_bibs.bib_id = loc.bib_record_id AND loc.location_code !~ 'multi'
			ORDER BY 1
		),
		','
	) AS "bib_locs"
FROM bad_bibs
JOIN sierra_view.bib_view bib ON bib.id = bad_bibs.bib_id
JOIN sierra_view.record_metadata md ON md.id = bad_bibs.bib_id
ORDER BY bib_locs, 4, 2, 1
