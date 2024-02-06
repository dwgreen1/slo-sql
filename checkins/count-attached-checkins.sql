SELECT id2reckey(brp.bib_record_id),
       brp.best_title,
       hrl.location_code,
       COUNT(*)
FROM sierra_view.bib_record_holding_record_link brhrl
         JOIN sierra_view.holding_record_location hrl
              ON brhrl.holding_record_id = hrl.holding_record_id
         JOIN sierra_view.bib_record_property brp
              ON brhrl.bib_record_id = brp.bib_record_id
GROUP BY 1, 2, 3
ORDER BY 1;
