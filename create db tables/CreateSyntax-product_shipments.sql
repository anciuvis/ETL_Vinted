-- Create syntax for 'product_shipments'

CREATE TABLE `product_shipments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tracking_code` int(11) NOT NULL,
  `from_country` varchar(2) NOT NULL DEFAULT '',
  `to_country` varchar(2) NOT NULL DEFAULT '',
  `package_type_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `shipping_label_created` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracking_code` (`tracking_code`),
  KEY `package_type_id` (`package_type_id`),
  CONSTRAINT `fk_pack_type` FOREIGN KEY (`package_type_id`) REFERENCES `product_package_types` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
