<template>
  <div>
    <div
      style="
        display: flex;
        width: 90%;
        margin: 0 auto;
        justify-content: space-between;
      "
    >
      <h2 style="margin-left: 1rem; margin-top: 1rem; text-align: center">
        FORMULARIO ECOSAC
      </h2>
      <div style="align-self: flex-end; display: flex; gap: 0.2rem">
        <v-btn @click="switchLocale('en')">EN</v-btn>
        <v-btn @click="switchLocale('es')">ES</v-btn>
      </div>
    </div>
    <v-card elevation="0" flat dense outlined rounded class="mt-1 mb-1">
      <v-card-text>
        <v-container class="mb-4">
          <v-form ref="miFormulario" v-model="isFormValid" lazy-validation>
            <v-row>
              <v-col cols="12" class="s-col-form">
                <label class="label-field">Nombre del Cliente</label>
                <v-text-field
                  :rules="[(v) => !!v || 'Texto es requerido']"
                  outlined
                  color="success"
                  v-model="clientName"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">País de Destino</label>
                </div>
                <v-row>
                  <v-col cols="12">
                    <v-combobox
                      outlined
                      v-if="!selectedCountryField"
                      v-model="selectedCountry"
                      :items="country.map((item) => item.descCountry)"
                      item-text="descCountry"
                      item-value="idCountry"
                      color="success"
                      return-object
                      dense
                      placeholder="Seleccione un país"
                    >
                    </v-combobox>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">Puerto de Destinto</label>
                </div>
                <v-row>
                  <v-col cols="12">
                    <v-combobox
                      v-if="!selectedPortField"
                      outlined
                      v-model="selectedPort"
                      :items="port.map((item) => item.descPort)"
                      item-value="idPort"
                      item-text="descPort"
                      color="success"
                      return-object
                      dense
                      placeholder="Seleccione un puerto"
                    >
                    </v-combobox>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">Destino Final</label>
                </div>
                <v-row>
                  <v-col cols="12">
                    <v-combobox
                      v-if="!selectedPortFinalField"
                      outlined
                      v-model="selectedPortFinal"
                      :items="portFinal.map((item) => item.descPortFinal)"
                      item-value="idPortFinal"
                      item-text="descPortFinal"
                      return-object
                      color="success"
                      dense
                      placeholder="Seleccione un destino"
                    >
                    </v-combobox>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>

            <v-row>
              <v-col cols="4">
                <v-text-field
                  v-if="!selectedCountry"
                  outlined
                  variant="underlined"
                  color="success"
                  v-model="selectedCountryField"
                ></v-text-field>
                <small v-if="!selectedCountry" class="text-red"
                  >En caso de no encontrarlo, escribir el País de Destino</small
                >
              </v-col>
              <v-col cols="4">
                <v-text-field
                  v-if="!selectedPort"
                  outlined
                  variant="underlined"
                  color="success"
                  v-model="selectedPortField"
                ></v-text-field>
                <small v-if="!selectedPort" class="text-red"
                  >En caso de no encontrarlo, escribir el Puerto Destino</small
                >
              </v-col>
              <v-col cols="4">
                <v-text-field
                  v-if="!selectedPortFinal"
                  outlined
                  variant="underlined"
                  color="success"
                  v-model="selectedPortFinalField"
                ></v-text-field>
                <small v-if="!selectedPortFinal" class="text-red"
                  >En caso de no encontrarlo, escribir el Puerto Destino</small
                >
              </v-col>
            </v-row>
          </v-form>
        </v-container>
        <v-tabs v-model="activeTab" style="width: 90%; margin: 0 auto" centered>
          <v-tabs-slider></v-tabs-slider>
          <v-tab
            @click="activateTab('tab1-1')"
            href="#tab1-1"
            :class="{ 'tab-selected': activeTab === 'tab1-1' }"
            >Datos pára la Factura</v-tab
          >
          <v-tab
            @click="activateTab('tab1-2')"
            href="#tab1-2"
            :class="{ 'tab-selected': activeTab === 'tab1-2' }"
            >Conocimiento de Embarque</v-tab
          >
          <v-tab
            @click="activateTab('tab1-3')"
            href="#tab1-3"
            :class="{ 'tab-selected': activeTab === 'tab1-3' }"
            >Certificados</v-tab
          >
          <v-tab
            @click="activateTab('tab1-4')"
            href="#tab1-4"
            :class="{ 'tab-selected': activeTab === 'tab1-4' }"
            >Dirección y Envio</v-tab
          >
        </v-tabs>

        <v-tabs-items
          v-model="activeTab"
          style="display: flex; flex-direction: column; width: 100%"
        >
          <v-tab-item
            :value="'tab1-1'"
            class="datosFactura"
            v-if="activeTab === 'tab1-1'"
          >
            <v-container>
              <v-form>
                <v-row>
                  <v-divider class="border-opacity-100"></v-divider>
                </v-row>
                <v-row class="mt-5">
                  <v-col cols="4" class="s-col-form">
                    <label class="label-field">Nombre para la Factura</label>
                    <v-select
                      v-model="billNameSelectedOption"
                      :items="billNameOptions"
                      outlined
                      color="success"
                      dense
                      @change="toggleTextFieldBillName"
                    ></v-select>
                  </v-col>
                  <v-col
                    v-if="billNameSelectedOption === 'Otra (Detallar)'"
                    cols="8"
                    class="s-col-form align-self-end"
                  >
                    <v-text-field
                      outlined
                      color="success"
                      v-model="billNameCustomOption"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <v-col cols="4" class="s-col-form">
                    <label class="label-field">Dirección para la Factura</label>
                    <v-select
                      v-model="billDirectionSelectedOption"
                      :items="billDirectionOptions"
                      outlined
                      dense
                      color="success"
                      @change="toggleTextFieldBillDirection"
                    ></v-select>
                  </v-col>
                  <v-col
                    v-if="billDirectionSelectedOption === 'Otra (Detallar)'"
                    cols="8"
                    class="s-col-form align-self-end"
                  >
                    <v-text-field
                      outlined
                      color="success"
                      v-model="billDirectionCustomOption"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <v-col cols="4" class="s-col-form">
                    <label class="label-field"
                      >Información Adicional para la Factura (opcional)</label
                    >
                    <v-checkbox
                      v-model="checkBoxValueInfoBill"
                      label="¿Agregar información adicional?"
                    ></v-checkbox>
                  </v-col>
                  <v-col
                    v-if="checkBoxValueInfoBill"
                    cols="8"
                    class="s-col-form align-self-center"
                  >
                    <v-text-field
                      outlined
                      v-model="textFieldValueInfoBill"
                      color="success"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-form>
            </v-container>
          </v-tab-item>

          <!-- CONOCIMIENTO DE EMBARQUE B/L -->
          <v-tab-item
            :value="'tab1-2'"
            class="conocimientoEmbarque"
            v-if="activeTab === 'tab1-2'"
          >
            <v-container>
              <v-form>
                <v-row>
                  <v-divider class="border-opacity-100"></v-divider>
                </v-row>
                <v-row class="mt-5">
                  <v-col cols="6" class="s-col-form">
                    <label class="label-field">Pagador de Flete</label>
                    <v-text-field
                      outlined
                      color="success"
                      v-model="freigthPayer"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="6" class="s-col-form">
                    <label class="label-field">Lugar de Pago</label>
                    <v-text-field
                      outlined
                      color="success"
                      v-model="placePayment"
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <cols cols="4" class="s-col-form">
                    <label class="label-field">Tipo Emision de BL</label>
                    <v-checkbox
                      v-model="swbBL"
                      @change="handleBLChange('swbBL')"
                      label="SWB"
                      class="mt-n1"
                    ></v-checkbox>
                    <v-checkbox
                      v-model="telexBL"
                      @change="handleBLChange('telexBL')"
                      label="TELEX RELEASE"
                      class="mt-n1"
                    ></v-checkbox>
                    <v-checkbox
                      v-model="originalBL"
                      @change="handleBLChange('originalBL')"
                      label="ORIGINAL IMPRESO EN DESTINO"
                      class="mt-n1"
                    ></v-checkbox>
                    <v-checkbox
                      v-model="otherBL"
                      @change="handleBLChange('otherBL')"
                      label="OTRO"
                      class="mt-n1"
                    ></v-checkbox>
                  </cols>
                  <v-col
                    v-if="otherBL"
                    cols="8"
                    class="s-col-form align-self-end"
                  >
                    <v-text-field
                      outlined
                      v-model="txtDataBL"
                      color="success"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <v-col cols="12" class="mt-2 s-col-form">
                    <label class="label-field"
                      >Especificaciones adicionales respecto al pago de flete
                      (opcional)</label
                    >
                    <v-text-field
                      outlined
                      v-model="freightPayerInfoAdd"
                      color="success"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <v-divider color="success"></v-divider>
                </v-row>

                <div class="mt-3 data-consignee">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Información Consignatario</label
                      ></v-col
                    >
                  </v-row>
                  <v-row>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Nombre de Consignatario</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="nameConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Dirección</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="directionConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Telefono 1</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="telf1Consignee"
                        required
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">Telefono 2</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="telf2Consignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="6" class="s-col-form" v-if="showEORIField">
                      <label class="label-field">EORI</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="EORIConsignee"
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Fax</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="faxConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Persona de contacto</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="contactPersonConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field"
                        >Identificación Fiscal (opcional)</label
                      >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="taxIDConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">Correo Electrónico</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="emailConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">Website (opcional)</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="webisteConsignee"
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </div>

                <div class="mt-3 notifier">
                  <div
                    class="mt-3 data-notifier"
                    v-for="(notifier, index) in notifiers"
                    :key="index"
                  >
                    <v-row>
                      <v-col
                        ><label style="color: red; font-weight: bold"
                          >Información Notificante {{ index + 1 }}</label
                        ></v-col
                      >
                    </v-row>
                    <v-row>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field"
                          >Nombre de Notificante {{ index + 1 }}</label
                        >
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.nameNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Dirección</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.directionNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Telefono 1</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.telf1Notifier"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Telefono 2</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.telf2Notifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form" v-if="showEORIField">
                        <label class="label-field">EORI</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.EORINotifier"
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Fax</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.faxNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Persona de contacto</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.contactPersonNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field"
                          >Identificación Fiscal (opcional)</label
                        >
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.taxIDNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Correo Electrónico</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.emailNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Website (opcional)</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.websiteNotifier"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                  </div>

                  <v-btn
                    class="mt-4"
                    @click="addNotifier"
                    style="
                      background-color: #def1c1;
                      width: 20%;
                      padding: 1rem 0 2rem 0;
                    "
                  >
                    <v-icon style="margin-right: 3px">mdi-plus-circle</v-icon>
                    Agregar Notificante
                  </v-btn>
                </div>
                <v-row>
                  <v-col cols="12" class="mt-6 s-col-form">
                    <label class="label-field"
                      >Información adicional en el B/L (opcional)</label
                    >
                    <v-text-field
                      outlined
                      v-model="BLInfoAdd"
                      color="success"
                      dense
                    ></v-text-field>
                  </v-col>
                </v-row>
              </v-form>
            </v-container>
          </v-tab-item>

          <v-tab-item
            :value="'tab1-3'"
            class="certificados"
            v-if="activeTab === 'tab1-3'"
          >
            <v-container>
              <v-form>
                <v-row>
                  <v-divider class="border-opacity-100"></v-divider>
                </v-row>

                <div class="mt-2 phytoPart">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Certificado Fitosanitario / Sanitario
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-2">
                    <v-col cols="12" class="s-col-form">
                      <v-checkbox
                        v-model="isAllowedPhyto"
                        label="Requiere Permiso de importación (Colombia / Hondura /
                      Vietnam)"
                      ></v-checkbox>
                    </v-col>
                  </v-row>

                  <v-row class="mt-5">
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Nombre </label>
                      <v-select
                        v-model="phytoNameSelectedOption"
                        :items="phytoNameOptions"
                        outlined
                        color="success"
                        dense
                        @change="toggleTextFieldPhytoName"
                      ></v-select>
                    </v-col>
                    <v-col
                      v-if="phytoNameSelectedOption === 'Otra (Detallar)'"
                      cols="8"
                      class="s-col-form align-self-end"
                    >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoNameCustomOption"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">Dirección </label>
                      <v-select
                        v-model="phytoAddressSelectedOption"
                        :items="phytoAddressOptions"
                        outlined
                        color="success"
                        dense
                        @change="toggleTextFieldPhytoAddress"
                      ></v-select>
                    </v-col>
                    <v-col
                      v-if="phytoAddressSelectedOption === 'Otra (Detallar)'"
                      cols="8"
                      class="s-col-form align-self-end"
                    >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoAddressCustomOption"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">Puerto Destino / País</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoCountryPort"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field"
                        >Indicar Pais de Transito</label
                      >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoTransitCountry"
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field"
                        >Información Adicional en el certificado
                        (opcional)</label
                      >
                      <v-checkbox
                        v-model="phytoInfoAdd"
                        label="Se requiere que se incluya una glosa adicional en el Fitosanitario"
                      ></v-checkbox>
                    </v-col>
                    <v-col
                      v-if="phytoInfoAdd"
                      cols="6"
                      class="s-col-form align-self-center"
                    >
                      <v-text-field
                        outlined
                        v-model="textFieldValuePhytoInfoAdd"
                        color="success"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="12" class="s-col-form">
                      <label class="label-field"
                        >Para Re-Exportación (opcional)</label
                      >
                      <v-file-input
                        v-model="phytoExportSENASA"
                        label="Adjuntar solicitud para
                      SENASA"
                        accept=".doc,.docx,.xls,.xlsx,.pdf,.txt,.csv,.ppt,.pptx,.jpg,.jpeg,.png,.gif"
                        @change="onFileChange"
                      ></v-file-input>
                    </v-col>
                  </v-row>
                </div>

                <v-row>
                  <v-divider class="mt-5" color="success"></v-divider>
                </v-row>

                <div class="mt-4 certOriginPart">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Certificado de Origen
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-2">
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field"
                        >Nombre en el certificado de Origen</label
                      >
                      <v-select
                        v-model="certificateNameOriginSelectedOption"
                        :items="certificateNameOriginOptions"
                        outlined
                        color="success"
                        dense
                        @change="toggleTextFieldCertificateNameOrigin"
                      ></v-select>
                    </v-col>
                    <v-col
                      v-if="
                        certificateNameOriginSelectedOption ===
                        'Otra (Detallar)'
                      "
                      cols="8"
                      class="s-col-form align-self-end"
                    >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="certificateNameOriginCustomOption"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row class="mt-2">
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field"
                        >Dirección en el certificado de Origen</label
                      >
                      <v-select
                        v-model="certificateAddressOriginSelectedOption"
                        :items="certificateAddressOriginOptions"
                        outlined
                        color="success"
                        dense
                        @change="toggleTextFieldCertificateAddressOrigin"
                      ></v-select>
                    </v-col>
                    <v-col
                      v-if="
                        certificateAddressOriginSelectedOption ===
                        'Otra (Detallar)'
                      "
                      cols="8"
                      class="s-col-form align-self-end"
                    >
                      <v-text-field
                        outlined
                        color="success"
                        v-model="certificateAddressOriginCustomOption"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field"
                        >Información Adicional para el Certificado de Origen
                        (opcional)</label
                      >
                      <v-checkbox
                        v-model="certificateInfoAdd"
                        label="Se requiere que se incluya una glosa adicional en el Certificado de Origen"
                      ></v-checkbox>
                    </v-col>
                    <v-col
                      v-if="certificateInfoAdd"
                      cols="6"
                      class="s-col-form align-self-center"
                    >
                      <v-text-field
                        outlined
                        v-model="textFieldValueCertificateInfoAdd"
                        color="success"
                        dense
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </div>
                <v-row>
                  <v-divider class="mt-5" color="success"></v-divider>
                </v-row>

                <div class="mt-4 certQuality">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Certificado de Calidad y Otros Documentos Adicionales
                        Requeridos
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-2">
                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="packingList"
                        label="Packing List: Plantilla / Formato propio"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="plasticStatement"
                        label="Declaración de plástico (Unión Europea)"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="INVIMA"
                        label="Carta INVIMA"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="FDA"
                        label="Información de aviso previo de la FDA"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="PPQ"
                        label="PPQ 203 (Si es que aplica)"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="ColdTreatment"
                        label="Cartas COLD TREATMENT"
                        class="mt-n1"
                      ></v-checkbox>
                    </v-col>

                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="InspectionFormat"
                        label="Formato de inspección de contenedores"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="MicrobioAnalysis"
                        label="Certificado de Análisis Microbiológico"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="InsuranceCertificate"
                        label="Claim Guide and Insurance certificate (If CIF incoterms)"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="DAM"
                        label="Declaración de Aduanas (DAM)"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="QualityReport"
                        label="Reporte de Calidad"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="OtherCert"
                        label="Otros (detallar)"
                        class="mt-n1"
                      ></v-checkbox>
                    </v-col>
                  </v-row>

                  <v-row v-if="OtherCert" class="mt-2">
                    <v-col cols="12" class="s-col-form">
                      <v-text-field
                        outlined
                        v-model="OtherCertText"
                        label="Detalles de otros certificado"
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </div>
              </v-form>
            </v-container>
          </v-tab-item>

          <v-tab-item
            :value="'tab1-4'"
            class="direccionEnvio"
            v-if="activeTab === 'tab1-4'"
          >
            <v-container>
              <v-form>
                <v-row>
                  <v-divider class="border-opacity-100"></v-divider>
                </v-row>
                <div class="mt-5">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Dirección para el envio de los Documentos Originales
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-1">
                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="isConsigneeSendDoc"
                        label="Misma del Consignatario"
                        @change="
                          handleCheckboxChangeConsigneeSendDocs(
                            'isConsigneeSendDoc'
                          )
                        "
                      ></v-checkbox>
                      <div style="display: flex; gap: 1rem">
                        <v-checkbox
                          style="align-self: flex-end"
                          v-model="isNotifierSendDoc"
                          label="Misma del Notificante"
                          @change="
                            handleCheckboxChangeConsigneeSendDocs(
                              'isNotifierSendDoc'
                            )
                          "
                        ></v-checkbox>
                        <v-combobox
                          v-if="isNotifierSendDoc"
                          color="success"
                          :items="
                            notifiers.map(
                              (notifier) => notifier.directionNotifier
                            )
                          "
                          v-model="selectedNotifierAddress"
                        ></v-combobox>
                      </div>

                      <v-checkbox
                        v-model="isOtherSendDoc"
                        label="Otros (Detallar)"
                        @change="
                          handleCheckboxChangeConsigneeSendDocs(
                            'isOtherSendDoc'
                          )
                        "
                      ></v-checkbox>
                    </v-col>
                  </v-row>
                </div>
                <div class="mt-3 otherSend">
                  <div
                    class="mt-3 data-otherSend"
                    v-for="(otherSend, index) in otherSends"
                    :key="index"
                  >
                    <v-row>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Nombre de la Empresa</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.nameCompany"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Dirección</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.addressCompany"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Telefono</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.telef"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Persona de contacto</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.contactPerson"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field"
                          >Identificación Fiscal (opcional)</label
                        >
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.taxID"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Correo Electrónico</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.emailAddress"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">País</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.country"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">Ciudad</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.city"
                          required
                        ></v-text-field>
                      </v-col>
                    </v-row>

                    <v-row class="mb-5">
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Estado</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.state_city"
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">Codigo Postal</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.postalCode"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                  </div>
                </div>

                <v-row>
                  <v-divider color="success"></v-divider>
                </v-row>
                <div class="mt-5">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Correo Electrónicos para el Envio de los Documentos
                        Escaneados
                      </label></v-col
                    >
                  </v-row>
                </div>

                <div class="mt-3 data-email">
                  <v-row>
                    <v-col
                      v-for="(email, index) in emails"
                      :key="index"
                      cols="4"
                      class="s-col-form"
                    >
                      <label class="label-field">Correo Electrónico</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="email.email"
                        required
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </div>
                <v-btn
                  class="mt-4"
                  @click="addEmail"
                  style="
                    background-color: #def1c1;

                    padding: 1rem 1rem 2rem 1rem;
                  "
                >
                  <v-icon style="margin-right: 3px">mdi-plus-circle</v-icon>
                  Agregar Correo Electrónicos
                </v-btn>

                <v-row class="mt-5">
                  <v-divider color="success"></v-divider>
                </v-row>

                <div class="mt-5">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >Del Envio de Documentos, seleccionar:
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-1">
                    <v-col cols="12" class="s-col-form">
                      <v-checkbox
                        v-model="isSendScanning"
                        label="Requiere Documentos Escaneados"
                        @change="handleCheckboxSendDocs('isSendScanning')"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="isSendPhysicalDocument"
                        label="Requiere Valija con los siguientes Documentos Físicos"
                        @change="
                          handleCheckboxSendDocs('isSendPhysicalDocument')
                        "
                      ></v-checkbox>
                    </v-col>
                  </v-row>
                </div>
                <div class="mt-1 otherPhysicalDocs">
                  <div
                    class="mt-1 data-otherPhysicalDocs"
                    v-for="(
                      isSendPhysicalDocument, index
                    ) in SendPhysicalDocuments"
                    :key="index"
                  >
                    <v-row>
                      <v-col cols="4" class="s-col-form reqDocPhy">
                        <v-checkbox
                          v-model="isSendPhysicalDocument.bill"
                          label="Factura"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.originalCertificate"
                          label="Certificado de Origen"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.packingList"
                          label="Packing List"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="
                            isSendPhysicalDocument.phytosanitaryCertificate
                          "
                          label="Certificado Fitosanitario"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.otherSendingPacking"
                          label="Otros (especificar)"
                          class="mt-n1"
                        ></v-checkbox>
                      </v-col>
                      <v-col
                        v-if="isSendPhysicalDocument.otherSendingPacking"
                        cols="6"
                        class="s-col-form align-self-end"
                      >
                        <v-text-field
                          outlined
                          v-model="textFieldValueOtherSendingPacking"
                          color="success"
                          dense
                        ></v-text-field>
                      </v-col>
                    </v-row>
                  </div>
                </div>
              </v-form>
            </v-container>
          </v-tab-item>
          <v-btn
            color="green darken-2"
            class="ml-auto"
            style="
              width: 15%;
              padding: 1rem 0rem 1.8rem 0rem;
              margin-right: 1rem;
            "
            @click="createFormFinal"
            >{{ $t("form.submit") }}</v-btn
          >
        </v-tabs-items>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
import _Form from "../services/Form/FormService";
import "vuetify/dist/vuetify.min.css";

import { useI18n } from "vue-i18n";

import "@mdi/font/css/materialdesignicons.min.css";

export default {
  setup() {
    const { locale } = useI18n();
    const switchLocale = (lang) => {
      locale.value = lang;
    };

    return { switchLocale };
  },
  data() {
    return {
      //active tab
      activeTab: "tab1-1",

      //NOMBRE FACTURA
      billNameSelectedOption: null,
      billNameCustomOption: "",
      billNameOptions: ["Misma del consignatario", "Otra (Detallar)"],

      //DIRECCION FACTURA
      billDirectionSelectedOption: null,
      billDirectionCustomOption: "",
      billDirectionOptions: ["Misma del consignatario", "Otra (Detallar)"],

      phytoNameSelectedOption: null,
      phytoNameCustomOption: "",
      phytoNameOptions: ["Misma del consignatario", "Otra (Detallar)"],

      phytoAddressSelectedOption: null,
      phytoAddressCustomOption: "",
      phytoAddressOptions: ["Misma del consignatario", "Otra (Detallar)"],

      //INFO ADICIONAL FACTURA
      checkBoxValueInfoBill: false,
      textFieldValueInfoBill: "",
      clientName: "",

      //TIPO EMISION BL
      swbBL: false,
      telexBL: false,
      originalBL: false,
      otherBL: false,
      txtDataBL: "",

      //notifier
      notifiers: [],

      newNotifier: {
        nameNotifier: "",
        directionNotifier: "",
        telf1Notifier: "",
        telf2Notifier: "",
        EORINotifier: "",
        faxNotifier: "",
        contactPersonNotifier: "",
        taxIDNotifier: "",
        emailNotifier: "",
        websiteNotifier: "",
      },

      //certificado phyto
      isAllowedPhyto: false,
      phytoInfoAdd: false,
      textFieldValuePhytoInfoAdd: "",

      //certificado de Origen
      certificateNameOriginSelectedOption: null,
      certificateNameOriginCustomOption: "",
      certificateNameOriginOptions: [
        "Misma del consignatario",
        "Otra (Detallar)",
      ],

      itemsNotifierSendDoc: [],

      certificateAddressOriginSelectedOption: null,
      certificateAddressOriginCustomOption: "",
      certificateAddressOriginOptions: [
        "Misma del consignatario",
        "Otra (Detallar)",
      ],

      certificateInfoAdd: false,
      textFieldValueCertificateInfoAdd: "",

      //certificado de calidad y otro documento add
      packingList: false,
      plasticStatement: false,
      INVIMA: false,
      FDA: false,
      PPQ: false,
      ColdTreatment: false,
      InspectionFormat: false,
      MicrobioAnalysis: false,
      InsuranceCertificate: false,
      DAM: false,
      QualityReport: false,
      OtherCert: false,
      OtherCertText: "",

      //Dirección Envio
      isConsigneeSendDoc: false,
      isNotifierSendDoc: false,
      isOtherSendDoc: false,

      otherSends: [],

      newOtherSends: {
        nameCompany: "",
        addressCompany: "",
        telef: "",
        contactPerson: "",
        taxID: "",
        emailAddress: "",
        country: "",
        city: "",
        state_city: "",
        postalCode: "",
      },

      //email
      emails: [],
      newEmail: {
        email: "",
      },

      //send scanning o physical documents
      isSendScanning: false,
      isSendPhysicalDocument: false,

      SendPhysicalDocuments: [],

      newIsSendPhysicalDocument: {
        bill: false,
        originalCertificate: false,
        packingList: false,
        phytosanitaryCertificate: false,
        otherSendingPacking: false,
      },
      textFieldValueOtherSendingPacking: "",

      //1. GETS
      // Obtener todo los paises / puerto / destino
      selectedCountry: null,
      selectedCountryId: null,
      country: [],
      selectedPort: null,
      port: [],
      selectedPortFinal: null,
      portFinal: [],
      selectedCountryField: "",
      selectedPortField: "",
      selectedPortFinalField: "",

      //Create
      idCountry: null,
      idRegion: null,
      destinationPort: null,
      destinationFinal: null,

      //datos para factura
      billNameCustomOption: "",
      billDirectionCustomOption: "",
      textFieldValueInfoBill: "",

      //conocimiento de embarque
      freigthPayer: "",
      placePayment: "",
      freightPayerInfoAdd: "",
      BLInfoAdd: "",
      emissionType: "",
      txtDataBL: "",

      //Consignatario
      nameConsignee: "",
      directionConsignee: "",
      telf1Consignee: "",
      telf2Consignee: "",
      EORIConsignee: "",
      faxConsignee: "",
      contactPersonConsignee: "",
      taxIDConsignee: "",
      emailConsignee: "",
      webisteConsignee: "",

      //certificate!!
      phytoCountryPort: "",
      phytoTransitCountry: "",

      //importar pdf / word / etc
      phytoExportSENASA: null,
      filePath: null,

      //redirect
      foobar: null,

      //eori validation
      showEORIField: false,
      selectedNotifierAddress: "",
      notifierAddresses: {},
      selectedNotifier: "",
    };
  },
  watch: {
    //Pais
    selectedCountry: function (newVal) {
      let country = this.country.find((item) => item.descCountry === newVal);

      if (country !== undefined) {
        console.log("descCountry seleccionado: " + country.descCountry);
        console.log("idCountry seleccionado: " + country.idCountry);

        this.idRegion = country.idRegion;
        this.selectedCountry = country.descCountry;
        this.idCountry = country.idCountry;

        this.showEORIField = this.idRegion === "11" ? true : false;

        console.log("data example EORI ", this.showEORIField);

        this.getFormPort(country.idCountry);
        this.getFormFinalDestiny(country.idCountry);
      } else {
        this.selectedCountry = "";
      }
    },

    //Puerto
    selectedPort: function (newVal) {
      let port = this.port.find((item) => item.descPort === newVal);
      if (port !== undefined) {
        this.selectedPort = port.descPort;

        this.destinationPort = port.idPort;
      } else {
        this.selectedPort = "";
      }
    },

    //Ciudad
    selectedPortFinal: function (newVal) {
      let portFinal = this.port.find((item) => item.descPort === newVal);
      if (portFinal !== undefined) {
        this.selectedPortFinal = portFinal.descPort;

        this.destinationFinal = portFinal.idPort;
      } else {
        this.selectedPortFinal = "";
      }
    },

    txtDataBL(newValue) {
      if (this.isOtherSelected) {
        this.emissionType = newValue;
      }
    },
  },
  methods: {
    toggleTextFieldBillName() {
      if (this.billNameSelectedOption === "Otra (Detallar)") {
        this.billNameCustomOption = "";
      }
    },

    toggleTextFieldBillDirection() {
      if (this.billDirectionSelectedOption === "Otra (Detallar)") {
        this.billDirectionOptions = "";
      }
    },

    addNotifier() {
      this.notifiers.push(Object.assign({}, this.newNotifier));
      this.itemsNotifierSendDoc.push(this.notifiers.length.toString()); // Agrega un nuevo ítem al array
    },

    handleBLChange(selected) {
      if (selected === "swbBL") {
        this.emissionType = "SWB";
        this.isOtherSelected = false;
        this.telexBL = false;
        this.originalBL = false;
        this.otherBL = false;
      } else if (selected === "telexBL") {
        this.emissionType = "TELEX RELEASE";
        this.isOtherSelected = false;
        this.swbBL = false;
        this.originalBL = false;
        this.otherBL = false;
      } else if (selected === "originalBL") {
        this.emissionType = "ORIGINAL IMPRESO EN DESTINO";
        this.isOtherSelected = false;
        this.swbBL = false;
        this.telexBL = false;
        this.otherBL = false;
      } else if (selected === "otherBL") {
        this.isOtherSelected = true;
        this.emissionType = "";
        this.swbBL = false;
        this.telexBL = false;
        this.originalBL = false;
      }
    },

    toggleTextFieldCertificateNameOrigin() {
      if (this.certificateNameOriginSelectedOption === "Otra (Detallar)") {
        this.certificateNameOriginOptions = "";
      }
    },

    toggleTextFieldCertificateAddressOrigin() {
      if (this.certificateAddressOriginSelectedOption === "Otra (Detallar)") {
        this.certificateAddressOriginOptions = "";
      }
    },

    addOtherSendDoc() {
      if (!this.isConsigneeSendDoc) {
        if (this.isOtherSendDoc) {
          this.otherSends.push(Object.assign({}, this.newOtherSends));
        } else {
          this.otherSends = [];
        }
      } else {
        this.isOtherSendDoc = false;
        this.otherSends = [];
      }
    },

    handleCheckboxChangeConsigneeSendDocs(checkboxName) {
      if (checkboxName === "isConsigneeSendDoc") {
        if (this.isConsigneeSendDoc) {
          this.isOtherSendDoc = false;
          this.isNotifierSendDoc = false;
          this.otherSends = [];
        }
      } else if (checkboxName === "isOtherSendDoc") {
        if (this.isOtherSendDoc) {
          this.isConsigneeSendDoc = false;
          this.isNotifierSendDoc = false;
          this.addOtherSendDoc();
        } else {
          this.otherSends = [];
        }
      } else if (checkboxName === "isNotifierSendDoc") {
        if (this.isNotifierSendDoc) {
          this.isOtherSendDoc = false;
          this.isConsigneeSendDoc = false;
          this.otherSends = [];
        }
      }
    },

    addEmail() {
      this.emails.push(Object.assign({}, this.newEmail));
    },

    addSendPhysicalDocument() {
      if (!this.isSendScanning) {
        if (this.isSendPhysicalDocument) {
          this.SendPhysicalDocuments.push(
            Object.assign({}, this.newIsSendPhysicalDocument)
          );
        } else {
          this.SendPhysicalDocuments = [];
        }
      } else {
        this.isSendPhysicalDocument = false;
        this.SendPhysicalDocuments = [];
      }
    },

    handleCheckboxSendDocs(checkboxName) {
      if (checkboxName === "isSendScanning") {
        if (this.isSendScanning) {
          this.isSendPhysicalDocument = false;
          this.SendPhysicalDocuments = [];
        }
      } else if (checkboxName === "isSendPhysicalDocument") {
        if (this.isSendPhysicalDocument) {
          this.isSendScanning = false;
          this.addSendPhysicalDocument();
        } else {
          this.SendPhysicalDocuments = [];
        }
      }
    },
    //active tab
    activateTab(tab) {
      this.activeTab = tab;
    },

    //GETs
    getFormCountryES() {
      _Form
        .getFormCountryES()
        .then((response) => {
          this.country = response.data.map((item) => ({
            idRegion: item.idRegion,
            idCountry: item.idCountry,
            descCountry: item.descCountry,
          }));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormPort(idCountry) {
      let param = {
        idCountry: idCountry,
      };

      _Form
        .getFormPort(param)
        .then((response) => {
          this.port = response.data.map((item) => ({
            idPort: item.idPort,
            descPort: item.descPort,
          }));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    getFormFinalDestiny(idCountry) {
      let param = {
        idCountry: idCountry,
      };

      _Form
        .getFormPortDestination(param)
        .then((response) => {
          this.portFinal = response.data.map((item) => ({
            idPortFinal: item.idPort,
            descPortFinal: item.descPort,
          }));
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    //CREATE
    createCountry() {
      let param = {
        descCountry: this.selectedCountryField,
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

    createPort() {
      let param = {
        idCountry: this.idCountry || null, //siempreeee
        descPort: this.selectedPortField,
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

    createPortFinal() {
      let param = {
        idCountry: this.idCountry || null, //siempreeee
        descPort: this.selectedPortFinalField,
      };
      _Form
        .createPortDestination(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },
    //DATA CONSIGNEE
    createDataConsignee() {
      let param = {
        nameConsignee: this.nameConsignee,
        addressConsignee: this.directionConsignee,
        telef1: this.telf1Consignee,
        telef2: this.telf2Consignee,
        EORI: this.EORIConsignee,
        Fax: this.faxConsignee,
        contactPerson: this.contactPersonConsignee,
        taxID: this.taxIDConsignee,
        email: this.emailConsignee,
        website: this.webisteConsignee,
        descCountry: this.selectedCountry,
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
      this.notifierAddresses = {}; // Diccionario para almacenar direcciones de notifiers

      for (let notifier of this.notifiers) {
        let param = {
          nameNotifier: notifier.nameNotifier,
          addressNotifier: notifier.directionNotifier,
          telef1: notifier.telf1Notifier,
          telef2: notifier.telf2Notifier,
          EORI: notifier.EORINotifier,
          Fax: notifier.faxNotifier,
          contactPerson: notifier.contactPersonNotifier,
          taxID: notifier.taxIDNotifier,
          email: notifier.emailNotifier,
          website: notifier.websiteNotifier,
          descCountry: this.selectedCountry,
        };
        this.notifierAddresses[notifier.nameNotifier] =
          notifier.directionNotifier;

        if (notifier.nameNotifier === this.selectedNotifierAddress) {
          this.isNotifierSendDoc = notifier.directionNotifier;
        }

        _Form
          .createDataNotifier(param)
          .then((response) => {
            console.log(response.data);
          })
          .catch((error) => {
            console.log("error", error);
          });
      }
    },

    createRequiredDocument() {
      let ortherCert;
      if (this.OtherCert == false) {
        ortherCert = " - ";
      } else if (this.OtherCert == true) {
        ortherCert = this.OtherCertText;
      }

      let param = {
        packingList: this.packingList ? 1 : 0,
        plasticStatement: this.plasticStatement ? 1 : 0,
        INVIMA: this.INVIMA ? 1 : 0,
        FDA: this.FDA ? 1 : 0,
        PPQ: this.PPQ ? 1 : 0,
        ColdTreatment: this.ColdTreatment ? 1 : 0,
        InspectionFormat: this.InspectionFormat ? 1 : 0,
        MicrobioAnalysis: this.MicrobioAnalysis ? 1 : 0,
        InsuranceCertificate: this.InsuranceCertificate ? 1 : 0,
        DAM: this.DAM ? 1 : 0,
        QualityReport: this.QualityReport ? 1 : 0,
        Other: ortherCert,
      };
      console.log("Parametros: " + param.Other);

      _Form
        .createRequiredDocument(param)
        .then((response) => {
          console.log(response.data);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createAddressOriginalsDoc() {
      for (let otherSend of this.otherSends) {
        let param = {
          nameCompany: otherSend.nameCompany,
          addressCompany: otherSend.addressCompany,
          telef: otherSend.telef,
          contactPerson: otherSend.contactPerson,
          taxID: otherSend.taxID,
          emailAddress: otherSend.emailAddress,
          country: otherSend.country,
          city: otherSend.city,
          state_city: otherSend.state_city,
          postalCode: otherSend.postalCode,
        };
        _Form
          .createAddressOriginalsDoc(param)
          .then((response) => {
            console.log(response.data);
          })
          .catch((error) => {
            console.log("error", error);
          });
      }
    },

    createAddressEmail() {
      for (let email of this.emails) {
        let param = {
          email: email.email,
        };
        _Form
          .createAddressEmail(param)
          .then((response) => {
            console.log(response.data);
          })
          .catch((error) => {
            console.log("error", error);
          });
      }
    },

    createSendPhysicalDocuments() {
      const document = this.SendPhysicalDocuments[0];

      let otherSendingPacking;
      if (document.otherSendingPacking == false) {
        otherSendingPacking = " - ";
      } else if (document.otherSendingPacking == true) {
        otherSendingPacking = this.textFieldValueOtherSendingPacking;
      }

      let param = {
        bill: document.bill ? 1 : 0,
        originalCertificate: document.originalCertificate ? 1 : 0,
        packingList: document.packingList ? 1 : 0,
        phytosanitaryCentificate: document.phytosanitaryCertificate ? 1 : 0,
        Other: otherSendingPacking,
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

    onFileChange(event) {
      this.phytoExportSENASA = event.target.files[0];
    },

    createFormFinal() {
      let formData = new FormData();
      formData.append("file", this.phytoExportSENASA);

      _Form
        .uploadFile(formData)
        .then((response) => {
          let filePath = response.data.filePath;
          this.createForm(filePath);
        })
        .catch((error) => {
          console.log("error", error);
        });
    },

    createForm(filePath) {
      //VALIDACIONES
      let billName;
      if (this.billNameSelectedOption === "Misma del consignatario") {
        billName = this.nameConsignee;
      } else if (this.billNameSelectedOption === "Otra (Detallar)") {
        billName = this.billNameCustomOption;
      }

      let billDirection;
      if (this.billDirectionSelectedOption === "Misma del consignatario") {
        billDirection = this.directionConsignee;
      } else if (this.billDirectionSelectedOption === "Otra (Detallar)") {
        billDirection = this.billDirectionCustomOption;
      }

      let billInfoAdd;
      if (this.checkBoxValueInfoBill == false) {
        billInfoAdd = "No se agrego información adicional para la factura";
      } else if (this.checkBoxValueInfoBill == true) {
        billInfoAdd = this.textFieldValueInfoBill;
      }

      let phytoName;
      if (this.phytoNameSelectedOption === "Misma del consignatario") {
        phytoName = this.nameConsignee;
      } else if (this.phytoNameSelectedOption === "Otra (Detallar)") {
        phytoName = this.phytoNameCustomOption;
      }

      let phytoAddress;
      if (this.phytoAddressSelectedOption === "Misma del consignatario") {
        phytoAddress = this.directionConsignee;
      } else if (this.phytoAddressSelectedOption === "Otra (Detallar)") {
        phytoAddress = this.phytoAddressCustomOption;
      }

      //
      let isAllowedPhyto;
      if (this.isAllowedPhyto == false) {
        isAllowedPhyto = 0;
      } else if (this.isAllowedPhyto == true) {
        isAllowedPhyto = 1;
      }

      let phytoInfoAdd;
      if (this.phytoInfoAdd == false) {
        phytoInfoAdd = "No se agrego glosa adicional en el FitoSanitario";
      } else if (this.phytoInfoAdd == true) {
        phytoInfoAdd = this.textFieldValuePhytoInfoAdd;
      }

      //certificaciones de origen

      let certificateNameOrigin;
      if (
        this.certificateNameOriginSelectedOption === "Misma del consignatario"
      ) {
        certificateNameOrigin = this.nameConsignee;
      } else if (
        this.certificateNameOriginSelectedOption === "Otra (Detallar)"
      ) {
        certificateNameOrigin = this.certificateNameOriginCustomOption;
      }

      let certificateAddressOrigin;
      if (
        this.certificateAddressOriginSelectedOption ===
        "Misma del consignatario"
      ) {
        certificateAddressOrigin = this.directionConsignee;
      } else if (
        this.certificateAddressOriginSelectedOption === "Otra (Detallar)"
      ) {
        certificateAddressOrigin = this.certificateAddressOriginCustomOption;
      }

      let certificateInfoAdd;
      if (this.certificateInfoAdd == false) {
        certificateInfoAdd =
          "No se agrego glosa adicional en el Certificado de Origen";
      } else if (this.certificateInfoAdd == true) {
        certificateInfoAdd = this.textFieldValuePhytoInfoAdd;
      }

      this.createDataNotifier();

      //direccion envio
      let isConsigneeSendDoc;
      let isNotifierSendDoc;
      if (
        this.isConsigneeSendDoc == false &&
        this.isOtherSendDoc == true &&
        this.isNotifierSendDoc == false
      ) {
        isConsigneeSendDoc = null;
        isNotifierSendDoc = null;
      } else if (
        this.isConsigneeSendDoc == true &&
        this.isOtherSendDoc == false &&
        this.isNotifierSendDoc == false
      ) {
        isConsigneeSendDoc = this.directionConsignee;
        isNotifierSendDoc = null;
      } else if (
        this.isConsigneeSendDoc == false &&
        this.isOtherSendDoc == false &&
        this.isNotifierSendDoc == true
      ) {
        console.log("DIRECCION DEL NOTIFIER ", this.selectedNotifierAddress);
        isConsigneeSendDoc = null;
        isNotifierSendDoc = this.selectedNotifierAddress;
      }

      let isSendScanning;
      if (this.isSendScanning == false && this.isSendPhysicalDocument == true) {
        isSendScanning = 0;
      } else if (
        this.isSendScanning == true &&
        this.isSendPhysicalDocument == false
      ) {
        isSendScanning = 1;
      }

      try {
        if (this.selectedCountryField) {
          this.createCountry();
        }
        if (this.selectedPortField) {
          this.createPort();
        }
        if (this.selectedPortFinalField) {
          this.createPortFinal();
        }

        if (this.nameConsignee) {
          this.createDataConsignee();
        }

        if (this.isSendPhysicalDocument) {
          this.createSendPhysicalDocuments();
        }

        console.log("nameNotifier value:", this.nameNotifier);

        this.createRequiredDocument();
        this.createAddressOriginalsDoc();
        this.createAddressEmail();

        let param = {
          idClient: "CL000712244593",
          nameClient: this.clientName,
          CountryName: this.idCountry,
          DestinationPort: this.destinationPort,
          DestinationFinal: this.destinationFinal,
          BillName: billName,
          BillAddress: billDirection,
          BillInfoAdd: billInfoAdd,
          FreightPayer: this.freigthPayer,
          PlacePayment: this.placePayment,
          emissionType: this.emissionType,
          FreightPayerInfoAdd: this.freightPayerInfoAdd,
          BLDataInfoAdd: this.BLInfoAdd,
          IsAllowedPhyto: isAllowedPhyto,
          PhytoName: phytoName,
          PhytoAddress: phytoAddress,
          PhytoCountryPort: this.phytoCountryPort,
          PhytoInfoAdd: phytoInfoAdd,
          PhytoTransitCountry: this.phytoTransitCountry,
          PhytoExportSENASA: filePath,
          CertificateNameOrigin: certificateNameOrigin,
          CertificateAddressOrigin: certificateAddressOrigin,
          CertificateInfoAdd: certificateInfoAdd,
          isConsigneeSendDoc: isConsigneeSendDoc,
          isNotifierSendDoc: isNotifierSendDoc,
          IsSendScanning: isSendScanning,
        };

        // Usa 'param' aquí para lo que necesites
        console.log("prueba" + param.PhytoExportSENASA);
        console.log("CountryName " + param.CountryName);
        console.log("emissionType " + param.emissionType);
        _Form
          .createForm(param)
          .then((response) => {
            console.log(response.data);
            if (
              response.data &&
              (response.data.status === "success" ||
                response.data.status === true)
            ) {
              this.$nextTick(() => {
                // Schedule navigation after next rendering cycle
                this.$router.push("/thanks");
              });
            }
          })
          .catch((error) => {
            console.log("error", error);
          });
      } catch (error) {
        console.log("Error in createForm process", error);
      }
    },
  },

  mounted() {
    this.activeTab = "tab1-1";
    this.getFormCountryES();
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap");

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Ubuntu";
}

.text-red {
  color: rgb(241, 87, 87);
}

.v-tabs {
  width: 100%;
}

.label-warn {
  display: flex;
  width: 100%;
  justify-content: space-between;
}

.custom-combobox .v-input__append-inner {
  top: 50%;
  transform: translateY(-50%);
}
.v-input__details {
  display: none;
}
.tab-selected {
  background-color: rgb(239, 247, 229);
  border-radius: 2rem;
}
.reqDocPhy {
  margin-top: -1rem;
  margin-left: 2rem;
}
</style>
