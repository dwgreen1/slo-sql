SET TIMEZONE = 'America/New_York';
SELECT
  (SELECT COUNT(*)
FROM sierra_view.circ_trans
WHERE op_code = 'o'
  AND date_trunc('month', transaction_gmt) = date_trunc('month', now()) - interval '1 month') AS "Checkouts",
  (SELECT COUNT(*)
FROM sierra_view.circ_trans
WHERE op_code = 'r'
  AND date_trunc('month', transaction_gmt) = date_trunc('month', now()) - interval '1 month') AS "Renewals";