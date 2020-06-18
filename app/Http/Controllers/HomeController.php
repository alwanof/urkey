<?php

namespace App\Http\Controllers;


use App\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {

        $limit=auth()->user()->getSetting('notifications-show-limit')->value;

        $data=[
            'allNoti'=>auth()->user()->notifications->take($limit),
            'newNoti'=>auth()->user()->unreadNotifications->take($limit),
            'oldNoti'=>auth()->user()->readNotifications->take($limit),
        ];

        auth()->user()->unreadNotifications->markAsRead();
        return view('home',compact([
            'data',
        ]));
    }

    public function lang($locale)
    {
        App::setLocale($locale);
        session()->put('locale', $locale);
        return redirect()->back();
    }

    public function tracking_map(){
        $acl = [
            'access_tracking_map' => (Gate::allows('access_tracking_map')) ? true : false,
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




        return view('home.tracking_map',compact(['acl','firm']));
    }
}
