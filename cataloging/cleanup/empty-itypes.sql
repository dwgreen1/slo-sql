-- Shows unused ITYPEs
SELECT it.code AS itypecode
     , it.name AS itype_name
FROM sierra_view.itype_property_myuser it
         LEFT JOIN
     sierra_view.item_record i
     ON
         i.itype_code_num = it.code
WHERE it.name != ''
GROUP BY 1, 2
HAVING SUM(CASE
               WHEN i.itype_code_num IS NULL THEN 0
               ELSE 1
    END) = 0
ORDER BY 1;