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
          return 'Voice call'
        end

        def say(entity:)
          return 'Voice say'
        end

        def play(entity:)
          return 'Voice play'
        end

        def get_digits(entity:)
          return 'Voice get_digits'
        end

        def forward_call(entity:)
          return 'Voice forward_call'
        end

        def record(entity:)
          return 'Voice record'
        end

        def terminal_record(entity:)
          return 'Voice terminal_record'
        end

        def enqueue(entity:)
          return 'Voice enqueue'
        end

        def dequeue(entity:)
          return 'Voice dequeue'
        end

        def redirect(entity:)
          return 'Voice redirect'
        end

        def reject
          return 'Voice reject'
        end
      end
    end
  end
end
