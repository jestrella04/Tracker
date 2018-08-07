<?php

use Slim\Http\Request;
use Slim\Http\Response;

// Validate the CSRF token is valid.
$csrfValidationMiddleware = function (Request $request, Response $response, $next) {
	$routePath = $request->getUri()->getPath();

	if (false === $request->getAttribute('csrf_status')) {
        //Token validation failed
		if (strpos($routePath, 'api/') === 0) {
            // Output error message if using API
			$response = $response->write('CSRF token validation failed.');
		} else {
            // Add flash message and redirect to the login page
			$this->flash->addMessage('danger', 'CSRF token validation failed.');
			$response = $response->withStatus(302)->withHeader('Location', safeRedirect('/login'));
		}
	} else {
		$response = $next($request, $response);
	}

	return $response;
};
