# frozen_string_literal: true

require 'slack-notifier'

module DeviseSlackNotifiable
  class Notifier
    def initialize
      return unless enabled?

      raise DeviseSlackNotifiable::Errors::Configuration, 'Missing Slack Webhook URL' unless webhook

      @client = Slack::Notifier.new(webhook)
    end

    def send_message(message)
      return true unless enabled?

      @client.ping(message)
    end

    protected

    attr_reader :client

    def enabled?
      DeviseSlackNotifiable.configuration.enabled
    end

    def webhook
      DeviseSlackNotifiable.configuration.slack_webhook
    end
  end
end
