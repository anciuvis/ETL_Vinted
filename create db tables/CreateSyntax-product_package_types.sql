-- Create syntax for 'product_package_types'

CREATE TABLE `product_package_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `description` varchar(100) CHARACTER SET utf8mb4 DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
