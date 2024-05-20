<template>
  <v-container class="fill-height" fluid>
    <v-row justify="center" align="center">
      <v-col cols="12" md="6">
        <v-card class="elevation-12">
          <v-card-title class="headline text-center">
            Thank You for Submitting the Form!
          </v-card-title>
          <v-card-text class="text-center">
            <v-icon color="green" large>mdi-check-circle</v-icon>
            <p class="subtitle-1 mt-2">
              We appreciate your time and effort. Your submission has been
              received successfully.
            </p>
          </v-card-text>
          <v-card-actions class="justify-center">
            <v-btn style="color: black" @click="goHome">Go to Home</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  methods: {
    goHome() {
      this.$router.push("/");
    },
  },
};
</script>

<style scoped>
.fill-height {
  min-height: 100vh;
}

.v-card {
  background: linear-gradient(45deg, #def1c1, #daf1b7);
  color: black;
}

.v-card-title,
.v-card-text,
.v-card-actions {
  color: black !important;
}
</style>
