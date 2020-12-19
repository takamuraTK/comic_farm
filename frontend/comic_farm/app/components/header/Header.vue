<template>
  <div>
    <nav
      class="bg-gray-800 pt-2 md:pt-1 pb-1 px-1 mt-0 h-auto fixed w-full z-20 top-0"
    >
      <div class="flex flex-wrap items-center">
        <div
          class="flex flex-shrink md:w-1/3 justify-center md:justify-start text-white"
        >
          <a href="/">
            <span class="text-xl pl-2"
              >ComicFarm<i class="em em-grinning"></i
            ></span>
          </a>
        </div>

        <div
          class="flex flex-1 md:w-1/3 justify-center md:justify-start text-white px-2"
        >
          <span class="relative w-full">
            <input
              type="search"
              placeholder="Search"
              class="w-full bg-gray-900 text-white transition border border-transparent focus:outline-none focus:border-gray-400 rounded py-3 px-2 pl-10 appearance-none leading-normal"
            />
            <div class="absolute search-icon" style="top: 1rem; left: 0.8rem;">
              <svg
                class="fill-current pointer-events-none text-white w-4 h-4"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              >
                <path
                  d="M12.9 14.32a8 8 0 1 1 1.41-1.41l5.35 5.33-1.42 1.42-5.33-5.34zM8 14A6 6 0 1 0 8 2a6 6 0 0 0 0 12z"
                ></path>
              </svg>
            </div>
          </span>
        </div>

        <div
          class="flex w-full pt-2 content-center justify-between md:w-1/3 md:justify-end"
        >
          <ul
            class="list-reset flex justify-between flex-1 md:flex-none items-center"
            v-if="this.isLoggedIn"
          >
            <li class="flex-1 md:flex-none md:mr-3">
              <a
                class="inline-block text-gray-600 no-underline hover:text-gray-200 hover:text-underline py-2 px-4"
                href="#"
                @click="$auth.logout()"
                >ログアウト</a
              >
            </li>
          </ul>
          <ul
            class="list-reset flex justify-between flex-1 md:flex-none items-cente"
            v-else
          >
            <li class="flex-1 md:flex-none md:mr-3">
              <nuxt-link to="/users/signin" class="text-gray-600">
                ログイン
              </nuxt-link>
            </li>
            <li class="flex-1 md:flex-none md:mr-3">
              <nuxt-link to="/users/signup" class="text-gray-600">
                新規登録
              </nuxt-link>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  props: ["isLoggedIn"],
};
</script>
