<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => ['auth:api']], function () {
    Route::apiResource('users', 'API\UserController', ['except' => ['create', 'edit', 'show']]);
    Route::apiResource('roles', 'API\RoleController', ['except' => ['create', 'edit', 'show']]);
    Route::apiResource('permissions', 'API\PermissionController', ['except' => ['create', 'edit', 'show']]);
    Route::apiResource('configs', 'API\ConfigurationController', ['except' => ['create', 'edit', 'show']]);
    Route::apiResource('settings', 'API\SettingController', ['only' => ['index', 'update']]);
    Route::get('search/users', 'API\UserController@search');
    Route::post('toggle/role', 'API\UserController@toggleRole');
    Route::post('toggle/permission', 'API\UserController@togglePerm');
    Route::post('toggle/config/role', 'API\ConfigurationController@toggleRole');
    Route::get('search/roles', 'API\ConfigurationController@search');
    Route::get('search/permissions', 'API\PermissionController@search');
    Route::get('search/configs', 'API\ConfigurationController@search');
    Route::get('search/settings', 'API\SettingController@search');

    Route::apiResource('firms', 'API\FirmController', ['except' => ['create', 'edit', 'show']]);
    Route::get('search/firms', 'API\FirmController@search');
    Route::post('approve/firm', 'API\FirmController@approve');
    Route::post('activate/firm', 'API\FirmController@activate');

    Route::apiResource('agents', 'API\AgentController', ['except' => ['create', 'edit', 'show']]);
    Route::get('search/agents', 'API\AgentController@search');
    Route::post('approve/agent', 'API\AgentController@approve');
    Route::post('activate/agent', 'API\AgentController@activate');

    Route::apiResource('drivers', 'API\DriverController', ['except' => ['create', 'edit', 'show']]);
    Route::get('search/drivers', 'API\DriverController@search');
    Route::post('activate/driver', 'API\DriverController@activate');





});


