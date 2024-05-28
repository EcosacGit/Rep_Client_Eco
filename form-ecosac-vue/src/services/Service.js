import axios from "axios";

// -------------------- PRUEBAS---------------------//
const baseURL = "http://127.0.0.1:8000/api/"; //API DE LARAVEL DE

const baseUrlAPI = "http://api.ecosac.com.pe:58000/api/";

export const api = axios.create({
  baseURL,
});

export const urlApi = axios.create({
  baseURL: baseUrlAPI,
});
