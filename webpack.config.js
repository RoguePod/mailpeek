const Path    = require('path');
const Webpack = require('webpack');
const NodeEnv = process.env.NODE_ENV || 'development';
const DevTool = NodeEnv == 'production' ? 'cheap-module-source-map' : 'eval';

module.exports = {
  entry: './app/webpack/javascripts/application.js',
  devtool: DevTool,
  output: {
    path: Path.join(__dirname, 'app', 'assets', 'javascripts', 'mailpeek'),
    filename: 'application.js',
    publicPath: '/assets/mailpeek/',
  },
  module: {
    loaders: [{
      test: /\.js$/,
      loaders: ['babel?presets[]=react,presets[]=es2015&compact=false']
    }, {
      test: /\.css$/,
      loader: 'style!css!postcss'
    }, {
      test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: 'url?limit=20000&name=[name].[ext]&mimetype=application/font-woff'
    }, {
      test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
      loader: 'url?limit=20000&name=[name].[ext]'
    }]
  },
  plugins: [
    new Webpack.IgnorePlugin(/^\.\/locale$/, [/moment$/]),
    new Webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify(NodeEnv)
      }
    })
  ],
  postcss: function() {
    return [
      require('postcss-import'),
      require('autoprefixer'),
      require('precss'),
      require('lost')
    ];
  }
}
