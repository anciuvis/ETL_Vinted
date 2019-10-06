-- Create syntax for 'product_invoices'

CREATE TABLE `product_invoices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) unsigned NOT NULL,
  `amount` decimal(6,4) NOT NULL,
  `user_invoice_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
