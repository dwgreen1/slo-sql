/*
 Innovative's software doesn't intervene proactively or helpfully
 when a field is getting too big, in most cases.  Thresholds are
 actually much greater than 10K.  Problems and behaviors can
 manifest when a record has a field in it with more than "too
 many" "characters" -- sometimes a problem with the field, or with
 the record.  When reproducible workflows that are problematic are
 identified and a "big field" is discovered to be a contributor to
 the problem, Innovative's engineers typically try to make sure the
 programs handle the situation sensibly, but it's still important
 to reduce the size of the field.

505 Notes fields are the most likely to get too big.  MARC and
 Sierra both allow more than one 505 field.  The solution for any
 issues with a too-big field at some point will be to create >n fields,
 each with <10K characters in them.
*/
SELECT
id2reckey(record_id),
field_len,
substring(field_content, 0,30)||'.......'
from (SELECT record_id,
(((octet_len - char_len) * 7) + (char_len - octet_len + char_len) + 5)
AS field_len , field_content
FROM ( SELECT record_id,
                          Octet_length(field_content) AS octet_len,
                          Length(field_content)       AS char_len ,
                          field_content
              FROM sierra_view.varfield
     ) AS set1
     ) as algo where field_len > 10000
order by field_len desc;