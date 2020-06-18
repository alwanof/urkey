@extends('layouts.master')
@section('title',__('orders.new.title'))

@section('nav')
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>{{ __('orders.new.title') }}</h1>
            </div>

        </div>
    </div><!-- /.container-fluid -->
@endsection
@section('content')

    <!-- Default box -->
    @can('access_hotorders')
        @can('create_orders')
            <neworder :acl="{{json_encode($acl)}}" :agent="{{json_encode($agent)}}" :firm="{{json_encode($firm)}}"  :lang={{ json_encode(app()->getLocale()) }} :auth="{{ json_encode(Auth::user()) }}" ></neworder>
        @endcan
        <hotorders :acl="{{json_encode($acl)}}" :agent="{{json_encode($agent)}}" :firm="{{json_encode($firm)}}"  :lang={{ json_encode(app()->getLocale()) }} :auth="{{ json_encode(Auth::user()) }}" ></hotorders>
    @endcan
@endsection

@section('css')
    <link rel="stylesheet" href="{{asset('assets/plugins/toastr/toastr.css')}}">
@endsection

@section('js')
    <script src="{{asset('assets/plugins/toastr/toastr.min.js')}}"></script>
@endsection
