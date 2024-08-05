<template>
  <v-app class="app scroll">
    <router-view
      style="
        width: 90%;
        margin: 0 auto;
        background-color: rgb(255, 255, 255);
        border-radius: 1rem;
      "
      class="mt-4 mb-4"
    ></router-view>
  </v-app>
</template>

<script>
import Form from "./views/Form.vue";
import RedirectPage from "./views/RedirectPage.vue";
import FormUpdate from "./views/FormUpdate.vue";
export default {
  name: "App",
  data: () => ({
    timeInactiveShow: 0,
  }),

  components: {
    Form,
    FormUpdate,
    RedirectPage,
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap");

* {
  font-family: "Ubuntu";
}
.v-application,
.app,
.scroll {
  background-color: rgb(248, 248, 247);
}
</style>
