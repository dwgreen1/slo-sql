SET TIMEZONE = 'America/New_York';
SELECT pe.index_entry
FROM sierra_view.phrase_entry pe
WHERE pe.index_tag = 'o'
  AND pe.index_entry ~ '^[0-9]'
  AND pe.record_id IN (
    SELECT rm.id
    FROM sierra_view.record_metadata rm
             LEFT JOIN sierra_view.bib_record_location brl ON rm.id = brl.bib_record_id
-- Cataloged today
-- WHERE date_trunc('day', creation_date_gmt) = date_trunc('day', now())
-- Cataloged yesterday
    WHERE creation_date_gmt > current_date - interval '1' day
-- Not an Ohioana, or OhioLINK title only
      AND brl.location_code NOT ILIKE E'on%'
      AND brl.location_code != E'owp'
);

SET TIMEZONE = 'America/New_York';
SELECT pe.index_entry
FROM sierra_view.phrase_entry pe
WHERE pe.index_tag = 'o'
  AND pe.index_entry ~ '^[0-9]'
  AND pe.record_id IN (
    SELECT rm.id
    FROM sierra_view.record_metadata rm
    LEFT JOIN sierra_view.bib_record_location brl ON rm.id = brl.bib_record_id
    -- Cataloged today
    -- WHERE date_trunc('day', creation_date_gmt) = date_trunc('day', now())
    -- Cataloged yesterday
    WHERE creation_date_gmt > current_date - interval '1' day
    -- An Ohioana title
      AND brl.location_code ILIKE E'on%'
);