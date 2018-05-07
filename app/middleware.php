<?php

use Slim\Http\Request;
use Slim\Http\Response;

// Check the user is logged in when necessary.
$loggedInMiddleware = function (Request $request, Response $response, $next) {
	$route = $request->getAttribute('route');
	$auth = $this->get('AuthController');

	if ($route) {
		$routeName = $route->getName();
		$groups = $route->getGroups();
		$methods = $route->getMethods();
		$arguments = $route->getArguments();
        
        # Define routes that user does not have to be logged in with. All other routes, the user
        # needs to be logged in with.
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
				$response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/');
			} else {
                // Update session time and proceed as normal...
				$auth->updateSessionActivity();
				$response = $next($request, $response);
			}
		} else {
			if (in_array($routeName, $publicRoutesArray)) {
                // Redirect to the public route
				$response = $next($request, $response);
			} else {
                // Redirect to the login page
				$response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/login');
			}
		}
	} else {
		$response = $this->renderer->render($response->withStatus(404), '404.php');
	}

	return $response;
};
