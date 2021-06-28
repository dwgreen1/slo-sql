SELECT b.bcode2                                       AS mat_type,
       COUNT(i.id),
       SUM(i.checkout_total)                          AS total_checkout,
       SUM(i.renewal_total)                           AS total_renewal,
       (SUM(i.checkout_total) + SUM(i.renewal_total)) AS total_circ
FROM sierra_view.bib_view AS b
         JOIN sierra_view.bib_record_item_record_link as bi
              ON b.id = bi.bib_record_id
         JOIN sierra_view.item_view AS i
              ON bi.item_record_id = i.id
-- WHERE i.record_creation_date_gmt > '06-30-2014'
GROUP BY 1
ORDER BY 1;
