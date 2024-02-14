SET TIMEZONE = 'America/New_York';
SELECT lm.name,
       COUNT(ct.id)
FROM sierra_view.circ_trans ct
JOIN sierra_view.location_myuser lm ON lm.code = TRIM(ct.item_location_code)
WHERE ct.op_code = 'o'
AND ct.itype_code_num < 200
AND date_part('year', ct.transaction_gmt) = '2023'
GROUP BY lm.name
ORDER BY 1;
