SET TIMEZONE = 'America/New_York';
SELECT
NOW()::TIMESTAMP WITH TIME ZONE AS now_gmt,
       MAX(c.transaction_gmt)::TIMESTAMP WITH TIME ZONE AS max,
       MIN(c.transaction_gmt)::TIMESTAMP WITH TIME ZONE AS min,
       AGE(MIN(c.transaction_gmt)) AS earliest_transaction_age
FROM sierra_view.circ_trans AS c;