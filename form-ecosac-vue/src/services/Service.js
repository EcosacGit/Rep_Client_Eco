import axios from "axios";

//-------------------PRODUCCION------------------//  || api from main

// -------------------- PRUEBAS---------------------//

const baseURL = "http://127.0.0.1:8000/api/"; //API DE LARAVEL DE

export const api = axios.create({
  baseURL,
});
