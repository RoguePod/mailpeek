class @Sidebar extends React.Component
  render: ->
    emails = @props.emails.map (email, index) =>
      click      = this.props.handleEmailClick.bind(this, email)

      classNames = 'email-item'
      if email.message_id == @props.selected.message_id
        classNames = 'email-item email-item_selected'

      `<li
        className={classNames}
        key={index}
        onClick={click}>
        <strong className="email-item__subject">{email.subject}</strong>
        <em className="email-item__date text-muted">{email.created_at} ago</em>
      </li>`


    classNames = 'sidebar'
    classNames = 'sidebar sidebar_open' if this.props.open
    `<div className={classNames}>
      <ul className="list-unstyled">
        {emails}
      </ul>
    </div>`
