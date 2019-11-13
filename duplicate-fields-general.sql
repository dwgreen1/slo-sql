SELECT DISTINCT id2reckey(vf.record_id) || 'a'
FROM sierra_view.varfield_view vf
WHERE vf.record_type_code = 'b'
GROUP BY vf.record_id,
         vf.varfield_type_code,
         vf.marc_tag,
         vf.marc_ind1,
         vf.marc_ind2,
         vf.field_content
HAVING COUNT(*) > 1
ORDER BY 1;