<?php

namespace App\Events;

use App\Order;
use App\User;
use Illuminate\Queue\SerializesModels;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;

class UserHasRemoved
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    public $user;
    public $order;
    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct(User $user, Order $order)
    {
        $this->user=$user;
        $this->order=$order;
    }


}
