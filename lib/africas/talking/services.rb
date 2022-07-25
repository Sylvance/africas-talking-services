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

      class VoiceCallEntity
        attr_accessor :from, :to, :client_request_id

        def initialize(from:, to:, client_request_id:)
          @from              = from
          @to                = to
          @client_request_id = client_request_id
        end

        def to_body
          {
            from: @from,
            to: @to,
            client_request_id: @client_request_id
          }
        end
      end

      class VoiceSayEntity
        attr_accessor :text, :voice, :play_beep

        def initialize(text:, voice:, play_beep:)
          @text      = text
          @voice     = voice
          @play_beep = play_beep
        end

        def to_body
          {
            text: @text,
            voice: @voice,
            play_beep: @play_beep
          }
        end
      end

      class VoicePlayEntity
        attr_accessor :audio_url

        def initialize(audio_url:)
          @audio_url = audio_url
        end

        def to_body
          {
            audio_url: @audio_url
          }
        end
      end

      class VoiceGetDigitsEntity
        attr_accessor :prompt

        def initialize(prompt:, timed_out_notification:, timeout:, finish_on_key:, callback_url:)
          @prompt                 = prompt
          @timed_out_notification = timed_out_notification
          @timeout                = timeout
          @finish_on_key          = finish_on_key
          @callback_url           = callback_url
        end

        def to_body
          {
            prompt: @prompt,
            timed_out_notification: @timed_out_notification,
            timeout: @timeout,
            finish_on_key: @finish_on_key,
            callback_url: @callback_url
          }
        end
      end

      class VoiceForwardCallEntity
        attr_accessor :phone_numbers, :ringback_tone, :record, :max_duration, :caller_id, :sequential

        def initialize(phone_numbers:, ringback_tone:, record:, max_duration:, caller_id:, sequential:)
          @phone_numbers = phone_numbers
          @ringback_tone = ringback_tone
          @record        = record
          @max_duration  = max_duration
          @caller_id     = caller_id
          @sequential    = sequential
        end

        def to_body
          {
            phone_numbers: @phone_numbers,
            ringback_tone: @ringback_tone,
            record: @record,
            max_duration: @max_duration,
            caller_id: @caller_id,
            sequential: @sequential
          }
        end
      end

      class VoiceRecordEntity
        attr_accessor :prompt, :finish_on_key, :maxLength, :trim_silence, :play_beep

        def initialize(prompt:, finish_on_key:, maxLength:, trim_silence:, play_beep:)
          @prompt        = prompt
          @finish_on_key = finish_on_key
          @maxLength     = maxLength
          @trim_silence  = trim_silence
          @play_beep     = play_beep
        end

        def to_body
          {
            prompt: @prompt,
            finish_on_key: @finish_on_key,
            maxLength: @maxLength,
            trim_silence: @trim_silence,
            play_beep: @play_beep
          }
        end
      end

      class VoiceTerminalRecordEntity
        attr_accessor :prompt, :play_beep

        def initialize(prompt:, play_beep:)
          @prompt    = prompt
          @play_beep = play_beep
        end

        def to_body
          {
            prompt: @prompt,
            play_beep: @play_beep
          }
        end
      end

      class VoiceEnqueueEntity
        attr_accessor :queue_name, :hold_music

        def initialize(queue_name:, hold_music:)
          @queue_name = queue_name
          @hold_music = hold_music
        end

        def to_body
          {
            queue_name: @queue_name,
            hold_music: @hold_music
          }
        end
      end

      class VoiceDequeueEntity
        attr_accessor :queue_name, :phone_number

        def initialize(queue_name:, phone_number:)
          @queue_name = queue_name
          @phone_number = phone_number
        end

        def to_body
          {
            queue_name: @queue_name,
            phone_number: @phone_number
          }
        end
      end

      class VoiceRedirectEntity
        attr_accessor :handler_url

        def initialize(handler_url:)
          @handler_url = handler_url
        end

        def to_body
          {
            handler_url: @handler_url
          }
        end
      end

      class CallbackEntity
        attr_accessor :callback_response

        def initialize(callback_response:)
          @callback_response = callback_response
        end

        def is_active
          response["is_active"]
        end

        def session_id
          response["session_id"]
        end

        def direction
          response["direction"]
        end

        def caller_number
          response["caller_number"]
        end

        def destination_number
          response["destination_number"]
        end

        def get_digits_response
          response["get_digits_response"]
        end

        def recording_url
          response["recording_url"]
        end

        def duration_in_seconds
          response["duration_in_seconds"]
        end

        def currency_code
          response["currency_code"]
        end

        def amount
          response["amount"]
        end

        private

        def response
          @callback_response
        end
      end
    end
  end
end
