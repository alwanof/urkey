<?php

namespace App\Http\Controllers\API;

use App\Member;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Mockery\Exception;

class AgentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
            try {
                if(auth()->user()->hasPermissionTo('isAdmin')) {
                    $members = Member::where('type', 1)->latest()->paginate(10);
                }else{
                    $uid=Member::where('email',auth()->user()->email)->first()->uid;
                    $members=Member::where('type',1)->where('ref',$uid)->latest()->paginate(10);
                }

            }catch (Exception $e){
                return response()->json($e->getMessage(), 400);
            }

        return $members;
    }

    public function search(Request $request)
    {
        try {
            if(auth()->user()->hasPermissionTo('isAdmin')) {
                $agents = Member::where('type',1)->where('name', 'LIKE', '%' . $request->keywords . '%')
                    ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
                    ->paginate(10);
            }else{
                $uid=Member::where('email',auth()->user()->email)->first()->uid;
                $agents = Member::where('type',1)->where('ref',$uid)->where('name', 'LIKE', '%' . $request->keywords . '%')
                    ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
                    ->paginate(10);
            }

        }catch (Exception $e){
            return response()->json($e->getMessage(), 400);
        }

        return $agents;
    }


    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string',
            'email' => 'required|email|unique:members',
            'password' => 'required|min:6',
            'phone' => 'required|numeric|min:99999',
        ]);
        try {
            Member::create([
                'uid'=>Str::random(16),
                'name' => $request->name,
                'email' => $request->email,
                'password' => $request->password,
                'phone' => $request->phone,
                'ref'=>$request->ref,
                'type'=>1

            ]);
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }


    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required|string',
            'email' => 'required|email',
            'phone' => 'required|numeric|min:99999',
        ]);
        try {
            $agents = Member::findOrFail($id);
            $agents->name = $request->name;
            $agents->email = $request->email;
            $agents->phone = $request->phone;
            $agents->ref=$request->ref;
            if (strlen($request->password) > 5) {
                $agents->password = $request->password;
            }
            $agents->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }


    public function destroy($id)
    {

        $agents=Member::find($id);
        $agents->delete();
        return response()->json(1, 200);
    }

    public function approve(Request $request){
        $this->validate($request, [
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);
        try {
            $user=User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'remember_token' => Str::random(10),
            ]);
            $user->assignRole('agents');
            $agent=Member::find($request->id);
            $agent->status=1;
            $agent->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }
    public function activate(Request $request){
        $this->validate($request, [
            'id' => 'required',
        ]);
        try {
            $agent=Member::find($request->id);
            $agent->status=2;
            $agent->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }
}
