<?php

require ROOT_PATH . '/vendor/autoload.php';

// Load Environment file
$dotEnv = new \Dotenv\Dotenv(ROOT_PATH);
$dotEnv->load();

// Include common functions
require ROOT_PATH . '/app/common.php';

// Instantiate the app
$settings = require ROOT_PATH . '/app/settings.php';
$app = new \Slim\App($settings);

// Set up dependencies
require ROOT_PATH . '/app/dependencies.php';

// Register middleware
require ROOT_PATH . '/app/middleware.php';

// Register routes
require ROOT_PATH . '/app/routes.php';

// Apply middleware and containers
$app->add($loggedInMiddleware);
$app->add($container->get('csrf'));
