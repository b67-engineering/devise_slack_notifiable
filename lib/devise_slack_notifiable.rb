# frozen_string_literal: true

require 'devise_slack_notifiable/version'
require 'devise_slack_notifiable/configuration'
require 'devise/models/slack_notifiable'

module DeviseSlackNotifiable
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= DeviseSlackNotifiable::Configuration.new
    yield(configuration)
  end
end
