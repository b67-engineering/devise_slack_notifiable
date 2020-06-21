# frozen_string_literal: true

module Devise
  module Models
    # Slack notifications for devise models!
    module SlackNotifiable
      extend ActiveSupport::Concern

      included do
        # Rails hook
        # Triggers slack registration message
        after_create :registration_notification

        protected

        # Devise hook
        # Triggers slack confirmation message
        def after_confirmation
          confirmation_notification

          super if defined?(super)
        end

        # Sends slack notification if confirmation_message_enabled
        def confirmation_notification
          return unless DeviseSlackNotifiable.configuration.confirmation_message_enabled

          send_slack_notification(
            DeviseSlackNotifiable.configuration.confirmation_message_formatter
          )
        end

        # Sends slack notification
        def registration_notification
          send_slack_notification(
            DeviseSlackNotifiable.configuration.registration_message_formatter
          )
        end

        private

        # Creates notifier and sends message
        #
        # @param [Proc] formatter
        def send_slack_notification(formatter)
          notifier = DeviseSlackNotifiable::Notifier.new
          notifier.send_message(self, formatter)
        end
      end
    end
  end
end
