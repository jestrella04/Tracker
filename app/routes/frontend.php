<?php

use Slim\Http\Request;
use Slim\Http\Response;

/* ----------------- */
/* Front-end Screens */
/* ----------------- */

/* Display screens */
$app->get('/', 'RenderViewController:renderScreenHome')->setname('home');
$app->get('/login', 'RenderViewController:renderScreenLogin')->setname('login');
$app->get('/forgot-password', 'RenderViewController:renderScreenForgotPassword')->setname('forgot-password');
$app->get('/change-password', 'RenderViewController:renderScreenChangePassword')->setname('change-password');

/* Data validation */
$app->post('/login', 'DataValidationController:processPostLoginRequest')->setName('post-login');
$app->post('/forgot-password', 'DataValidationController:processPostForgotPasswordRequest')->setname('post-forgot-password');
$app->post('/change-password', 'DataValidationController:processPostChangePasswordRequest')->setname('post-change-password');
$app->any('/logout', 'DataValidationController:processLogoutRequest')->setName('logout');