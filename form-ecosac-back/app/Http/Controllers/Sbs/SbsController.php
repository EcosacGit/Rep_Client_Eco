<?php

namespace App\Http\Controllers\Sbs;

use App\Http\Controllers\Controller;
use GuzzleHttp\Client;
use Illuminate\Http\Request;


class SbsController extends Controller
{
    public function obtenerTipoCambio(Request $request)
    {
        $token = env('TOKENSBS');
        $client = new Client();
        $url = env('URLSBS');
        $month = $request->input('month');
        $year = $request->input('year');

        $response = $client->get($url, [
            'query' => [
                'month' => $month,
                'year' => $year,
            ],
            'headers' =>
            [
                'Authorization' => "Bearer {$token}"
            ]
        ]);

        $data = json_decode($response->getBody());

        return response()->json($data);
    }
}
