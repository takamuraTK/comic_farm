<template>
  <div>
    {{ this.result }}
  </div>
</template>

<script>
export default {
  props: ["token"],
  data() {
    return {
      result: ""
    };
  },
  async mounted() {
    this.$axios
      .$get("http://localhost:3000/v1/auth/confirmation/", {
        params: {
          confirmation_token: this.token
        }
      })
      .then(
        response => {
          this.result = "登録に成功しました。";
        },
        error => {
          this.result = "認証トークンが不正な値です。";
        }
      );
  }
};
</script>
