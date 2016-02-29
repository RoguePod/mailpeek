import 'font-awesome/css/font-awesome.css';
import 'normalize.css/normalize.css';

import $ from 'jquery';
import React from 'react';
import ReactDOM from 'react-dom';

import App from './components/App.js';

let elements = { App };

$(document).on('ready page:load', () => {
  // renders react elements with proper layout
  $('[data-react]').each((index, element) => {
    let reactElement = element.dataset.react;
    if(elements[reactElement]) {
      let props = JSON.parse(element.dataset.props);
      ReactDOM.render(
        React.createElement(elements[reactElement], props), element);
    }
  });
});
