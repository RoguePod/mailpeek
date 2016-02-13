class @Sidebar extends React.Component
  render: ->
    emails = @props.emails.map (email, index) =>
      onSelect = this.props.onEmailSelect.bind(this, email)
      onDelete = this.props.onEmailDelete.bind(this, email)
      selected = this.props.selected &&
                 email.message_id == this.props.selected.message_id

      `<ListItem
        key={index}
        email={email}
        selected={selected}
        onSelect={onSelect}
        onDelete={onDelete} />`

    classNames = 'sidebar'
    classNames = 'sidebar sidebar_open' if this.props.open
    `<div className={classNames}>
      <ul className="list-unstyled">
        {emails}
      </ul>
    </div>`
