DROP TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_id` INT(11) NOT NULL,
  `description` VARCHAR(100) CHARACTER SET utf8mb4 DEFAULT '',
  PRIMARY KEY (`id`)
);

INSERT INTO tmp1 (`type_id`, `description`)	
SELECT 	`jsondata`->>'$.id',
		`jsondata`->>'$.description'
FROM `product_package_types_tmp`;

INSERT INTO product_package_types (`type_id`, `description`)
SELECT type_id, description
FROM tmp1
WHERE type_id NOT IN 
		( SELECT type_id
		  FROM product_package_types
		);  
UPDATE product_package_types a 
JOIN tmp1 b ON
a.type_id = b.type_id
SET
a.description = b.description;
DROP TEMPORARY TABLE tmp1;