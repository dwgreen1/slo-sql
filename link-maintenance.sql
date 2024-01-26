--Returns bib locs + item locs + holdings locs
SELECT id2reckey(bv.id) AS "REC #",
       array_to_string(
               ARRAY(
                       SELECT DISTINCT brl.location_code
                       FROM sierra_view.bib_record_location AS brl
                       WHERE bv.id = brl.bib_record_id
                         AND brl.location_code !~ 'multi'
                       ORDER BY 1
                   ),
               ','
           )            AS "bib_locs",
       array_to_string(
               ARRAY(
                       SELECT DISTINCT ir.location_code
                       FROM sierra_view.item_record ir
                                JOIN sierra_view.bib_record_item_record_link bil
                                     ON ir.id = bil.item_record_id AND bv.id = bil.bib_record_id
--                                      WHERE ir.location_code !~ 'multi'
                       ORDER BY 1
                   ),
               ','
           )            AS "item_locs",
       array_to_string(
               ARRAY(
                       SELECT DISTINCT hrl.location_code
                       FROM sierra_view.holding_record_location hrl
                                JOIN sierra_view.bib_record_holding_record_link bhl
                                     ON hrl.holding_record_id = bhl.holding_record_id AND bv.id = bhl.bib_record_id
--                                      WHERE hrl.location_code !~ 'multi'
                       ORDER BY 1
                   ),
               ','
           )            AS "holdings_locs"
FROM sierra_view.bib_view bv
ORDER BY 1;
