<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Firm extends Model
{
    protected $fillable=['name','email','password','phone','avatarURL','uid'];
    protected $appends = ['avatar'];

    public function getAvatarAttribute()
    {
        $path = Storage::exists('/public/firms/' . $this->uid . '.jpg');
        $avatar = ($path) ? asset('storage/firms/' . $this->uid . '.jpg') : asset('storage/firms/0.jpg');
        return $avatar;
    }
}
