<?php
foreach (glob('./{product_invoices,product_shipments,provider_invoices,product_package_types,provider_prices}', GLOB_BRACE) as $dir) {
	$resulting_data = [];
    foreach (glob("{$dir}/*.json") as $filename) {
			$lines = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
			file_put_contents("{$dir}/merged.json", implode("\n", $lines), FILE_APPEND);
		}
}
