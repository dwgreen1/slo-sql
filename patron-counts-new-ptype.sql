SET TIMEZONE = 'America/New_York';

SELECT (SELECT count(DISTINCT pr.id)
        FROM sierra_view.patron_record pr
               JOIN sierra_view.record_metadata rm on pr.id = rm.id
        WHERE pr.ptype_code = e'0'
          AND date_trunc('month', rm.creation_date_gmt) = date_trunc('month', now()) - interval '1 month'
       ) as "Total State",

       (SELECT count(DISTINCT pr.id)
        FROM sierra_view.patron_record pr
               JOIN sierra_view.record_metadata rm on pr.id = rm.id
        WHERE pr.ptype_code = e'3'
          AND date_trunc('month', rm.creation_date_gmt) = date_trunc('month', now()) - interval '1 month' ) as "Total Resident";