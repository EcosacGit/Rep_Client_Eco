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
        {{ $t("form.title") }}
      </h2>
      <v-switch
        style="font-weight: bold; color: black"
        v-model="locale"
        :label="locale.toUpperCase()"
        false-value="es"
        true-value="en"
        hide-details
        @click="switchLocale(locale === 'en' ? 'es' : 'en')"
        color="success"
      ></v-switch>
    </div>
    <v-card elevation="0" flat dense outlined rounded class="mt-1 mb-1">
      <v-card-text>
        <v-container class="mb-4">
          <v-form ref="miFormulario" v-model="isFormValid" lazy-validation>
            <v-row>
              <v-col cols="12" class="s-col-form">
                <label class="label-field">{{ $t("form.nameClient") }}</label>
                <v-text-field
                  outlined
                  color="success"
                  v-model="clientName"
                  readonly
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">{{ $t("form.country") }}</label>
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
                      :placeholder="$t('form.messageCountry')"
                    >
                    </v-combobox>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">{{
                    $t("form.puertoDestino")
                  }}</label>
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
                      :placeholder="$t('form.messagePuertoDestino')"
                    >
                    </v-combobox>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="4" class="s-col-form">
                <div class="label-warn">
                  <label class="label-field">{{
                    $t("form.puertoFinal")
                  }}</label>
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
                      :placeholder="$t('form.messageDestinoFinal')"
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
                  >{{ $t("form.alert") }} {{ $t("form.country") }}</small
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
                  >{{ $t("form.alert") }} {{ $t("form.puertoDestino") }}</small
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
                  >{{ $t("form.alert") }} {{ $t("form.puertoFinal") }}</small
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
            >{{ $t("form.factura") }}</v-tab
          >
          <v-tab
            @click="activateTab('tab1-2')"
            href="#tab1-2"
            :class="{ 'tab-selected': activeTab === 'tab1-2' }"
            >{{ $t("form.embarque") }}</v-tab
          >
          <v-tab
            @click="activateTab('tab1-3')"
            href="#tab1-3"
            :class="{ 'tab-selected': activeTab === 'tab1-3' }"
            >{{ $t("form.certificado") }}</v-tab
          >
          <v-tab
            @click="activateTab('tab1-4')"
            href="#tab1-4"
            :class="{ 'tab-selected': activeTab === 'tab1-4' }"
            >{{ $t("form.direccion") }}</v-tab
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
                    <label class="label-field">{{ $t("form.billName") }}</label>
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
                    v-if="
                      billNameSelectedOption == 'Otra (Detallar)' ||
                      billNameSelectedOption == 'Other (Describe)'
                    "
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
                    <label class="label-field">{{
                      $t("form.billAddress")
                    }}</label>
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
                    v-if="
                      billDirectionSelectedOption === 'Otra (Detallar)' ||
                      billDirectionSelectedOption === 'Other (Describe)'
                    "
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
                    <label class="label-field">{{ $t("form.billInfo") }}</label>
                    <v-checkbox
                      class="mt-2"
                      v-model="checkBoxValueInfoBill"
                      :label="$t('form.addInforBill')"
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
                    <label class="label-field">{{
                      $t("form.pagadorFlete")
                    }}</label>
                    <v-text-field
                      outlined
                      color="success"
                      v-model="freigthPayer"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="6" class="s-col-form">
                    <label class="label-field">{{
                      $t("form.lugarPago")
                    }}</label>
                    <v-text-field
                      outlined
                      color="success"
                      v-model="placePayment"
                    ></v-text-field>
                  </v-col>
                </v-row>

                <v-row>
                  <cols cols="4" class="s-col-form">
                    <label class="label-field">{{
                      $t("form.tipoEmision")
                    }}</label>
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
                      :label="$t('form.originalBL')"
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
                    <label class="label-field">{{
                      $t("form.espeAdicionales")
                    }}</label>
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
                      ><label style="color: red; font-weight: bold">{{
                        $t("form.consigneeInfo")
                      }}</label></v-col
                    >
                  </v-row>
                  <v-row>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.consigneeInfo")
                      }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="nameConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.direccionConsignee")
                      }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="directionConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.telefono1")
                      }}</label>
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
                      <label class="label-field">{{
                        $t("form.telefono2")
                      }}</label>
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
                      <label class="label-field">{{
                        $t("form.contactPerson")
                      }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="contactPersonConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">{{ $t("form.taxID") }}</label>
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
                      <label class="label-field">{{ $t("form.email") }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="emailConsignee"
                        required
                      ></v-text-field>
                    </v-col>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.website")
                      }}</label>
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
                          >{{ $t("form.notifierInfo") }} {{ index + 1 }}</label
                        ></v-col
                      >
                    </v-row>
                    <v-row>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field"
                          >{{ $t("form.nameNotifier") }} {{ index + 1 }}</label
                        >
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.nameNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field"
                          >{{ $t("form.direccionConsignee") }}
                        </label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.directionNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.telefono1")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.telefono2")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.contactPerson")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.contactPersonNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.taxID")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.email")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="notifier.emailNotifier"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.website")
                        }}</label>
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
                    {{ $t("form.botonNotificante") }}
                  </v-btn>
                </div>
                <v-row>
                  <v-col cols="12" class="mt-6 s-col-form">
                    <label class="label-field">{{ $t("form.infoBL") }}</label>
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

                <div class="mt-4 phytoPart">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >{{ $t("form.phytoCertificado") }}
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-1">
                    <v-col cols="12" class="s-col-form">
                      <v-checkbox
                        v-model="isAllowedPhyto"
                        :label="$t('form.isAllowedPhyto')"
                      ></v-checkbox>
                    </v-col>
                  </v-row>

                  <v-row class="mt-5">
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field"
                        >{{ $t("form.phytoName") }}
                      </label>
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
                      v-if="
                        phytoNameSelectedOption === 'Otra (Detallar)' ||
                        phytoNameSelectedOption === 'Other (Describe)'
                      "
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
                      <label class="label-field"
                        >{{ $t("form.phytoAddress") }}
                      </label>
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
                      v-if="
                        phytoAddressSelectedOption === 'Otra (Detallar)' ||
                        phytoAddressSelectedOption === 'Other (Describe)'
                      "
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
                      <label class="label-field">{{
                        $t("form.phytoPuerto")
                      }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoCountryPort"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.phytoDestino")
                      }}</label>
                      <v-text-field
                        outlined
                        color="success"
                        v-model="phytoTransitCountry"
                      ></v-text-field>
                    </v-col>
                  </v-row>

                  <v-row>
                    <v-col cols="6" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.infoPhyto")
                      }}</label>
                      <v-checkbox
                        v-model="phytoInfoAdd"
                        :label="$t('form.phytoInfoAdd')"
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
                      <label class="label-field">{{
                        $t("form.reExport")
                      }}</label>
                      <v-file-input
                        v-model="phytoExportSENASA"
                        :label="$t('form.senasa')"
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
                        >{{ $t("form.certOrigen") }}
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-2">
                    <v-col cols="4" class="s-col-form">
                      <label class="label-field">{{
                        $t("form.certName")
                      }}</label>
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
                          'Otra (Detallar)' ||
                        certificateNameOriginSelectedOption ===
                          'Other (Describe)'
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
                      <label class="label-field">{{
                        $t("form.certAddress")
                      }}</label>
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
                          'Otra (Detallar)' ||
                        certificateAddressOriginSelectedOption ===
                          'Other (Describe)'
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
                      <label class="label-field">{{
                        $t("form.certInfo")
                      }}</label>
                      <v-checkbox
                        v-model="certificateInfoAdd"
                        :label="$t('form.infoLabelCert')"
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
                        >{{ $t("form.certQuality") }}
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-2">
                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="packingList"
                        :label="$t('form.packingList')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="plasticStatement"
                        :label="$t('form.plasticStatement')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="INVIMA"
                        :label="$t('form.INVIMA')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="FDA"
                        :label="$t('form.FDA')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="PPQ"
                        :label="$t('form.PPQ')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="ColdTreatment"
                        :label="$t('form.ColdTreatment')"
                        class="mt-n1"
                      ></v-checkbox>
                    </v-col>

                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="InspectionFormat"
                        :label="$t('form.InspectionFormat')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="MicrobioAnalysis"
                        :label="$t('form.MicrobioAnalysis')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="InsuranceCertificate"
                        :label="$t('form.InsuranceCertificate')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="DAM"
                        :label="$t('form.DAM')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="QualityReport"
                        :label="$t('form.QualityReport')"
                        class="mt-n1"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="OtherCert"
                        :label="$t('form.OtherCert')"
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
                        >{{ $t("form.addressSend") }}
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-1">
                    <v-col cols="6" class="s-col-form">
                      <v-checkbox
                        v-model="isConsigneeSendDoc"
                        :label="$t('form.consigneSend')"
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
                          :label="$t('form.notifierSend')"
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
                        :label="$t('form.OtherCert')"
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
                        <label class="label-field">{{
                          $t("form.otherSendName")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.nameCompany"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.otherSendAddress")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.addressCompany"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.otherSendTel")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.contactPerson")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.contactPerson"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.taxID")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.email")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.emailAddress"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.otherSendCountry")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.country"
                          required
                        ></v-text-field>
                      </v-col>
                      <v-col cols="4" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.otherSendCity")
                        }}</label>
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
                        <label class="label-field">{{
                          $t("form.otherSendState")
                        }}</label>
                        <v-text-field
                          outlined
                          color="success"
                          v-model="otherSend.state_city"
                        ></v-text-field>
                      </v-col>
                      <v-col cols="6" class="s-col-form">
                        <label class="label-field">{{
                          $t("form.otherSendPostalCode")
                        }}</label>
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
                        >{{ $t("form.emailAddress") }}
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
                      <label class="label-field">{{ $t("form.email") }}</label>
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
                  {{ $t("form.emailAddressButton") }}
                </v-btn>

                <v-row class="mt-5">
                  <v-divider color="success"></v-divider>
                </v-row>

                <div class="mt-5">
                  <v-row>
                    <v-col
                      ><label style="color: red; font-weight: bold"
                        >{{ $t("form.sendChoice") }}
                      </label></v-col
                    >
                  </v-row>
                  <v-row class="mt-1">
                    <v-col cols="12" class="s-col-form">
                      <v-checkbox
                        v-model="isSendScanning"
                        :label="$t('form.scanningDoc')"
                        @change="handleCheckboxSendDocs('isSendScanning')"
                      ></v-checkbox>
                      <v-checkbox
                        v-model="isSendPhysicalDocument"
                        :label="$t('form.nextDoc')"
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
                          :label="$t('form.invoiceCheck')"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.originalCertificate"
                          :label="$t('form.originCheck')"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.packingList"
                          :label="$t('form.packingCheck')"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="
                            isSendPhysicalDocument.phytosanitaryCertificate
                          "
                          :label="$t('form.phytoDataCheck')"
                          class="mt-n1"
                        ></v-checkbox>
                        <v-checkbox
                          v-model="isSendPhysicalDocument.otherSendingPacking"
                          :label="$t('form.otherCheck')"
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
            color="green darker -2"
            class="mt-2 ml-auto"
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

import { computed } from "vue";
import { useI18n } from "vue-i18n";

import Swal from "sweetalert2";

import "@mdi/font/css/materialdesignicons.min.css";

export default {
  setup() {
    const { locale, t } = useI18n();
    const switchLocale = (lang) => {
      locale.value = lang;
    };

    const commonOptions = computed(() => {
      if (locale.value === "en") {
        return ["Same as the consignee", "Other (Describe)"];
      } else {
        return ["Misma del Consignatario", "Otra (Detallar)"];
      }
    });

    return {
      switchLocale,
      commonOptions,
    };
  },
  computed: {
    billNameOptions() {
      return this.commonOptions;
    },
    billDirectionOptions() {
      return this.commonOptions;
    },
    phytoNameOptions() {
      return this.commonOptions;
    },
    phytoAddressOptions() {
      return this.commonOptions;
    },

    certificateNameOriginOptions() {
      return this.commonOptions;
    },
    certificateAddressOriginOptions() {
      return this.commonOptions;
    },
  },
  data() {
    return {
      //active tab
      activeTab: "tab1-1",

      //NOMBRE FACTURA
      billNameSelectedOption: null,
      billNameCustomOption: "",

      //DIRECCION FACTURA
      billDirectionSelectedOption: null,
      billDirectionCustomOption: "",

      phytoNameSelectedOption: null,
      phytoNameCustomOption: "",

      phytoAddressSelectedOption: null,
      phytoAddressCustomOption: "",

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

      itemsNotifierSendDoc: [],

      certificateAddressOriginSelectedOption: null,
      certificateAddressOriginCustomOption: "",

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
      emailAdded: false,

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

      locale: "es",

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
      idClient: "",
    };
  },

  created() {
    this.getClientData();
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
      if (
        this.billNameSelectedOption == "Otra (Detallar)" ||
        this.billNameSelectedOption == "Other (Describe)"
      ) {
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
      this.emailAdded = true; // Actualiza la bandera
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

    getClientData() {
      let param = {
        bspCardCode: "CE00000000127",
      };
      _Form
        .showBusinessPartners(param)
        .then((response) => {
          let data = response.data;

          console.log("Respuesta: " + JSON.stringify(data));
          console.log("Respuesta: " + data[0].BspCardName);
          this.clientName = data[0].BspCardName;
          this.idClient = data[0].BspCardCode;
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
      let billName;
      console.log("NAME BILL: ", this.billNameSelectedOption);
      if (
        this.billNameSelectedOption === "Misma del Consignatario" ||
        this.billNameSelectedOption === "Same as the consignee"
      ) {
        billName = this.nameConsignee;
      } else if (
        this.billNameSelectedOption === "Otra (Detallar)" ||
        this.billNameSelectedOption === "Other (Describe)"
      ) {
        billName = this.billNameCustomOption;
      }

      let billDirection;
      if (
        this.billDirectionSelectedOption === "Misma del Consignatario" ||
        this.billDirectionSelectedOption === "Same as the consignee"
      ) {
        billDirection = this.directionConsignee;
      } else if (
        this.billDirectionSelectedOption === "Otra (Detallar)" ||
        this.billDirectionSelectedOption === "Other (Describe)"
      ) {
        billDirection = this.billDirectionCustomOption;
      }

      let billInfoAdd;
      if (this.checkBoxValueInfoBill == false) {
        billInfoAdd = "No se agrego información adicional para la factura";
      } else if (this.checkBoxValueInfoBill == true) {
        billInfoAdd = this.textFieldValueInfoBill;
      }

      let phytoName;
      if (
        this.phytoNameSelectedOption === "Misma del Consignatario" ||
        this.phytoNameSelectedOption === "Same as the consignee"
      ) {
        phytoName = this.nameConsignee;
      } else if (
        this.phytoNameSelectedOption === "Otra (Detallar)" ||
        this.phytoNameSelectedOption === "Other (Describe)"
      ) {
        phytoName = this.phytoNameCustomOption;
      }

      let phytoAddress;
      if (
        this.phytoAddressSelectedOption === "Misma del Consignatario" ||
        this.phytoAddressSelectedOption === "Same as the consignee"
      ) {
        phytoAddress = this.directionConsignee;
      } else if (
        this.phytoAddressSelectedOption === "Otra (Detallar)" ||
        this.phytoAddressSelectedOption === "Other (Describe)"
      ) {
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
        this.certificateNameOriginSelectedOption ===
          "Misma del Consignatario" ||
        this.certificateNameOriginSelectedOption === "Same as the consignee"
      ) {
        certificateNameOrigin = this.nameConsignee;
      } else if (
        this.certificateNameOriginSelectedOption === "Otra (Detallar)" ||
        this.certificateNameOriginSelectedOption === "Other (Describe)"
      ) {
        certificateNameOrigin = this.certificateNameOriginCustomOption;
      }

      let certificateAddressOrigin;
      if (
        this.certificateAddressOriginSelectedOption ===
          "Misma del Consignatario" ||
        this.certificateAddressOriginSelectedOption === "Same as the consignee"
      ) {
        certificateAddressOrigin = this.directionConsignee;
      } else if (
        this.certificateAddressOriginSelectedOption === "Otra (Detallar)" ||
        this.certificateAddressOriginSelectedOption === "Other (Describe)"
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

      //VALIDACIONES SWAL

      //validation
      const isCountryValid =
        this.selectedCountry || this.selectedCountryField.trim();
      const isPortValid = this.selectedPort || this.selectedPortField.trim();
      const isPortFinalValid =
        this.selectedPortFinal || this.selectedPortFinalField.trim();

      // Construir el mensaje personalizado
      let message = this.$t("form.swal");
      let messageWarning = this.$t("form.swal3");

      if (!isCountryValid) {
        message += this.$t("form.country") + " || ";
      }
      if (!isPortValid) {
        message += this.$t("form.puertoDestino") + " || ";
      }
      if (!isPortFinalValid) {
        message += this.$t("form.puertoFinal") + " || ";
      }
      if (billName == undefined) {
        message += this.$t("form.billName") + " || ";
      }
      if (billDirection == undefined) {
        message += this.$t("form.billAddress") + " || ";
      }
      if (this.freigthPayer == "") {
        message += this.$t("form.pagadorFlete") + " || ";
      }
      if (this.placePayment == "") {
        message += this.$t("form.lugarPago") + " || ";
      }
      if (this.emissionType == "") {
        message += this.$t("form.tipoEmision") + " || ";
      }
      if (phytoName == undefined) {
        message += this.$t("form.phytoName") + " || ";
      }
      if (phytoAddress == undefined) {
        message += this.$t("form.phytoAddress") + " || ";
      }
      if (this.phytoCountryPort == "") {
        message += this.$t("form.phytoPuerto") + " || ";
      }
      if (this.phytoTransitCountry == "") {
        message += this.$t("form.phytoDestino") + " || ";
      }

      if (certificateNameOrigin == undefined) {
        message += this.$t("form.certName") + " || ";
      }
      if (certificateAddressOrigin == undefined) {
        message += this.$t("form.certAddress") + " || ";
      }

      let certQualityValidation =
        this.packingList == false &&
        this.plasticStatement == false &&
        this.INVIMA == false &&
        this.FDA == false &&
        this.PPQ == false &&
        this.ColdTreatment == false &&
        this.InspectionFormat == false &&
        this.MicrobioAnalysis == false &&
        this.InsuranceCertificate == false &&
        this.DAM == false &&
        this.QualityReport == false &&
        this.OtherCert == false;

      if (certQualityValidation) {
        message += this.$t("form.certQuality") + " || ";
      }

      let addressSend =
        this.isConsigneeSendDoc == false &&
        this.isNotifierSendDoc == false &&
        this.isOtherSendDoc == false;

      if (addressSend) {
        message += this.$t("form.addressSend") + " || ";
      }

      let sendDocs =
        this.isSendScanning == false && this.isSendPhysicalDocument == false;

      if (sendDocs) {
        message += this.$t("form.sendChoice") + " || ";
      }

      //consignatario data!!!!!
      let consigneeValidation =
        this.nameConsignee == "" ||
        this.directionConsignee == "" ||
        this.telf1Consignee == "" ||
        this.telf2Consignee == "" ||
        this.faxConsignee == "" ||
        this.contactPersonConsignee == "" ||
        this.emailConsignee == "";

      // Add EORIConsignee validation if showEORIField is true
      if (this.showEORIField) {
        consigneeValidation = consigneeValidation || this.EORIConsignee == "";
        if (this.EORIConsignee == "") {
          message += "EORI Consignee || ";
        }
      }

      if (consigneeValidation) {
        message += this.$t("form.consigneeInfo") + " || ";
      }

      //validar envio de correo
      let emailValidation = false;
      if (Array.isArray(this.emails)) {
        const emailObject = this.emails.some(
          (item) => typeof item === "object" && item !== null
        );

        if (emailObject) {
          emailValidation = this.emails.some((item) => item.email == "");
          if (emailValidation) {
            message += this.$t("form.emailAddress") + " || ";
          }
        }
      }

      let notifierValidation = false;
      //validación Notifier
      if (Array.isArray(this.notifiers)) {
        const notifierObject = this.notifiers.some(
          (item) => typeof item === "object" && item !== null
        );

        if (notifierObject) {
          notifierValidation = this.notifiers.some(
            (item) =>
              item.nameNotifier == "" ||
              item.directionNotifier == "" ||
              item.telf1Notifier == "" ||
              item.telf2Notifier == "" ||
              item.faxNotifier == "" ||
              item.contactPersonNotifier == "" ||
              item.emailNotifier == ""
          );

          if (this.showEORIField) {
            notifierValidation =
              notifierValidation ||
              this.notifiers.some((item) => item.EORINotifier == "");
            if (this.notifiers.some((item) => item.EORINotifier == "")) {
              message += "EORI Notifier || ";
            }
          }
          console.log("NOTIFIERS contains an object");

          if (notifierValidation) {
            message += this.$t("form.notifierInfo") + " || ";
          }
        } else {
          console.log("NOTIFIERS does not contain an object");
        }
      } else {
        console.log("NOTIFIERS is not an array");
      }

      let errorCount = 0;
      if (!isCountryValid) errorCount++;
      if (!isPortValid) errorCount++;
      if (!isPortFinalValid) errorCount++;
      if (billName == undefined) errorCount++;
      if (billDirection == undefined) errorCount++;
      if (this.freigthPayer == "") errorCount++;
      if (this.placePayment == "") errorCount++;
      if (this.emissionType == "") errorCount++;
      if (consigneeValidation) errorCount++;
      if (notifierValidation) errorCount++;
      if (phytoName == undefined) errorCount++;
      if (phytoAddress == undefined) errorCount++;
      if (this.phytoCountryPort == "") errorCount++;
      if (this.phytoTransitCountry == "") errorCount++;
      if (certificateNameOrigin == undefined) errorCount++;
      if (certificateAddressOrigin == undefined) errorCount++;
      if (certQualityValidation) errorCount++;
      if (addressSend) errorCount++;
      if (sendDocs) errorCount++;
      if (emailValidation) errorCount++;

      // Mostrar SweetAlert si hay más de 5 condiciones que no se cumplen
      if (errorCount > 3) {
        Swal.fire({
          title: "Oops...",
          text: "Por favor, llene el formulario correctamente",
          icon: "error",
          showConfirmButton: false,
          timer: 3000,
          width: "400px",
          timerProgressBar: true,
        });
        return false; // Evita el envío del formulario
      } else if (
        !isCountryValid ||
        !isPortValid ||
        !isPortFinalValid ||
        billName == undefined ||
        billDirection == undefined ||
        this.freigthPayer == "" ||
        this.placePayment == "" ||
        this.emissionType == "" ||
        consigneeValidation ||
        notifierValidation ||
        phytoName == undefined ||
        phytoAddress == undefined ||
        this.phytoCountryPort == "" ||
        this.phytoTransitCountry == "" ||
        certificateNameOrigin == undefined ||
        certificateAddressOrigin == undefined ||
        certQualityValidation ||
        addressSend ||
        sendDocs ||
        emailValidation
      ) {
        Swal.fire({
          title: "Oops...",
          text: message,
          icon: "error",
          showConfirmButton: false,
          timer: 3000,
          width: "400px", // Ajusta el ancho según tus necesidades
          timerProgressBar: true,
        });
        return false; // Evita el envío del formulario
      }

      if (!this.emailAdded) {
        Swal.fire({
          title: "Oops...",
          text: "Por favor, añada su dirección de correo electrónico",
          icon: "error",
          showConfirmButton: false,
          timer: 3000,
          width: "400px",
          timerProgressBar: true,
        });
        return false; // Evita el envío del formulario
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

        if (this.isSendPhysicalDocument) {
          this.createSendPhysicalDocuments();
        }

        this.createDataConsignee();
        this.createDataNotifier();

        if (this.freightPayerInfoAdd == null) {
          this.freightPayerInfoAdd =
            "No se agrego información adicional respecto al pago flete";
        }

        console.log("nameNotifier value:", this.nameNotifier);

        this.createRequiredDocument();
        this.createAddressOriginalsDoc();
        this.createAddressEmail();

        let param = {
          idClient: this.idClient,
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
        console.log("BILLNAME" + param.BillName);
        console.log("TEST ", this.destinationFinal);
        console.log("pago ", param.FreightPayer);

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
