# Africas::Talking::Services

Gem that helps one to easily create micro-services based on Africa's talking API.

Put your Ruby code in the file `lib/africas/talking/services`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add africas-talking-services

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install africas-talking-services

## Usage

Create your Africa's Talking Service with;

### Voice Service Usage

Initialize the voice service first;

```ruby
service = Africas::Talking::Services::Client.new(app_name: app_name, app_key: app_key)
voice = service.voice
```

#### -> making a voice call

```ruby
voice_call_entity = Africas::Talking::Services::VoiceCallEntity.new(from: from, to: to, client_request_id: client_request_id)

response = voice.call(entity: voice_call_entity)
response.success? # => true
```

#### -> handle a voice callback

Within the callback url endpoint do the following;

- i) Create a callback object from the callback response
```ruby
# create a callback response entity to easily handle the data
callback_entity = Africas::Talking::Services::CallbackEntity.new(callback_response: callback_response)
# attributes -> is_active, session_id, direction, caller_number, destination_number, get_digits_response,
#               recording_url, duration_in_seconds, currency_code, amount
# you can now use callback_entity to make business domain decisions then proceed below to return a response
```

- ii) Return a response based on the voice methods
```ruby
# you can inform the user of something [https://cloud.google.com/text-to-speech/docs/voices]
voice_say_entity = Africas::Talking::Services::VoiceSayEntity.new(text: 'Something', voice: 'en-GB-Standard-F', play_beep: true)
response = voice.say(entity: voice_say_entity)

# or
# you can play a pre-recorded audio from a url
voice_play_entity = Africas::Talking::Services::VoicePlayEntity.new(audio_url: 'http://www.myvoicemailserver.com/audio/vmail.wav')
response = voice.play(entity: voice_play_entity)

# or
# you can prompt user for digits
voice_get_digits_entity = Africas::Talking::Services::VoiceGetDigitsEntity.new(
  prompt: 'Enter your account number.',
  timed_out_notification: 'We failed to get your account number.',
  timeout: '30',
  finish_on_key: '#',
  callback_url: 'http://mycallbackURL.com'
)
response = voice.get_digits(entity: voice_get_digits_entity)

# or
# you can forward the call to an external number
voice_forward_call_entity = Africas::Talking::Services::VoiceForwardCallEntity.new(
  phone_numbers: '+254711XXXYYY,+25631XYYZZZZ,test@ke.sip.africastalking.com',
  ringback_tone: 'http://mymediafile.com/playme.mp3',
  record: true,
  max_duration: '5',
  caller_id: '+254711XXXYYY',
  sequential: true
)
response = voice.forward_call(entity: voice_forward_call_entity)

# or
# prompt a user for an answer and record the audio
voice_record_entity = Africas::Talking::Services::VoiceRecordEntity.new(
  prompt: 'Please tell us your name after the beep.',
  finish_on_key: '#',
  maxLength: '10',
  trim_silence: true,
  play_beep: true
)
response = voice.record(entity: voice_record_entity)

# or
# prompt a user to record the audio and only ends when they cut the phone
voice_terminal_record_entity = Africas::Talking::Services::VoiceTerminalRecordEntity.new(
  prompt: 'Please leave a message after the beep.',
  play_beep: true
)
response = voice.terminal_record(entity: voice_terminal_record_entity)

# or
# pass an incoming call to a queue to be handled later.
voice_enqueue_entity = Africas::Talking::Services::VoiceEnqueueEntity.new(
  queue_name: 'test',
  hold_music: 'http://www.mymediaserver.com/audio/callWaiting.wav'
)
response = voice.enqueue(entity: voice_enqueue_entity)

# or
# pass the call enqueued to a separate number so that it can be handled e.g by an agent.
voice_dequeue_entity = Africas::Talking::Services::VoiceDequeueEntity.new(
  queue_name: 'test',
  phone_number: '+254711082XXX'
)
response = voice.dequeue(entity: voice_dequeue_entity)

# or
# transfer control of the call to the script whose URL is passed in.
voice_redirect_entity = Africas::Talking::Services::VoiceRedirectEntity.new(
  handler_url: 'http://www.myotherhandler.com/process.php'
)
response = voice.redirect(entity: voice_redirect_entity)

# or
# reject incoming call without incurring any costs.
response = voice.reject

# then return the response back to AT
# if using rails
respond_to do |format|
  format.json { ... }
  format.xml { render xml: response }
end
# or just
return response
```

#### -> call transfer

You can transfer your call to another number;

```ruby
call_transfer_entity = Africas::Talking::Services::CallTransferEntity.new(
  session_id: session_id,
  phone_number: phone_number,
  call_leg: call_leg,
  hold_music_url: hold_music_url
)

response = voice.transfer_call(entity: call_transfer_entity)
response.success? # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sylvance/africas-talking-services.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
