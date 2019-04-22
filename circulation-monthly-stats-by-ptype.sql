SET TIMEZONE = 'America/New_York';

WITH totals AS (
	SELECT --transaction fields
		CASE
			WHEN t.ptype_code = '0' THEN 'State Employees'
			WHEN t.ptype_code = '3' THEN 'Ohio Residents'
			ELSE 'Others'
		END AS user_group,
		SUM(
			CASE
				WHEN t.op_code = 'o' THEN 1
				ELSE 0
			END
		) AS total_chkout,
		SUM(
			CASE
				WHEN t.op_code = 'r' THEN 1
				ELSE 0
			END
		) AS total_renewal
	FROM sierra_view.circ_trans t
	WHERE date_trunc('month', t.transaction_gmt) = date_trunc('month', now()) - interval '1 month'
	GROUP BY 1
) SELECT * FROM totals
UNION ALL
SELECT 'TOTAL', SUM(total_chkout), SUM(total_renewal) FROM totals