import React from 'react';

import ListItem from './ListItem.js';

import '../../stylesheets/Sidebar.css';

class Sidebar extends React.Component {
  render() {
    let emails = this.props.emails.map((email, index) => {
      let onSelect = this.props.onEmailSelect.bind(this, email);
      let onDelete = this.props.onEmailDelete.bind(this, email);
      let selected = this.props.selected &&
                     email.message_id == this.props.selected.message_id;

      return (
        <ListItem
          key={index}
          email={email}
          selected={selected}
          onSelect={onSelect}
          onDelete={onDelete} />
      );
    });

    let classNames = 'sidebar'
    if(this.props.open) {
      classNames = 'sidebar sidebar_open';
    }

    return (
      <div className={classNames}>
        <div
          className="sidebar__overlay"
          onClick={this.props.onOverlayClick.bind(this)} />
        <ul className="sidebar__list">
          {emails}
        </ul>
      </div>
    );
  }
}

export default Sidebar;
