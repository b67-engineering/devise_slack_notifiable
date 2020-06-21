# frozen_string_literal: true

module DeviseSlackNotifiable
  module Errors
    # Configuration error
    # raised when properties are missing
    class Configuration < StandardError; end
  end
end
