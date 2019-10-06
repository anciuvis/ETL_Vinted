-- Create syntax for 'provider_invoices'

CREATE TABLE `provider_invoices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tracking_code` int(11) NOT NULL,
  `from_country` varchar(2) NOT NULL DEFAULT '',
  `to_country` varchar(2) NOT NULL DEFAULT '',
  `amount` decimal(6,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tracking_code` (`tracking_code`,`from_country`,`to_country`),
  CONSTRAINT `fk_tracking_code` FOREIGN KEY (`tracking_code`) REFERENCES `product_shipments` (`tracking_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
