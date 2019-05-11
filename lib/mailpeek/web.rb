# frozen_string_literal: true
require 'erb'

require 'mailpeek/web/router'
require 'mailpeek/web/action'
require 'mailpeek/web/helpers'
require 'mailpeek/web/application'

require 'rack/protection'

require 'rack/builder'
require 'rack/file'

module Mailpeek
  class Web
    ROOT = File.expand_path("#{File.dirname(__FILE__)}/../../web")
    VIEWS = "#{ROOT}/views"
    LAYOUT = "#{VIEWS}/layout.erb"
    ASSETS = "#{ROOT}/assets"


    class << self
      def settings
        self
      end

      def middlewares
        @middlewares ||= []
      end

      def use(*middleware_args, &block)
        middlewares << [middleware_args, block]
      end


      def views
        @views ||= VIEWS
      end

      def enable(*opts)
        opts.each {|key| set(key, true) }
      end

      def disable(*opts)
        opts.each {|key| set(key, false) }
      end

      # Helper for the Sinatra syntax: Mailpeek::Web.set(:session_secret, Rails.application.secrets...)
      def set(attribute, value)
        send(:"#{attribute}=", value)
      end

      attr_accessor :app_url
      attr_writer :views
    end

    def self.inherited(child)
      child.app_url = self.app_url
    end

    def settings
      self.class.settings
    end

    def use(*middleware_args, &block)
      middlewares << [middleware_args, block]
    end

    def middlewares
      @middlewares ||= Web.middlewares.dup
    end

    def call(env)
      app.call(env)
    end

    def self.call(env)
      @app ||= new
      @app.call(env)
    end

    def app
      @app ||= build
    end

    def enable(*opts)
      opts.each {|key| set(key, true) }
    end

    def disable(*opts)
      opts.each {|key| set(key, false) }
    end

    def set(attribute, value)
      send(:"#{attribute}=", value)
    end

    def self.register(extension)
      extension.registered(WebApplication)
    end

    private

    def using?(middleware)
      middlewares.any? do |(m,_)|
        m.kind_of?(Array) && (m[0] == middleware || m[0].kind_of?(middleware))
      end
    end

    def build
      middlewares = self.middlewares
      klass = self.class

      ::Rack::Builder.new do
        %w(stylesheets javascripts images).each do |asset_dir|
          map "/#{asset_dir}" do
            run ::Rack::File.new("#{ASSETS}/#{asset_dir}", { 'Cache-Control' => 'public, max-age=86400' })
          end
        end

        middlewares.each {|middleware, block| use(*middleware, &block) }

        run WebApplication.new(klass)
      end
    end
  end

  Mailpeek::WebApplication.helpers WebHelpers

  Mailpeek::WebAction.class_eval "def _render\n#{ERB.new(File.read(Web::LAYOUT)).src}\nend"
end
