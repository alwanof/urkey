<?php

namespace App\Http\Controllers\API;

use App\Member;
use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Mockery\Exception;

class FirmController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        return Member::where('type',0)->latest()->paginate(10);
    }

    public function search(Request $request)
    {
        $firms = Member::where('type',0)->where('name', 'LIKE', '%' . $request->keywords . '%')
        ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
        ->paginate(10);

    	return $firms;
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
            $firms = Member::findOrFail($id);
            $firms->name = $request->name;
            $firms->email = $request->email;
            $firms->phone = $request->phone;
    		if (strlen($request->password) > 5) {
                $firms->password = $request->password;
    		}
            $firms->save();
    		return response()->json(1, 200);
    	} catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }


    public function destroy($id)
    {

        $firms=Member::find($id);
        $firms->delete();
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
            $user->assignRole('firms');
            $firm=Member::find($request->id);
            $firm->status=1;
            $firm->save();
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
            $firm=Member::find($request->id);
            $firm->status=2;
            $firm->save();
            return response()->json(1, 200);
        } catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }
}
