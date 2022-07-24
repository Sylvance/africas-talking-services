# frozen_string_literal: true

RSpec.describe Africas::Talking::Services do
  let(:client) { Africas::Talking::Services::Client }
  let(:service) { client.new(app_name: app_name, app_key: app_key) }
  let(:app_name) { 'app_name' }
  let(:app_key) { 'app_key' }

  it 'has a version number' do
    expect(Africas::Talking::Services::VERSION).not_to be nil
  end

  describe 'Africas::Talking::Services::Voice class' do
    let(:voice) { service.voice }
    let(:entity) { 'entity' }

    it 'can create a voice call to call AT api' do
      expect(voice.call(entity: entity)).to eq('Voice call')
    end

    it 'can create a voice say to call AT api' do
      expect(voice.say(entity: entity)).to eq('Voice say')
    end

    it 'can create a voice play to call AT api' do
      expect(voice.play(entity: entity)).to eq('Voice play')
    end

    it 'can create a voice get_digits call to AT api' do
      expect(voice.get_digits(entity: entity)).to eq('Voice get_digits')
    end

    it 'can create a voice forward_call to call AT api' do
      expect(voice.forward_call(entity: entity)).to eq('Voice forward_call')
    end

    it 'can create a voice record call to AT api' do
      expect(voice.record(entity: entity)).to eq('Voice record')
    end

    it 'can create a voice enqueue to call AT api' do
      expect(voice.enqueue(entity: entity)).to eq('Voice enqueue')
    end

    it 'can create a voice dequeue call to AT api' do
      expect(voice.dequeue(entity: entity)).to eq('Voice dequeue')
    end

    it 'can create a voice redirect to call AT api' do
      expect(voice.redirect(entity: entity)).to eq('Voice redirect')
    end

    it 'can create a voice reject call to AT api' do
      expect(voice.reject).to eq('Voice reject')
    end
  end
end
