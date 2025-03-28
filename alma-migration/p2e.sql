SET STATEMENT_TIMEOUT TO 0;
SELECT id2reckey(sierra_view.varfield.record_id)
FROM sierra_view.varfield
  JOIN sierra_view.bib_record
    ON sierra_view.bib_record.id = sierra_view.varfield.record_id
  JOIN sierra_view.bib_record_location
    ON sierra_view.bib_record_location.bib_record_id = sierra_view.varfield.record_id
WHERE sierra_view.bib_record_location.location_code IN ('swp', 'fwp', 'elr', 'odl')
  AND sierra_view.varfield.marc_tag = '856'
  AND sierra_view.varfield.marc_ind1 = '4'
  AND sierra_view.varfield.marc_ind2 = '0';
