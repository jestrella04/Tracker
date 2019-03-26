<?php

use Slim\Http\Request;
use Slim\Http\Response;

// Check the user is logged in when necessary.
$loggedInMiddleware = function (Request $request, Response $response, $next) {
	$route = $request->getAttribute('route');
	$auth = $this->get('AuthController');

	if ($route) {
		$routeName = $route->getName();
		$routePath = $request->getUri()->getPath();
        
		$publicRoutesArray = array(
			'login',
			'post-login',
			'forgot-password',
			'post-forgot-password',
			'session-clean'
		);

		if ($auth->isValidSession()) {
			if ('login' == $routeName) {
                // Update session time and redirect to the home page
				$auth->updateSessionActivity();
				$response = $response->withStatus(302)->withHeader('Location', safeRedirect('/'));
			} else {
                // Update session time and proceed as normal...
				$auth->updateSessionActivity();
				$response = $next($request, $response);
			}
		} else if (in_array($routeName, $publicRoutesArray)) {
			// Redirect to the public route
			$response = $next($request, $response);
		} else if (strpos($routePath, 'api/') === 0 || strpos($routePath, '/api/') === 0) {
			// Return unauthorized response status
			$response = $response->withStatus(403);
		} else if ('login' !== $routeName) {
			// Redirect to the login page
			$response = $response->withStatus(302)->withHeader('Location', safeRedirect('/login'));
		}
	} else {
		$response = $this->renderer->render($response->withStatus(404), '404.php');
	}

	return $response;
};
