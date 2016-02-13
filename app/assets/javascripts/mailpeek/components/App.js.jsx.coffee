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

  componentDidMount: ->
    @handleFocus = =>
      @_retrieveEmails(false)
      true

    window.addEventListener 'focus', @handleFocus

    true

  componentWillUnmount: ->
    window.removeEventListener 'focus', @handleFocus

    true

  _retrieveEmails: (fetching = true) ->
    @setState
      fetching: fetching
      error: null

    $.ajax
      type: 'GET'
      url: '/mailpeek/mail.json'
      dataType: 'json'
      success: (response) =>
        emails = response.emails

        if @state.selected && _.find(emails, (e) => e.file == @state.selected.file)
          selected = @state.selected
        else
          selected = _.first(emails)
        @setState
          emails: emails
          fetching: false
          selected: selected
      error: =>
        @setState
          fetching: false
          error: 'Sorry, an error occurred when retrieving the emails.'
    true

  _handleEmailSelect: (email) ->
    @setState
      selected: email
      open: false
    true

  _handleEmailDelete: (email, event) ->
    event.stopPropagation()
    if confirm('Are you sure?  This cannot be undone.')
      @setState
        error: false
        fetching: true
      $.ajax
        type: 'DELETE'
        url: "/mailpeek/mail/#{email.file}"
        success: (response) =>
          @_retrieveEmails()
        error: =>
          @setState
            error: 'Sorry, an error ocurred when deleting the email.'
            fetching: false
      true

    true

  _handleMenuToggle: ->
    @setState open: !@state.open
    true

  _handleRefresh: ->
    @_retrieveEmails()
    true

  _handleAllEmailsDelete: ->
    if confirm('Are you sure you want delete ALL emails? This cannot be undone')
      @setState
        error: false
        fetching: true
      $.ajax
        type: 'DELETE'
        url: '/mailpeek/mail'
        success: (response) =>
          @setState selected: null
          @_retrieveEmails()
        error: =>
          @setState
            error: 'Sorry, an error ocurred when deleting all emails.'
            fetching: false
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
          className="fa fa-bars header__menu-icon visible-xs" onClick={this._handleMenuToggle.bind(this)} />
        <i
          className="fa fa-trash header__trash-icon" onClick={this._handleAllEmailsDelete.bind(this)} />
        <i
          className="fa fa-refresh header__refresh-icon" onClick={this._handleRefresh.bind(this)} />
        <span className="header__title">Mailpeek</span>
      </header>
      {error}
      <Sidebar
        emails={this.state.emails}
        open={this.state.open}
        selected={this.state.selected}
        onEmailSelect={this._handleEmailSelect.bind(this)}
        onEmailDelete={this._handleEmailDelete.bind(this)} />
      <Email
        email={this.state.selected} />
    </div>`
