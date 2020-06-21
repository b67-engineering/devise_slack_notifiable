# frozen_string_literal: true

require 'slack-notifier'

module DeviseSlackNotifiable
  # Module <-> Slack communication layer
  # and payload builder
  class Notifier

    # DeviseSlackNotifiable::Notifier constructor.
    #
    # Creates Slack::Notifier instance
    def initialize
      return unless enabled?

      raise DeviseSlackNotifiable::Errors::Configuration, 'Missing Slack Webhook URL' unless webhook

      @client = Slack::Notifier.new(webhook)
    end

    # Sends slack message
    #
    # @param [Model] entity
    # @param [Proc] message_formatter
    def send_message(entity, message_formatter)
      return true unless enabled?

      @client.ping(
        formatter(
          message_formatter.call(entity),
          entity
        )
      )
    end

    protected

    attr_reader :client

    # Integration enabled?
    #
    # @return [Boolean]
    def enabled?
      DeviseSlackNotifiable.configuration.enabled
    end

    # Webhook URL
    #
    # @return [String, NilClass]
    def webhook
      DeviseSlackNotifiable.configuration.slack_webhook
    end

    # Context fields
    #
    # @return [Array]
    def context_fields
      DeviseSlackNotifiable.configuration.context_fields
    end

    # Message builder
    #
    # @param [String] message
    # @param [ActiveRecord::Base] entity
    #
    # @return [Hash]
    def formatter(message, entity)
      {
        blocks: [
          {
            type: 'section',
            text: {
              type: 'plain_text',
              text: message,
              emoji: true
            }
          },
          {
            type: 'section',
            text: {
              type: 'plain_text',
              text: 'Context:',
              emoji: true
            }
          },
          {
            type: 'section',
            fields: context_fields.map do |field|
              {
                type: 'mrkdwn',
                text: "*#{field.to_s.humanize}:* #{entity.send(field)}"
              }
            end
          }
        ]
      }
    end
  end
end
