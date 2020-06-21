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
          # FIXME: Create notification after confirmation
        end

        def registration_notification
          # FIXME: Create notification after registration
        end
      end
    end
  end
end
