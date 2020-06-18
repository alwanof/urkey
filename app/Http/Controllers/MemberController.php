<?php

namespace App\Http\Controllers;

use App\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class MemberController extends Controller
{

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function __construct()
    {
        $this->middleware('auth');
        $this->middleware('permission:access_members_area');
        $this->middleware('permission:access_firms',['only'=>['firms']]);
        $this->middleware('permission:access_agents',['only'=>['agents']]);
        $this->middleware('permission:access_drivers',['only'=>['drivers']]);


    }

    public function firms(){

        $acl = [
            'access_firms' => (Gate::allows('access_firms')) ? true : false,
            'firms_edit_trash' => (Gate::allows('firms_edit_trash')) ? true : false,
            'firms_activate' => (Gate::allows('firms_activate')) ? true : false,
            'firms_approve' => (Gate::allows('firms_approve')) ? true : false
        ];
        return view('member.firms',compact(['acl']));
    }
    public function agents(){

        $firms=Member::where('type',0)->get();


        $acl = [
            'access_agents' => (Gate::allows('access_agents')) ? true : false,
            'agents_edit_trash' => (Gate::allows('agents_edit_trash')) ? true : false,
            'agents_activate' => (Gate::allows('agents_activate')) ? true : false,
            'agents_approve' => (Gate::allows('agents_approve')) ? true : false,
            'create_agents' => (Gate::allows('create_agents')) ? true : false
        ];
        return view('member.agents',compact(['acl','firms']));
    }

    public function drivers(){

        $firms=Member::where('type',0)->get();


        $acl = [
            'access_drivers' => (Gate::allows('access_drivers')) ? true : false,
            'drivers_edit_trash' => (Gate::allows('drivers_edit_trash')) ? true : false,
            'drivers_activate' => (Gate::allows('drivers_activate')) ? true : false,
            'drivers_approve' => (Gate::allows('drivers_approve')) ? true : false
        ];
        return view('member.drivers',compact(['acl','firms']));
    }
}
