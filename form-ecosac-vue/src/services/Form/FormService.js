import { api } from "../Service";

const form = "form";

export default {
  getForm(obj, requestID) {
    return api.post(form + "/get-form", obj);
  },

  getFormAddressEmail() {
    return api.post(`${form}/get-form-address-email`);
  },

  getFormAddressOriginalsDoc() {
    return api.post(`${form}/get-form-address-originals-doc`);
  },

  getFormCountryEN() {
    return api.post(`${form}/get-form-country-en`);
  },

  getFormCountryES() {
    return api.post(`${form}/get-form-country-es`);
  },

  getFormDataConsignee() {
    return api.post(`${form}/get-form-data-consignee`);
  },

  getFormDataNotifier() {
    return api.post(`${form}/get-form-data-notifier`);
  },

  getFormPort(obj, requestID) {
    return api.post(form + "/get-form-port", obj);
  },

  getFormPortDestination(obj, requestID) {
    return api.post(form + "/get-form-port-destination", obj);
  },
  getFormRequiredDocs() {
    return api.post(`${form}/get-form-required-documents`);
  },

  getFormSendPhysicalDocs() {
    return api.post(`${form}/get-form-send-physical-documents`);
  },

  //Create!!
  createCountry(params) {
    return api.post(`${form}/create-country`, params);
  },

  createAddressEmail(params) {
    return api.post(`${form}/create-address-email`, params);
  },

  createAddressOriginalsDoc(params) {
    return api.post(`${form}/create-address-originals-doc`, params);
  },

  createDataConsignee(params) {
    return api.post(`${form}/create-data-consignee`, params);
  },

  createDataNotifier(params) {
    return api.post(`${form}/create-data-notifier`, params);
  },

  createPort(params) {
    return api.post(`${form}/create-port`, params);
  },

  createPortDestination(params) {
    return api.post(`${form}/create-port-destination`, params);
  },

  createRequiredDocument(params) {
    return api.post(`${form}/create-required-document`, params);
  },

  createSendPhysicalDocuments(params) {
    return api.post(`${form}/create-send-physical-documents`, params);
  },

  createForm(params) {
    return api.post(`${form}/create`, params);
  },

  uploadFile(params) {
    return api.post(`${form}/upload-file`, params);
  },
};
