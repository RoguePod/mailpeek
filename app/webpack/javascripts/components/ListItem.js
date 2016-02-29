import React from 'react';

import '../../stylesheets/ListItem.css';

class ListItem extends React.Component {
  render() {
    let classNames = 'email-item';
    if(this.props.selected) {
      classNames = 'email-item email-item_selected';
    }

    return (
      <li
        className={classNames}
        onClick={this.props.onSelect}>

        <div className="email-actions">
          <i
            className="fa fa-remove email-actions__trash-icon" onClick={this.props.onDelete} />
        </div>

        <div className="email-description">
          <strong className="email-description__subject">
            {this.props.email.subject}
          </strong>
          <em className="email-description__date text-muted">
            {this.props.email.created_at} ago
          </em>
        </div>
      </li>
    );
  }
}

export default ListItem;
