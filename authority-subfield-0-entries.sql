SELECT DISTINCT REGEXP_REPLACE(subfield.content, '^https?:\/\/id.loc.gov\/authorities\/.*\/', '', 'gi') AS "ARN"
FROM sierra_view.subfield
WHERE subfield.tag = '0'
AND subfield.content LIKE 'http%id.loc.gov%'
AND subfield.marc_tag = '100'
LIMIT 50;