-- Create syntax for 'provider_prices'

CREATE TABLE `provider_prices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `from_country` varchar(2) NOT NULL DEFAULT '',
  `to_country` varchar(2) NOT NULL DEFAULT '',
  `price` decimal(9,6) NOT NULL,
  `actual_package_size` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8;
