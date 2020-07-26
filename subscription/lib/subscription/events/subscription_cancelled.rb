module Subscription
  module Events
    class SubscriptionCancelled < RubyEventStore::Event
      SCHEMA = {
        cancelled_at: Time
      }.freeze

      def self.strict(data:)
        ClassyHash.validate(data, SCHEMA)
        new(data: data)
      end
    end
  end
end
