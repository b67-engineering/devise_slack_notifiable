# frozen_string_literal: true

module DeviseSlackNotifiable
  class Configuration
    attr_accessor :enabled, :slack_webhook

    def initialize
      @enabled = false
      @slack_webhook = nil
    end
  end
end
