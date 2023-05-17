BEGIN;
SET SESSION STATEMENT_TIMEOUT TO 0;
COMMIT;
WITH suppr_vals AS (
    SELECT
        id2reckey(b.id) AS bib_record,
        b.bcode3 AS bib_suppr_val,
        ARRAY(
            SELECT i.icode2
            FROM sierra_view.bib_record_item_record_link brirl
            JOIN sierra_view.item_view i ON brirl.item_record_id = i.id
            WHERE brirl.bib_record_id = b.id
        ) AS item_icode2_vals,
        ARRAY(
            SELECT o.ocode4
			FROM sierra_view.bib_record_order_record_link brorl
			JOIN sierra_view.order_view o ON brorl.order_record_id = o.id
			WHERE brorl.bib_record_id = b.id
        ) AS order_code4_vals,
        ARRAY(
            SELECT h.scode2
			FROM sierra_view.bib_record_holding_record_link brhrl
			JOIN sierra_view.holding_view h ON brhrl.holding_record_id = h.id
			WHERE brhrl.bib_record_id = b.id
        ) AS holdings_scode2_vals
    FROM sierra_view.bib_view b
    WHERE b.id NOT IN (
        SELECT brl.bib_record_id
        FROM sierra_view.bib_record_location brl
        WHERE brl.location_code IN ('owp', 'odl')
    )
)
SELECT
    suppr_vals.bib_record,
    suppr_vals.bib_suppr_val,
    array_to_string(
        CASE
            WHEN ( '-' = ANY(suppr_vals.item_icode2_vals) OR '-' = ANY(suppr_vals.holdings_scode2_vals)) THEN ARRAY['-','u']
            WHEN ( '-' = ANY(suppr_vals.order_code4_vals) OR 'z' = ANY(suppr_vals.item_icode2_vals)
                OR 'z' = ANY(suppr_vals.holdings_scode2_vals) OR 'z' = ANY(suppr_vals.order_code4_vals)) THEN ARRAY['z','n']
            ELSE ARRAY['s','m']
        END,
        ','
    ) AS correct_bib_suppr_vals,
    array_to_string(suppr_vals.item_icode2_vals, ',') AS item_icodes,
    array_to_string(suppr_vals.order_code4_vals, ',') AS order_code4s,
    array_to_string(suppr_vals.holdings_scode2_vals, ',') AS holdings_scode2s
FROM suppr_vals
WHERE NOT bib_suppr_val = ANY (
    CASE
        WHEN ( '-' = ANY(suppr_vals.item_icode2_vals) OR '-' = ANY(suppr_vals.holdings_scode2_vals)) THEN ARRAY['-','u']
        WHEN ( '-' = ANY(suppr_vals.order_code4_vals) OR 'z' = ANY(suppr_vals.item_icode2_vals)
            OR 'z' = ANY(suppr_vals.holdings_scode2_vals) OR 'z' = ANY(suppr_vals.order_code4_vals)) THEN ARRAY['z','n']
        ELSE ARRAY['s','m']
    END
    )
;
