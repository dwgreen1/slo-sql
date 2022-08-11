COALESCE(
    CAST(
        NULLIF(
        (
            ( md.record_num % 10 ) * 2 +
            ( md.record_num / 10 % 10 ) * 3 +
            ( md.record_num / 100 % 10 ) * 4 +
            ( md.record_num / 1000 % 10 ) * 5 +
            ( md.record_num / 10000 % 10 ) * 6 +
            ( md.record_num / 100000 % 10 ) * 7 +
            ( md.record_num / 1000000 ) * 8
         ) % 11,
         10
         )
  AS CHAR(1)
  ),
  'x'
 )
