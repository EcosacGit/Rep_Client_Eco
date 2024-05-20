<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Services\ApiService;


class ApiController extends Controller
{
    //
    protected $apiService;

    public function __construct(ApiService $apiService)
    {
        $this->apiService = $apiService;
    }


    public function getApi()
    {
        $response = $this->apiService->makeAPIRequestTest();
        return response()->json($response);
    }
}
