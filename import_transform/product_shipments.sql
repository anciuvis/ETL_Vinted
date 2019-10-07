DROP TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tracking_code` INT(11) NOT NULL,
  `from_country` VARCHAR(2) NOT NULL DEFAULT '',
  `to_country` VARCHAR(2) NOT NULL DEFAULT '',
  `package_type_id` INT(11) NOT NULL,
  `transaction_id` INT(11) NOT NULL,
  `shipping_label_created` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracking_code` (`tracking_code`),
  KEY `package_type_id` (`package_type_id`)
);
INSERT INTO tmp1 (`tracking_code`, `from_country`, `to_country`, `package_type_id`, `transaction_id`, `shipping_label_created`)	
SELECT 	`jsondata`->>'$.tracking_code',
		`jsondata`->>'$.from_country',
		`jsondata`->>'$.to_country',
		`jsondata`->>'$.package_type_id',
		`jsondata`->>'$.transaction_id',		
		`jsondata`->>'$.shipping_label_created'
FROM `product_shipments_tmp`;

INSERT INTO product_shipments (`tracking_code`, `from_country`, `to_country`, `package_type_id`, `transaction_id`, `shipping_label_created`)
SELECT tracking_code, from_country, to_country, package_type_id, transaction_id, shipping_label_created
FROM tmp1
WHERE (tracking_code, from_country, to_country, transaction_id) NOT IN 
		( SELECT tracking_code, from_country, to_country, transaction_id
		  FROM product_shipments
		);
UPDATE product_shipments a 
JOIN tmp1 b ON
a.tracking_code = b.tracking_code AND
a.from_country = b.from_country AND
a.to_country = b.to_country AND
a.transaction_id = b.transaction_id
SET
a.package_type_id = b.package_type_id,
a.shipping_label_created = b.shipping_label_created;
DROP TEMPORARY TABLE tmp1