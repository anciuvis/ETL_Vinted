DROP TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_country` VARCHAR(2) NOT NULL DEFAULT '',
  `to_country` VARCHAR(2) NOT NULL DEFAULT '',
  `price` DECIMAL(9,6) NOT NULL,
  `actual_package_size` VARCHAR(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
);
INSERT INTO tmp1 (`from_country`, `to_country`, `price`, `actual_package_size`)	
SELECT 	`jsondata`->>'$.from_country',
		`jsondata`->>'$.to_country',
		`jsondata`->>'$.price',
		`jsondata`->>'$.actual_package_size'
FROM `provider_prices_tmp`;

INSERT INTO provider_prices (`from_country`, `to_country`, `price`, `actual_package_size`)
SELECT from_country, to_country, price, actual_package_size
FROM tmp1
WHERE (from_country, to_country, actual_package_size) NOT IN 
		( SELECT from_country, to_country, actual_package_size
		  FROM provider_prices
		);
UPDATE provider_prices a 
JOIN tmp1 b ON
a.from_country = b.from_country AND
a.to_country = b.to_country AND
a.actual_package_size = b.actual_package_size
SET
a.price = b.price;
DROP TEMPORARY TABLE tmp1