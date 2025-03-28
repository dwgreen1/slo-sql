SELECT
    COALESCE(prfn.first_name, 'Grand Total') AS first_name,
    COALESCE(prfn.last_name, '') AS last_name,
    COUNT(ct.id) AS transactions,
    COUNT(DISTINCT DATE(ct.transaction_gmt)) AS sessions
FROM sierra_view.circ_trans ct
    JOIN sierra_view.patron_record pr ON pr.id = ct.patron_record_id
    JOIN sierra_view.patron_record_fullname prfn ON prfn.patron_record_id = pr.record_id
WHERE
    op_code = 'o'
    AND stat_group_code_num = 825
    AND transaction_gmt >= NOW() - INTERVAL '6 months'
GROUP BY
    GROUPING SETS ((prfn.first_name, prfn.last_name), ())
ORDER BY
    sessions DESC;
