<?php

require __DIR__ . '/../vendor/autoload.php';

// Include common functions
require __DIR__ . '/common.php';

// Instantiate the app
$settings = require __DIR__ . '/../app/settings.php';
$app = new \Slim\App($settings);

// Set up dependencies
require __DIR__ . '/../app/dependencies.php';

// Register middleware
require __DIR__ . '/../app/middleware.php';

// Register routes
require __DIR__ . '/../app/routes.php';

// Apply middleware and containers
$app->add($loggedInMiddleware);
$app->add($container->get('csrf'));