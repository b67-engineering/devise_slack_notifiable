# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DeviseSlackNotifiable do
  subject { DeviseSlackNotifiable.configuration }

  context 'configuration' do
    context 'enabled' do
      context 'when default' do
        it 'returns value' do
          expect(subject.enabled).to be_eql(false)
        end
      end

      context 'when provided' do
        let(:new_value) { true }

        before do
          DeviseSlackNotifiable.configure { |config| config.enabled = new_value }
        end

        it 'returns value' do
          expect(subject.enabled).to be_eql(new_value)
        end
      end
    end

    context 'slack_webhook' do
      context 'when default' do
        it 'returns value' do
          expect(subject.slack_webhook).to be_nil
        end
      end

      context 'when provided' do
        let(:new_value) { 'https://google.com' }

        before do
          DeviseSlackNotifiable.configure { |config| config.slack_webhook = new_value }
        end

        it 'returns value' do
          expect(subject.slack_webhook).to be_eql(new_value)
        end
      end
    end

    context 'registration_message_formatter' do
      context 'when default' do
        it 'returns lambda' do
          expect(subject.registration_message_formatter).to be_a(Proc)
        end
      end

      context 'when provided' do
        let(:output) { 'formatted message' }
        let(:new_value) { ->(_) { output } }

        before do
          DeviseSlackNotifiable.configure { |config| config.registration_message_formatter = new_value }
        end

        it 'returns lambda' do
          expect(subject.registration_message_formatter).to be_eql(new_value)
          expect(subject.registration_message_formatter.call(1)).to be_eql(output)
        end
      end
    end

    context 'confirmation_message_formatter' do
      context 'when default' do
        it 'returns lambda' do
          expect(subject.confirmation_message_formatter).to be_a(Proc)
        end
      end

      context 'when provided' do
        let(:output) { 'formatted message' }
        let(:new_value) { ->(_) { output } }

        before do
          DeviseSlackNotifiable.configure { |config| config.confirmation_message_formatter = new_value }
        end

        it 'returns lambda' do
          expect(subject.confirmation_message_formatter).to be_eql(new_value)
          expect(subject.confirmation_message_formatter.call(1)).to be_eql(output)
        end
      end
    end

    context 'confirmation_message_enabled' do
      context 'when default' do
        it 'returns value' do
          expect(subject.confirmation_message_enabled).to be_eql(true)
        end
      end

      context 'when provided' do
        let(:new_value) { false }

        before do
          DeviseSlackNotifiable.configure { |config| config.confirmation_message_enabled = new_value }
        end

        it 'returns value' do
          expect(subject.confirmation_message_enabled).to be_eql(new_value)
        end
      end
    end

    context 'context_fields' do
    context 'when default' do
      it 'returns value' do
        expect(subject.context_fields).to be_eql(%i[id email])
      end
    end

    context 'when provided' do
      let(:new_value) { %i[id email first_name last_name] }

      before do
        DeviseSlackNotifiable.configure { |config| config.context_fields = new_value }
      end

      it 'returns value' do
        expect(subject.context_fields).to be_eql(new_value)
      end
    end
  end
  end
end
