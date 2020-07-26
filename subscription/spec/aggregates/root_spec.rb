require_relative '../spec_helper'

RSpec.describe Subscription::Aggregates::Root do
  subject(:aggregate) { described_class.new(email: email) }

  let(:email) { 'ben@example.com' }

  describe '#sign_up' do
    context "when signing up with existing email" do
      it 'produces an error' do
        Subscription::Models::Subscription.create email: email, signed_up_at: Time.now, level: 'base'
        expect { aggregate.sign_up }.to raise_error(Subscription::Error)
      end
    end

    context "when signing up with a new email" do
      it 'successfully signs up an email' do
        expect { aggregate.sign_up }.not_to raise_error
        expect(aggregate).to have_applied(
          an_event(Subscription::Events::SubscriptionSignedUpTo).with_data(
            email: email,
            signed_up_at: a_value,
            level: "signup"
          ).strict
        )
      end
    end
  end

  describe '#upgrade' do
    context "when upgrading with non existing email" do
      it 'produces an error' do
        expect { aggregate.upgrade }.to raise_error(Subscription::Error)
      end
    end

    context "when upgrading a newly signed up subscription" do
      it 'successfully upgrades the subscription' do
        aggregate.sign_up
        expect { aggregate.upgrade }.not_to raise_error
        expect(aggregate).to have_applied(
          an_event(Subscription::Events::SubscriptionUpgraded).with_data(
            level: "premium"
          ).strict
        )
      end
    end
  end

  describe '#cancel' do
    context "when cancelling with non existing email" do
      it 'produces an error' do
        expect { aggregate.cancel }.to raise_error(Subscription::Error)
      end
    end

    context "when cancelling an signed up subscription" do
      it 'successfully cancels the subscription' do
        aggregate.sign_up
        expect { aggregate.cancel }.not_to raise_error
        expect(aggregate).to have_applied(
          an_event(Subscription::Events::SubscriptionCancelled).with_data(
            cancelled_at: a_value
          ).strict
        )
      end
    end
  end
end
