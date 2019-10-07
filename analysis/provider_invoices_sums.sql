SELECT `provider_invoices`.`from_country`, `provider_invoices`.`to_country`, SUM(`provider_invoices`.`amount`) sum
FROM provider_invoices
GROUP BY from_country, to_country
ORDER BY sum DESC;