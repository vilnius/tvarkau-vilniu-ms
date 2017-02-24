const path = require('path');
const webpack = require('webpack');
const autoprefixer = require('autoprefixer');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    context: path.join(__dirname, 'src'),
    devtool: 'inline-source-map',
    entry: [
        './js/client.jsx'
    ],
    output: {
        path: __dirname + '/dist/ui-react/',
        filename: 'client.min.js',
        publicPath: '/'
    },
    resolve: {
        extensions: ['', '.scss', '.css', '.js', '.json', '.jsx']
    },
    module: {
        loaders: [
            {
                test: /.(js|jsx)?$/,
                exclude: /(node_modules)/,
                loader: 'babel-loader',
                query: {
                    presets: ['react', 'es2015', 'stage-0'],
                    plugins: [
                        'react-html-attrs',
                        'transform-class-properties',
                        'transform-decorators-legacy',
                        ['import', {libraryName: 'antd', style: 'css'}]
                    ]
                }
            },
            {
                test: /\.css$/,
                loader: "style-loader!css-loader"
            }
        ]
    },
    postcss: [autoprefixer],
    plugins: [
        new webpack.optimize.OccurenceOrderPlugin(),
        new webpack.HotModuleReplacementPlugin(),
        new webpack.NoErrorsPlugin(),
        new webpack.DefinePlugin({
            'process.env.NODE_ENV': JSON.stringify('development')
        }),
        new CopyWebpackPlugin([
            {from: 'index.html', to: '../ui-react/index.html'}
        ])
    ]
};
