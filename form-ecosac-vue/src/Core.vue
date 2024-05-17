<template>
  <v-app class="app scroll">
    <router-view></router-view>
  </v-app>
</template>

<script>
import Form from "./views/Form.vue";
import RedirectPage from "./views/RedirectPage.vue";
export default {
  name: "App",
  data: () => ({
    timeInactiveShow: 0,
  }),

  components: {
    Form,
    RedirectPage,
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap");

* {
  font-family: "Ubuntu";
}
</style>
