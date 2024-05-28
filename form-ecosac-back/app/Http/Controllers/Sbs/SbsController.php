<?php

namespace App\Http\Controllers\Sbs;

use App\Http\Controllers\Controller;
use App\Services\Sbs\Contracts\ISbsService;
use Exception;
use Illuminate\Http\Request;


class SbsController extends Controller
{
    protected $sbsService;

    public function __construct(ISbsService $sbsService)
    {
        $this->sbsService = $sbsService;
    }

    public function obtenerTipoCambio(Request $request)
    {
        try {
            $postData = $request->all(); // Obtener todos los datos del formulario

            $businessPartners = $this->sbsService->obtenerTipoCambio($postData);

            if (isset($businessPartners['error'])) {
                return response()->json($businessPartners, 500);
            }

            return response()->json($businessPartners, 200);
        } catch (Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
