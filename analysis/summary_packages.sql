SELECT COUNT(package_type_id) AS freq, b.`description`
FROM product_shipments a
LEFT JOIN `product_package_types` b
ON a.`package_type_id` = b.`type_id`
GROUP BY description
ORDER BY freq DESC;