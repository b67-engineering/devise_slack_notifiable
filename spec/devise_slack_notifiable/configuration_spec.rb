# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DeviseSlackNotifiable::Configuration do
  subject { DeviseSlackNotifiable::Configuration.new }

  context 'enabled' do
    it 'reads' do
      expect(subject).to respond_to(:enabled)
    end

    it 'writes' do
      expect(subject).to respond_to(:enabled)
    end
  end

  context 'slack_webhook' do
    it 'reads' do
      expect(subject).to respond_to(:slack_webhook)
    end

    it 'writes' do
      expect(subject).to respond_to(:slack_webhook=)
    end
  end

  context 'registration_message_formatter' do
    it 'reads' do
      expect(subject).to respond_to(:registration_message_formatter)
    end

    it 'writes' do
      expect(subject).to respond_to(:registration_message_formatter=)
    end
  end

  context 'confirmation_message_formatter' do
    it 'reads' do
      expect(subject).to respond_to(:confirmation_message_formatter)
    end

    it 'writes' do
      expect(subject).to respond_to(:confirmation_message_formatter=)
    end
  end

  context 'confirmation_message_enabled' do
    it 'reads' do
      expect(subject).to respond_to(:confirmation_message_enabled)
    end

    it 'writes' do
      expect(subject).to respond_to(:confirmation_message_enabled=)
    end
  end

  context 'context_fields' do
    it 'reads' do
      expect(subject).to respond_to(:context_fields)
    end

    it 'writes' do
      expect(subject).to respond_to(:context_fields=)
    end
  end

end
