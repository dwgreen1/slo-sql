-- Show the contents of all m-tagged fields.
-- Should all be 035
-- Should really only be used by Marcive for tmp numbers at this point
SELECT *
FROM sierra_view.varfield_view vv
WHERE vv.record_type_code = 'b'
AND vv.varfield_type_code = 'm'
ORDER BY 1;
