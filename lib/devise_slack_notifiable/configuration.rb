# frozen_string_literal: true

module DeviseSlackNotifiable
  # Configuration container
  class Configuration
    attr_accessor :enabled,
                  :slack_webhook,
                  :registration_message_formatter,
                  :confirmation_message_formatter,
                  :confirmation_message_enabled,
                  :context_fields

    # DeviseSlackNotifiable::Configuration constructor.
    #
    # Sets default values
    def initialize
      @enabled = false
      @slack_webhook = nil
      @confirmation_message_enabled = true

      @context_fields = %i[id email]

      @registration_message_formatter = lambda { |entity|
        "Yeah 🎉! Looks like we have new #{entity.model_name.human}! 😊"
      }

      @confirmation_message_formatter = lambda { |entity|
        "#{entity.model_name.human} have just confirmed his account 🥂"
      }
    end
  end
end
