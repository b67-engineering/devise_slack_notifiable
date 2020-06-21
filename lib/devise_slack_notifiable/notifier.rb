# frozen_string_literal: true

require 'slack-notifier'

module DeviseSlackNotifiable
  class Notifier
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

    def enabled?
      DeviseSlackNotifiable.configuration.enabled
    end

    def webhook
      DeviseSlackNotifiable.configuration.slack_webhook
    end

    def context_fields
      DeviseSlackNotifiable.configuration.context_fields
    end

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
            type: 'divider'
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
