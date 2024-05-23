<?php

namespace App\Repositories\Form;

use App\Repositories\Form\Contracts\IFormRepository;
use Illuminate\Support\Facades\DB;

class FormRepository implements IFormRepository
{
    //METHODS GET
    public function getForm()
    {
        $result = DB::select('EXEC Form_GetForm');
        return $result;
    }

    public function getFormAddressEmail($idClient, $idDataConsignee)
    {
        return DB::select(
            'EXEC Form_GetFormAddressEmail ?, ?',
            [$idClient, $idDataConsignee]
        );
    }

    public function getFormAddressOriginalsDoc($idClient, $idDataConsignee)
    {
        return DB::select('EXEC Form_GetFormAddressOriginalsDoc ?, ?', [$idClient, $idDataConsignee]);
    }

    public function getFormCountryEN()
    {
        return DB::select('EXEC Form_GetFormCountryEN');
    }

    public function getFormCountryES()
    {
        return DB::select('EXEC Form_GetFormCountryES');
    }

    public function getFormDataConsignee($idClient)
    {
        return DB::select('EXEC Form_GetFormDataConsignee ?', [$idClient]);
    }

    public function getFormDataNotifier($idDataConsignee)
    {
        return DB::select('EXEC Form_GetFormDataNotifier ?', [$idDataConsignee]);
    }

    public function getFormPort($idCountry)
    {
        $result = DB::select('EXEC Form_GetFormPort ?', [$idCountry]);
        return $result;
    }

    public function getFormPortDestination($idCountry)
    {
        $result = DB::select('EXEC Form_GetFormPortDestination ?', [$idCountry]);
        return $result;
    }

    public function getFormRequiredDocuments($idClient, $idDataConsignee)
    {
        return DB::select('EXEC Form_GetFormRequiredDocuments ? , ?', [$idClient, $idDataConsignee]);
    }

    public function getFormSendPhysicalDocuments($idClient, $idDataConsignee)
    {
        return DB::select(
            'EXEC Form_GetFormSendPhysicalDocuments ? , ?',
            [$idClient, $idDataConsignee]
        );
    }

    //METHODS POST
    public function createFormCountry($data)
    {
        return DB::select('EXEC Form_CreateFormCountry ?', [$data]);
    }

    public function createFormAddressEmail($data)
    {
        return DB::select('EXEC Form_CreateFormAddressEmail ?', [$data]);
    }

    public function createFormAddressOriginalsDoc($data)
    {
        return DB::select('EXEC Form_CreateFormAddressOriginalsDoc ?', [$data]);
    }

    public function createFormDataConsignee($data)
    {
        return DB::select('EXEC Form_CreateFormDataConsignee ?', [$data]);
    }

    public function createFormDataNotifier($data)
    {
        return DB::select('EXEC Form_CreateFormDataNotifier ?', [$data]);
    }

    public function createFormPort($data)
    {
        return DB::select('EXEC Form_CreateFormPort ?', [$data]);
    }
    public function createFormPortDestination($data)
    {
        return DB::select('EXEC Form_CreateFormPortDestination ?', [$data]);
    }

    public function createFormRequiredDocument($data)
    {
        return DB::select('EXEC Form_CreateFormRequiredDocument ?', [$data]);
    }

    public function createFormSendPhysicalDocuments($data)
    {
        return DB::select('EXEC Form_CreateFormSendPhysicalDocuments ?', [$data]);
    }

    //MAIN METHOD
    public function createForm($data)
    {
        return DB::select('EXEC Form_CreateForm ?', [$data]);
    }
}
