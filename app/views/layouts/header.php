<!DOCTYPE html>
<html lang="en">
	<head>
		<title><?= $settings['company_name']['value'] ?> Tracker</title>
        <base href="<?php echo dirname($_SERVER['SCRIPT_NAME']) . '/'; ?>">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Workforce tracker for <?= $settings['company_name']['value'] ?>">
		<meta name="author" content="Jonathan Estrella">
		<meta name="mobile-web-app-capable" content="yes">
		<link rel="icon" sizes="196x196" href="public/assets/img/favicon.png" type="image/png">
		<link rel="manifest" href="public/manifest.json">
        <link href="public/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="public/assets/font-awesome/css/fontawesome.min.css" rel="stylesheet">
        <link href="public/assets/font-awesome/css/fontawesome-all.min.css" rel="stylesheet">
        <link href="public/assets/css/tracker.css" rel="stylesheet">
	</head>

	<body>
		<noscript>
			<div class="d-flex justify-content-center">
				<div class="alert alert-danger" role="alert">
					Your browser does not support Javascript, please contact your system administrator for instructions on how to enable and/or upgrade to a modern web browser.
				</div>
			</div>
		</noscript>
