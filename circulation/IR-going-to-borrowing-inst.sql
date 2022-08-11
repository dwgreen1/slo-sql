SELECT i.barcode, b.title,

        CASE WHEN i.vol IS NULL THEN c.content ELSE c.content||' '||i.vol END call_num,

                 i.price, i.in_transit_date, i.due_date, i.loan_period,

                 ll.name AS home_loc, bl.name AS desintation, i.pickup, i.patron

FROM

        (SELECT ip,barcode, m.field_content, ch.due_gmt::DATE AS due_date,

         ch.checkout_gmt, ch.checkout_gmt::DATE AS in_transit_date, ip.call_number,

         (to_char(ch.due_gmt,'MM-DD-YYYY')::DATE - to_char(ch.checkout_gmt,'MM-DD-YYYY')::DATE) AS loan_period,

         i.id , i.location_code, i.item_status_code, i.price,vol.field_content as vol,

         m.field_content as mes,

        -- THE NEXT THREE LINES ARE USED TO PARSE THE ITEM MESSAGE TO GET THE PATRON ID, BORROWING LIBRARY, AND PICKUP LOCATION

        REPLACE(REPLACE(m.field_content, SUBSTRING(m.field_content, 1,POSITION('.' IN m.field_content)-1),''),SUBSTRING(m.field_content, POSITION('@' IN m.field_content)),'') AS patron,

        LEFT(REPLACE(m.field_content, SUBSTRING(m.field_content, 1,POSITION('@' IN m.field_content)),''),5) AS to,

        REPLACE(m.field_content, SUBSTRING(m.field_content, 1,POSITION(' at ' IN m.field_content)+3),'') AS pickup

        FROM sierra_view.item_record i

        LEFT JOIN sierra_view.checkout ch ON i.id = ch.item_record_id

        LEFT JOIN sierra_view.item_record_property ip ON i.id = ip.item_record_id

        LEFT JOIN

                 (SELECT m.record_id, m.field_content

                 FROM sierra_view.varfield_view m

                 WHERE m.record_type_code = 'i'

                 AND m.varfield_type_code = 'm') m

        ON i.id = m.record_id

        LEFT JOIN (

                 -- THIS GRABS THE VOLUME DATA WHEN IT EXIST IN ITEM RECORDS TO HELP BUILD THE CALL NUMBER

                 SELECT v.record_id, v.field_content

                 FROM sierra_view.varfield_view v

                 WHERE v.record_type_code = 'i'

                 AND v.varfield_type_code = 'v') as vol

        ON i.id = vol.record_id

        -- SO/OL OFFSITE STATUS

        WHERE i.item_status_code = '@') AS i

LEFT JOIN sierra_view.bib_record_item_record_link bi ON i.id = bi.item_record_id

LEFT JOIN sierra_view.bib_view b ON bi.bib_record_id = b.id

LEFT JOIN

        -- THIS GRABS THE BASE FOR THE CALL NUMBER

        (SELECT sv.record_id, sv.content FROM

        sierra_view.subfield_view sv

        WHERE sv.record_type_code = 'b' AND sv.marc_tag = '099') c

ON bi.bib_record_id = c.record_id

        AND (i.call_number IS NULL OR RIGHT(i.call_number,LENGTH(i.call_number)-2) = c.content)

LEFT JOIN sierra_view.location_myuser ll ON i.location_code = ll.code

LEFT JOIN sierra_view.location_myuser bl ON i.to = bl.code

WHERE i.checkout_gmt BETWEEN '2021-07-01' AND '2022-04-01'

-- THE NEXT TWO LINES DETERMINE THAT THE ITEM WAS SENT BUT HAD NOT YET ARRIVED TO BORROWING LIBRARY.

-- A VALUE OF 7 OR 21 DAYS FOR I.LOAN_PERIOD ARE BASED ON THE DEFAULT DUE DATE MINUS THE CHECKOUT/TRANSIT DATE.

-- ONCE THE ITEM IS RECEVIED, THE DUE DATE IS UPDATED, CHANGING THE I.LOAN_PERIOD VALUE TO BE GREATER THAN 7 OR 21.

-- IF I.LOAN_PERIOD IS STILL 7 OR 21 DAYS AFTER A MONTH OR SO FROM THE TRANSIT DATE, IT IS LIKELY THE ITEM WAS LOST IN TRANSIT.

AND i.field_content LIKE '%requested by%'

AND (i.loan_period = 7 OR i.loan_period = 21)

ORDER BY i.checkout_gmt DESC;
