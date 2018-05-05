# Tracker

A simple workforce tracker application for small to medium teams using the Slim PHP framework.

## Dependencies

Main dependencies that should be installed on your server:

* Web server with URL rewriting.
* PHP 5.5 or newer.
* MySQL 5.6 or newer.
* Composer for managing backend PHP dependencies.
* Yarn for managing frontend dependencies.
* Webpack for bundling frontend dependencies.

Run `composer` commnand in the root directory to install all PHP dependencies.
Run `yarn` command in the root directory to install all frontend dependencies.

## Deployment information

When time has come to upload the application into a production environment, please make sure of the following:

* Your virtual host document root is pointing to the application's `public/` directory.
* Directory `logs/` is web writeable.
