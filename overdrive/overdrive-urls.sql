SELECT id2reckey(record_id), content
FROM sierra_view.subfield_view
WHERE tag = 'u'
  AND marc_tag IN ('856', '956')
  AND content ILIKE '%overdrive%'
  AND content NOT ILIKE '%samples.%'
  AND content NOT ILIKE '%excerpts.%';
