# frozen_string_literal: true

RSpec.describe Africas::Talking::Services do
  let(:client) { Africas::Talking::Services::Client }
  let(:service) { client.new(app_name: app_name, app_key: app_key) }
  let(:voice) { service.voice }
  let(:app_name) { "app_name" }
  let(:app_key) { "app_key" }

  it "has a version number" do
    expect(Africas::Talking::Services::VERSION).not_to be nil
  end

  context "Services::Voice: when doing a voice call api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceCallEntity.new(
        from: "from", to: "to", client_request_id: "client_request_id"
      )
    end

    it "can create a voice call to call AT api" do
      expect(voice.call(entity: entity).content).to eq("Voice call")
    end
  end

  context "Services::Voice: when doing a voice say api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceSayEntity.new(
        text: "Something", voice: "en-GB-Standard-F", play_beep: true
      )
    end

    it "can create a voice say to call AT api" do
      expect(voice.say(entity: entity).content).to eq("Voice say")
    end
  end

  context "Services::Voice: when doing a voice play api call" do
    let(:entity) do
      Africas::Talking::Services::VoicePlayEntity.new(
        audio_url: "http://www.myvoicemailserver.com/audio/vmail.wav"
      )
    end

    it "can create a voice play to call AT api" do
      expect(voice.play(entity: entity).content).to eq("Voice play")
    end
  end

  context "Services::Voice: when doing a voice get_digits api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceGetDigitsEntity.new(
        prompt: "Enter your account number.",
        timed_out_notification: "We failed to get your account number.",
        timeout: "30",
        finish_on_key: "#",
        callback_url: "http://mycallbackURL.com"
      )
    end

    it "can create a voice get_digits call to AT api" do
      expect(voice.get_digits(entity: entity).content).to eq("Voice get_digits")
    end
  end

  context "Services::Voice: when doing a voice forward_call api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceForwardCallEntity.new(
        phone_numbers: "+254711XXXYYY,+25631XYYZZZZ,test@ke.sip.africastalking.com",
        ringback_tone: "http://mymediafile.com/playme.mp3",
        record: true,
        max_duration: "5",
        caller_id: "+254711XXXYYY",
        sequential: true
      )
    end

    it "can create a voice forward_call to call AT api" do
      expect(voice.forward_call(entity: entity).content).to eq("Voice forward_call")
    end
  end

  context "Services::Voice: when doing a voice record api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceRecordEntity.new(
        prompt: "Please tell us your name after the beep.",
        finish_on_key: "#",
        maxLength: "10",
        trim_silence: true,
        play_beep: true
      )
    end

    it "can create a voice record call to AT api" do
      expect(voice.record(entity: entity).content).to eq("Voice record")
    end
  end

  context "Services::Voice: when doing a voice terminal_record api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceTerminalRecordEntity.new(
        prompt: "Please leave a message after the beep.",
        play_beep: true
      )
    end

    it "can create a voice terminal_record to call AT api" do
      expect(voice.terminal_record(entity: entity).content).to eq("Voice terminal_record")
    end
  end

  context "Services::Voice: when doing a voice enqueue api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceEnqueueEntity.new(
        queue_name: "test",
        hold_music: "http://www.mymediaserver.com/audio/callWaiting.wav"
      )
    end

    it "can create a voice enqueue to call AT api" do
      expect(voice.enqueue(entity: entity).content).to eq("Voice enqueue")
    end
  end

  context "Services::Voice: when doing a voice dequeue api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceDequeueEntity.new(
        queue_name: "test",
        phone_number: "+254711082XXX"
      )
    end

    it "can create a voice dequeue call to AT api" do
      expect(voice.dequeue(entity: entity).content).to eq("Voice dequeue")
    end
  end

  context "Services::Voice: when doing a voice redirect api call" do
    let(:entity) do
      Africas::Talking::Services::VoiceRedirectEntity.new(
        handler_url: "http://www.myotherhandler.com/process.php"
      )
    end

    it "can create a voice redirect to call AT api" do
      expect(voice.redirect(entity: entity).content).to eq("Voice redirect")
    end
  end

  context "Services::Voice: when doing a voice reject api call" do
    it "can create a voice reject call to AT api" do
      expect(voice.reject.content).to eq("Voice reject")
    end
  end
end
