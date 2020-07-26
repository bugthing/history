module Subscription
  module Events
    class SubscriptionUpgraded < RubyEventStore::Event
      SCHEMA = {
        level: String
      }.freeze

      def self.strict(data:)
        ClassyHash.validate(data, SCHEMA)
        new(data: data)
      end
    end
  end
end
