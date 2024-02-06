-- RETURNED AND STILL IN-TRANSIT TO YOUR INSTITUTION

SELECT i.barcode, b.title,

        CASE WHEN i.vol IS NULL THEN c.content ELSE c.content||' '||i.vol END call_num,

                 i.price, in_transit_date, bl.name AS returning_library, ll.name AS home_loc

FROM

        (SELECT ip,barcode, m.field_content, ch.due_gmt, ch.checkout_gmt, ip.call_number,

        i.id , i.location_code, i.item_status_code, i.price,vol.field_content as vol,

        m.from, m.in_transit_date

        FROM sierra_view.item_record i

        LEFT JOIN sierra_view.checkout ch ON i.id = ch.item_record_id

        LEFT JOIN sierra_view.item_record_property ip ON i.id = ip.item_record_id

        LEFT JOIN

                 -- THIS GRABS THE DATE AND STATUS FROM THE ITEM MESSAGE TO DETERMINE WHEN AN ITEM LEFT THE BORROWING INSTITUTION

                 (SELECT m.record_id, m.field_content,

                  LEFT(REPLACE(m.field_content, SUBSTRING(m.field_content, 1,41),''),5) AS from,

                 TO_DATE(LEFT(REPLACE(m.field_content,SUBSTRING(LEFT(m.field_content,16),1,4),''),11), 'MON DD YYYY') AS in_transit_date

                 FROM sierra_view.varfield_view m

                 WHERE m.record_type_code = 'i'

                 AND m.varfield_type_code = 'm'

                 AND m.field_content LIKE '%IN TRANSIT%') m

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

-- THE TWO JOINS BELOW GRAB THE DESCRIPTIONS OF THE LOCATION CODES FOR BETTER READABILITY

LEFT JOIN sierra_view.location_myuser ll ON i.location_code = ll.code

LEFT JOIN sierra_view.location_myuser bl ON i.from = bl.code

-- WHERE i.in_transit_date BETWEEN '2021-07-01' AND '2022-04-01'
WHERE i.in_transit_date BETWEEN '2021-07-01' AND '2022-04-04'

ORDER BY i.in_transit_date
