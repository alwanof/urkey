<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Mail;

class ContactController extends Controller
{
    private $name;

    private $email;

    private $phone;

    private $subject;

    private $message_body_txt;


    public function send_message(Request $request){

        $request->validate([
            'full_name'=>'required|string',
            'full_email'=>'required',
            'phone_number'=>'required',
            'subject'=>'required',
            'message_body'=>'required',
        ]);

        $this->name = $request->full_name;

        $this->email = $request->full_email;

        $this->phone = $request->phone_number;

        $this->subject = $request->subject;

        $this->message_body_txt = $request->message_body;

        $data = array('name'=>$request->full_name,'email'=>$request->full_email,'phone'=>$request->phone_number,'subject'=>$request->subject,'message_body'=>$request->message_body);

        Mail::send(['html'=>'mail'],$data, function($message) {
            $message->to('info@meazafood.com', 'Meaza Food')->subject
               ('New Mail <'.$this->name.'>');
            $message->from($this->email,$this->name);
        });

        return redirect()->route('route_start')->with('success','Message Sent Successfully');
    }
}
