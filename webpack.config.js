var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
	context: __dirname + '/public',
	module: {
		rules: [
			{
				test: /\.css$/,
				use: ExtractTextPlugin.extract({
					fallback: 'style-loader',
					use: ['css-loader?minimize=true'],
				})
			}
		]
	},
	entry: './static/js/webpack.js',
	output: {
		path: __dirname + '/public/static/js',
		filename: 'bundle.min.js'
	},
	plugins: [
		new ExtractTextPlugin({ filename: '../css/bundle.min.css' }),
		new webpack.ProvidePlugin({ $: 'jquery', jQuery: 'jquery', moment: 'moment' }),
	],
};