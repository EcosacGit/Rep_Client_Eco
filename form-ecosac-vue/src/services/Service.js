import axios from "axios";

// -------------------- PRUEBAS---------------------//
//const baseURL = "http://127.0.0.1:8000/api/"; //API DE LARAVEL DE
//const baseURL = "http://10.10.100.155:8087/api_form_client/public/api/";
//const baseURL = "http://api.ecosac.com.pe:58000/api_form_client/public/api/";
const baseURL = "http://190.119.54.14:58000/api_form_client/public/api/";

const baseUrlAPI = "http://api.ecosac.com.pe:58000/api/";

export const api = axios.create({
  baseURL,
});

export const urlApi = axios.create({
  baseURL: baseUrlAPI,
});
