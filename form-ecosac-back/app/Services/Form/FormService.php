<?php

namespace App\Services\Form;

use App\Repositories\Form\Contracts\IFormRepository;
use App\Services\Form\Contracts\IFormService;
use Exception;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Exception\ServerException;

class FormService implements IFormService
{
    protected $formRepository;
    public $client;


    public function __construct(IFormRepository $formRepository)
    {
        $this->formRepository = $formRepository;
        $this->client = new Client();
    }

    public function getForm()
    {
        return $this->formRepository->getForm();
    }

    public function getFormAddressEmail($idClient, $idDataConsignee)
    {
        return $this->formRepository->getFormAddressEmail($idClient, $idDataConsignee);
    }

    public function getFormAddressOriginalsDoc($idClient, $idDataConsignee)
    {
        return $this->formRepository->getFormAddressOriginalsDoc($idClient, $idDataConsignee);
    }

    public function getFormCountryEN()
    {
        return $this->formRepository->getFormCountryEN();
    }
    public function getFormCountryES()
    {
        return $this->formRepository->getFormCountryES();
    }

    public function getFormDataConsignee($idClient)
    {
        return $this->formRepository->getFormDataConsignee($idClient);
    }

    public function getFormDataNotifier($idDataConsignee)
    {
        return $this->formRepository->getFormDataNotifier($idDataConsignee);
    }

    public function getFormPort($idCountry)
    {
        return $this->formRepository->getFormPort($idCountry);
    }

    public function getFormPortDestination($idCountry)
    {
        return $this->formRepository->getFormPortDestination($idCountry);
    }

    public function getFormRequiredDocuments($idClient, $idDataConsignee)
    {
        return $this->formRepository->getFormRequiredDocuments($idClient, $idDataConsignee);
    }

    public function getFormSendPhysicalDocuments($idClient, $idDataConsignee)
    {
        return $this->formRepository->getFormSendPhysicalDocuments($idClient, $idDataConsignee);
    }

    public function createFormCountry($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormCountry($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormAddressEmail($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormAddressEmail($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormAddressOriginalsDoc($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormAddressOriginalsDoc($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormDataConsignee($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormDataConsignee($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormDataNotifier($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormDataNotifier($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormPort($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormPort($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormPortDestination($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormPortDestination($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormRequiredDocument($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormRequiredDocument($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function createFormSendPhysicalDocuments($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createFormSendPhysicalDocuments($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    //MAIN METHOD

    public function createForm($data)
    {
        try {
            $jsonData = json_encode($data);
            $response = $this->formRepository->createForm($jsonData);

            // Verifica si la respuesta contiene un mensaje de error
            if (isset($response[0]->ErrorMessage)) {
                return ['status' => 'error', 'message' => $response[0]->ErrorMessage];
            }
            return ['status' => 'success', 'message' => $response[0]->mensaje];
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function getBusinessPartners($postData)
    {
        $url = 'http://api.ecosac.com.pe:58000/api/maeBusinessPartner/get-business-partner-by-id';

        try {
            $response = $this->client->request('POST', $url, [
                'headers' => [
                    'Accept' => 'application/json',
                    'Content-Type' => 'application/json',
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
            // Errores 4xx
            return [
                'error' => 'Client error: ' . $e->getMessage(),
                'response' => $e->getResponse()->getBody()->getContents(),
            ];
        } catch (ServerException $e) {
            // Errores 5xx
            return [
                'error' => 'Server error: ' . $e->getMessage(),
                'response' => $e->getResponse()->getBody()->getContents(),
            ];
        } catch (RequestException $e) {
            // Otros errores de la solicitud
            return [
                'error' => 'Request error: ' . $e->getMessage(),
            ];
        }
    }
}
