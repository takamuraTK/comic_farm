const { resolve } = require("path");
const { getWebpackConfig } = require("nuxt");


module.exports = {
  stories: ['../app/components/**/*.stories.js'],
  addons: ['@storybook/addon-essentials'],
  // `configType` has a value of 'DEVELOPMENT' or 'PRODUCTION'
  // You can change the configuration based on that.
  // 'PRODUCTION' is used when building the static version of storybook.
  webpackFinal: async (sbWebpack, { configType }) => {
    const nuxtWebpack = await getWebpackConfig("client", {
      for: process.env.NODE_ENV === "production" ? "build" : "dev",
    });
    const recomposedWebpackConfig = {
      mode: nuxtWebpack.mode,
      devtool: nuxtWebpack.devtool,
      entry: sbWebpack.entry,
      output: sbWebpack.output,
      bail: sbWebpack.bail,
      module: {
        rules: [
          ...nuxtWebpack.module.rules.map((el) => {
            const reg = RegExp(el.test);
            // 拡張子が「.postcss」か「.css」の時
            if (reg.test(".postcss") || reg.test(".css")) {
              el.oneOf = el.oneOf.map((e) => {
                e.use.push({
                  loader: "postcss-loader",
                  options: {
                    ident: "postcss",
                    plugins: [
                      require("tailwindcss")("./tailwind.config.js"),
                      require("autoprefixer"),
                    ],
                  },
                });
                return e;
              });
            }
            // 拡張子が「.sass」か「.scss」の時(基本scssのみで良いが念のためsassも記載)
            if (reg.test(".sass") || reg.test(".scss")) {
              el.oneOf = el.oneOf.map((e) => {
                e.use.push(
                  {
                    loader: "postcss-loader",
                    options: {
                      ident: "postcss",
                      plugins: [
                        require("tailwindcss")("./tailwind.config.js"),
                        require("autoprefixer"),
                      ],
                    },
                  },
                  {
                    loader: "sass-loader",
                  },
                  // ここでscssの変数などの変換を行う
                  {
                    loader: "sass-resources-loader",
                    options: {
                      resources: ["./assets/scss/variable.scss"],
                      include: resolve(__dirname, "../"),
                    },
                  }
                );
                return e;
              });
            }
            return el;
          }),
        ],
      },
      plugins: sbWebpack.plugins,
      resolve: {
        extensions: nuxtWebpack.resolve.extensions,
        modules: nuxtWebpack.resolve.modules,
        alias: {
          ...nuxtWebpack.resolve.alias,
          ...sbWebpack.resolve.alias,
        },
      },
      optimization: sbWebpack.optimization,
      performance: {
        ...sbWebpack.performance,
        ...nuxtWebpack.performance,
      },
    };
    return recomposedWebpackConfig;
  },
};
