<?php

namespace App\Listeners;

use App\Bill;
use App\Notifications\NewOrderFromAgent;
use App\Notifications\YourOrderApproved;
use App\Notifications\YourOrderTrackingNo;
use App\Notifications\YourOrderUnderReview;
use App\Notifications\YourOrderUpdated;
use App\User;
use Illuminate\Support\Facades\Notification;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use PDF;
class AdminUpdateOrderHook
{

    public function handle($event)
    {
        $order=$event->order;
        $bill=Bill::where('order_id',$order->id)->where('amount','>',0)->first();
        if($bill->amount!=$order->summary){
            $bill->amount=$order->summary;
            $bill->save();
        }


        $order=$event->order;
        $OID=substr(md5($order->id),0,5).'-'.$order->id;
        $pdf = PDF::loadView('orders.order_invoice',compact(['order','OID']));
        $event->order->user->notify(new YourOrderUpdated($pdf,$order));


    }
}
