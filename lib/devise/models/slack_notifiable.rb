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
          # FIXME: Create proper notification after confirmation

          notifier = DeviseSlackNotifiable::Notifier.new
          notifier.send_message("User(#{id}) has been confirmed")
        end

        def registration_notification
          # FIXME: Create proper notification after registration

          notifier = DeviseSlackNotifiable::Notifier.new
          notifier.send_message("User(#{id}) has been created")
        end
      end
    end
  end
end
