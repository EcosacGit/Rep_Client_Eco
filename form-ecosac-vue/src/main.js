import { createApp } from "vue";

import "vuetify/styles";
import { createVuetify } from "vuetify";
import * as components from "vuetify/components";
import * as directives from "vuetify/directives";

import { aliases, mdi } from "vuetify/iconsets/mdi";

import Core from "./Core.vue";

import { createI18n, useI18n } from "vue-i18n";
import { en, es } from "vuetify/locale";
import { createVueI18nAdapter } from "vuetify/locale/adapters/vue-i18n";

import Form from "./views/Form.vue";
import RedirectPage from "./views/RedirectPage.vue";
import { createMemoryHistory, createRouter } from "vue-router";

import VueSweetalert2 from "vue-sweetalert2";
import "sweetalert2/dist/sweetalert2.min.css";

const routes = [
  { path: "/", component: Form },
  { path: "/thanks", component: RedirectPage },
];

const router = createRouter({
  history: createMemoryHistory(),
  routes,
});
const messages = {
  en: {
    $vuetify: {
      ...en,
      dataIterator: {
        rowsPerPageText: "Items per page:",
        pageText: "{0}-{1} of {2}",
      },
    },
    form: {
      title: "Ecosac Form",
      nameClient: "Customer Name",
      country: "Destination Country",
      puertoDestino: "Port of Discharge",
      puertoFinal: "Final Destination",
      alert: "If you can't find it, write the ",

      factura: "Data for the Invoice",
      embarque: "Bill of Lading(BL)",
      certificado: "Certificate",
      direccion: " Address and Sending",

      billName: "Name on the Invoice",
      billAddress: "Address on the Invoice",
      billInfo: "Additional information for the Invoice(optional)",

      pagadorFlete: "Freight payer",
      lugarPago: "Place of payment",
      tipoEmision: "Issue Type",
      espeAdicionales:
        "Additional specification  about the freight payment(optional)",

      consigneeInfo: "Consignee Information",
      nameConsignee: "Consignee",
      direccionConsignee: "Address",
      telefono1: "Phone 1",
      telefono2: "Phone 2",
      contactPerson: "Contact Person",
      taxID: "Tax ID(optional)",
      email: "Email",
      website: "Website(optional)",

      notifierInfo: "Notifier Information",
      botonNotificante: "Add Notifier",
      nameNotifier: "Notifier Information",
      infoBL: "Additional Information for the B/L(optional)",

      phytoCertificado: "Sanitary / Phytosanitary Certificate",
      phytoName: "Name",
      phytoAddress: "Address",
      phytoPuerto: "Port of Destination / Country",
      phytoDestino: "For international Transit",
      infoPhyto: "Additional information on the certificate(optional)",
      reExport: "For Re-Export(optional)",

      certOrigen: "Certificate of Origin",
      certName: "Name of the Certificate of Origin",
      certAddress: "Address of the Certificate of Origin",
      certInfo: "Additional information for the invoice(optional)",
      certQuality:
        "Quality Certificates and other Additional Documents Required",
      submit: "Submit",

      addressSend: "Address to Send the Original Documents",
      emailAddress: "Email for sending Scanned Documents",
      emailAddressButton: "Add Email Address",
      sendChoice: "Sending Documents, please Mark: ",

      otherSendName: "Company",
      otherSendAddress: "Address",
      otherSendTel: "Phone",
      otherSendCountry: "Country",
      otherSendCity: "City",
      otherSendState: "State",
      otherSendPostalCode: "Postal Code",

      //DATA DENTRO DE LOS COMBOBOX
      messageCountry: "Choose a country",
      messagePuertoDestino: "Choose a port",
      messageDestinoFinal: "Choose a destiny",

      addInforBill:
        "If you require additional text to be added to the invoice, check here and describe it below:",

      originalBL: "ORIGINAL PRINTED AT DESTINATION",
      isAllowedPhyto: "Import license required (Colombia / Honduras / Vietnam)",
      phytoInfoAdd:
        "If you require additional text to be added to the Phytosanitary Certificate, check here and describe it below:",
      senasa: "Attach application for SENASA",
      infoLabelCert:
        "If you require additional text to be added to the invoice, check here and describe it below:",

      packingList: "Packing List: Own format / Template",
      plasticStatement: "Plastic Declaration (European Union)",
      INVIMA: "INVIMA Letter",
      FDA: "FDA prior notice information including growers list",
      PPQ: "PPQ 203 (if applicable)",
      ColdTreatment: "COLD TREATMENT Letter",
      InspectionFormat: "7-point Inspection Checklist for Containers",
      MicrobioAnalysis: "Microbiological Analysis Certificate",
      InsuranceCertificate:
        "Claim Guide and Insurance certificate (If CIF incoterms)",
      DAM: "Customs declaration (DAM)",
      QualityReport: "Quality Report",
      OtherCert: "Other (describe)",

      consigneSend: "Same as the Consignee",
      notifierSend: "Same as the Notifier",

      scanningDoc: "Requires scanned documents",
      nextDoc: "Requires original documents (DHL)",

      invoiceCheck: "Invoice",
      originCheck: "Certificate of Origen",
      packingCheck: "Packing List",
      phytoDataCheck: "PhytoSanitary Certificate",
      otherCheck: "Otros (especificar)",

      swal: "Fill the fields: ",

      //REDIRECT PAGE
      thanks: "Thank You for Submitting the Form!",
      thanks2:
        "We appreciate your time and effort. Your submission has been received successfully.",
    },
  },
  es: {
    $vuetify: {
      ...es,
      dataIterator: {
        rowsPerPageText: "Items per page:",
        pageText: "{0}-{1} of {2}",
      },
    },
    form: {
      title: "Formulario Ecosac",
      nameClient: "Nombre del Cliente",
      country: "País de Destino",
      puertoDestino: "Puerto de Destino",
      puertoFinal: "Destino Final",
      alert: "En caso de no encontrarlo, escribir el ",

      factura: "Datos para la Factura",
      embarque: " Conocimiento de Embarque",
      certificado: "Certificado",
      direccion: "Dirección y Envio",

      billName: "Nombre para la Factura",
      billAddress: "Dirección para la Factura",
      billInfo: "Información Adicional para la Factura(opcional)",

      pagadorFlete: "Pagador de Flete",
      lugarPago: "Lugar de Pago",
      tipoEmision: "Tipo Emisión de BL",
      espeAdicionales:
        "Especificaciones adicionales respecto al pago de flete (opcional)",

      consigneeInfo: "Información Consignatario",
      nameConsignee: "Nombre de Consignatario",
      direccionConsignee: "Dirección",
      telefono1: "Teléfono 1",
      telefono2: "Teléfono 2",
      contactPerson: "Persona de Contacto",
      taxID: "Identificación Fiscal(opcional)",
      email: "Correo Electrónico",
      website: "Website(opcional)",

      botonNotificante: "Agregar Notificante",
      notifierInfo: "Información Notificante",
      nameNotifier: "Nombre de Notificante",
      infoBL: "Información adicional en el B/L (opcional)",
      submit: "Enviar",

      phytoCertificado: "Certificado Fitosanitario / Sanitario",
      phytoName: "Nombre",
      phytoAddress: "Dirección",
      phytoPuerto: "Puerto Destino / País",
      phytoDestino: "Para Transito Internacional",
      infoPhyto: "Información Adicional en el certificado (opcional)",
      reExport: "Para Re-Exportación (opcional)",

      certOrigen: "Certificado de Origen",
      certName: "Nombre en el certificado de Origen",
      certAddress: "Dirección en el certificado de Origen",
      certInfo: "Información Adicional para el Certificado de Origen(opcional)",
      certQuality:
        "Certificado de Calidad y Otros Documentos Adicionales  Requeridos",

      addressSend: "Dirección para el envio de los Documentos Originales",
      emailAddress:
        "Correo Electrónicos para el Envio de los Documentos Escaneados",
      emailAddressButton: "Añadir Correo Electrónico",
      sendChoice: "Del Envio de Documentos, seleccionar",

      otherSendName: "Nombre de la Empresa",
      otherSendAddress: "Dirección",
      otherSendTel: "Teléfono",
      otherSendCountry: "País",
      otherSendCity: "Ciudad",
      otherSendState: "Estado",
      otherSendPostalCode: "Código Postal",

      //DATA DENTRO DEL COMBOBOX
      messageCountry: "Seleccione un pais",
      messagePuertoDestino: "Selecciona un puerto",
      messageDestinoFinal: "Selecciona un destino",

      addInforBill: "¿Agregar información adicional?",
      originalBL: "ORIGINAL IMPRESO EN DESTINO",
      isAllowedPhyto:
        "Requiere Permiso de importación (Colombia / Hondura / Vietnam)",
      phytoInfoAdd:
        "Se requiere que se incluya una glosa adicional en el Fitosanitario",
      senasa: "Adjuntar solicitud para SENASA",
      infoLabelCert:
        "Se requiere que se incluya una glosa adicional en el Certificado de Origen",

      packingList: "Packing List: Plantilla / Formato propio",
      plasticStatement: "Declaración de plástico (Unión Europea)",
      INVIMA: "Carta INVIMA",
      FDA: "Información de aviso previo de la FDA",
      PPQ: "PPQ 203 (Si es que aplica)",
      ColdTreatment: "Cartas COLD TREATMENT",
      InspectionFormat: "Formato de inspección de contenedores",
      MicrobioAnalysis: "Certificado de Análisis Microbiológico",
      InsuranceCertificate:
        "Claim Guide and Insurance certificate (If CIF incoterms)",
      DAM: "Declaración de Aduanas (DAM)",
      QualityReport: "Reporte de Calidad",
      OtherCert: "Otros (detallar)",

      consigneSend: "Misma del Consignatario",
      notifierSend: "Misma del Notificante",
      scanningDoc: "Requiere Documentos Escaneados",
      nextDoc: "Requiere Valija con los siguientes Documentos",

      invoiceCheck: "Factura",
      originCheck: "Certificado de Origen",
      packingCheck: "Packing List",
      phytoDataCheck: "Certificado Fitosanitario",
      otherCheck: "Otros (especificar)",
      swal: "Completar los datos: ",

      //REDIRECT PAGE
      thanks: "¡Gracias por completar el formulario!",
      thanks2:
        "Apreciamos su tiempo y esfuerzo. Su envío ha sido recibido exitosamente.",
    },
  },
};

const i18n = createI18n({
  legacy: false, // Vuetify does not support the legacy mode of vue-i18n
  locale: "es",
  fallbackLocale: "en",
  messages,
});

const vuetify = createVuetify({
  icons: {
    defaultSet: "mdi",
    aliases,
    sets: {
      mdi,
    },
  },
  locale: {
    adapter: createVueI18nAdapter({ i18n, useI18n }),
  },
  components,
  directives,
});

createApp(Core)
  .use(vuetify)
  .use(i18n)
  .use(VueSweetalert2)
  .use(router)
  .mount("#app");
