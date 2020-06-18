<?php

namespace App\Http\Controllers;

use App\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Str;

class OrdersController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');

    }

    public function index(){
        $acl = [
            'access_orders' => (Gate::allows('access_orders')) ? true : false,
            'role' => auth()->user()->roles,
        ];
        $agent=(object)[];
        $firm=(object)[];
        switch (auth()->user()->roles[0]->name){
            case 'Agents':
                $agent=Member::where('email',auth()->user()->email)->first();
                $firm=($agent)?Member::where('uid',$agent->ref)->first():(object)[];
                break;
            case 'Firms':
                $firm=Member::where('email',auth()->user()->email)->first();
                break;
        }

        return view('orders.orders',compact(['acl','agent','firm']));
    }

    public function create(){
        $acl = [
            'create_orders' => (Gate::allows('create_orders')) ? true : false,
            'role' => auth()->user()->roles,
            'handover' => (Gate::allows('handover')) ? true : false,
        ];

        $agent=(object)[];
        $firm=(object)[];
        switch (auth()->user()->roles[0]->name){
            case 'Agents':
                $agent=Member::where('email',auth()->user()->email)->first();
                $firm=($agent)?Member::where('uid',$agent->ref)->first():(object)[];
                break;
            case 'Firms':
                $firm=Member::where('email',auth()->user()->email)->first();
                break;
        }

        return view('orders.new',compact(['acl','agent','firm']));
    }
}
