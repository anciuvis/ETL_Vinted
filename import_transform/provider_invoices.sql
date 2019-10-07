DROP TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tracking_code` INT(11) NOT NULL,
  `from_country` VARCHAR(2) NOT NULL DEFAULT '',
  `to_country` VARCHAR(2) NOT NULL DEFAULT '',
  `amount` DECIMAL(9,6) NOT NULL,
  PRIMARY KEY (`id`)
);
INSERT INTO tmp1 (`tracking_code`, `from_country`, `to_country`, `amount`)	
SELECT 	`jsondata`->>'$.tracking_code',
		`jsondata`->>'$.from_country',
		`jsondata`->>'$.to_country',
		`jsondata`->>'$.amount'
FROM `provider_invoices_tmp`;

INSERT INTO provider_invoices (`tracking_code`, `from_country`, `to_country`, `amount`)
SELECT tracking_code, from_country, to_country, amount
FROM tmp1
WHERE (tracking_code, from_country, to_country) NOT IN 
		( SELECT tracking_code, from_country, to_country
		  FROM provider_invoices
		);
UPDATE provider_invoices a 
JOIN tmp1 b ON
a.tracking_code = b.tracking_code AND
a.from_country = b.from_country AND
a.to_country = b.to_country 
SET
a.amount = b.amount;
DROP TEMPORARY TABLE tmp1