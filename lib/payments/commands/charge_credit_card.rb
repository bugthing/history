module Payments
  module Commands
    class ChargeCreditCard < Command
      aggregate Payments::Payment
      stream_prefix 'Payment'
      ident_attr :order_id

      attribute :order_id, Types::Integer
      attribute :number, Types::String
      attribute :expiry, Types::String
      attribute :cvv, Types::String
      attribute :name, Types::String
      attribute :address, Types::String
      attribute :postcode, Types::String
      attribute :pence, Types::Integer
    end
  end
end
