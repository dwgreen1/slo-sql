SELECT Barcode,
       i1.location,
       i1.sortcall,
       CASE
           WHEN GREATEST(i1.sortvol1, i1.sortvol2, sortvol3, sortvol4, sortvol5) > 1800 THEN
               GREATEST(i1.sortvol1, i1.sortvol2, sortvol3, sortvol4, sortvol5)
           END AS voldate,
       i1.copynum,
       i1.sortvol1,
       i1.sortvol2,
       i1.sortvol3,
       i1.sortvol4,
       i1.sortvol5,
       CallNumber,
       Title,
       Status,
       LastInventoried,
       ItemNumber

FROM (
         SELECT DISTINCT iprop.barcode                                     AS Barcode,
                         iloc.name                                         AS location,
                         CASE
                             WHEN iprop.call_number_norm is NULL
                                 THEN bph.index_entry
                             ELSE iprop.call_number_norm
                             END                                           AS sortcall,
                         CAST((
                             string_to_array(
                                     TRIM(
                                             regexp_replace(
                                                     regexp_replace(sfiv.content, '[^0-9]', ' ', 'g')
                                                 , '[ ]+', ' ', 'g')
                                         )
                                 , ' '
                                 ))[1] AS NUMERIC)                         AS sortvol1,
                         CAST((
                             string_to_array(
                                     TRIM(
                                             regexp_replace(
                                                     regexp_replace(sfiv.content, '[^0-9]', ' ', 'g')
                                                 , '[ ]+', ' ', 'g')
                                         )
                                 , ' '
                                 ))[2] AS NUMERIC)                         AS sortvol2,
                         CAST((
                             string_to_array(
                                     TRIM(
                                             regexp_replace(
                                                     regexp_replace(sfiv.content, '[^0-9]', ' ', 'g')
                                                 , '[ ]+', ' ', 'g')
                                         )
                                 , ' '
                                 ))[3] AS NUMERIC)                         AS sortvol3,
                         CAST((
                             string_to_array(
                                     TRIM(
                                             regexp_replace(
                                                     regexp_replace(sfiv.content, '[^0-9]', ' ', 'g')
                                                 , '[ ]+', ' ', 'g')
                                         )
                                 , ' '
                                 ))[4] AS NUMERIC)                         AS sortvol4,
                         CAST((
                             string_to_array(
                                     TRIM(
                                             regexp_replace(
                                                     regexp_replace(sfiv.content, '[^0-9]', ' ', 'g')
                                                 , '[ ]+', ' ', 'g')
                                         )
                                 , ' '
                                 ))[5] AS NUMERIC)                         AS sortvol5,
                         i.copy_num                                        AS copynum,
                         -- sfiv.content                                      AS volume,
                         CASE
                             WHEN iprop.call_number is NULL
                                 THEN TRIM(regexp_replace(sfbc.content, '\|.', ' ', 'g'))
                             ELSE TRIM(regexp_replace(iprop.call_number, '\|.', ' ', 'g'))
                             END || ' ' ||
                         CASE
                             WHEN sfiv.content is NULL THEN ''
                             ELSE sfiv.content || ' '
                             END ||
                         CASE
                             WHEN i.copy_num is NULL THEN ''
                             ELSE 'c.' || i.copy_num
                             END                                           AS CallNumber,
                         bibprop.best_title                                AS Title,
                         CASE
                             WHEN (cko.loanrule_code_num > 0 AND i.item_status_code = '-') THEN 'Checked Out'
                             ELSE isnam.name
                             END                                           AS Status,
                         TO_CHAR(i.inventory_gmt, 'YYYY-MM-DD HH24:MI:SS') AS LastInventoried,
                         'i' || rmi.record_num ||
                         COALESCE(
                                 CAST(
                                         NULLIF(
                                                     (
                                                             (rmi.record_num % 10) * 2 +
                                                             (rmi.record_num / 10 % 10) * 3 +
                                                             (rmi.record_num / 100 % 10) * 4 +
                                                             (rmi.record_num / 1000 % 10) * 5 +
                                                             (rmi.record_num / 10000 % 10) * 6 +
                                                             (rmi.record_num / 100000 % 10) * 7 +
                                                             (rmi.record_num / 1000000) * 8
                                                         ) % 11,
                                                     10
                                             )
                                     AS CHAR(1)
                                     ),
                                 'x'
                             )                                             AS ItemNumber
         FROM sierra_view.item_record AS i
                  JOIN
              sierra_view.item_record_property AS iprop
              ON
                  iprop.item_record_id = i.record_id
                  JOIN
              sierra_view.location_myuser AS iloc
              ON
                  iloc.code = i.location_code
                  JOIN
              sierra_view.item_status_property_myuser AS isnam
              ON
                  isnam.code = i.item_status_code
                  JOIN
              sierra_view.record_metadata As rmi
              ON
                  rmi.id = i.record_id
                  JOIN
              sierra_view.bib_record_item_record_link AS bilink
              ON
                  bilink.item_record_id = i.record_id
                  JOIN
              sierra_view.bib_record_property AS bibprop
              ON
                  bibprop.bib_record_id = bilink.bib_record_id
                  JOIN
              sierra_view.phrase_entry AS bph
              ON
                      bibprop.bib_record_id = bph.record_id
                      AND
                      bph.index_tag = 'c'
                  JOIN
              sierra_view.material_property_myuser AS mtnam
              ON
                  mtnam.code = bibprop.material_code
                  LEFT JOIN
              sierra_view.checkout AS cko
              ON
                  i.record_id = cko.item_record_id
                  LEFT JOIN
              sierra_view.subfield AS sfiv
              ON
                      sfiv.record_id = i.record_id
                      AND
                      sfiv.field_type_code = 'v'
                  LEFT JOIN
              sierra_view.subfield AS sfbc
              ON
                      sfbc.record_id = bibprop.bib_record_id
                      AND
                      sfbc.field_type_code = 'c'
         WHERE iloc.code = 'sdjr'
     ) AS i1;