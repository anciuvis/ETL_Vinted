<?php

$conn = new mysqli();
$conn->connect('127.0.0.1', 'root');
$conn->select_db('vinted');

foreach (glob('./{product_invoices,product_shipments,provider_invoices,product_package_types,provider_prices}', GLOB_BRACE) as $dir) {
	$resulting_data = [];
	$n = basename($dir)."_tmp";
	$conn->query("DROP TABLE IF EXISTS `{$n}`");
	echo "dropped table  {$n}\n";
	$conn->query("CREATE TABLE `{$n}` (`jsondata` json DEFAULT NULL) ENGINE=InnoDB");
	echo "creating table {$n}\n";
    foreach (glob("{$dir}/*.json") as $filename) {

			$conn->begin_transaction();
			$lines = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
			array_walk($lines, function($line) use($conn, $n){
				$conn->query("INSERT INTO {$n}(jsondata) VALUES('{$line}')");
			});
			$conn->commit();
		}
		echo "{$n} done\n";
}
