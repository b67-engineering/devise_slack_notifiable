# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DeviseSlackNotifiable do
  subject { DeviseSlackNotifiable::VERSION }

  context 'version' do
    it 'returns in format' do
      expect(subject).to match(/^\d+\.\d+\.\d$/)
    end
  end
end
