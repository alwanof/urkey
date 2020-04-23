<?php

namespace App\Http\Controllers\API;

use App\Firm;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class FirmController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        return Firm::latest()->paginate(10);
    }

    public function search(Request $request)
    {
        $firms = Firm::where('name', 'LIKE', '%' . $request->keywords . '%')
        ->orWhere('email', 'LIKE', '%' . $request->keywords . '%')
        ->paginate(10);

    	return $firms;
    }


    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string',
            'email' => 'required|email|unique:firms',
            'password' => 'required|min:6',
            'phone'=>'required|min:6|max:25',
            'uid'=>'required'
        ]);
        try {
            Firm::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'phone'=>$request->email,
                'avatarURL'=>asset('storage/firms/'.$request->uid.'.jpg'),
                'uid' => $request->uid,
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
            'email' => 'required|email|unique:firms',
            'phone'=>'required|min:6|max:25',
            'uid'=>'required'
        ]);
        try {
            $firm = Firm::findOrFail($id);
    		$firm->name = $request->name;
    		$firm->email = $request->email;
            $firm->phone = $request->phone;
    		if (strlen($request->password) > 5) {
                $firm->password = Hash::make($request->password);
    		}
    		$firm->save();
    		return response()->json(1, 200);
    	} catch (Exception $e) {
            return response()->json($e->getMessage(), 400);
        }
    }


    public function destroy($id)
    {

        $firm=Firm::find($id);
    	$firm->delete();
    	return response()->json(1, 200);
    }

}
