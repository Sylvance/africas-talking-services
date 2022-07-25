# frozen_string_literal: true

module Africas
  module Talking
    module Services
      class Voice
        attr_accessor :app_name, :app_key

        def initialize(app_name:, app_key:)
          @app_name = app_name
          @app_key  = app_key
        end

        def call(entity:)
          "Voice call"
        end

        def say(entity:)
          "Voice say"
        end

        def play(entity:)
          "Voice play"
        end

        def get_digits(entity:)
          "Voice get_digits"
        end

        def forward_call(entity:)
          "Voice forward_call"
        end

        def record(entity:)
          "Voice record"
        end

        def terminal_record(entity:)
          "Voice terminal_record"
        end

        def enqueue(entity:)
          "Voice enqueue"
        end

        def dequeue(entity:)
          "Voice dequeue"
        end

        def redirect(entity:)
          "Voice redirect"
        end

        def reject
          "Voice reject"
        end
      end
    end
  end
end
