<?php

namespace App\Services\Form;

use App\Repositories\Form\Contracts\IFormRepository;
use App\Services\Form\Contracts\IFormService;
use Exception;

class FormService implements IFormService
{
    protected $formRepository;

    public function __construct(IFormRepository $formRepository)
    {
        $this->formRepository = $formRepository;
    }

    public function getForm($idClient)
    {
        return $this->formRepository->getForm($idClient);
    }

    public function getFormAddressEmail()
    {
        return $this->formRepository->getFormAddressEmail();
    }

    public function getFormAddressOriginalsDoc()
    {
        return $this->formRepository->getFormAddressOriginalsDoc();
    }

    public function getFormCountryEN()
    {
        return $this->formRepository->getFormCountryEN();
    }
    public function getFormCountryES()
    {
        return $this->formRepository->getFormCountryES();
    }

    public function getFormDataConsignee()
    {
        return $this->formRepository->getFormDataConsignee();
    }

    public function getFormDataNotifier()
    {
        return $this->formRepository->getFormDataNotifier();
    }

    public function getFormPort($idCountry)
    {
        return $this->formRepository->getFormPort($idCountry);
    }

    public function getFormPortDestination($idCountry)
    {
        return $this->formRepository->getFormPortDestination($idCountry);
    }

    public function getFormRequiredDocuments()
    {
        return $this->formRepository->getFormRequiredDocuments();
    }

    public function getFormSendPhysicalDocuments()
    {
        return $this->formRepository->getFormSendPhysicalDocuments();
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
}
