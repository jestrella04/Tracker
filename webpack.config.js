var debug = process.env.NODE_ENV !== 'production';
var webpack = require('webpack');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
	context: __dirname + '/public',
	devtool: debug ? 'inline-sourcemap' : false,
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
	plugins: debug ? [
		new ExtractTextPlugin({ filename: '../css/bundle.min.css' }),
		new webpack.ProvidePlugin({ $: 'jquery', jQuery: 'jquery', moment: 'moment' }),
	] : [
		new ExtractTextPlugin({ filename: '../css/bundle.min.css' }),
		new webpack.ProvidePlugin({ $: 'jquery', jQuery: 'jquery', moment: 'moment' }),
		new webpack.optimize.DedupePlugin(),
		new webpack.optimize.UglifyJsPlugin({ mangle: false, sourcemap: false }),
	],
};