-- URLS for records in Create Lists #1
SELECT id2reckey(record_id), content
FROM sierra_view.subfield
WHERE tag = 'u'
  AND marc_tag IN ('856')
  AND content NOT ILIKE '%.gov%'
  AND content NOT ILIKE '%ohiomemory%'
  AND content NOT ILIKE '%worldcat%'
  AND content NOT ILIKE '%oclc%'
  AND content NOT ILIKE '%.us/%'
  AND content NOT ILIKE '%contentdm%'
  AND record_id IN (
      SELECT record_metadata_id
      FROM sierra_view.bool_set
      WHERE bool_info_id = 1
    );