# frozen_string_literal: true

module DeviseSlackNotifiable
  class Configuration
    attr_accessor :slack_webhook

    def initialize
      @slack_webhook = nil
    end
  end
end
