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
      title: "Form Title",
      name: "Name",
      email: "Email",
      submit: "Submit",
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
      title: "Título del Formulario",
      name: "Nombre",
      email: "Correo Electrónico",
      submit: "Enviar",
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

createApp(Core).use(vuetify).use(i18n).use(router).mount("#app");
