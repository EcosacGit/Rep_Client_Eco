<template>
  <div style="display: flex; flex-direction: column">
    <button @click="getForm()">GetForm</button>
    <!--  SE VA USAR EN EL REPORTE || NO IMPORTA AHORA -->

    <button @click="getFormCountryEN()">getFormCountryEN</button>
    <!-- PARA TRABAJAR CON LA VERSION EN INGLES  -->
    <button @click="getFormCountryES()">getFormCountryES</button>
    <button @click="getFormAddressEmail()">getFormAddressEmail</button>
    <button @click="getFormAddressOriginalsDoc()">
      getFormAddressOriginalsDoc
    </button>
    <button @click="getFormDataConsignee()">getFormDataConsignee</button>
    <button @click="getFormDataNotifier()">getFormDataNotifier</button>
    <button @click="getFormPort()">getFormPort</button>
    <button @click="getFormRequiredDocs()">getFormRequiredDocs</button>
    <button @click="getFormSendPhysicalDocs()">getFormSendPhysicalDocs</button>

    <h2>CREATE!!!!</h2>
    <button @click="createCountry()">createCountry</button>
    <button @click="createAddressEmail()">createAddressEmail</button>
    <button @click="createAddressOriginalsDoc()">
      createAddressOriginalsDoc
    </button>
    <button @click="createDataConsignee()">createDataConsignee</button>
    <button @click="createDataNotifier()">createDataNotifier</button>
    <button @click="createPort()">createPort</button>
    <button @click="createRequiredDocument()">createRequiredDocument</button>
    <button @click="createSendPhysicalDocuments()">
      createSendPhysicalDocuments
    </button>
    <button @click="createForm()">createForm</button>
  </div>
</template>

<script>
import _Form from "../services/Form/FormService";
export default {
  methods: {
    getForm() {
      let param = {
        idClient: 2,
      };
      _Form
        .getForm(param)
        .then((response) => {
          console.log("Respuesta: " + response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormAddressEmail() {
      _Form
        .getFormAddressEmail()
        .then((response) => {
          console.log("Respuesta: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormAddressEmail() {
      _Form
        .getFormAddressEmail()
        .then((response) => {
          console.log("Respuesta: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormAddressOriginalsDoc() {
      _Form
        .getFormAddressOriginalsDoc()
        .then((response) => {
          console.log("Respuesta: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormCountryEN() {
      _Form
        .getFormCountryEN()
        .then((response) => {
          console.log("PAIS INGLES: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormCountryES() {
      _Form
        .getFormCountryES()
        .then((response) => {
          console.log("PAIS ESPAÑOL: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormDataConsignee() {
      _Form
        .getFormDataConsignee()
        .then((response) => {
          console.log("Consignee: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormDataNotifier() {
      _Form
        .getFormDataNotifier()
        .then((response) => {
          console.log("Notifier: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormPort() {
      let param = {
        idCountry: 4,
      };
      _Form
        .getFormPort(param)
        .then((response) => {
          console.log("Respuesta: " + response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getClientData() {
      let param = {
        bspCardCode: "CL000712244593",
      };
      _Form
        .showBusinessPartners(param)
        .then((response) => {
          console.log("Respuesta: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormRequiredDocs() {
      _Form
        .getFormRequiredDocs()
        .then((response) => {
          console.log("Required Docs: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormSendPhysicalDocs() {
      _Form
        .getFormSendPhysicalDocs()
        .then((response) => {
          console.log("Physical Docs: " + JSON.stringify(response.data));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    // BOTONES CREATE!!!
    createCountry() {
      let param = {
        descCountry: "vue3Test",
      };
      _Form
        .createCountry(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createAddressEmail() {
      let param = {
        email: "vue3Test@gmail.com",
      };
      _Form
        .createAddressEmail(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createAddressOriginalsDoc() {
      let param = {
        nameCompany: "vue3",
        addressCompany: "vue33",
        telef: "901856517",
        contactPerson: "omarvue3",
        taxID: "vue30m4r",
        emailAddress: "vue@gmail.com",
        country: "Vue",
        city: "vueCity",
        state_city: "stateCity",
        postalCode: "CodeCity",
      };
      _Form
        .createAddressOriginalsDoc(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createDataConsignee() {
      let param = {
        nameConsignee: "Vue3",
        telef1: "943255425",
        telef2: "977564332",
        EORI: "EORIVUE323",
        Fax: "FAX123",
        contactPerson: "Vue Doe",
        taxID: "TAXID123",
        email: "vue3@example.com",
        website: "www.vue3.com",
        idDataNotifier: 3,
        descCountry: "Germany",
      };
      _Form
        .createDataConsignee(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createDataNotifier() {
      let param = {
        nameNotifier: "Vue3",
        telef1: "943255425",
        telef2: "977564332",
        EORI: "EORIVUE323",
        Fax: "FAX123",
        contactPerson: "Vue Doe",
        taxID: "TAXID123",
        email: "vue3@example.com",
        website: "www.vue3.com",
        descCountry: "Germany",
      };
      _Form
        .createDataNotifier(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createPort() {
      let param = {
        idCountry: 3,
        descPort: "Salavuerry",
      };
      _Form
        .createPort(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createRequiredDocument() {
      let param = {
        packingList: 1,
        plasticStatement: 1,
        INVIMA: 1,
        FDA: 0,
        PPQ: 1,
        ColdTreatment: 0,
        InspectionFormat: 1,
        MicrobioAnalysis: 1,
        InsuranceCertificate: 1,
        DAM: 0,
        QualityReport: 0,
        Other: "Vue3 certificate",
      };
      _Form
        .createRequiredDocument(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createSendPhysicalDocuments() {
      let param = {
        bill: 1,
        originalCertificate: 0,
        packingList: 1,
        phytosanitaryCentificate: 1,
        Other: "Vue3 vuetify",
      };
      _Form
        .createSendPhysicalDocuments(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createForm() {
      let param = {
        idClient: 2,
        nameClient: "pruebaaa",
        CountryName: null,
        DestinationPort: null,
        DestinationFinal: null,
        BillName: "Vue bill",
        BillAddress: "123 main vueet, Atowny, CA 12345",
        BillInfoAdd: "Additional vue info",
        FreightPayer: "Jane vue",
        PlacePayment: "Vue LA",
        emissionType: "Nam",
        FreightPayerInfoAdd: "Additional freight payer information",
        BLDataInfoAdd: "Bill of lading information",
        IsAllowedPhyto: 1,
        PhytoName: "Phytosanitary Certificate for Apples",
        PhytoAddress: "123 Orchard Lane, Anytown, CA 12345",
        PhytoCountryPort: "New York, NY",
        PhytoInfoAdd: "Additional phytosanitary certificate information",
        PhytoTransitCountry: "Mexico",
        PhytoExportSENASA: "0x3000780031003",
        CertificateNameOrigin: "Certificate of Origin",
        CertificateAddressOrigin: "123 Main Street, Anytown, CA 12345",
        CertificateInfoAdd: "Additional certificate of origin information",
        isConsigneeSendDoc: 1,
        IsSendScanning: 0,
      };
      _Form
        .createForm(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },
  },
};
</script>
