@extends('layouts.master')
@section('title',__('tracking.title'))

@section('nav')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>{{ __('tracking.title') }}</h1>
            </div>
            <div class="col-sm-6">
                <!-- ##########nav2######### -->
            </div>
        </div>
    </div><!-- /.container-fluid -->
@endsection
@section('content')
    <!-- Default box -->
    <trackingmap :acl="{{json_encode($acl)}}"  :firm="{{json_encode($firm)}}"  :lang={{ json_encode(app()->getLocale()) }} :auth="{{ json_encode(Auth::user()) }}" ></trackingmap>

@endsection

@section('css')
    <link rel="stylesheet" href="{{asset('assets/plugins/toastr/toastr.css')}}">
@endsection

@section('js')
    <script src="{{asset('assets/plugins/toastr/toastr.min.js')}}"></script>

@endsection
