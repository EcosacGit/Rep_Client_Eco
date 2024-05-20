<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class ApiService
{
    public function makeAPIRequestTest()
    {
        try {
            $response = Http::post('http://api.ecosac.com.pe:58000/api/maeBusinessPartner/get-selectors-business-part');

            // Check for successful response status
            if ($response->successful()) {
                return $response->json();
            }

            // Handle non-successful response
            return [
                'status' => 'error',
                'message' => 'API request fallo: ' . $response->status(),
                'body' => $response->body()
            ];
        } catch (\Exception $e) {
            return [
                'status' => 'error',
                'message' => 'Exception occurred: ' . $e->getMessage()
            ];
        }
    }
}
