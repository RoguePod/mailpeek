class @Body extends React.Component
  constructor: (props) ->
    super props
    @state =
      tab: props.email.body[0].type

  componentWillReceiveProps: (nextProps) ->
    if nextProps.email.message_id != @props.email.message_id
      @setState
        tab: nextProps.email.body[0].type
    true

  _onTabChange: (tab) ->
    @setState
      tab: tab
    true

  _body: ->
    for body in @props.email.body
      continue unless body.type == @state.tab
      if body.type == 'text'
        return body.content.split('\n').map (p, index) ->
          `<span key={index}>{p}<br /></span>`
      else
        return `<div dangerouslySetInnerHTML={{__html: body.content}} />`
    null

  render: ->
    email = @props.email

    tabs = email.body.map (body, index) =>
      classNames = ['body__tab']
      classNames.push 'body__tab_selected' if body.type == @state.tab
      onClick = @_onTabChange.bind(@, body.type)
      `<div
        key={index}
        className={classNames.join(' ')}
        onClick={onClick}>
        {body.type.toUpperCase()}
      </div>`


    body = @_body()
    # <div className="body__content" dangerouslySetInnerHTML={this._body()} />
    `<div className="body">
      <div className="body__tabs">
        {tabs}
      </div>
      <div className="body__content">{body}</div>
    </div>`
