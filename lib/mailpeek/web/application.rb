# frozen_string_literal: true

module Mailpeek
  class WebApplication
    extend WebRouter

    CONTENT_LENGTH = "Content-Length"
    CONTENT_TYPE = "Content-Type"
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

    get "/" do
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

      json(
        emails: all_emails,
        unread: unread
      )
    end

    get '/read' do
      Mailpeek.emails.each do |email|
        email.read = true
      end

      if params['email_id'].present?
        redirect "#{root_path}emails/#{params['email_id']}"
      else
        redirect_with_query root_path # request.query_parameters
      end
    end

    get "/emails/:email_id/attachments/:id" do
      location = Mailpeek.configuration.location
      path     = File.join(
        location, route_params['email_id'], 'attachments',
        "#{route_params['id']}.#{params['format']}"
      )

      send_file path
    end

    get "/emails/:id" do
      @emails = Mailpeek.emails

      if params['q'].present?
        @emails = @emails.select { |x| x.match?(params['q']) }
      end

      @total_count = @emails.size
      @emails = @emails.first(params['per'] || 10)
      @email  = @emails.detect { |x| x.id.to_s == route_params[:id].to_s }

      if @email.blank?
        redirect_with_query root_path # request.query_parameters
      else
        @email.read = true
        erb(:show)
      end
    end

    delete '/emails/:id' do
      email = Mailpeek.email(route_params['id'])

      email&.destroy

      redirect_with_query root_path # request.query_parameters
    end

    delete '/emails' do
      Mailpeek.emails.each(&:destroy)

      redirect root_path
    end

    def call(env)
      action = self.class.match(env)
      return [404, {"Content-Type" => "text/plain", "X-Cascade" => "pass" }, ["Not Found"]] unless action

      resp = catch(:halt) do
        app = @klass
        self.class.run_befores(app, action)
        begin
          resp = action.instance_exec env, &action.block
        ensure
          self.class.run_afters(app, action)
        end

        resp
      end

      resp = case resp
      when Array
        resp
      else
        headers = {
          "Content-Type" => "text/html",
          "Cache-Control" => "no-cache",
          "Content-Security-Policy" => CSP_HEADER
        }

        [200, headers, [resp]]
      end

      resp[1] = resp[1].dup

      resp[1][CONTENT_LENGTH] = resp[2].inject(0) { |l, p| l + p.bytesize }.to_s

      resp
    end

    def self.helpers(mod=nil, &block)
      if block_given?
        WebAction.class_eval(&block)
      else
        WebAction.send(:include, mod)
      end
    end

    def self.before(path=nil, &block)
      befores << [path && Regexp.new("\\A#{path.gsub("*", ".*")}\\z"), block]
    end

    def self.after(path=nil, &block)
      afters << [path && Regexp.new("\\A#{path.gsub("*", ".*")}\\z"), block]
    end

    def self.run_befores(app, action)
      run_hooks(befores, app, action)
    end

    def self.run_afters(app, action)
      run_hooks(afters, app, action)
    end

    def self.run_hooks(hooks, app, action)
      hooks.select { |p,_| !p || p =~ action.env[WebRouter::PATH_INFO] }.
            each {|_,b| action.instance_exec(action.env, app, &b) }
    end

    def self.befores
      @befores ||= []
    end

    def self.afters
      @afters ||= []
    end
  end
end
