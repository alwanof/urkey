<?php

function getColor($v){
        $x=$v;
        switch (true) {
            case ($x<20):
                return 'danger';
                break;
            case ($x<40):
                return 'warning';
                break;
            case ($x<75):
                return 'primary';
                break;
            default:
                return 'success';
                break;

        }
 }

 function coolNumber($num){
     if($num <1000){
         return $num;
     }

     if($num <1000000){
         return ($num/1000).'K';
     }
     if($num >=1000000){
         return ($num/1000000).'M';
     }
 }




?>
