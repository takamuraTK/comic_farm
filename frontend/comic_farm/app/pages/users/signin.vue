<template>
  <div class="flex flex-col items-center">
    <h2 class="font-bold text-lg m-3">Sign In</h2>
    <div
      class="bg-gray-500 shadow-md rounded px-8 pt-6 pb-8 mb-4 flex flex-col w-1/2"
    >
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
          v-model="email"
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
          v-model="password"
        />
      </div>
      <div class="flex items-center justify-between">
        <button
          class="bg-gray-900 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded"
          type="button"
          @click="loginWithAuthModule"
        >
          ログイン
        </button>
        <a
          class="inline-block align-baseline font-bold text-sm text-blue hover:text-blue-darker"
          href="#"
        >
          パスワードを忘れた場合
        </a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      password: ""
    };
  },
  methods: {
    async loginWithAuthModule() {
      await this.$auth
        .loginWith("local", {
          data: {
            email: this.email,
            password: this.password
          }
        })
        .then(
          response => {
            console.log(response);
            return response;
          },
          error => {
            return error;
          }
        );
    }
  }
};
</script>

<style></style>
