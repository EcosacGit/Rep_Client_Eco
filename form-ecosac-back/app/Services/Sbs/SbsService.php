<?php

namespace App\Services\Sbs;

use App\Services\Sbs\Contracts\ISbsService;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Exception\ServerException;

class SbsService implements ISbsService
{
    public $client;
    public function __construct()
    {
        $this->client = new Client();
    }

    public function obtenerTipoCambio($postData)
    {
        $url = env('URLSBS');
        $token = env('TOKENSBS');

        try {
            $response = $this->client->request('GET', $url, [
                'headers' => [
                    'Accept' => 'application/json',
                    'Content-Type' => 'application/json',
                    'Authorization' => 'Bearer ' . $token,
                ],
                'json' => $postData,
            ]);

            $statusCode = $response->getStatusCode();
            $body = $response->getBody()->getContents();

            if ($statusCode == 200) {
                return json_decode($body, true);
            }

            return [
                'error' => 'Failed to fetch data',
                'status' => $statusCode,
            ];
        } catch (ClientException $e) {
            return [
                'error' => 'Client error: ' . $e->getMessage(),
                'response' => $e->getResponse()->getBody()->getContents(),
            ];
        } catch (ServerException $e) {
            return [
                'error' => 'Server error: ' . $e->getMessage(),
                'response' => $e->getResponse()->getBody()->getContents(),
            ];
        } catch (RequestException $e) {
            return [
                'error' => 'Request error: ' . $e->getMessage(),
            ];
        }
    }
}
