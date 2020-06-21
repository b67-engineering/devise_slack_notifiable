# frozen_string_literal: true

module Devise
  module Models
    module SlackNotifiable
      extend ActiveSupport::Concern

      included do
        after_create :registration_notification

        protected

        def after_confirmation
          confirmation_notification

          super
        end

        def confirmation_notification
          return unless DeviseSlackNotifiable.configuration.confirmation_message_enabled

          send_slack_notification(
            DeviseSlackNotifiable.configuration.confirmation_message_formatter
          )
        end

        def registration_notification
          send_slack_notification(
            DeviseSlackNotifiable.configuration.registration_message_formatter
          )
        end

        private

        def send_slack_notification(formatter)
          notifier = DeviseSlackNotifiable::Notifier.new
          notifier.send_message(self, formatter)
        end
      end
    end
  end
end
