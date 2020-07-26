module Subscription
  module Events
    class SubscriptionSignedUpTo < RubyEventStore::Event
      SCHEMA = {
        email: String,
        signed_up: Time,
        level: String
      }.freeze

      def self.strict(data:)
        ClassyHash.validate(data, SCHEMA)
        new(data: data)
      end
    end
  end
end
