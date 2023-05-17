SELECT
  ir.location_code,
  ln.name,
  COUNT(ir.location_code)
FROM
  sierra_view.item_record ir
    JOIN sierra_view.location l ON l.code = ir.location_code
  JOIN sierra_view.location_name ln ON ln.location_id = l.id
WHERE
  virtual_type_code IS NULL
GROUP BY ir.location_code, ln.name
ORDER BY 2 DESC;