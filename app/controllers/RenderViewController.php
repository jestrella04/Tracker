<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;

class RenderViewController extends BaseController
{
    public function renderScreenLogin(Request $request, Response $response, array $args)
    {
        // CSRF token name and value
        $args['nameKey'] = $this->csrf->getTokenNameKey();
        $args['valueKey'] = $this->csrf->getTokenValueKey();
        $args['name'] = $request->getAttribute($args['nameKey']);
        $args['value'] = $request->getAttribute($args['valueKey']);

        // Flash messages
        $args['flashMessages'] = $this->getFlashMessages();

        // Get app settings
        $args['settings'] = $this->settings;

        return $this->renderer->render($response, 'login.php', $args);
    }

    public function renderScreenHome(Request $request, Response $response, array $args)
    {
        // CSRF token name and value
        $args['nameKey'] = $this->csrf->getTokenNameKey();
        $args['valueKey'] = $this->csrf->getTokenValueKey();
        $args['name'] = $request->getAttribute($args['nameKey']);
        $args['value'] = $request->getAttribute($args['valueKey']);

        // Flash messages
        $args['flashMessages'] = $this->getFlashMessages();

        // Auth controller
        $auth = $this->container->get('AuthController');
        $auth->setUserId($_SESSION['tracker_userid']);
        $args['auth'] = $auth;

        // User controller
        $user = $this->container->get('UserController');
        $args['user'] = $user;

        // Session controller
        $session = $this->container->get('SessionController');

        // Get current user
        $args['userId'] = $this->getCurrentUserId();

        // Get current date
        $args['currDate'] = date('Y-m-d', time());

        // Get app settings
        $args['settings'] = $this->settings;

        // Validate session and load view accordingly
        if ($auth->isDefaultPassword()) {
            return $this->renderer->render($response, 'change-password.php', $args);
        } else {
            // Create the user session in database
            //$session->addActiveSession($args['userId']);

            return $this->renderer->render($response, 'home.php', $args);
        }
    }

    public function renderScreenChangePassword(Request $request, Response $response, array $args)
    {
        // CSRF token name and value
        $args['nameKey'] = $this->csrf->getTokenNameKey();
        $args['valueKey'] = $this->csrf->getTokenValueKey();
        $args['name'] = $request->getAttribute($args['nameKey']);
        $args['value'] = $request->getAttribute($args['valueKey']);

        // Flash messages
        $args['flashMessages'] = $this->getFlashMessages();

        // Get current user
        $args['userId'] = $this->getCurrentUserId();

        // Get app settings
        $args['settings'] = $this->settings;

        return $this->renderer->render($response, 'change-password.php', $args);
    }

    public function renderScreenForgotPassword(Request $request, Response $response, array $args)
    {
        // CSRF token name and value
        $args['nameKey'] = $this->csrf->getTokenNameKey();
        $args['valueKey'] = $this->csrf->getTokenValueKey();
        $args['name'] = $request->getAttribute($args['nameKey']);
        $args['value'] = $request->getAttribute($args['valueKey']);

        // Flash messages
        $args['flashMessages'] = $this->getFlashMessages();

        // Get app settings
        $args['settings'] = $this->settings;

        return $this->renderer->render($response, 'forgot-password.php', $args);
    }
}