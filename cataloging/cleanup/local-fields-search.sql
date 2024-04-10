select brl.location_code
     ,id2reckey(sv.record_id)
     ,vv.field_content
     ,sv.content
from sierra_view.varfield_view vv
join sierra_view.subfield_view sv on vv.record_id = sv.record_id
join bib_record_location brl on brl.bib_record_id = vv.record_id
where sv.marc_tag = '500'
and sv.tag =  '5'
order by 1, 2;
