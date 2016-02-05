require 'mail/check_delivery_params'

module Mailpeek
  # Public: Delivery
  class Delivery
    include Mail::CheckDeliveryParams if defined?(Mail::CheckDeliveryParams)

    class InvalidOption < StandardError; end

    attr_accessor :settings

    def initialize(options = {})
      if options[:location].nil?
        raise(
          InvalidOption,
          'A location option is required when using Mailpeek')
      end
      self.settings = options
    end

    def deliver!(mail)
      check_delivery_params(mail) if respond_to?(:check_delivery_params)

      FileUtils.mkdir_p(settings[:location])

      filepath = File.join(settings[:location], Time.now.to_i.to_s)

      File.open(filepath, 'w') do |f|
        f.write mail.to_s
      end
    end
  end
end
