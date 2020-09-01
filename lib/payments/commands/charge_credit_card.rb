module Payments
  module Commands
    class ChargeCreditCard
      def self.call(order_id:,
                    number:,
                    expiry:,
                    cvv:,
                    name:,
                    address:,
                    postcode:,
                    pence:)
      end
    end
  end
end
