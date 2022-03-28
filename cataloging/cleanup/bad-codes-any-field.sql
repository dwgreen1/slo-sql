SET SEARCH_PATH TO sierra_view;
SELECT *
FROM iii.sierra_view.subfield_view
WHERE content ILIKE ANY('{"%ǂ%"}')
LIMIT 10;
