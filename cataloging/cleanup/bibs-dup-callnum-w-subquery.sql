SELECT sub."Record #",
       sub."Field Content",
       sub."Tags",
       sub."Count"
FROM (SELECT id2reckey(record_id)                                            AS "Record #",
             field_content                                                   AS "Field Content",
             string_agg(varfield_type_code, ',' ORDER BY varfield_type_code) AS "Tags",
             COUNT(field_content)                                            AS "Count"
      FROM sierra_view.varfield
      WHERE marc_tag = '092'
        AND marc_ind1 = ' '
        AND marc_ind2 = ' '
      GROUP BY record_id, field_content
      HAVING (COUNT(field_content) = 3)) sub
WHERE sub."Record #" IN (SELECT id2reckey(record_id) AS "Record #"
                         FROM sierra_view.varfield
                         WHERE marc_tag = '092'
                         GROUP BY marc_tag, id2reckey(record_id)
                         HAVING (COUNT(marc_tag) = 3));
