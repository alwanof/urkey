<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class OrdersController extends Controller
{
    public function __construct()
    {

    }

    public function index(){
        $acl = [
            'access_orders' => (Gate::allows('access_orders')) ? true : false,
        ];
        return view('orders.orders',compact(['acl']));
    }
}
