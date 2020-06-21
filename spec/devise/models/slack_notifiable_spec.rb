# frozen_string_literal: true

require 'spec_helper'
require 'active_model'
require 'devise'

# FIXME:
# It's hard to test model without database,
# but we can do that making assumptions that there is device
# and works as docs says, same for ActiveRecord
RSpec.describe Devise::Models::SlackNotifiable do
  subject do
    class User
      # Callbacks
      extend ActiveModel::Callbacks

      define_model_callbacks :create

      # Our implementation
      include Devise::Models::SlackNotifiable

      # Triggers
      def save
        run_callbacks(:create)
      end
    end

    User.new
  end

  # Callback after save
  context 'registration' do
    before do
      expect_any_instance_of(DeviseSlackNotifiable::Notifier)
        .to receive(:send_message).with(
          subject,
          DeviseSlackNotifiable.configuration.registration_message_formatter
        )
    end

    it 'sends slack notification' do
      expect(subject).to be_a(User)

      subject.save
    end
  end

  # Devise internal callback "after_confirmation"
  context 'confirmation' do
    context 'disabled' do
      before do
        DeviseSlackNotifiable.configure do |config|
          config.confirmation_message_enabled = false
        end

        expect_any_instance_of(DeviseSlackNotifiable::Notifier)
          .not_to receive(:send_message)
      end

      it 'does not send slack notification' do
        expect(subject).to be_a(User)

        subject.send(:after_confirmation)
      end
    end

    context 'enabled' do
      before do
        expect_any_instance_of(DeviseSlackNotifiable::Notifier)
          .to receive(:send_message).with(
            subject,
            DeviseSlackNotifiable.configuration.confirmation_message_formatter
          )
      end

      it 'sends slack notification' do
        expect(subject).to be_a(User)

        subject.send(:after_confirmation)
      end
    end
  end
end
