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

### Voice Service Example

Initialize the voice service first;

```ruby
service = Africas::Talking::Services.new(app_name: app_name, app_key: app_key)
voice = service.voice
```

#### -> making a voice call

```ruby
call_entity = Africas::Talking::Services::CallEntity.new(from: from, to: to, client_request_id: client_request_id)

response = voice.call(entity: call_entity)
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
# you can inform the user of something
response = voice.say(text: 'Something', voice: 'en-GB-Standard-F', play_beep: true)

# or
# you can play a pre-recorded audio from a url
response = voice.play(audio_url: 'http://www.myvoicemailserver.com/audio/vmail.wav')

# or
# you can prompt user for digits
response = voice.get_digits(
  prompt: 'Enter your account number.',
  timed_out_notification: 'We failed to get your account number.',
  timeout: '30',
  finish_on_key: '#',
  callback_url: 'http://mycallbackURL.com'
)

# or
# you can forward the call to an external number
response = voice.forward_call(
  phone_numbers: '+254711XXXYYY,+25631XYYZZZZ,test@ke.sip.africastalking.com',
  ringback_tone: 'http://mymediafile.com/playme.mp3',
  record: true,
  max_duration: '5',
  caller_id: '+254711XXXYYY',
  sequential: true
)

# or
# prompt a user for an answer and record the audio
response = voice.record(
  prompt: 'Please tell us your name after the beep.',
  finish_on_key: '#',
  maxLength: '10',
  trim_silence: true,
  play_beep: true
)

# or
# prompt a user to record the audio and only ends when they cut the phone
response = voice.terminal_record(
  prompt: 'Please leave a message after the beep.',
  play_beep: true
)

# or
# pass an incoming call to a queue to be handled later.
response = voice.enqueue(
  queue_name: 'test',
  hold_music: 'http://www.mymediaserver.com/audio/callWaiting.wav'
)

# or
# pass the call enqueued to a separate number so that it can be handled e.g by an agent.
response = voice.dequeue(
  queue_name: 'test',
  phone_number: '+254711082XXX'
)

# or
# transfer control of the call to the script whose URL is passed in.
response = voice.redirect(
  handler_url: 'http://www.myotherhandler.com/process.php'
)

# or
# reject incoming call without incurring any costs.
response = voice.reject

# then return the response back to AT
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

response = voice.transfer_call(call_transfer_entity)
response.success? # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sylvance/africas-talking-services.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
