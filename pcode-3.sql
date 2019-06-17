SELECT user_defined_property.code, user_defined_property_name.name
FROM sierra_view.user_defined_category
INNER JOIN sierra_view.user_defined_property ON user_defined_property.user_defined_category_id = user_defined_category.id
INNER JOIN sierra_view.user_defined_property_name ON user_defined_property_name.user_defined_property_id = user_defined_property.id
WHERE user_defined_category.code = 'pcode3' AND iii_language_id = 1;
