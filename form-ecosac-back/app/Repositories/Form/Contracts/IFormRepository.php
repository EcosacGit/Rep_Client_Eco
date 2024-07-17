<?php

namespace App\Repositories\Form\Contracts;

interface IFormRepository
{
    public function getForm();
    public function getFormAddressEmail($idClient, $idDataConsignee);
    public function getFormAddressOriginalsDoc($idClient, $idDataConsignee);

    public function getFormCountryEN();
    public function getFormCountryES();
    public function getFormDataConsignee($idClient, $idDataConsignee);
    public function getFormDataNotifier($idDataConsignee);
    public function getFormPort($idCountry);
    public function getFormPortDestination($idCountry);
    public function getFormRequiredDocuments($idClient, $idDataConsignee);
    public function getFormSendPhysicalDocuments($idClient, $idDataConsignee);
    public function createFormCountry($data);
    public function createFormAddressEmail($data);
    public function createFormAddressOriginalsDoc($data);
    public function createFormDataConsignee($data);
    public function createFormDataNotifier($data);
    public function createFormPort($data);
    public function createFormPortDestination($data);
    public function createFormRequiredDocument($data);
    public function createFormSendPhysicalDocuments($data);
    public function createForm($data);
    public function getFormAllData();

    //update || re send
    public function getFormByDataSend($idForm);
}
