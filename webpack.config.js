const webpack = require('webpack');
const TerserJSPlugin = require("terser-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const OptimizeCSSAssetsPlugin = require("optimize-css-assets-webpack-plugin");

module.exports = {
  context: __dirname + "/public",
  entry: "./static/js/webpack.js",
  output: {
    path: __dirname + "/public/static/js",
    filename: "bundle.min.js"
  },
  optimization: {
    minimizer: [new TerserJSPlugin({}), new OptimizeCSSAssetsPlugin({})]
  },
  plugins: [
    new MiniCssExtractPlugin({filename: "../css/bundle.min.css", chunkFilename: "[id].css"}),
    new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery", moment: "moment"})
  ],
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, "css-loader"]
      }
    ]
  }
};
