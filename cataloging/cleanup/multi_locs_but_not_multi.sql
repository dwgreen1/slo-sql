-- verify that all bibs with more than two locations have
WITH temp_bibs_multi_loc AS (
SELECT r.id,
       r.record_num,
       count(l.bib_record_id) as count_locations
FROM sierra_view.record_metadata as r
         LEFT OUTER JOIN
     sierra_view.bib_record_location as l
     ON
         l.bib_record_id = r.id
WHERE r.record_type_code = 'b'
GROUP BY r.id,
         r.record_num,
         l.bib_record_id

HAVING count(l.bib_record_id) > 1)
SELECT id2reckey(b.id),
       l.id
FROM temp_bibs_multi_loc as b
         LEFT OUTER JOIN
     sierra_view.bib_record_location as l
     ON
         (
                     l.bib_record_id = b.id
                 AND l.location_code = 'multi'
             )
WHERE l.id IS null
GROUP BY b.id,
         l.id;
