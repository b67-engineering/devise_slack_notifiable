# frozen_string_literal: true

require 'slack-notifier'

module DeviseSlackNotifiable
  class Notifier
    def initialize
      @client = Slack::Notifier.new(DeviseSlackNotifiable.configuration.slack_webhook)
    end

    def send_message(message)
      @client.ping(message)
    end

    protected

    attr_reader :client

  end
end
