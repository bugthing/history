module Subscription
  module Aggregates
    class Root
      include AggregateRoot

      def initialize(email:)
        @email = email
        @signed_up_at = nil
        @level = nil
        @cancelled_at
      end

      def sign_up(signed_up_at: Time.now)
        raise Error if Models::Subscription.exists?(email: @email)
        apply Events::SubscriptionSignedUpTo.new(data: {
          email: @email,
          signed_up_at: signed_up_at,
          level: 'signup'
        })
      end

      def upgrade
        raise Error if @level.nil?
        apply Events::SubscriptionUpgraded.new(data: {
          level: 'premium'
        })
      end

      def cancel(cancelled_at: Time.now)
        raise Error if @level.nil?
        apply Events::SubscriptionCancelled.new(data: {
          cancelled_at: cancelled_at
        })
      end

      def apply_subscription_signed_up_to(event)
        @email = event.data[:email]
        @signed_up_at = event.data[:signed_up_at]
        @level = event.data[:level]
      end

      def apply_subscription_upgraded(event)
        @level = event.data[:level]
      end

      def apply_subscription_cancelled(event)
        @cancelled_at = event.data[:cancelled_at]
      end
    end
  end
end
