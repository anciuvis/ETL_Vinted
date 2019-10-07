SELECT a.`transaction_id`, a.`package_type_id`, b.`amount` AS amount_product, b2.`amount` AS amount_provider, d.`price` AS price_listed, (b2.`amount` - d.`price`) AS amount_diff, c.kilos AS kg, d.`actual_package_size` AS kg_pricelist, a.`from_country`, a.`to_country`
FROM `product_shipments` a
LEFT JOIN `product_invoices` b ON
a.`transaction_id` = b.`transaction_id`
LEFT JOIN `provider_invoices` b2 ON
a.`tracking_code` = b2.`tracking_code`
LEFT JOIN (
SELECT
  dataset.type_id AS type_id, CONCAT((REPLACE(REPLACE(TRIM(LEADING '.' FROM RIGHT(SUBSTRING_INDEX(dataset.description, 'kg', 1), 4)), ' ', ''), '0-', '')), ' kg') AS kilos
FROM
      (
        SELECT `product_package_types`.`type_id`, `product_package_types`.`description` AS description
        FROM `product_package_types`
      ) AS dataset
) AS c 
ON a.`package_type_id` = c.type_id

LEFT JOIN `provider_prices` AS d
ON a.from_country = d.`from_country` AND
a.`to_country` = d.`to_country` AND
c.kilos = d.`actual_package_size`;

	
    
