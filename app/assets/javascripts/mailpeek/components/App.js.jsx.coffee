class @App extends React.Component
  constructor: (props) ->
    super props
    emails = JSON.parse(@props.data).emails
    @state =
      emails: emails
      selected: _.first(emails)
      open: false
      fetching: false
      error: null

  _retrieveEmails: ->
    @setState
      fetching: true
      error: null
    request = new XMLHttpRequest()
    request.open('GET', '/mailpeek/mail.json', true)

    request.onload = =>
      try
        response = JSON.parse(request.responseText)
      catch e
        response =
          error: 'Sorry, An error occurred when retrieving the emails'

      if request.status >= 200 && request.status < 400
        if @state.selected
          selected = @state.selected
        else
          selected = _.first(response.emails)
        @setState
          emails: response.emails
          fetching: false
          selected: selected
      else
        console.log 'nope'
        @setState
          fetching: false
          error: response.error

    request.onerror = =>
      console.log 'error';
      @setState
        fetching: false
        error: 'Sorry, An error occurred when retrieving the emails'

    request.send()
    true

  componentDidMount: ->
    true

  _onEmailClick: (email) ->
    @setState
      selected: email
      open: false
    true

  _onMenuIconClick: ->
    @setState
      open: !@state.open
    true

  _onRefreshIconClick: ->
    this._retrieveEmails()
    true

  render: ->
    classNames = ['error']
    classNames.push 'error_show' if @state.error
    error = `<div className={classNames.join(' ')}>{this.state.error}</div>`

    loading = null
    if @state.fetching
      loading =
        `<div className="loading">
          <i className="fa fa-refresh fa-spin loading__icon" />
        </div>`
    `<div>
      {loading}
      <header className="header">
        <i
          className="fa fa-bars header__menu-icon visible-xs" onClick={this._onMenuIconClick.bind(this)} />
        <i
          className="fa fa-refresh header__refresh-icon" onClick={this._onRefreshIconClick.bind(this)} />
        <span className="header__title">Mailpeek</span>
      </header>
      {error}
      <Sidebar
        emails={this.state.emails}
        open={this.state.open}
        selected={this.state.selected}
        handleEmailClick={this._onEmailClick.bind(this)} />
      <Email
        email={this.state.selected} />
    </div>`
