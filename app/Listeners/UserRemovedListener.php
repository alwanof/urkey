<?php

namespace App\Listeners;

use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class UserRemovedListener
{

    public function handle($event)
    {

        dd($event->user->name);

    }
}
