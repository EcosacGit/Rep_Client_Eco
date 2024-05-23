<?php

namespace App\Http\Controllers\Form;

use App\Http\Controllers\Controller;
use App\Services\Form\Contracts\IFormService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Exception;
use Illuminate\Support\Facades\Log;

class FormController extends Controller
{
    //
    protected $formService;

    public function __construct(IFormService $formService)
    {
        $this->formService = $formService;
    }

    public function get_form()
    {
        $response = $this->formService->getForm();

        return response()->json($response);
    }

    public function get_form_address_email(Request $request)
    {
        $idClient = $request->input('idClient');
        $idDataConsignee = $request->input('idDataConsignee');

        $response = $this->formService->getFormAddressEmail(
            $idClient,
            $idDataConsignee
        );

        return response()->json($response);
    }

    public function get_form_address_originals_doc(Request $request)
    {
        $idClient = $request->input('idClient');
        $idDataConsignee = $request->input('idDataConsignee');

        $response = $this->formService->getFormAddressOriginalsDoc($idClient, $idDataConsignee);

        return response()->json($response);
    }

    public function get_form_country_en()
    {
        $response = $this->formService->getFormCountryEN();
        return response()->json($response);
    }

    public function get_form_country_es()
    {
        $response = $this->formService->getFormCountryES();
        return response()->json($response);
    }

    public function get_form_data_consignee(Request $request)
    {
        $response = $this->formService->getFormDataConsignee($request->idClient);
        return response()->json($response);
    }

    public function get_form_data_notifier(Request $request)
    {
        $response = $this->formService->getFormDataNotifier($request->idDataConsignee);
        return response()->json($response);
    }

    public function get_form_port(Request $request)
    {
        $response = $this->formService->getFormPort($request->idCountry);
        return response()->json($response);
    }

    public function get_form_port_destination(Request $request)
    {
        $response = $this->formService->getFormPortDestination($request->idCountry);
        return response()->json($response);
    }

    public function get_form_required_documents(Request $request)
    {
        $idClient = $request->input('idClient');
        $idDataConsignee = $request->input('idDataConsignee');

        $response = $this->formService->getFormRequiredDocuments($idClient, $idDataConsignee);

        return response()->json($response);
    }

    public function get_form_send_physical_documents(Request $request)
    {

        $idClient = $request->input('idClient');
        $idDataConsignee = $request->input('idDataConsignee');

        $response = $this->formService->getFormSendPhysicalDocuments($idClient, $idDataConsignee);

        return response()->json($response);
    }

    //CREATE METHODS
    public function createCountry(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormCountry($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createAddressEmail(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormAddressEmail($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createAddressOriginalsDoc(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormAddressOriginalsDoc($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createDataConsignee(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormDataConsignee($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }
    public function createDataNotifier(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormDataNotifier($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createPort(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormPort($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createPortDestination(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormPortDestination($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createRequiredDocument(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormRequiredDocument($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function createSendPhysicalDocuments(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createFormSendPhysicalDocuments($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function create(Request $request)
    {
        try {
            $data = $request->all();
            $data = $this->formService->createForm($data);
            if ($data['status'] === 'error') {
                throw new Exception($data['message']);
            }
            return response()->json($data);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()]);
        }
    }

    public function uploadFile(Request $request)
    {
        try {
            if ($request->hasFile('file')) {
                $file = $request->file('file');
                $fileName = $file->getClientOriginalName();

                // Guardar el archivo en la ruta de red especificada
                Storage::disk('cliente_exportaciones')->put($fileName, file_get_contents($file));

                $filePath = env('FILE_PATH') . $fileName;

                return response()->json(['status' => 'success', 'message' => 'File uploaded successfully', 'filePath' => $filePath]);
            } else {
                throw new Exception('No file uploaded');
            }
        } catch (Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()]);
        }
    }
    public function showBusinessPartners(Request $request)
    {
        try {
            $postData = $request->all(); // Obtener todos los datos del formulario

            $businessPartners = $this->formService->getBusinessPartners($postData);

            if (isset($businessPartners['error'])) {
                return response()->json($businessPartners, 500);
            }

            return response()->json($businessPartners, 200);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
