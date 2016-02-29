import React from 'react';
import moment from 'moment';

import '../../stylesheets/Email.css';

import Body from './Body.js';

class Email extends React.Component {
  render() {
    let email = this.props.email;

    if(!email) {
      return <div className="email email_empty">No Emails Found</div>;
    }

    let createdAt = moment(email.date).format('MMM Do YYYY @ h:mm:ss a');

    return (
      <div className="email">
        <div className="email__details">
          <dl className="email__list">
            <dt className="email__dt">Sent</dt>
            <dd className="email__dd">{createdAt}</dd>
            <dt className="email__dt">Subject</dt>
            <dd className="email__dd">{email.subject}</dd>
            <dt className="email__dt">To</dt>
            <dd className="email__dd">{email.to}</dd>
            <dt className="email__dt">From</dt>
            <dd className="email__dd">{email.from}</dd>
          </dl>
        </div>
        <Body email={email} />
      </div>
    );
  }
}

export default Email;
