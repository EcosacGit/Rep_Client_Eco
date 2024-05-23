<?php

namespace App\Services\Form\Contracts;

interface IFormService
{
    public function getForm();
    public function getFormAddressEmail();
    public function getFormAddressOriginalsDoc();

    public function getFormCountryEN();
    public function getFormCountryES();
    public function getFormDataConsignee();
    public function getFormDataNotifier();
    public function getFormPort($idCountry);
    public function getFormPortDestination($idCountry);
    public function getFormRequiredDocuments();
    public function getFormSendPhysicalDocuments();
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
    public function getBusinessPartners($postData);
}
