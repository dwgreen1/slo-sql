SET search_path = sierra_view;
WITH ItemsMessage_u AS
       (
         SELECT bil.bib_record_id
         FROM bib_record_item_record_link bil
                INNER JOIN item_record i
                           ON bil.item_record_id = i.id
              -- Change the following to whichever item fixed-field code you want
         WHERE i.item_status_code = '@'
       ),
     ItemsMessage_NOTu AS
       (
         SELECT bil.bib_record_id
         FROM bib_record_item_record_link bil
                INNER JOIN item_record i
                           ON bil.item_record_id = i.id
          -- Change it here as well!
         WHERE i.item_status_code IS NULL
            OR i.item_status_code != '@'
       )
SELECT DISTINCT bv.record_num
FROM ItemsMessage_u u
       INNER JOIN bib_view bv
                  ON u.bib_record_id = bv.id
       LEFT OUTER JOIN ItemsMessage_NOTu notu
                       ON u.bib_record_id = notu.bib_record_id
WHERE notu.bib_record_id IS NULL;
