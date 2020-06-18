<?php

namespace App\Http\Controllers\API;

use App\Member;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Mockery\Exception;

class DriverController extends Controller
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
                $members =Member::where('type',2)->latest()->paginate(10);
            }else{
                $uid=Member::where('email',auth()->user()->email)->first()->uid;
                $members=Member::where('type',2)->where('ref',$uid)->latest()->paginate(10);
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
                $drivers = Member::where('type',2)->where('name', 'LIKE', '%' . $request->keywords . '%')
                    ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
                    ->paginate(10);
            }else{
                $uid=Member::where('email',auth()->user()->email)->first()->uid;
                $drivers = Member::where('type',2)->where('ref',$uid)->where('name', 'LIKE', '%' . $request->keywords . '%')
                    ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
                    ->paginate(10);
            }

        }catch (Exception $e){
            return response()->json($e->getMessage(), 400);
        }


        return $drivers;
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
                'type'=>2

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
            $drivers = Member::findOrFail($id);
            $drivers->name = $request->name;
            $drivers->email = $request->email;
            $drivers->phone = $request->phone;
            $drivers->ref=$request->ref;
            if (strlen($request->password) > 5) {
                $drivers->password = $request->password;
            }
            $drivers->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }


    public function destroy($id)
    {

        $drivers=Member::find($id);
        $drivers->delete();
        return response()->json(1, 200);
    }


    public function activate(Request $request){
        $this->validate($request, [
            'id' => 'required',
        ]);
        try {
            $driver=Member::find($request->id);
            $driver->status=2;
            $driver->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }
}
