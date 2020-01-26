# frozen_string_literal: true

module Mailpeek
  # Public: WebApplication
  class WebApplication
    extend WebRouter

    CONTENT_LENGTH = 'Content-Length'
    CONTENT_TYPE = 'Content-Type'
    CSP_HEADER = [
      "default-src 'self' https: http:",
      "child-src 'self'",
      "connect-src 'self' https: http: wss: ws:",
      "font-src 'self' https: http:",
      "frame-src 'self'",
      "img-src 'self' https: http: data:",
      "manifest-src 'self'",
      "media-src 'self'",
      "object-src 'none'",
      "script-src 'self' https: http: 'unsafe-inline'",
      "style-src 'self' https: http: 'unsafe-inline'",
      "worker-src 'self'",
      "base-uri 'self'"
    ].join('; ').freeze

    def initialize(klass)
      @klass = klass
    end

    def settings
      @klass.settings
    end

    def self.settings
      Mailpeek::Web.settings
    end

    def self.set(key, val)
      # nothing, backwards compatibility
    end

    get '/' do
      email = emails.first

      if email.blank?
        erb(:index)
      else
        redirect_with_query "#{root_path}emails/#{email.id}"
      end
    end

    get '/emails' do
      all_emails = emails.map do |email|
        { id: email.id, read: email.read }
      end

      json(emails: all_emails, unread: unread)
    end

    get '/read' do
      Mailpeek.emails.each do |email|
        email.read = true
      end

      if params[:email_id].present?
        redirect "#{root_path}emails/#{params[:email_id]}"
      else
        redirect_with_query root_path
      end
    end

    get '/emails/:email_id/attachments/:id' do
      path = File.join(
        Mailpeek.configuration.location, params[:email_id], 'attachments',
        params[:id]
      )

      send_file(path, params[:id])
    end

    get '/emails/:id' do
      @email = emails.detect { |x| x.id.to_s == params[:id].to_s }

      if @email.blank?
        redirect_with_query root_path
      else
        @email.read = true
        erb(:show)
      end
    end

    delete '/emails/:id' do
      email = Mailpeek.email(params[:id])

      email&.destroy

      redirect_with_query root_path
    end

    delete '/emails' do
      Mailpeek.emails.each(&:destroy)

      redirect root_path
    end

    # rubocop:disable Metrics/MethodLength
    def call(env)
      action = self.class.match(env)

      unless action
        return [
          404,
          { 'Content-Type' => 'text/plain', 'X-Cascade' => 'pass' },
          ['Not Found']
        ]
      end

      response = catch(:halt) do
        response = action.instance_exec(env, &action.block)
      end

      response =
        case response
        when Array
          response
        else
          headers = {
            'Content-Type' => 'text/html',
            'Cache-Control' => 'no-cache',
            'Content-Security-Policy' => CSP_HEADER
          }

          [200, headers, [response]]
        end

      response[1] = response[1].dup

      response[1][CONTENT_LENGTH] = response[2].inject(0) do |l, p|
        l + p.bytesize
      end.to_s

      response
    end
    # rubocop:enable Metrics/MethodLength

    def self.helpers(mod = nil, &block)
      if block_given?
        WebAction.class_eval(&block)
      else
        WebAction.send(:include, mod)
      end
    end
  end
end
