<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Member extends Model
{
    protected $fillable=['name','email','password','phone','uid','type','ref'];
    protected $appends = ['avatar','editable','refID'];

    public function getAvatarAttribute()
    {
        $user=User::where('email',$this->email)->first();
        if($user){
            $path = Storage::exists('/public/users/' . $user->id . '.jpg');
            $avatar = ($path) ? asset('storage/users/' . $user->id . '.jpg') : asset('storage/users/0.jpg');
            return $avatar;
        }
        return asset('storage/users/0.jpg');

    }

    public function getEditableAttribute(){
        $user=User::where('email',$this->email)->first();
        if($user){
            return false;
        }
        return true;
    }

    public function getRefIDAttribute(){

        if($this->ref){
            return Member::where('uid',$this->ref)->first();
        }
        return $this->id;
    }







}
