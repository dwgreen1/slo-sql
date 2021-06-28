SELECT ct.transaction_gmt::date, count(ct.transaction_gmt)
FROM sierra_view.circ_trans ct
WHERE ct.transaction_gmt >= current_date - interval '6 days'
  AND ct.op_code = 'i'
GROUP BY ct.transaction_gmt::date
