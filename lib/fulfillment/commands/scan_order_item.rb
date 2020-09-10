module Fulfillment
  module Commands
    class ScanOrderItem < Command
      aggregate Fulfillment::OrderFulfillment
      stream_prefix 'OrderFulfillment'
      ident_attr :order_id

      attribute :order_id, Types::Integer
      attribute :barcode, Types::Array.of(Types::String)
    end
  end
end
