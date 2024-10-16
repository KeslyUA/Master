<?php 
    $dsn = "mysql:dbname=masterworkrrhh;host=localhost";
	//$dsn = "mysql:dbname=masterworkrrhh;host=192.168.1.30";
	$user = "root";
	$password = "";

	try {
		$pdo = new PDO($dsn,$user,$password);
		$errorDbConexion = false;
	}
	catch ( PDOException $e) {
		echo 'Error al conectarnos ' . $e->getMessage();
	}

	$pdo->exec("SET CHARACTER SET utf8"); // <--utf8
?>