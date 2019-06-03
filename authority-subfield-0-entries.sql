SELECT DISTINCT REGEXP_REPLACE(subfield.content, '^https?:\/\/id.loc.gov\/authorities\/.*\/', '', 'gi')
FROM sierra_view.subfield
WHERE subfield.tag = '0'
AND subfield.content LIKE 'http%'
AND subfield.marc_tag = '100'
LIMIT 50;