DROP TABLE IF EXISTS vinted.tmp1;
CREATE TEMPORARY TABLE vinted.tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `jsondata` JSON,
  `from_country` VARCHAR(2) NOT NULL DEFAULT '',
  `to_country` VARCHAR(2) NOT NULL DEFAULT '',
  `price` DECIMAL(6,4) NOT NULL,
  `actual_package_size` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`)
);
LOAD DATA LOCAL INFILE '/Users/anciuvis/Desktop/Vinted/provider_prices/part-00000-f9d86808-ca2f-4689-830a-776d12075b6d-c000.json' 
INTO TABLE vinted.tmp1(jsondata)

SET `from_country` = TRIM((jsondata->>'$.from_country')),
	`to_country` = TRIM((jsondata->>'$.to_country')),
	`price` = TRIM((jsondata->>'$.price')),
	`actual_package_size` = TRIM((jsondata->>'$.actual_package_size'));

INSERT INTO vinted.provider_prices (`from_country`, `to_country`, `price`, `actual_package_size`)
SELECT from_country, to_country, price, actual_package_size
FROM vinted.tmp1 
WHERE ( from_country, to_country, actual_package_size) NOT IN 
		( SELECT from_country, to_country, actual_package_size 
		  FROM vinted.provider_prices
		);
		
UPDATE vinted.provider_prices a 
JOIN vinted.tmp1 b ON
a.from_country = b.from_country AND
a.to_country = b.to_country AND
a.actual_package_size = b.actual_package_size
SET
a.price = b.price;

DROP TABLE vinted.tmp1;