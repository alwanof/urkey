<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use App\User;

Route::get('/', 'ThemeController@index')->name('route_start');
Route::post('/send/email', 'ContactController@send_message')->name('send_email');

Route::get('/language/{language}','LanguageController@index')->name('switcher')->where('language','[A-Za-z]+');

Route::get('test', 'UserController@testo');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::get('lang/{locale}', 'HomeController@lang')->name('lang');

Route::prefix('admin')->middleware('auth')->group(function () {
    Route::get('/users', 'UserController@index')->name('users')->middleware('permission:access-users');
    Route::get('/roles', 'UserController@roles')->name('roles')->middleware('permission:access-roles');
    Route::get('/permissions', 'UserController@permissions')->name('permissions')->middleware('permission:access-permissions');
    Route::get('/profile/{user}', 'UserController@profile')->name('profile');
    Route::get('/me', 'UserController@me')->name('me');
    Route::get('/config', 'ConfigController@config')->name('config.index')->middleware('permission:access-configs');
    Route::get('/settings', 'ConfigController@settings')->name('config.settings');

    Route::get('/firms', 'MemberController@firms')->name('members.firms');
    Route::get('/agents', 'MemberController@agents')->name('members.agents');
    Route::get('/drivers', 'MemberController@drivers')->name('members.drivers');
    Route::get('/orders', 'OrdersController@index')->name('orders.index');
    Route::get('create/orders', 'OrdersController@create')->name('orders.create');
    Route::get('/tracking/map', 'HomeController@tracking_map')->name('home.tracking.map');
});

