# frozen_string_literal: true

require 'ox'

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
          CreateXML.new(:Call, "Voice call", entity.to_body)
        end

        def say(entity:)
          CreateXML.new(:Say, "Voice say", entity.to_body)
        end

        def play(entity:)
          CreateXML.new(:Play, "Voice play", entity.to_body)
        end

        def get_digits(entity:)
          CreateXML.new(:GetDigits, "Voice get_digits", entity.to_body)
        end

        def forward_call(entity:)
          CreateXML.new(:Dial, "Voice forward_call", entity.to_body)
        end

        def record(entity:)
          CreateXML.new(:Record, "Voice record", entity.to_body)
        end

        def terminal_record(entity:)
          CreateXML.new(:Record, "Voice terminal_record", entity.to_body)
        end

        def enqueue(entity:)
          CreateXML.new(:Enqueue, "Voice enqueue", entity.to_body)
        end

        def dequeue(entity:)
          CreateXML.new(:Dequeue, "Voice dequeue", entity.to_body)
        end

        def redirect(entity:)
          CreateXML.new(:Redirect, "Voice redirect", entity.to_body)
        end

        def reject
          CreateXML.new(:Reject, nil, nil)
        end

        private

        class CreateXML
          attr_accessor :element, :content, :params

          def initialize(element, content, params)
            @element = element
            @content = content
            @params  = params
          end

          def result
            doc = Ox::Document.new

            instruct = Ox::Instruct.new(:xml)
            instruct[:version] = '1.0'
            instruct[:encoding] = 'UTF-8'
            instruct[:standalone] = 'yes'

            doc << instruct

            ox_element = Ox::Element.new(@element)

            params.each do |key, value|
              ox_element[key] = value
            end

            ox_element << content
            doc << ox_element

            xml = Ox.dump(doc)
            return xml
          end
        end
      end
    end
  end
end
