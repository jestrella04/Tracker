<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;

class DataValidationController extends BaseController
{
    public function processPostLoginRequest(Request $request, Response $response, array $args)
    {
        $auth = $this->container->get('AuthController');
        $data = $request->getParsedBody();
        $user = array();

        $user['id'] = $this->filterString(strtolower($data['userid']));
        $user['password'] = $this->filterString($data['password']);

        $auth->setUserId($user['id']);
        $auth->setUserPassword($user['password']);

        if ($auth->isValidUser() && $auth->isValidPassword()) {
            // All good, create session information
            $_SESSION['tracker_userid'] = $user['id'];
            $_SESSION['tracker_date_created'] = time();
            $_SESSION['tracker_date_updated'] = time();

            if ($auth->isDefaultPassword()) {
                // Redirect to the change password page
                $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/change-password');
            } else {
                // Create the session in database before redirect
                $session = $this->container->get('SessionController');
                $session->addActiveSession($user['id']);

                // Redirect to the home page
                $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/');
            }
        } else {
            // Invalid login information. Let's add a flash message
            $this->postFlashMessage('danger', 'Invalid login credentials. Please try again.');

            // Redirect back to the login page
            $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/login');
        }

        return $response;
    }

    public function processPostChangePasswordRequest(Request $request, Response $response, array $args)
    {
        $auth = $this->container->get('AuthController');
        $session = $this->container->get('SessionController');
        $user = $this->container->get('UserController');
        $data = $request->getParsedBody();
        $pass = array();

        $pass['id'] = $this->filterString(strtolower($data['user_id']));
        $pass['password1'] = $this->filterString($data['password1']);
        $pass['password2'] = $this->filterString($data['password2']);
        $pass['password3'] = $this->filterString($data['password3']);

        $auth->setUserId($pass['id']);
        $auth->setUserPassword($pass['password1']);
        
        if ($auth->isValidUser() && $auth->isValidPassword() && $pass['password2'] === $pass['password3']) {
            // Proceed to change password
            $hash = password_hash($pass['password2'], PASSWORD_DEFAULT);
            $user->postUserPasswordUpdate($pass['id'], $hash);

            // Post a flash message
            $this->postFlashMessage('success', 'Password was successfully updated.');

            // Remove user from session and redirect back to the login page
            unset($_SESSION['tracker_userid']);
            unset($_SESSION['tracker_date_created']);
            unset($_SESSION['tracker_date_updated']);

            $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/login');
        } else {
            // Invalid information. Let's add a flash message
            $this->postFlashMessage('danger', 'Invalid original password.');

            // Redirect back to the change password page
            $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/change-password');
        }

        return $response;
    }

    public function processPostForgotPasswordRequest(Request $request, Response $response, array $args)
    {
        $user = $this->container->get('UserController');
        $data = $request->getParsedBody();
        $email = $this->filterString($data['recovery_email']);

        $validUser = $user->getUserByEmail($email);
        
        if (!empty($validUser['id'])) {
            // Reset password and redirect to the login page
            $reset = $user->postResetPassword($validUser['id']);

            if ($reset) {
                $this->postFlashMessage('success', 'Reset password instructions have been sent to your email address.');
                $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/login');
            } else {
                $this->postFlashMessage('danger', 'An error occurred while resetting your password.');
                $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/forgot-password');
            }
        } else {
           // Redirect to the forgot password page
           $this->postFlashMessage('danger', 'The provided email address is not associated with any user.');
           $response = $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/forgot-password'); 
        }

        return $response;
    }

    public function processLogoutRequest(Request $request, Response $response, array $args)
    {
        $userId = $this->getCurrentUserId();
        $session = $this->container->get('SessionController');
        $session->removeActiveSession($userId);

        // Clear all session variables
		session_unset();

		// Destroy the session
        session_destroy();
        
        return $response->withStatus(302)->withHeader('Location', dirname($_SERVER['SCRIPT_NAME']) . '/login');
    }
}