export default {
  // Global page headers (https://go.nuxtjs.dev/config-head)
  srcDir: 'app',

  head: {
    title: 'comic_farm',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [
  ],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    { src: '~/plugins/axios.js', ssr: false }
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [
    // https://go.nuxtjs.dev/tailwindcss
    '@nuxtjs/tailwindcss',
  ],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    '@nuxtjs/axios',
    '@nuxtjs/auth'
  ],

  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {
  },

  router: {
    middleware: ['auth']
  },

  axios: {
    baseURL: 'http://localhost/v1'
  },

  auth: {
    redirect: {
      login: '/users/signin',
      logout: '/users/signin',
      callback: false,
      home: '/',
  },
  strategies: {
    local: {
      endpoints: {
        login: { url: '/auth/sign_in', method: 'post', propertyName: false },
        logout: { url: '/auth/sign_out', method: 'delete' },
        user: false,
      },
    }
  }
  }
}
