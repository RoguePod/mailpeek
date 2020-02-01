# frozen_string_literal: true

module Mailpeek
  # Public: WebAction
  class WebAction
    attr_accessor :env, :block, :type

    def settings
      Web.settings
    end

    def request
      @request ||= ::Rack::Request.new(env)
    end

    def halt(res)
      throw :halt, res
    end

    def redirect(location)
      halt([302, { 'Location' => "#{request.base_url}#{location}" }, []])
    end

    def params
      return @params if @params

      @params =
        route_params
        .merge(request.params)
        .each_with_object({}) do |(key, value), results|
          results[key.to_s] = value
          results[key.to_sym] = value
          results
        end

      @params
    end

    def route_params
      env[WebRouter::ROUTE_PARAMS]
    end

    def erb(content, options = {})
      if content.is_a? Symbol
        unless respond_to?(:"_erb_#{content}")
          src = ERB.new(File.read("#{Web.settings.views}/#{content}.erb")).src
          WebAction.class_eval("def _erb_#{content}\n#{src}\n end")
        end
      end

      if @_erb
        _erb(content, options[:locals])
      else
        @_erb = true
        content = _erb(content, options[:locals])

        _render { content }
      end
    end

    def render(engine, content, options = {})
      raise 'Only erb templates are supported' if engine != :erb

      erb(content, options)
    end

    def json(payload)
      [
        200,
        { 'Content-Type' => 'application/json', 'Cache-Control' => 'no-cache' },
        [JSON.generate(payload)]
      ]
    end

    def send_file(path, filename)
      [
        200,
        {
          'Cache-Control' => 'no-cache',
          'Content-Type' => 'application/octet-stream',
          'Content-Disposition' => "attachment; filename=\"#{filename}\""
        },
        [File.read(path)]
      ]
    end

    def initialize(env, block)
      @_erb = false
      @env = env
      @block = block

      # @@files ||= {}
    end

    private

    def _erb(file, locals)
      locals&.each do |k, v|
        define_singleton_method(k) { v } unless singleton_methods.include?(k)
      end

      if file.is_a?(String)
        ERB.new(file).result(binding)
      else
        send(:"_erb_#{file}")
      end
    end
  end
end
