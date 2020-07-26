require_relative 'spec_helper'

RSpec.describe Subscription do
  describe '#sign_up' do
    subject { Subscription::Services.new.sign_up(email: email) }

    let(:email) { 'ben@example.com' }

    context "when signing up with bad email address" do
      let(:email) { 'noatsign' }
      it 'produces an error' do
        expect { subject }.to raise_error(Subscription::Error)
      end
    end

    context "when signing up with existing email" do
      it 'produces an error' do
        Subscription::Models::Subscription.create email: email, signed_up_at: Time.now, level: 'base'
        expect { subject }.to raise_error(Subscription::Error)
      end
    end

    context "when signing up with a new email" do
      it 'successfully signs up an email' do
        expect { subject }.not_to raise_error
      end
    end
  end
end
