SELECT i.itype_code_num,
       COUNT(DISTINCT i.id) FILTER (WHERE b.publish_year > 2009)                AS "2010",
       COUNT(DISTINCT i.id) FILTER (WHERE b.publish_year BETWEEN 2000 AND 2009) AS "2000-2009",
       COUNT(DISTINCT i.id) FILTER (WHERE b.publish_year BETWEEN 1990 AND 1999) AS "1990-1999",
       COUNT(DISTINCT i.id) FILTER (WHERE b.publish_year BETWEEN 1980 AND 1989) AS "1980-1989"
--and so on
FROM sierra_view.bib_record_property b
         JOIN
     sierra_view.bib_record_item_record_link l
     ON
         b.bib_record_id = l.bib_record_id
         JOIN
     sierra_view.item_record i
     ON
         l.item_record_id = i.id
GROUP BY 1
ORDER BY 1