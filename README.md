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

Run `composer` and `yarn` commands in the root directory to install all backend and frontend dependencies.

For production:
`composer install --no-dev --optimize-autoloader`
`NODE_ENV=production yarn install`

For development:
`composer install`
`yarn install`

## Deployment information
Use Webpack to bundle the project's frontend depencencies together.

For production:
`NODE_ENV=production webpack`

For development:
`webpack`

When time has come to upload the application into a production environment, please make sure of the following:

* Application's directory structure is not accessible from your web server.
* Your virtual host document root is pointing to the application's `public/` directory (Or you can just create a symlink).
* Directory `logs/` is web writeable.
