const path = require('path')

module.exports = {
  stories: ['../app/components/**/*.stories.js'],
  addons: ['@storybook/addon-essentials'],
  webpackFinal: config => {
    config.module.rules.push({
      test: /\.scss$/,
      use: ['style-loader', 'css-loader', 'sass-loader'],
      include: path.resolve(__dirname, '../')
    })
    return config
  }
}
