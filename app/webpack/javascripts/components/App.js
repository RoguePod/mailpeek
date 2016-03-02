import React from 'react';
import Find from 'lodash/find';
import First from 'lodash/fp/first';
import $ from 'jquery';

import Sidebar from './Sidebar.js';
import Email from './Email.js';

import '../../stylesheets/App.css';

class App extends React.Component {
  constructor(props) {
    super(props);
    let emails = props.emails;
    this.state = {
      emails: emails,
      selected: First(emails),
      open: false,
      fetching: false,
      error: null
    }
  }

  componentDidMount() {
    this.handleFocus = () => {
      this._retrieveEmails(false);
    }

    window.addEventListener('focus', this.handleFocus)
  }

  componentWillUnmount() {
    window.removeEventListener('focus', this.handleFocus)
  }

  _retrieveEmails(fetching = true) {
    this.setState({
      fetching: fetching,
      error: null
    })

    $.ajax({
      type: 'GET',
      url: '/mailpeek/mail.json',
      dataType: 'json',
      success: (response) => {
        let emails   = response.emails;
        let selected = this.state.selected;

        if(selected && Find(emails, (e) => { return e.file == selected.file })) {
          selected = this.state.selected;
        } else {
          selected = First(emails);
        }

        this.setState({
          emails: emails,
          fetching: false,
          selected: selected
        });
      },
      error: () => {
        this.setState({
          fetching: false,
          error: 'Sorry, an error occurred when retrieving the emails.'
        });
      }
    });
  }

  _handleEmailSelect(email) {
    this.setState({
      selected: email,
      open: false
    });
  }

  _handleEmailDelete(email, event) {
    event.stopPropagation()
    if(email.file && confirm('Are you sure?  This cannot be undone.')) {
      this.setState({
        error: false,
        fetching: true
      })
      $.ajax({
        type: 'DELETE',
        url: `/mailpeek/mail/${email.file}`,
        success: (response) => {
          this._retrieveEmails();
        },
        error: () => {
          this.setState({
            error: 'Sorry, an error ocurred when deleting the email.',
            fetching: false
          });
        }
      });
    }
    return false;
  }

  _handleMenuToggle() {
    this.setState({ open: !this.state.open });
  }

  _handleRefresh() {
    this._retrieveEmails();
  }

  _handleAllEmailsDelete() {
    let msg = 'Are you sure you want delete ALL emails? This cannot be undone';
    if(confirm(msg)) {
      this.setState({
        error: false,
        fetching: true
      })
      $.ajax({
        type: 'DELETE',
        url: '/mailpeek/mail',
        success: (response) => {
          this.setState({ selected: null });
          this._retrieveEmails();
        },
        error: () => {
          this.setState({
            error: 'Sorry, an error ocurred when deleting all emails.',
            fetching: false
          });
        }
      });
    }
  }

  render() {
    let classNames = ['app__error'];
    if(this.state.error) {
      classNames.push('app__error_show');
    }
    let error = <div className={classNames.join(' ')}>{this.state.error}</div>;

    let loading = null
    if(this.state.fetching) {
      loading =
        <div className="app__loading">
          <i className="fa fa-refresh fa-spin loading__icon" />
        </div>
    }
    return (
      <div className="app">
        {loading}
        <header className="app__header">
          <i
            className="fa fa-bars app__menu-icon" onClick={this._handleMenuToggle.bind(this)} />
          <i
            className="fa fa-trash app__trash-icon" onClick={this._handleAllEmailsDelete.bind(this)} />
          <i
            className="fa fa-refresh app__refresh-icon" onClick={this._handleRefresh.bind(this)} />
          <span className="app__title">Mailpeek</span>
        </header>
        {error}
        <Sidebar
          emails={this.state.emails}
          open={this.state.open}
          selected={this.state.selected}
          onOverlayClick={this._handleMenuToggle.bind(this)}
          onEmailSelect={this._handleEmailSelect.bind(this)}
          onEmailDelete={this._handleEmailDelete.bind(this)} />
        <Email
          email={this.state.selected} />
      </div>
    );
  }
}

export default App;
