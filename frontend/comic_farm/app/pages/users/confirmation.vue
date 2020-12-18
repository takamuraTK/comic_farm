<template>
  <div v-if="$route.query.confirmation_token">
    <CheckConfirmation :token="$route.query.confirmation_token" />
  </div>
  <div class="flex flex-col items-center" v-else>
    <p>ご登録いただいたメールアドレスに認証用のメールを送信いたしました。</p>
    <button class="underline" @click="reSendEmail">メールを再送する</button>
    <p>{{ this.reSendResult }}</p>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import CheckConfirmation from "~/components/CheckConfirmation.vue";

export default {
  auth: false,
  components: {
    CheckConfirmation
  },
  data() {
    return {
      reSendResult: ""
    };
  },
  computed: {
    ...mapGetters({
      registerEmail: "register/registerEmail"
    })
  },
  methods: {
    reSendEmail() {
      this.$axios
        .post("/auth/confirmation", {
          email: this.registerEmail
        })
        .then(
          response => {
            this.reSendResult == "メールを再送しました。";
          },
          error => {
            this.reSendResult == "メールの再送に失敗しました。";
          }
        );
    }
  }
};
</script>

<style></style>
