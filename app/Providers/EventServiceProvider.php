<?php

namespace App\Providers;

use App\Events\AdminApprovedOrder;
use App\Events\AdminCompletedOrder;
use App\Events\AdminUpdateOrder;
use App\Events\AgentSentOrder;
use App\Events\UserHasRemoved;
use App\Listeners\AdminApprovedOrderHook;
use App\Listeners\AdminCompletedOrderHook;
use App\Listeners\AdminUpdateOrderHook;
use App\Listeners\AgentSentOrderHook;
use App\Listeners\UserRemovedListener;
use Illuminate\Auth\Events\Login;
use Illuminate\Support\Facades\Event;
use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
        Login::class => [
            \App\Listeners\GenerateToken::class,
        ],
        UserHasRemoved::class=>[
            UserRemovedListener::class,
        ],


    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        parent::boot();

        //
    }
}
