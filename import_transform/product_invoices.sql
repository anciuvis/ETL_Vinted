DROP TABLE IF EXISTS tmp1;
CREATE TEMPORARY TABLE tmp1 (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` INT(11) UNSIGNED NOT NULL,
  `amount` DECIMAL(9,6) NOT NULL,
  `user_invoice_date` DATE NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO tmp1 (`transaction_id`, `amount`, `user_invoice_date`)	
SELECT 	`jsondata`->>'$.transaction_id',
		`jsondata`->>'$.amount',
		`jsondata`->>'$.user_invoice_date'
FROM `product_invoices_tmp`;

INSERT INTO product_invoices (`transaction_id`, `amount`, `user_invoice_date`)
SELECT transaction_id, amount, user_invoice_date
FROM tmp1
WHERE ( transaction_id, user_invoice_date ) NOT IN 
		( SELECT transaction_id, user_invoice_date
		  FROM product_invoices
		);  
UPDATE product_invoices a 
JOIN tmp1 b ON
a.transaction_id = b.transaction_id AND
a.user_invoice_date = b.user_invoice_date
SET
a.amount = b.amount;
DROP TEMPORARY TABLE tmp1;