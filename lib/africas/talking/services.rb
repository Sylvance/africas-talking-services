# frozen_string_literal: true

require_relative "services/version"
require_relative "services/voice"

module Africas
  module Talking
    module Services
      class Error < StandardError; end

      class Client
        attr_accessor :app_name, :app_key
        def initialize(app_name:, app_key:)
          @app_name = app_name
          @app_key  = app_key 
        end

        def voice
          Voice.new(app_name: @app_name, app_key: @app_key)
        end
      end
    end
  end
end
