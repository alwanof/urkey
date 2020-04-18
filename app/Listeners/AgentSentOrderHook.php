<?php

namespace App\Listeners;

use App\Notifications\NewOrderFromAgent;
use App\Notifications\YourOrderUnderReview;
use App\User;
use Illuminate\Support\Facades\Notification;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use PDF;
class AgentSentOrderHook
{

    public function handle($event)
    {
        $event->order->user->notify(new YourOrderUnderReview($event->order));
        $users = User::permission('isAdmin')->get();
        Notification::send($users,new NewOrderFromAgent($event->order));

    }
}
