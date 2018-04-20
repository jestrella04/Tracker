<?php

// Initialize PHP session
session_start();

// Define absolute root path
define(ROOT_PATH, dirname(dirname(__FILE__)));

// Require application bootstrap file
require ROOT_PATH . '/app/bootstrap.php';

// Run the application
$app->run();
