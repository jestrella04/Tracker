<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Tracker – <?= $settings['company_name']['value'] ?></title>
        <base href="<?= safeRedirect('/'); ?>">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Workforce tracker for <?= $settings['company_name']['value'] ?>">
		<meta name="author" content="Jonathan Estrella">
		<meta name="mobile-web-app-capable" content="yes">
		<link rel="icon" sizes="196x196" href="static/img/<?= $settings['company_logo_favicon']['value'] ?>" type="image/png">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css" integrity="sha384-G0fIWCsCzJIMAVNQPfjH08cyYaUtMwjJwqiRKxxE/rx96Uroj1BtIQ6MLJuheaO9" crossorigin="anonymous">
        <link href="static/css/bundle.min.css" rel="stylesheet">
	</head>

	<body>
		<noscript>
			<div class="d-flex justify-content-center">
				<div class="alert alert-danger" role="alert">
					Your browser does not support Javascript, please contact your system administrator for instructions on how to enable and/or upgrade to a modern web browser.
				</div>
			</div>
		</noscript>
