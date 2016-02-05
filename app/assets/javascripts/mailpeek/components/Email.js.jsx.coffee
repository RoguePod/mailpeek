class @Email extends React.Component
  render: ->
    email = @props.email

    createdAt  = moment(email.date).format('MMM Do YYYY, h:mm:ss a')
    `<div className="email">
      <div className="email__details">
        <dl className="email__list dl-horizontal">
          <dt>Sent</dt>
          <dd>{createdAt}</dd>
          <dt>Subject</dt>
          <dd>{email.subject}</dd>
          <dt>To</dt>
          <dd>{email.to}</dd>
          <dt>From</dt>
          <dd>{email.from}</dd>
        </dl>
      </div>
      <Body email={email} />
    </div>`
