# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DeviseSlackNotifiable::Notifier do
  subject { DeviseSlackNotifiable::Notifier.new }

  describe '.new' do
    context 'disabled' do
      before do
        expect_any_instance_of(Slack::Notifier).not_to receive(:new)
      end

      it 'creates instance' do
        expect(subject).to be_a(DeviseSlackNotifiable::Notifier)
      end
    end

    context 'enabled' do
      before do
        DeviseSlackNotifiable.configure { |config| config.enabled = true }
      end

      context 'without webhook' do
        it 'raises error' do
          expect { subject }.to raise_error(
                                  DeviseSlackNotifiable::Errors::Configuration,
                                  'Missing Slack Webhook URL'
                                )
        end
      end

      context 'with webhook' do
        let(:webhook) { 'http://localhost' }

        before do
          DeviseSlackNotifiable.configure { |config| config.slack_webhook = webhook }

          expect(Slack::Notifier).to receive(:new).with(webhook)
        end

        it 'creates instance' do
          expect { subject }.not_to raise_error
        end
      end
    end
  end

  describe '#send_message' do
    context 'disabled' do
      before do
        expect_any_instance_of(Slack::Notifier).not_to receive(:ping)
      end

      it 'should not send message' do
        subject
      end
    end

    context 'enabled' do
      let(:model) { double('Entity', id: 9, email: 'spec@localhost') }
      let(:formatter) { ->(entity) { "Received name: #{entity.id}" } }
      let(:webhook) { 'http://localhost' }
      let(:expected_payload) do
        {
          blocks: [
            {
              text: {
                emoji: true,
                text: 'Received name: 9',
                type: 'plain_text'
              },
              type: 'section'
            },
            {
              text: {
                emoji: true,
                text: 'Context:',
                type: 'plain_text'
              },
              type: 'section'
            },
            {
              fields: [
                { text: '*Id:* 9', type: 'mrkdwn' },
                { text: '*Email:* spec@localhost', type: 'mrkdwn' }
              ],
              type: 'section'
            }
          ]
        }
      end

      before do
        DeviseSlackNotifiable.configure do |config|
          config.enabled = true
          config.slack_webhook = webhook
        end

        expect_any_instance_of(Slack::Notifier).to receive(:ping).with(expected_payload)
      end

      it 'sends message' do
        subject.send_message(model, formatter)
      end
    end
  end
end
