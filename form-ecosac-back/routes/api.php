<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Form\FormController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('form/get-form', [FormController::class, 'get_form']);
Route::post('form/get-form-address-email', [FormController::class, 'get_form_address_email']);
Route::post('form/get-form-address-originals-doc', [FormController::class, 'get_form_address_originals_doc']);
Route::post('form/get-form-country-en', [FormController::class, 'get_form_country_en']);
Route::post('form/get-form-country-es', [FormController::class, 'get_form_country_es']);
Route::post('form/get-form-data-consignee', [FormController::class, 'get_form_data_consignee']);
Route::post('form/get-form-data-notifier', [FormController::class, 'get_form_data_notifier']);
Route::post('form/get-form-port', [FormController::class, 'get_form_port']);
Route::post('form/get-form-port-destination', [FormController::class, 'get_form_port_destination']);
Route::post('form/get-form-required-documents', [FormController::class, 'get_form_required_documents']);
Route::post('form/get-form-send-physical-documents', [FormController::class, 'get_form_send_physical_documents']);


//POST CREATE
Route::post('form/create-country', [FormController::class, 'createCountry']);
Route::post('form/create-address-email', [FormController::class, 'createAddressEmail']);
Route::post('form/create-address-originals-doc', [FormController::class, 'createAddressOriginalsDoc']);
Route::post('form/create-data-consignee', [FormController::class, 'createDataConsignee']);
Route::post('form/create-data-notifier', [FormController::class, 'createDataNotifier']);
Route::post('form/create-port', [FormController::class, 'createPort']);
Route::post('form/create-port-destination', [FormController::class, 'createPortDestination']);

Route::post('form/create-required-document', [FormController::class, 'createRequiredDocument']);
Route::post('form/create-send-physical-documents', [FormController::class, 'createSendPhysicalDocuments']);

Route::post('form/create', [FormController::class, 'create']);
Route::post('form/upload-file', [FormController::class, 'uploadFile']);
Route::post('form/download-file', [FormController::class, 'downloadFile']);



Route::middleware('guest')->group(function () {
    Route::get('/obtener-tipo-cambio', [\App\Http\Controllers\Sbs\SbsController::class, 'obtenerTipoCambio']);
    //Third Api
    Route::post('form/get-business-partner-by-id', [FormController::class, 'showBusinessPartners']);
});


Route::post('form/get-form-all', [FormController::class, 'get_form_all_data']);
Route::post('form/get-form-by-data-send', [FormController::class, 'getFormByDataSend']);
