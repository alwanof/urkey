<?php

namespace App\Providers;

use App\Bill;
use App\Observers\UserObserver;
use App\User;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {

        Schema::defaultStringLength(191);
        view()->composer('widgets.notifications',function($view){

            $data=[
                'allNoti'=>auth()->user()->notifications()->limit(10)->get(),
                'newNoti'=>auth()->user()->unreadNotifications()->limit(10)->get(),
                'oldNoti'=>auth()->user()->readNotifications()->limit(10)->get(),
            ];
            $view->with('notifications', $data);

        });
        User::observe(UserObserver::class);

    }
}
