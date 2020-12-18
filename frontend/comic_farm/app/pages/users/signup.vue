<template>
  <div class="flex flex-col items-center">
    <h2 class="font-bold text-lg m-3">Sign Up</h2>
    <div
      class="bg-gray-500 shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col w-1/2"
    >
      <div class="mb-4">
        <label
          class="block text-grey-darker text-sm font-bold mb-2"
          for="username"
        >
          ユーザー名
        </label>
        <input
          class="shadow appearance-none border rounded py-2 px-3 text-grey-darker w-full"
          id="username"
          type="text"
          placeholder="UserName"
          v-model="user.name"
        />
      </div>
      <div class="mb-4">
        <label
          class="block text-grey-darker text-sm font-bold mb-2"
          for="email"
        >
          メールアドレス
        </label>
        <input
          class="shadow appearance-none border rounded py-2 px-3 text-grey-darker w-full"
          id="email"
          type="text"
          placeholder="Email"
          v-model="user.email"
        />
      </div>
      <div class="mb-6">
        <label
          class="block text-grey-darker text-sm font-bold mb-2"
          for="password"
        >
          パスワード
        </label>
        <input
          class="shadow appearance-none border border-red rounded py-2 px-3 text-grey-darker mb-3 w-full"
          id="password"
          type="password"
          placeholder="******************"
          v-model="user.password"
        />
      </div>

      <div class="flex items-center justify-between">
        <button
          class="bg-gray-900 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded"
          type="button"
          @click="signUp"
        >
          登録
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  auth: false,
  data() {
    return {
      user: {
        name: "",
        email: "",
        password: ""
      }
    };
  },
  methods: {
    signUp() {
      this.$store.commit("register/setRegisterEmail", this.user.email);
      this.$axios.post("/auth", this.user).then(response => {
        window.location.href = "/users/confirmation";
      });
    }
  }
};
</script>

<style></style>
