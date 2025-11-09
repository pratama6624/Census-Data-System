<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// route default (opsional)
$routes->get('/', function () {
    return 'Census API is running';
});

// Grup API dengan namespace khusus
$routes->group('api', ['namespace' => 'App\Controllers\Api'], static function ($routes) {

    // Auth
    $routes->group('auth', static function ($routes) {
        // POST /api/auth/login
        $routes->post('login', 'AuthController::login');

        // GET /api/auth/me  (butuh JWT filter)
        $routes->get('me', 'AuthController::me', ['filter' => 'jwt']);
    });

    // Cities (Cities Master)
    // JWT
    $routes->group('cities', ['filter' => 'jwt'], static function ($routes) {

        // GET /api/cities
        // list + pagination + search
        $routes->get('/', 'CityController::index');

        // POST /api/cities
        // add city
        $routes->post('/', 'CityController::store');

        // PUT /api/cities/1
        $routes->put('(:num)', 'CityController::update/$1');

        // DELETE /api/cities/1
        $routes->delete('(:num)', 'CityController::delete/$1');
    });

    // Census (Data Census)
    $routes->group('census', ['filter' => 'jwt'], static function ($routes) {

        // GET /api/census
        // list + pagination + search
        $routes->get('/', 'CensusController::index');

        // GET /api/census/1
        // detail
        $routes->get('(:num)', 'CensusController::show/$1');

        // POST /api/census
        // add census
        $routes->post('/', 'CensusController::store');

        // PUT /api/census/1
        $routes->put('(:num)', 'CensusController::update/$1');

        // DELETE /api/census/1
        $routes->delete('(:num)', 'CensusController::delete/$1');
    });
});