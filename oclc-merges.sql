	BEGIN;
	SET SESSION STATEMENT_TIMEOUT TO 0; 
	COMMIT; 
	WITH rec_001s AS (
		SELECT
		  pe.record_id   AS "record_w_001",
		  pe.index_entry AS "record_001"
		FROM sierra_view.phrase_entry pe
		WHERE pe.index_tag = 'o' AND pe.index_entry ~ '^[0-9]'
	),
	rec_019s AS (
		SELECT
		  sf.record_id AS "record_w_019",
		  sf.content   AS "record_019"
		FROM sierra_view.subfield sf
		WHERE sf.marc_tag = '019' AND sf.tag = 'a'
	),
	r001s AS (
		SELECT
		  pe.record_id   AS "rec_w_001",
		  pe.index_entry AS "rec_001"
		FROM sierra_view.phrase_entry pe
		WHERE pe.index_tag = 'o' AND pe.index_entry ~ '^[0-9]'
	)
	SELECT
		id2reckey(rec_001s.record_w_001) || 'a' AS "bib_2_merge",
		mrm.creation_date_gmt::date AS "merge_bib_created",
		mbv.cataloging_date_gmt::date AS "merge_bib_cat_date",
		rec_001s.record_001 AS "merge_bib_001",
		mbv.title AS "merge_bib_title",
		mbrp.publish_year AS "merge_bib_yr",
		array_to_string(
			ARRAY(
				SELECT loc.location_code
				FROM sierra_view.bib_record_location AS loc
				WHERE mbv.id = loc.bib_record_id AND loc.location_code !~ 'multi'
				ORDER BY 1
			),
			','
		) AS "merge_bib_locs",
		id2reckey(rec_019s.record_w_019) || 'a' AS "bib_2_keep",
		krm.creation_date_gmt::date AS "keep_bib_created",
		kbv.cataloging_date_gmt::date AS "keep_bib_cat_date",
		r001s.rec_001 AS "keep_bib_001",
		array_to_string(
			ARRAY(
				SELECT loc.location_code
				FROM sierra_view.bib_record_location AS loc
				WHERE kbv.id = loc.bib_record_id AND loc.location_code !~ 'multi'
				ORDER BY 1
			),
			','
		) AS "keep_bib_locs",
		kbv.title AS "keep_bib_title",
		kbrp.publish_year AS "keep_bib_yr",
		'N' AS "merged"
	FROM rec_001s
	JOIN rec_019s ON rec_019s.record_019 = rec_001s.record_001 
	JOIN r001s ON rec_019s.record_w_019 = r001s.rec_w_001
	JOIN sierra_view.bib_view mbv ON mbv.id = rec_001s.record_w_001
	JOIN sierra_view.bib_record_property mbrp ON mbrp.bib_record_id = mbv.id
	JOIN sierra_view.record_metadata mrm ON mrm.id = rec_001s.record_w_001
	JOIN sierra_view.bib_view kbv ON kbv.id = rec_019s.record_w_019
	JOIN sierra_view.bib_record_property kbrp ON kbrp.bib_record_id = kbv.id
	JOIN sierra_view.record_metadata krm ON krm.id = rec_019s.record_w_019
	ORDER BY 1;