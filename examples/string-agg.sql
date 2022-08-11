WITH bib_records AS (
    SELECT distinct(bib_record_id)
    FROM sierra_view.bib_record_location
)

SELECT b.bib_record_id,
       (
           SELECT string_agg(l.location_code, ',' ORDER BY l.display_order)
           FROM sierra_view.bib_record_location as l
           WHERE l.bib_record_id = b.bib_record_id
             -- exclude the 'multi' location, 
             -- as it's not really a location
             AND l.location_code != 'multi'
       ) AS locations
FROM bib_records as b
LIMIT 100;
