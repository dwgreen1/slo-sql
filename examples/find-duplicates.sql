select *
from (
         select A.*,
                count(*)
                over (partition by transaction_gmt, item_record_id, op_code, application_name, stat_group_code_num) CNT
         from sierra_view.circ_trans A
         where (op_code = 'o' or op_code = 'r' or op_code = 'i')) as BABS
where BABS.CNT > 1
