SELECT `provider_invoices`.`tracking_code`, `provider_invoices`.`amount`
FROM `provider_invoices`
WHERE `tracking_code` NOT IN 
	( 	SELECT `tracking_code`
		FROM `product_shipments`
	);