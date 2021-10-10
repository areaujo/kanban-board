const webpack = require('webpack');

module.exports = {
  plugins: [
    new webpack.DefinePlugin({
      $ENV: {
        KANBAN_APP_URL: JSON.stringify(process.env.KANBAN_APP_URL),
        DEV_BACKEND_URL: JSON.stringify(process.env.DEV_BACKEND_URL),
        PROD_BACKEND_URL: JSON.stringify(process.env.PROD_BACKEND_URL)
      }
    })
  ]
};